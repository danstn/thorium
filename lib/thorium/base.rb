require 'thor'
require 'thor/group'

require_relative 'core/bootstrap.rb'
require_relative 'version'
require_relative 'tasks/configurator'
require_relative 'tasks/common'
require_relative 'tasks/apache'
require_relative 'tasks/git'

module ThoriumCLI
  # Top level tasks for thorium
  # Includes routines that do not require packaging of subcomands
  class Thorium < Thor
    package_name 'Thorium'
    SKIP = ''
    ALIAS = 'th'
    OS = ENV['_system_type']

    include Thor::Actions
    include ApacheCLI
    include GitCLI

    class_option :verbose, type: :boolean, default: false, aliases: :v

    desc 'pubkeys', 'Simple public keys manipulation'
    def pubkeys
      public_keys = Dir.glob(File.expand_path('~/.ssh') + '/*.pub')
      if public_keys.any?
        puts '', 'Public keys found:'
        puts '------------------'
        print_keys public_keys
        ask_options = { limited_to: ('1'..public_keys.size.to_s).to_a, skip: SKIP }
        index = ask('Which key do you want in your clipboard?', :green, ask_options)
        copy_to_clipboard public_keys[index.to_i - 1] if index != ask_options[:skip]
      else
        say 'No public keys have been found.', :red
        generate_new = yes?('Do you want to generate a new one?', :green)
        run 'ssh-keygen' if generate_new
      end
    end

    desc 'fixperms', 'Permissions fixer'
    def fixperms
      system_configurator = ConfiguratorCLI::System.new
      system_configurator.configure :permissions
      # puts ConfiguratorCLI::System.configure :permissions
      # if --config or no fixperms file
      #   run fixperms configurator
      #   config_permissons:
      #     - ask for user/group
      #     - ask for allow-dir (default to /srv)
      # else
      #   run permission fixer: fix_permission
      #     - read user/group
      #     - read allow-dir
      #     - disallow anything but /srv, /home, /var/www
      #     - recursively fix permissions
    end

    # Apache subcommand
    desc 'apache [SUBCOMMAND] [ARGS]', 'Control Apache with ease!'
    subcommand 'apache', Apache

    # Git subcommand
    desc 'git [SUBCOMMAND] [ARGS]', 'Git wrapper'
    subcommand 'git', Git

    # Git subcommand
    desc 'config [SUBCOMMAND] [ARGS]', 'Configurator'
    subcommand 'config', Configurator

    no_commands do

      private
      # Prints public keys with indexes
      def print_keys(public_keys)
        public_keys.each_with_index do |f, i|
          say "[#{i + 1}] #{f}", :blue
          run "cat #{f}", verbose: false
        end
      end

      def copy_to_clipboard(content)
        if run 'which pbcopy > /dev/null', verbose: false
          run "pbcopy < #{content}"
        else
          say 'pbcopy is not installed, cannot copy to clipboard', :red
        end
      end
    end
  end
end
