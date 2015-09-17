# Interface to java lib
require "java"
require "jars/ticket_printer-1.2.0-jar-with-dependencies.jar"

java_import com.quicktravel.ticket_printer.PrintServiceLocator

module Quickets
  class AvailablePrinters
    def self.all(api_key)
      # Return only printers configured AND installed
      # ...and retain ordering as defined in config
      Quickets.config.printers_for(api_key) & installed_printers
    end

    def self.installed_printers
      PrintServiceLocator.new.all.map(&:name)
    end
  end
end
