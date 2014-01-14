module Github
  module Hook
    class CLI < Thor
      desc "list user/repo", "List hooks in the given repository"
      def list(repo)
        handle_404 do
          check_config!
          hooks = Github::Hook.hooks(repo)
          hooks.each do |hook|
            puts "#{hook['url']}"
            puts "> name:       #{hook['name']}"
            puts "> updated_at: #{hook['updated_at']}"
            puts "> created_at: #{hook['created_at']}"
            puts "> events:     #{hook['events'].join(", ")}"
            puts "> active:     #{hook['active']}"
            puts "> config:     #{hook['config']}"
            puts
          end unless hooks.nil?
        end
      end

      desc "campfire user/repo events", "Add a campfire hook in the given repository. Events must be separated by commas."
      method_option :room,       :required => true
      method_option :subdomain,  :required => true
      method_option :token,      :required => false
      def campfire(repo, events)
        handle_404 do
          check_config!
          events = split_events(events)
          Github::Hook.add_hook(repo, :name => "campfire", :events => events, :config => options.reverse_merge("token" => Github::Hook::Config.config['campfire_token']))
        end
      end

      desc "email user/repo events", "Add an email hook in the given repository. Events must be separated by commas."
      method_option :address, :required => true
      method_option :secret
      method_option :send_from_author, :default => "1"
      def email(repo, events)
        handle_404 do
          check_config!
          events = split_events(events)
          Github::Hook.add_hook(repo, :name => "email", :events => events, :config => options)
        end
      end

      desc "web user/repo events", "Add a web hook in the given repository. Events must be separated by commas."
      method_option :url, :required => true
      method_option :secret
      def web(repo, events)
        handle_404 do
          check_config!
          events = split_events(events)
          Github::Hook.add_hook(repo, :name => "web", :events => events, :config => options)
        end
      end

      desc "delete user/repo hook", "Delete the hook 1111 from the given repository"
      def delete(repo, hook)
        handle_404 do
          check_config!
          Github::Hook.delete_hook(repo, hook)
        end
      end

      private
      def handle_404
        yield
      rescue RestClient::ResourceNotFound
        resource_not_found_message!
      end

      def split_events(events)
        events.split(",").map(&:strip)
      end

      def check_config!
        unless Github::Hook::Config.config.key?('user')
          error("~/.github-hook.yml is not present. Please set 'user', 'password' and 'campfire_token'.")
        end
      end

      def resource_not_found_message!
        error("Resource Not Found (404): This repository may not exist or you may not have access to it.")
      end

      def error(message)
        puts message
        exit 1
      end
    end
  end
end
