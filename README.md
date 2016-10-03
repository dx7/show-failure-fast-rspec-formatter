show-failure-fast-rspec-formatter
=============

This formatter immediately shows the failure message when spec fails. Then you don't need wait the final report to know about failures.

You can use it directly in the command line:

  <code>$ rspec --require "/path/to/show_failure_fast_rspec_formatter.rb" --format ShowFailureFastRspecFormatter -- ./spec/your_spec.rb</code>

Or setting the SPEC_OPTS environment variable in your .bash_profile, .zshrc, etc:

  <code>export SPEC_OPTS="--require ~/Projects/show-failure-fast-rspec-formatter/show_failure_fast_rspec_formatter.rb --format ShowFailureFastRspecFormatter"</code>

Or wherever RSpec reads command line configuration options
  <https://www.relishapp.com/rspec/rspec-core/docs/configuration/read-command-line-configuration-options-from-files>
