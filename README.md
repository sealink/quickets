# Quickets

Ticket printing web service -- useful for printing from the browser
directly from javascript.

Exposes the following http API:

    GET  /               Returns a string
    GET  /printers       Returns a list of printer names
    POST /print-tickets  Prints the given tickets to the specifically
                         named printer

In all but the simple "/" path, an api_key is required.

Note:

This is a jruby app and require Java 1.7+.

## Running

The QUICKETS_DIR env var must be set, which points to the directory
holding the configuration file. If not set, it is defaulted to `/quickets`
which on windows is the same as `C:\quickets`.

    QUICKETS_DIR=./config bin/rackup

Warbler is also configured which will package up the jruby app along
with the jetty web server -- to use it:

    warble executable war
    QUICKETS_DIR=~/quickets/config java -jar quickets.war

The 'executable' param embeds jetty for cmd line run.

## Prod deployment

* Run `gem install warbler` to get the warbler utilitiy
* Run `warble war` to build dist/ROOT.war (note no "R" in the cmd)
* Copy dist/ROOT.war to your java app servers webapp dir

The war file will be unpacked and available on root (at least for
tomcat).

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

After checking out the repo, run `bundle` to install dependencies.
Then, run `rake spec` to run the tests.

You can also run `bin/console` for an interactive prompt that will allow you to experiment.

Depends on [sealink/ticket_printer](https://github.com/sealink/ticket_printer)
which is compiled, then built into a single jar, and has been copied in lib/jars.

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/[USERNAME]/quickets. This project is intended to be a safe,
welcoming space for collaboration, and contributors are expected to adhere to the
[Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the
[MIT License](http://opensource.org/licenses/MIT).

