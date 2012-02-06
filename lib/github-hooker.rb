require "github-hooker/version"
require 'net/http'
require 'json'
require 'yaml'
require 'restclient'
require 'active_support/core_ext/hash/reverse_merge'

module Github
  module Hooker
    def self.hooks(repo)
      url = "https://api.github.com/repos/#{repo}/hooks"
      github_api(:get, url)
    end

    def self.add_hook(repo, payload={})
      url = "https://api.github.com/repos/#{repo}/hooks"
      payload = payload.reverse_merge(:active => true)
      github_api(:post, url, :payload => payload.to_json)
    end

    def self.delete_hook(repo, hook)
      url = "https://api.github.com/repos/#{repo}/hooks/#{hook}"
      github_api(:delete, url)
    end

    def self.config
      @config ||= YAML.load_file(File.expand_path(config_filename))
    end

    def self.github_api(method, url, options={})
      options.reverse_merge!(
        :method => method,
        :url => url,
        :user => config["user"],
        :password => config["password"]
      )
      response = RestClient::Request.execute(options)
      begin
        JSON.parse(response)
      rescue JSON::ParserError
        response
      end
    end

    def self.config_filename
      "~/.github-hooker.yml"
    end
  end
end
