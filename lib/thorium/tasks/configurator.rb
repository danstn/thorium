module ConfigCLI

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

