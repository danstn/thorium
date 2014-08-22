require 'thor'
require 'thor/group'

require_relative 'core/bootstrap.rb'
require_relative 'version'
require_relative 'tasks/common'
require_relative 'tasks/apache'
require_relative 'tasks/git'

module ThoriumCLI
  # top level comment here for Thorium
  class Thorium < Thor
    package_name 'Thorium'
    SKIP = ''
    ALIAS = 'th'
    OS = ENV['_system_type']

    include Thor::Actions
    include ApacheCLI
    include GitCLI

    class_option :verbose,
                 type:    :boolean,
                 default: false,
                 aliases: :v

    desc 'pubkeys', 'Simple public keys manipulation tool'
    def pubkeys
      public_keys = Dir.glob(File.expand_path('~/.ssh') + '/*.pub')
      if public_keys.any?
        puts '\nPublic keys found:'
        puts '------------------'
        print_keys public_keys
        ask_options = { limited_to: (1..public_keys.size).to_a, skip: SKIP }
        index = ask('Which key do you want in your clipboard?', :green, ask_options)
        run 'pbcopy < #{public_keys[index.to_i-1]}' if index != ask_options[:skip]
      else
        say 'No public keys have been found.', :red
        generate_new = yes?('Do you want to generate a new one?', :green)
        run 'ssh-keygen' if generate_new
      end
    end

    private def print_keys(public_keys)
      public_keys.each_with_index do |f, i|
        say "[#{i + 1}] #{f}", :blue
        run "cat #{f}", verbose: false
      end
    end

    # Apache subcommand
    desc 'apache [SUBCOMMAND] [ARGS]', 'Control Apache with ease!'
    subcommand 'apache', Apache

    # Git subcommand
    desc 'git [SUBCOMMAND] [ARGS]', 'Git wrapper'
    subcommand 'git', Git
  end
end
