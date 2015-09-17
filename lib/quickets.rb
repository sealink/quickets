require "roda"

require "pathname"
require "quickets/version"
require "quickets/config"
require "quickets/logger"

require "quickets/ticket_printer"
require "quickets/available_printers"

# Config
quickets_dir = Pathname.new(
  if ENV['QUICKETS_DIR'].nil? || ENV['QUICKETS_DIR'] == ""
    Quickets.logger.warn "No QUICKETS_DIR set, using /quickets"
    "/quickets"
  else
    ENV['QUICKETS_DIR']
  end
)
Quickets.configure(quickets_dir.join("quickets.yml"))

module Quickets
  class App < Roda
    plugin :json_parser # request parse
    plugin :json        # response to_json
    plugin :error_handler

    route do |r|
      r.root do
        "Quickets #{Quickets::VERSION}"
      end

      r.on do
        Quickets.config.check_api_key!(r['api_key'])

        r.on 'printers' do
          AvailablePrinters.all(r['api_key'])
        end

        r.post "print-tickets" do
          ticket_printer = TicketPrinter.new(r.params)
          if ticket_printer.can_print?
            Thread.new { ticket_printer.print }
            {status: 'ok'}
          else
            response.status = 500
            {error: "Unknown printer: [#{ticket_printer.printer_name}]"}
          end
        end
      end
    end

    error do |e|
      Quickets.logger.error e
      { error: e.message }
    end
  end
end
