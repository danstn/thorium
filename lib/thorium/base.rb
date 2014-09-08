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
    include ConfigCLI
    include ApacheCLI
    include GitCLI

    class_option :verbose, type: :boolean, default: false, aliases: :v

    desc 'pubkey', 'Copy `id_rsa.pub` (default) in your clipboard'
    def pubkey
      path = '~/.ssh/id_rsa.pub'
      file = Dir.glob(File.expand_path(path)).first
      if file
        say "Use `thorium pubkeys` if you want to select a specific key.", :yellow
        copy_to_clipboard file
      else
        say "File `#{path}` has not been found.", :red
        generate_pubkey?
      end
    end

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
        generate_pubkey?
      end
    end

    # Apache subcommand
    desc 'apache [SUBCOMMAND] [ARGS]', 'Apache controller'
    subcommand 'apache', Apache

    # Git subcommand
    desc 'git [SUBCOMMAND] [ARGS]', 'Git wrapper'
    subcommand 'git', Git

    # Runcom subcommand
    desc 'runcom [SUBCOMMAND] [ARGS]', 'Runcom files'
    subcommand 'runcom', Runcom

    no_commands do

      private

      # Prompts to run `ssh-keygen`
      def generate_pubkey?
        answered_yes = yes?('Do you want to generate a new public pubkey?', :green)
        run 'ssh-keygen', verbose: false if answered_yes
      end

      # Prints public keys with indexes
      def print_keys(public_keys)
        public_keys.each_with_index do |f, i|
          say "[#{i + 1}] #{f}", :blue
          run "cat #{f}", verbose: false
        end
      end

      def copy_to_clipboard(content)
        say "(!) No content provided.", :red unless content
        if (run 'which pbcopy > /dev/null', verbose: false)
          run "pbcopy < #{content}", verbose: false
          say "--> `#{content}` copied to your clipboard.", :blue
        else
          say 'pbcopy is not installed, cannot copy to clipboard', :red
        end
      end

    end
  end
end
