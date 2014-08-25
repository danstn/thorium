module GitCLI
  # Git tasks package
  # Listing and cloning of repositories (Github support included)
  class Git < Thor
    package_name 'Thorium | Git'
    GH_API_URL = 'https://api.github.com'

    include Thor::Actions

    class_option :verbose, type: :boolean, default: 1

    desc 'list', 'Lists Github repositories'
    def list
      require 'json'
      gh_uname = ask('Enter Github username: ', :green)
      abort if gh_uname.empty?
      puts "\nFetching Github repositories (#{gh_uname})..."
      puts '------------------------------------------'
      @repos = get_gh_repos(gh_uname).each_with_index.map do |e, i|
        e.values_at('name', 'ssh_url', 'clone_url').unshift("[#{i + 1}]")
      end
      print_table @repos
    end

    desc 'clone', 'Clones a repository from the list'
    def clone
      list
      # Do not do anything if list is empty
      ask_options = { limited_to: ('1'..@repos.size.to_s).to_a, skip: '' }
      answer = ask('Which repository would you like to clone?', :green, ask_options)
      abort if answer == ask_options[:skip]
      protocol = ask('Select a protocol (ssh or https)?', :green, limited_to: %w(s h))
      url = if protocol == 's'
        @repos[answer.to_i - 1][2]
      else
        @repos[answer - 1][3]
      end
      run "git clone #{url}"
    end

    desc "trello", "Integrates Git with Trello"
    def trello
      # @STUB: trello poc placeholder
      # @TODO: Abstract and implement the placeholders below
      current_folder = yes?("Use current folder?", :green)
      trello_uname = ask("--> Trello username?", :green)
      trello_paswd = ask("--> Trello password?", :echo => false, :green)
      say "<LIST OF BOARDS WITH OPTIONS>"
      ask("Choose a baord? ", :green, :limited_to => ("1".."8").to_a)
      yes?("Do you want to sync with a remote?", :green)
      say "Syncing remote..."
      say "Adding post-commit hook..."
      say "All local commits will now be in Trello cards activity!"
    end

    no_commands do
      # Fetches Github repositories for a given user
      def get_gh_repos(uname)
        url = "#{GH_API_URL}/users/#{uname}/repos"
        gh_repos_filepath = ENV['HOME'] + "/.thorium/gh_repos_#{uname}.json"
        get url, gh_repos_filepath, verbose: false
        JSON.parse File.read(gh_repos_filepath)
      end
    end
  end
end
