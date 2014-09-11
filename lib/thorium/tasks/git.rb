module GitCLI
  # Git tasks package
  # Listing and cloning of repositories (Github support included)
  class Git < Thor
    package_name 'Thorium | Git'
    GH_API_URL     = 'https://api.github.com'
    GITIGNORE_REPO = 'https://raw.githubusercontent.com/github/gitignore/master/'

    require 'json'
    include Thor::Actions

    class_option :verbose, type: :boolean, default: 1

    desc 'list', 'Lists repositories (Github)'
    def list
      gh_uname = ask('Enter Github username: ', :green)
      abort if gh_uname.empty?
      say msg = "Fetching Github repositories (#{gh_uname})..." and say '-' * msg.size
      @repos = get_gh_repos(gh_uname).each_with_index.map do |e, i|
        e.values_at('name', 'ssh_url', 'clone_url').unshift("[#{i + 1}]")
      end
      print_table @repos
    end

    desc 'clone', 'Clones a repository from the list (Github)'
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
        @repos[answer.to_i - 1][3]
      end
      run "git clone #{url}"
    end

    desc 'ignore', 'Creates a specific .gitignore file in the current folder'
    method_option aliases: 'i'
    def ignore
      say msg = 'Fetching a list of gitignore files...' and say '-' * msg.size
      files = get_gitignore_list.map { |e| e['name'] }
      gitignore_files = files.each_with_index.map do |e, i|
        "[#{i}] #{File.basename(e, '.*')}"
      end
      print_in_columns gitignore_files
      ask_options = {
        mute_limit_set: true,
        limited_to:     ('1'..files.size.to_s).to_a,
        skip:           ''
      }
      answer = ask('Which file would you like to copy?', :green, ask_options)
      abort if answer == ask_options[:skip]
      create_gitignore(Dir.pwd + '/.gitignore', files[answer.to_i - 1])
    end

    no_commands do

      private

      # Fetches Github repositories for a given user
      def get_gh_repos(uname)
        url = "#{GH_API_URL}/users/#{uname}/repos"
        gh_repos_filepath = ENV['HOME'] + "/.thorium/gh_repos_#{uname}.json"
        get url, gh_repos_filepath, verbose: false
        JSON.parse File.read(gh_repos_filepath)
      end

      # Fetches a list of predefined gitignore files from github/gitignore repo
      def get_gitignore_list
        url = "#{GH_API_URL}/repos/github/gitignore/contents"
        gitignore_list_filepath = ENV['HOME'] + '/.thorium/gh_gitignore_list.json'
        get url, gitignore_list_filepath, verbose: false
        JSON.parse File.read(gitignore_list_filepath)
      end

      # Fetch gitignore file
      def create_gitignore(file_path, file_url)
        url = GITIGNORE_REPO + file_url
        get url, file_path
      end
    end
  end
end
