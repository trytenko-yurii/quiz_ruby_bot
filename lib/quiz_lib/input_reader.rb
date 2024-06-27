require_relative 'libraries'

module QuizTrytenko
  class InputReader
    def read(welcome_message: nil, validator: nil, error_message: nil, process: nil)
      puts welcome_message if welcome_message

      loop do
        input = gets.chomp

        input = process.call(input) if process

        if validator.nil? || validator.call(input)
          return input
        else
          puts error_message if error_message
        end
      end
    end
  end
end
# Приклад використання
reader = InputReader.new

# Введення числа з перевіркою і обробкою
number = reader.read(
  welcome_message: "Введіть число:",
  validator: ->(input) { input.match?(/^\d+$/) },
  error_message: "Помилка: введіть коректне число.",
  process: ->(input) { input.to_i }
)

puts "Введене число: #{number}"
