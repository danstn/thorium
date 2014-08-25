module ApacheCLI
  # Top level comment for apache
  class Apache < Thor
    package_name 'Thorium | Apache'

    include Thor::Actions

    class_option :verbose, type: :boolean, default: true
    class_option :sudo, type: :boolean, default: true
    class_option :ctl_method, enum: %w(apachectl apache2ctl service), default: 'apachectl'

    desc 'ctl [ARGS]', 'Apache controller wrapper'
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
      command = 'sudo ' + command if options[:sudo]
      run command, verbose: options[:verbose], capture: false
    end

    no_commands {}
  end
end
