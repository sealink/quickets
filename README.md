# Quickets

Ticket printing web service -- useful for printing from the browser
directly from javascript.

Exposes the following http API:

    GET  /               Returns a string
    GET  /printers       Returns a list of printer names
    POST /print-tickets  Prints the given tickets to the specifically
                         named printer

In all but the simple "/" path, an api_key is required.

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

## Running

The QUICKETS_DIR env var must be set, which points to the directory
holding the configuration file.

    QUICKETS_DIR=./config bundle exec puma

The puma cli has been copy-pasted to exe/quickets to allow simpler gem
install then run.

Warbler is also configured which will package up the jruby app along
with the jetty web server -- to use it:

    warble executable war
    QUICKETS_DIR=~/quickets/config java -jar quickets.war

Note that the java web server can't use a relative QUICKETS_DIR since it
will unpack the jar into a tmp directory.

## Configuration

Configuration is through a quickets.yml file which should be in the
directory specified by QUICKETS_DIR.

This file contains a map where the keys are api keys, and the values are
printer names. An examples:

    wharf-api12345ZSDFLKJSFD:
      - Front Counter Printer
      - Ticket Office Printer

The printer names given should match exactly as defined in your systems
printer configuration.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

Depends on [sealink/ticket_printer](https://github.com/sealink/ticket_printer)
which is compiled, then built into a single jar, and exists in lib/jars.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/quickets. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

