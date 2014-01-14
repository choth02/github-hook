require 'yaml'

module Github
  module Hook
    module Config
      FILENAME = '~/.github-hook.yml'

      def self.config
        @config ||= YAML.load_file(File.expand_path(FILENAME))
      end
    end
  end
end
