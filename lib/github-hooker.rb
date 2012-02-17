require "github-hooker/version"
require "github-hooker/config"
require 'net/http'
require 'json'
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

    def self.github_api(method, url, options={})
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
