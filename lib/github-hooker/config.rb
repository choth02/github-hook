require 'yaml'

module Github
  module Hooker
    module Config
      def self.filename
        "~/.github-hooker.yml"
      end

      def self.config
        @config ||= YAML.load_file(File.expand_path(filename))
      end
    end
  end
end
