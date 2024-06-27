require_relative 'libraries'

Quiz.instance.config do |config|
  config.yaml_dir = '/path/to/yaml'
  config.in_ext = '.yml'
  config.answers_dir = '/path/to/answers'
end

# Перевірка налаштувань:
puts Quiz.instance.yaml_dir      # => /path/to/yaml
puts Quiz.instance.in_ext        # => .yml
puts Quiz.instance.answers_dir   # => /path/to/answers
