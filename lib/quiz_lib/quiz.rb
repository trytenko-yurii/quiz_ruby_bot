require_relative 'libraries'

module QuizTrytenko
  class Quiz
    include Singleton

    attr_accessor :yaml_dir, :in_ext, :answers_dir

    def config
      yield self if block_given?
    end
  end
end
