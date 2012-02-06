require 'spec_helper'
require 'fileutils'
require 'thor'
require 'github-hooker'
require 'github-hooker/cli'

describe "github-hooker" do
  subject { Github::Hooker::CLI.new }

  before do
    Github::Hooker.stub(:config_filename).and_return("/tmp/.github-hooker.yml")
    FileUtils.touch(Github::Hooker.config_filename)
  end

  describe "list" do
    it "calls Github::Hooker with the correct arguments" do
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
      Github::Hooker.stub(:hooks).with("user/repo").and_return(hooks)
      subject.list("user/repo")
    end

    it "displays an error essage if ~/.github-hooker.yml is not present" do
    end

    describe "campfire" do
      it "calls Github::Hooker with the correct arguments" do
        Github::Hooker.stub(:add_hook).with("user/repo", {:name => "campfire", :events => ["pull_requests", "issue"], :config => {}})
        subject.campfire("user/repo", "pull_requests, issue")
      end
    end

    describe "web" do
      it "calls Github::Hooker with the correct arguments" do
        Github::Hooker.stub(:add_hook).with("user/repo", {:name => "web", :events => ["pull_requests", "issue"], :config => {}})
        subject.web("user/repo", "pull_requests, issue")
      end
    end

    describe "delete" do
      it "calls Github::Hooker with the correct arguments" do
        Github::Hooker.stub(:delete_hook).with("user/repo", 1010)
        subject.delete("user/repo", 1010)
      end
    end
  end
end
