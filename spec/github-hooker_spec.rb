require 'spec_helper'
require 'github-hooker'

describe Github::Hooker do
  context "given a valid credential" do
    before do
      Github::Hooker.stub(:config).and_return({ "user" => "user", "password" => "password", "campfire_token" => "token" })
    end

    it "lists the hooks in the given repo" do
      WebMock.stub_request(:get, "https://user:password@api.github.com/repos/user/repo/hooks").
        to_return(:status => 200, :body => fixture_file("list_hooks.json"), :headers => {})

      list = subject.hooks("user/repo")

      list[0]["url"].should == "https://api.github.com/repos/user/repo/hooks/157257"
      list[1]["url"].should == "https://api.github.com/repos/user/repo/hooks/157271"
    end

    it "adds a new campfire hook in the given repo" do
      WebMock.stub_request(:post, "https://user:password@api.github.com/repos/user/repo/hooks").
        with(:body => {"name"=>"campfire", "events"=>["pull_request", "issue_comment"], "active"=>"true", "config"=>{"subdomain"=>"company", "room"=>"my room", "token"=>"abcde", "long_url"=>"true"}}).
        to_return(:status => 200, :body => "{}", :headers => {})

      hook_options = {
        :name => "campfire",
        :events => ["pull_request", "issue_comment"],
        :active => "true",
        :config => {
          :subdomain => "company",
          :room => "my room",
          :token => "abcde",
          :long_url => "true"
        }
      }
      subject.add_hook("user/repo", hook_options)
    end
  end
end

def fixture_file(name)
  File.read(File.expand_path("../../spec/fixtures/#{name}", __FILE__))
end
