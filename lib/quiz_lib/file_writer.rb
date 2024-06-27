require_relative 'libraries'

module QuizTrytenko
  class FileWriter
    attr_accessor :answers_dir, :filename, :mode

    def initialize(mode, *args)
      @answers_dir = args[0] || "."
      @filename = args[1] || "output.txt"
      @mode = mode
    end

    def write(message)
      full_path = prepare_filename(@filename)
      File.open(full_path, @mode) do |file|
        file.puts(message)
      end
    end

    def prepare_filename(filename)
      File.join(@answers_dir, filename)
    end
  end
end
# Приклад використання:
file_writer = FileWriter.new("w", "answers", "output.txt")
file_writer.write("Привіт, світ!")
