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

    include Thor::Actions

    desc 'vim', 'Vim runcom file'
    def vim
      say ".vimrc file written"
    end

    desc 'sqlite', 'SQLite runcom file'
    def sqlite
      `touch ~/.sqliterc && echo '.headers ON' >> ~/.sqliterc && echo '.mode column' >> ~/.sqliterc`
      say ".sqliterc file written"
    end

  end

end

