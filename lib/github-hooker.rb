require "github-hooker/version"
require 'net/http'
require 'json'
require 'yaml'
require 'restclient'
require 'active_support/core_ext/hash/reverse_merge'

module Github
  module Hooker
    def self.hooks(repo, payload={})
      github_api(:get, repo, payload.to_json)
    end

    def self.add_hook(repo, payload={})
      payload = payload.reverse_merge(:active => true)
      github_api(:post, repo, :payload => payload.to_json)
    end

    def self.config
      @config ||= YAML.load_file(File.expand_path("~/.github-hooker.yml"))
    end

    def self.github_api(method, repo, options)
      options.reverse_merge!(
        :method => method,
        :url => "https://api.github.com/repos/#{repo}/hooks",
        :user => config["user"],
        :password => config["password"]
      )
      JSON.parse(RestClient::Request.execute(options))
    end
  end
end
