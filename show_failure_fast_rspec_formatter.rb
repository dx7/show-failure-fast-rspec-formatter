# Rspec 3 formatter by dx7
#
# This formatter immediately shows the failure message when spec fails. Then you don't need
# wait the final report to know about failures.
#
# You can use it directly in the command line:
#   $ rspec --require "/path/to/show_failure_fast_rspec_formatter.rb" --format ShowFailureFastRspecFormatter -- ./spec/your_spec.rb
#
# Or setting the SPEC_OPTS environment variable in your .bash_profile, .zshrc, etc:
#   export SPEC_OPTS="--require ~/Projects/show-failure-fast-rspec-formatter/show_failure_fast_rspec_formatter.rb --format ShowFailureFastRspecFormatter"
#
# Or wherever RSpec reads command line configuration options
#   https://www.relishapp.com/rspec/rspec-core/docs/configuration/read-command-line-configuration-options-from-files

require 'rspec/core/formatters/progress_formatter'

class ShowFailureFastRspecFormatter < RSpec::Core::Formatters::ProgressFormatter
  RSpec::Core::Formatters.register self, :example_failed, :dump_failures, :dump_summary

  def project_name
    @project_name ||= File.basename(Dir.pwd)
  end

  def example_failed(notification)
   output.puts notification.fully_formatted(index)
   system_notification(notification.description, "Rspec #{project_name}", 'Failure/Error')
  end

  def dump_failures(notification)
    # do nothing
  end

  def dump_summary(notification)
    super
    message = notification.fully_formatted(RSpec::Core::Notifications::NullColorizer)
    system_notification(message.split("\n").reverse.join("\n"), "Rspec #{project_name}", 'Success')
  end

  private

    def index
      @index ||= 0
      @index += 1
    end

    def system_notification(message, title, subtitle)
      if RUBY_PLATFORM.match(/darwin/)
        #`osascript -e 'display notification "#{message}" with title "#{title}"'`
        `terminal-notifier -group 'rspec-#{project_name}' -title '#{title}' -subtitle '#{subtitle}' -message '#{message}' -activate 'com.googlecode.iterm2' -sender 'com.googlecode.iterm2'`
      end
    end
end
