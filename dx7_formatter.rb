# Rspec 2 formatter by rafaeldx7
# Use: rspec --require "dx7_formatter.rb" --format Dx7Formatter -- ./spec/your_spec.rb

require 'rspec/core/formatters/base_text_formatter'

class Dx7Formatter < RSpec::Core::Formatters::BaseTextFormatter

  def index
    @index ||= -1
    @index += 1
  end

  def example_passed(example)
    super
    output.print success_color('.')
  end

  def example_pending(example)
    super
    output.print pending_color('*')
  end

  def example_failed(example)
    super
    output.puts
    dump_failure(example, index)
    dump_backtrace(example)
    exception = example.execution_result[:exception]
    `osascript -e 'display notification "#{exception.message.gsub(/"/, '\"')}" with title "Rspec Error"'`
  end

  def start_dump
    super
    output.puts
  end

  def dump_failures
  end

  def dump_summary(duration, example_count, failure_count, pending_count)
    super
    `osascript -e 'display notification "#{summary_line(example_count, failure_count, pending_count)}" with title "Rspec Finished"'`
  end

  def close
    super

    image_color = if @failure_count > 0
                    "red"
                  elsif @pending_count > 0
                    "yellow"
                  elsif @example_count == 0
                    "grey"
                  else
                    "green"
                  end
  end

end
