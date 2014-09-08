module ConfigCLI

  # General configurator
  class Config < Thor

    package_name 'Thorium | Configurator'

    include Thor::Actions

    desc 'permissions', 'Permission fixer setup'
    def permissions
      say "Configuring permissions fixer...", :blue
      user = ask("User:", :green)
      group = ask("Group:", :green)
      ask_options = { limited_to: %w(/srv /var/www), skip: '' }
      say "`/srv` will be used as default safe directory if skipped", :red
      answer = ask('Safe directory:', :green, ask_options)
    end

    no_commands do

      # Run a configurator given a context
      def configure(context = nil)
        say "Running System configurator...", :blue and return unless context
        self::send context
      rescue NoMethodError => e
        puts e
      end

    end

  end

  # RC files setup
  class Runcom < Thor

    package_name 'Thorium | Runcom'

    TH_URL = "https://raw.githubusercontent.com/dzotokan/thorium/master"
    RC_PATH = "lib/thorium/templates/rc"
    RC_FULL = "#{TH_URL}/#{RC_PATH}"

    include Thor::Actions

    desc 'all', 'Run all rc files'
    def all
      [:vim, :sqlite].each do |m|
        say "--> Running rc for: #{m.to_s}", :yellow
        self::send m
      end
    end

    desc 'vim', 'Vim runcom file'
    def vim
      say_rc_fetch
      get "#{RC_FULL}/vimrc.th-tpl", "~/.vimrc"
    end

    desc 'sqlite', 'SQLite runcom file'
    def sqlite
      say_rc_fetch
      get "#{RC_FULL}/sqliterc.th-tpl", "~/.sqliterc"
    end

    no_commands do

      def say_rc_fetch
        say "--> Fetching data from remote...", :blue
      end

    end

  end

end

