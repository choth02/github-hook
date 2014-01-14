require 'spec_helper'
require 'fileutils'
require 'thor'
require 'github-hook'
require 'github-hook/cli'

describe "github-hook" do
  before do
    Github::Hook::Config.stub(:config_filename).and_return("/tmp/.github-hook.yml")
    FileUtils.touch(Github::Hook::Config.config_filename)
    stub_config!
  end

  describe "list" do
    it "calls Github::Hook with the correct arguments" do
      hooks = [
        {
          "url" => "http://github/hooks/123",
          "name" => "web",
          "events" => ["event1", "event2"],
          "config" => {
            "url" => "http://example.com/callback"
          }
        }
      ]
      Github::Hook.stub(:hooks).with("user/repo").and_return(hooks)
      cli("list user/repo")
    end

    it "handles 404 errors in github API" do
      WebMock.stub_request(:get, "https://user:password@api.github.com/repos/user/non-existent-repo/hooks").
        to_return(:status => 404, :body => "NotFound", :headers => {})

      $stdout.should_receive(:puts).with("Resource Not Found (404): This repository may not exist or you may not have access to it.")
      expect { cli("list user/non-existent-repo") }.to raise_error(SystemExit)
    end
  end

  describe "campfire" do
    it "calls Github::Hook with the correct arguments" do
      Github::Hook.stub(:add_hook).with("user/repo", {:name => "campfire", :events => ["pull_request", "issue"], :config=> {"token"=>"token", "room"=>"RROM", "subdomain"=>"SUBDOMAIN"}})
      cli("campfire user/repo pull_request,issue --room=RROM --subdomain=SUBDOMAIN")
    end

    it "ignores campfire_token if --token is passed" do
      Github::Hook.stub(:add_hook).with("user/repo", {:name => "campfire", :events => ["pull_request", "issue"], :config => {"token"=>"cli_token", "room"=>"ROOM", "subdomain"=>"SUBDOMAIN"}})
      cli("campfire user/repo pull_request,issue --room=ROOM --subdomain=SUBDOMAIN --token=cli_token")
    end
  end

  describe "email" do
    it "calls Github::Hook with the correct arguments" do
      Github::Hook.stub(:add_hook).with("user/repo", {:name => "email", :events => ["push"], :config=> {"address"=>"user@example.com", "secret"=>"X-Test-github-hook", "send_from_author" => "1"}})
      cli("email user/repo push --address=user@example.com --secret=X-Test-github-hook --send-from-author=1")
    end
  end

  describe "web" do
    it "calls Github::Hook with the correct arguments" do
      Github::Hook.stub(:add_hook).with("user/repo", {:name => "web", :events => ["pull_request", "issue"], :config=> {"url"=>"http://example.com/callback"}})
      cli("web user/repo pull_request,issue --url=http://example.com/callback")
    end
  end

  describe "delete" do
    it "calls Github::Hook with the correct arguments" do
      Github::Hook.stub(:delete_hook).with("user/repo", "1010")
      cli("delete user/repo 1010")
    end
  end

  def cli(string)
    Github::Hook::CLI.start(string.split(" "))
  end
end
