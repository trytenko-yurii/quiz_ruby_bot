# question_data.rb
require_relative 'libraries'

module QuizTrytenko
  class QuestionData
    attr_accessor :collection, :yaml_dir, :in_ext, :threads

    def initialize(yaml_dir, in_ext = 'yaml')
      @collection = []
      @yaml_dir = yaml_dir
      @in_ext = in_ext
      @threads = []
      load_data
    end

    def to_yaml
      @collection.map(&:to_hash).to_yaml
    end

    def save_to_yaml(filename)
      File.write(prepare_filename(filename), to_yaml)
    end

    def to_json
      @collection.map(&:to_hash).to_json
    end

    def save_to_json(filename)
      File.write(prepare_filename(filename), to_json)
    end

    private

    def prepare_filename(filename)
      File.expand_path(filename, __dir__)
    end

    def each_file(&block)
      Dir.glob(File.join(@yaml_dir, "*.#{@in_ext}")).each do |filename|
        block.call(filename)
      end
    end

    def in_thread(&block)
      thread = Thread.new(&block)
      @threads << thread
    end

    def load_data
      each_file do |filename|
        in_thread { load_from(filename) }
      end
      @threads.each(&:join)
    end

    def load_from(filename)
      data = YAML.load_file(filename)
      data.each do |item|
        question = Question.new(item['question'], item['answers'].shuffle)
        @collection << question
      end
    end
  end
end
