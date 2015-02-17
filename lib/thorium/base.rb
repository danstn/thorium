require 'thor'
require 'thor/group'

require_relative 'core/bootstrap.rb'
require_relative 'version'
require_relative 'tasks/configurator'
require_relative 'tasks/common'
require_relative 'tasks/apache'
require_relative 'tasks/git'
require_relative 'tasks/ssh'

module ThoriumCLI
  # Top level tasks for thorium
  # Includes routines that do not require packaging of subcomands
  class Thorium < Thor
    package_name 'Thorium'

    include ConfigCLI
    include ApacheCLI
    include GitCLI
    include SshCLI

    # Apache subcommand
    desc 'apache [SUBCOMMAND] [ARGS]', 'Apache controller'
    subcommand 'apache', Apache

    # Git subcommand
    desc 'git [SUBCOMMAND] [ARGS]', 'Git wrapper'
    subcommand 'git', Git

    # Runcom subcommand
    desc 'runcom [SUBCOMMAND] [ARGS]', 'Runcom files'
    subcommand 'runcom', Runcom

    # SSH subcommand
    desc 'ssh [SUBCOMMAND] [ARGS]', 'SSH-related tasks'
    subcommand 'ssh', Ssh
  end
end
