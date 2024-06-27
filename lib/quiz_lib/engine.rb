require_relative 'libraries'

module QuizTrytenko
  class Engine
    attr_reader :question_collection, :user_name, :current_time, :writer, :statistics, :input_reader

    def initialize(input_reader)
      @input_reader = input_reader
      @user_name = @input_reader.read("Enter your name: ")
      @current_time = Time.now.strftime("%Y-%m-%d %H:%M:%S")
      @question_collection = load_questions
      @writer = FileWriter.new
      @statistics = Statistics.new
    end

    def load_questions
      yaml_questions = YAML.load_file('questions.yaml')
      json_questions = JSON.parse(File.read('questions.json'))
      yaml_questions + json_questions
    end

    def run
      @question_collection.each do |question|
        puts question['text']
        question['options'].each_with_index do |option, index|
          puts "#{('A'.ord + index).chr}. #{option}"
        end
        user_answer = get_answer_by_char(question)
        correct_answer = question['answer']
        check(user_answer, correct_answer)
      end
      @writer.write(@statistics.to_h)
    end

    def check(user_answer, correct_answer)
      if user_answer == correct_answer
        puts "Correct!"
        @statistics.increment_correct
      else
        puts "Incorrect. The correct answer was #{correct_answer}."
        @statistics.increment_incorrect
      end
    end

    def get_answer_by_char(question)
      loop do
        user_input = @input_reader.read("Your answer: ").strip.upcase
        if user_input.empty?
          puts "Answer cannot be empty. Please enter a valid option."
        elsif ('A'..'D').include?(user_input)
          return user_input
        else
          puts "Invalid option. Please enter a valid option (A, B, C, or D)."
        end
      end
    end
  end
end
