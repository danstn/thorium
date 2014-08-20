module GitCLI
  class Git < Thor
    package_name 'Thorium | Git'

    include Thor::Actions

    class_option :verbose, :type => :boolean, :default => 1
    @@gh_api_url = "https://api.github.com"

    desc "list", "Lists Github repositories"
    def list
      require 'json'
      require 'pp'
      gh_uname = ask("Enter Github username: ", :green)
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
      index = ask("Which repository would you like to clone?", :green, :limited_to => ("1".."#{@repos.size}").to_a).to_i
      protocol = ask("Select a protocol (ssh or https)?", :green, :limited_to => ["s", "h"])
      url = protocol == "s" ? @repos[index-1][2] : @repos[index-1][3]
      run("git clone #{url}")
    end

    no_commands {
      # Fetches Github repositories for a given user
      def get_gh_repos(uname)
        url = "#{@@gh_api_url}/users/#{uname}/repos"
        gh_repos_filepath = ENV['HOME'] + "/.thorium/gh_repos_#{uname}.json"
        get url, gh_repos_filepath, :verbose => false
        JSON.parse File.read(gh_repos_filepath)
      end
    }
  end
end