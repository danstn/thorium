require "thor"

class Thor
  module Shell
    class Basic

      def ask_filtered(statement, color, options)
        answer_set = options[:limited_to]
        correct_answer = nil
        if options.has_key? :skip
          statement += options[:skip].strip.empty? ? " (Enter to skip)" : " (#{options[:skip]} to skip)"
        end
        until correct_answer
          answers = answer_set.join(", ")
          answer = ask_simply("#{statement} [#{answers}]", color, options)
          skipped = (options.has_key?(:skip) && (answer == options[:skip].chomp))
          correct_answer = answer_set.include?(answer) || skipped ? answer : nil
          say("Your response must be one of: [#{answers}]. Please try again.") unless correct_answer
        end
        correct_answer
      end

    end
  end
end