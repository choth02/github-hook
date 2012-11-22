require "github-hooker/version"
require "github-hooker/config"
require 'net/http'
require 'json'
require 'restclient'
require 'active_support/core_ext/hash/reverse_merge'

module Github
  module Hooker
    def self.hooks(repo)
      path = "/repos/#{repo}/hooks"
      github_api(:get, path)
    end

    def self.add_hook(repo, payload={})
      path = "/repos/#{repo}/hooks"
      payload = payload.reverse_merge(:active => true)
      github_api(:post, path, :payload => payload.to_json)
    end

    def self.delete_hook(repo, hook)
      path = "/repos/#{repo}/hooks/#{hook}"
      github_api(:delete, path)
    end

    def self.github_api(method, path, options={})
      github_url = Github::Hooker::Config.config.fetch("api_url", "https://api.github.com")
      url = github_url + path

      options.reverse_merge!(
        :method   => method,
        :url      => url,
        :user     => Github::Hooker::Config.config["user"],
        :password => Github::Hooker::Config.config["password"]
      )
      response = RestClient::Request.execute(options)
      case response.code
      when 201, 200
        JSON.parse(response)
      when 204, 404, 500
        response
      end
    end
  end
end
