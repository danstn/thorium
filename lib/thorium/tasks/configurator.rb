module ConfiguratorCLI
  # Top level comment for apache
  class System < Thor

    package_name 'Thorium | Configurator'

    include Thor::Actions

    desc 'configure', 'Clones a repository from the list'
    def configure(context = nil)
      say "Running System configurator...", :blue and return unless context
      self::send context
    rescue NoMethodError => e
      puts e
    end

    desc 'permissions', 'Clones a repository from the list'
    def permissions
      say "Configuring permissions fixer...", :blue
      user = ask("User:", :green)
      group = ask("Group:", :green)
      ask_options = { limited_to: %w(/srv /var/www), skip: '' }
      say "`/srv` will be used as default safe directory if skipped", :red
      answer = ask('Safe directory:', :green, ask_options)
    end

    desc 'sqlite', 'SQLite configuration file'
    def sqlite
      `touch ~/.sqliterc && echo '.headers ON' >> ~/.sqliterc && echo '.mode column' >> ~/.sqliterc`
    end

    no_commands {}

  end
end

