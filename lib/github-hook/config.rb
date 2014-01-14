require 'yaml'

module Github
  module Hook
    module Config
      def self.filename
        "~/.github-hook.yml"
      end

      def self.config
        @config ||= YAML.load_file(File.expand_path(filename))
      end
    end
  end
end
