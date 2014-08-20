#!/usr/bin/env ruby

require 'thor'
require 'thor/group'

module ApacheCLI
  class Apache < Thor
    package_name 'Thorium | Apache'

    include Thor::Actions

    class_option :verbose, :type => :boolean, :default => 1
    class_option :sudo, :type => :boolean, :default => 1
    class_option :ctl_method, :enum => ['apachectl', 'apache2ctl', 'service'], :default => 'apachectl'

    desc "ctl [ARGS]", "Apache controller wrapper"
    long_desc <<-LONGDESC
      `start`     - Starts apache
      `stop`      - Stops apache
      `restart`   - Restarts apache
      `graceful`  - Restarts apache gracefully
      `status`    - Apache status
      > $ ctl restart
    LONGDESC
    def ctl(*args)
      command = "#{options[:ctl_method]} #{args * ' '}"
      command = 'sudo ' + command if options[:root] == 1
      run(command, {:verbose => options[:verbose], :capture => false})
    end

    no_commands {

    }
  end
end

module GitCLI
  class Git < Thor
    package_name 'Thorium | Git'

    include Thor::Actions

    @@gh_api_url = "https://api.github.com"

    class_option :verbose, :type => :boolean, :default => 1

    desc "list", "Lists Github repositories"
    def list
      require 'json'
      require 'pp'
      gh_uname = ask("Enter Github username: ")
      puts "\nFetching Github repositories (#{gh_uname})..."
      puts "------------------------------------------"
      @repos = get_gh_repos(gh_uname).each_with_index.map do |e, i|
        e.values_at("name", "ssh_url", "clone_url").unshift("[#{i+1}]")
      end
      print_table @repos
    end

    desc "clone", "Clones a repository from the list"
    def clone
      list
      index = ask("Which repository would you like to clone?", :limited_to => ("1".."#{@repos.size}").to_a).to_i
      protocol = ask("Select a protocol (ssh or https)?", :limited_to => ["s", "h"])
      url = protocol == "s" ? @repos[index-1][2] : @repos[index-1][3]
      run("git clone #{url}")
    end

    no_commands {
      def get_gh_repos(uname)
        url = "#{@@gh_api_url}/users/#{uname}/repos"
        gh_repos_filepath = ENV['HOME'] + "/.thorium/gh_repos_#{uname}.json"
        get url, gh_repos_filepath, :verbose => false
        JSON.parse File.read(gh_repos_filepath)
      end
    }

  end
end


module ThoriumCLI
  # Main tasks class
  class Thorium < Thor
    package_name 'Thorium'

    include ApacheCLI
    include GitCLI
    include Thor::Actions

    @@os = ENV['_system_type']

    class_option :verbose, :type => :boolean, :default => false

    desc "hello", "This command says hello to Thorium!"
    def hello
      name = ask("What is your name?")
      puts "Hello #{name}! Hello from Thorium!"
    end

    desc "pubkeys", "Show all public keys available"
    def pubkeys
      run("cat ~/.ssh/*.pub", :verbose => false)
    end

    desc "apache [SUBCOMMAND] [ARGS]", "Control Apache with ease!"
    subcommand "apache", Apache

    desc "git [SUBCOMMAND] [ARGS]", "Git wrapper"
    subcommand "git", Git
  end
end


ThoriumCLI::Thorium.start(ARGV)