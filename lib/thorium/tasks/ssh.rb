module SshCLI
  # Git tasks package
  # Listing and cloning of repositories (Github support included)
  class Ssh < Thor
    package_name 'Thorium | SSH'

    include Thor::Actions

    desc 'pubkey', 'Copy `id_rsa.pub` (default) in your clipboard'
    def pubkey
      path = '~/.ssh/id_rsa.pub'
      file = Dir.glob(File.expand_path(path)).first
      if file
        say "Use `thorium pubkeys` if you want to select a specific key.", :yellow
        copy_to_clipboard file
      else
        say "File `#{path}` has not been found.", :red
        generate_pubkey?
      end
    end

    desc 'pubkeys', 'Simple public keys manipulation'
    def pubkeys
      public_keys = Dir.glob(File.expand_path('~/.ssh') + '/*.pub')
      if public_keys.any?
        puts '', 'Public keys found:'
        puts '------------------'
        print_keys public_keys
        ask_options = { limited_to: ('1'..public_keys.size.to_s).to_a, skip: '' }
        index = ask('Which key do you want in your clipboard?', :green, ask_options)
        copy_to_clipboard public_keys[index.to_i - 1] if index != ask_options[:skip]
      else
        say 'No public keys have been found.', :red
        generate_pubkey?
      end
    end

    no_commands do

      private

      # Prompts to run `ssh-keygen`
      def generate_pubkey?
        answered_yes = yes?('Do you want to generate a new public pubkey?', :green)
        run 'ssh-keygen', verbose: false if answered_yes
      end

      # Prints public keys with indexes
      def print_keys(public_keys)
        public_keys.each_with_index do |f, i|
          say "[#{i + 1}] #{f}", :blue
          run "cat #{f}", verbose: false
        end
      end

      def copy_to_clipboard(content)
        say "(!) No content provided.", :red unless content
        if (run 'which pbcopy > /dev/null', verbose: false)
          run "pbcopy < #{content}", verbose: false
          say "--> `#{content}` copied to your clipboard.", :blue
        else
          say 'pbcopy is not installed, cannot copy to clipboard', :red
        end
      end

    end
  end
end
