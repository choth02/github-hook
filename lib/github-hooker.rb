require "github-hooker/version"
require 'net/http'
require 'json'
require 'yaml'
require 'restclient'

module Github
  module Hooker

    def self.add_hook(options={})
      payload = {
        :name => options[:name],
        :events => options[:events],
        :active => true,
      }

      request_options = {
        :method => :post,
        :url => "https://api.github.com/repos/#{options[:repo]}/hooks",
        :user => config[:user],
        :password => config[:password],
        :payload => payload
      }
      response = RestClient::Request.execute(request_options)
      response = JSON.parse(response)
    end

    def self.hooks(options={})
      request_options = {
        :method => :get,
        :url => "https://api.github.com/repos/#{options[:repo]}/hooks",
        :user => config["user"],
        :password => config["password"],
        :ssl => true
      }
      response = RestClient::Request.execute(request_options)
      response = JSON.parse(response)
    end

    def self.config
      @config ||= YAML.load_file(File.expand_path("~/.github-hooker.yml"))
    end

    def self.github_api

    end
  end
end
