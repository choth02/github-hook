require 'spec_helper'
require 'github-hooker'

describe Github::Hooker do

  context "given a valid credential" do
    before do
      Github::Hooker.stub(:config).and_return({ "user" => "user", "password" => "password" })
    end

    it "lists the hooks in the given repo" do
      list = subject.hooks(:repo => "user/repo")

      list[0]["url"].should == "https://api.github.com/repos/user/repo/hooks/157257"
      list[1]["url"].should == "https://api.github.com/repos/user/repo/hooks/157271"
    end

    it "adds a new hook in the given repo"
  end
end
