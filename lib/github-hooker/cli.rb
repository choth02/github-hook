module Github
  module Hooker
    class CLI < Thor
      desc "list user/repo", "List hooks in the given repository"
      def list(repo)
        hooks = Github::Hooker.hooks(repo)
        hooks.each do |hook|
          puts "#{hook['url']}"
          puts "> name:   #{hook['name']}"
          puts "> events: #{hook['events'].join(", ")}"
          puts
        end
      end

      desc "campfire user/repo events", "Add a campfire hook in the given repository. Events must be separated by commas."
      method_option :room,       :required => true
      method_option :subdomain,  :required => true
      def campfire(repo, events)
        events = split_events(events)
        puts Github::Hooker.add_hook(repo, :name => "campfire", :events => events, :config => options)
      end

      desc "web user/repo events", "Add a web hook in the given repository. Events must be separated by commas."
      method_option :url, :required => true
      def web(repo, events)
        events = split_events(events)
        puts Github::Hooker.add_hook(repo, :name => "web", :events => events, :config => options)
      end

      private
      def split_events(events)
        events.split(",").map(&:strip)
      end
    end
  end
end
