require_relative 'libraries'

module QuizTrytenko
  class FileWriter
    def initialize(file_name)
      @file = File.open(file_name, 'w')
    end

    def write(text)
      @file.write(text)
    end

    def close
      @file.close
    end
  end

  class Statistics
    def initialize(writer)
      @correct_answers = 0
      @incorrect_answers = 0
      @writer = writer
    end

    def correct_answer
      @correct_answers += 1
    end

    def incorrect_answer
      @incorrect_answers += 1
    end

    def print_report
      total_questions = @correct_answers + @incorrect_answers
      correct_percentage = total_questions > 0 ? (@correct_answers.to_f / total_questions * 100).round(2) : 0

      report = <<-REPORT
        Statistics Report:
        Correct Answers: #{@correct_answers}
        Incorrect Answers: #{@incorrect_answers}
        Total Questions: #{total_questions}
        Correct Percentage: #{correct_percentage}%
      REPORT

      @writer.write(report)
      @writer.close
    end
  end
end
# Приклад використання:
file_writer = FileWriter.new('report.txt')
stats = Statistics.new(file_writer)
stats.correct_answer
stats.correct_answer
stats.incorrect_answer
stats.print_report
