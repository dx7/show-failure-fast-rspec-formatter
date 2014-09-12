# Rspec 3 formatter by dx7
#
# This formatter immediately shows the failure message when spec fails. Then you don't need
# wait the final report to know about failures.
#
# You can use it directly in the command line:
#   $ rspec --require "/path/to/dx7_formatter.rb" --format Dx7Formatter -- ./spec/your_spec.rb
#
# Or setting the SPEC_OPTS environment variable in your .bash_profile, .zshrc, etc:
#   export SPEC_OPTS="--require ~/Projects/dx7-formatter/dx7_formatter.rb --format Dx7Formatter"
#
# Or wherever RSpec reads command line configuration options
#   https://www.relishapp.com/rspec/rspec-core/docs/configuration/read-command-line-configuration-options-from-files

require 'rspec/core/formatters/progress_formatter'

class Dx7Formatter < RSpec::Core::Formatters::ProgressFormatter
  RSpec::Core::Formatters.register self, :example_failed, :dump_failures, :dump_summary

  def example_failed(notification)
   output.puts notification.fully_formatted(index)
   system_notification(notification.description, 'Rspec Failure/Error')
  end

  def dump_failures(notification)
    # do nothing
  end

  def dump_summary(notification)
    super
    message = notification.fully_formatted(RSpec::Core::Notifications::NullColorizer)
    system_notification(message, 'Rspec')
  end

  private

    def index
      @index ||= 0
      @index += 1
    end

    def system_notification(message, title)
      if RUBY_PLATFORM.match(/darwin/)
        `osascript -e 'display notification "#{message}" with title "#{title}"'`
      end
    end
end
