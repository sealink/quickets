# Quickets

Ticket printing web service -- useful for printing from the browser
directly from javascript.

## Installation

This is a jruby gem and require Java 1.7+.

Add this line to your application's Gemfile:

```ruby
gem 'quickets'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install quickets

## Usage

The QUICKETS_DIR env var must be set, which points to the directory
holding the configuration file.

    QUICKETS_DIR=./config bundle exec puma

The puma cli has been copy-pasted to exe/quickets to allow simpler gem
install then run.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

Depends on [sealink/ticket_printer](https://github.com/sealink/ticket_printer)
which is compiled, then built into a single jar, and exists in lib/jars.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/quickets. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

