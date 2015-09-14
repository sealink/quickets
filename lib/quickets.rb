# Setup base yamload dir
require 'yamload'
current_file_dir = File.expand_path(File.dirname(__FILE__))
Yamload.dir = File.expand_path(File.join(current_file_dir, '..', 'config'))
puts File.expand_path(File.join(current_file_dir, '..', 'config'))

require "quickets/config"

# Web framework
require "roda"

# Interface to java lib
require "java"
require "jars/ticket_printer-1.2.0-jar-with-dependencies.jar"
java_import com.quicktravel.ticket_printer.PrintServiceLocator
java_import com.quicktravel.ticket_printer.TicketPrintCommand

module Quickets
  class App < Roda
    plugin :json
    plugin :error_handler do |e|
      { error: e.message }
    end

    route do |r|
      r.root do
        "Hello I am Quickets"
      end

      r.on do
        config = Quickets::Config.new
        fail ArgumentError, 'Invalid API key' if config.api_key != r['api_key']

        r.on 'printers' do
          installed_printers = PrintServiceLocator.new.all.map(&:name)
          config.printers & installed_printers # retains ordering of config
        end

        r.post "print-tickets" do
          ticket_print_command = TicketPrintCommand.new
          ticket_print_command.printer_name = r['printer_name']
          ticket_print_command.ticket_page_settings_from_map = r['page_format']
          ticket_print_command.execute
          {status: 'ok'}
        end
      end
    end
  end
end
