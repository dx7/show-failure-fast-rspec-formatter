dx7-formatter
=============

This formatter immediately shows the failure message when spec fails. Then you don't need wait the final report to know about failures.

You can use it directly in the command line:

  <code>$ rspec --require "/path/to/dx7_formatter.rb" --format Dx7Formatter -- ./spec/your_spec.rb</code>

Or setting the SPEC_OPTS environment variable in your .bash_profile, .zshrc, etc:

  <code>export SPEC_OPTS="--require ~/Projects/dx7-formatter/dx7_formatter.rb --format Dx7Formatter"</code>

Or wherever RSpec reads command line configuration options
  <https://www.relishapp.com/rspec/rspec-core/docs/configuration/read-command-line-configuration-options-from-files>
