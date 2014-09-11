require 'thor'

class Thor
  module Shell
    # Top level commit
    class Basic
      def ask_filtered(statement, color, options)
        answer_set = options[:limited_to]
        if options.key? :skip
          statement += if options[:skip].strip.empty?
            ' (Enter to skip)'
          else
            " (#{options[:skip]} to skip)"
          end
        end
        correct_answer answer_set, options, color, statement
      end

      def correct_answer(answer_set, options, color, statement)
        result = nil
        answers = answer_set.join(', ')

        statement += " [#{answers}]" unless options[:mute_limit_set]

        until result
          answer = ask_simply(statement, color, options)
          skipped = (options.key?(:skip) && (answer == options[:skip].chomp))
          result = answer_set.include?(answer) || skipped ? answer : nil
          unless result
            if options[:mute_limit_set]
              say('Your response is invalid. Please try again.')
            else
              say("Your response must be one of: [#{answers}]. Please try again.")
            end
          end
        end

        result
      end
    end
  end
end
