require "roda"

require "pathname"
require "quickets/config"
require "quickets/logger"

require "quickets/available_printers"

# Config
# Interface to java lib
require "java"
require "jars/ticket_printer-1.2.0-jar-with-dependencies.jar"
java_import com.quicktravel.ticket_printer.PrintServiceLocator
java_import com.quicktravel.ticket_printer.TicketPrintCommand
Quickets.logger.error "No QUICKETS_DIR set" if ENV['QUICKETS_DIR'].nil?
quickets_dir = Pathname.new ENV['QUICKETS_DIR']
Quickets.configure(quickets_dir.join("quickets.yml"))

module Quickets
  class App < Roda
    plugin :json_parser # request parse
    plugin :json        # response to_json
    plugin :error_handler

    route do |r|
      r.root do
        "Hello I am Quickets"
      end

      r.on do
        Quickets.config.check_api_key!(r['api_key'])

        r.on 'printers' do
          AvailablePrinters.all(r['api_key'])
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

    error do |e|
      Quickets.logger.error e
      { error: e.message }
    end
  end
end
