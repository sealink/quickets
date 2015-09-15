# Interface to java lib
require "java"
require "jars/ticket_printer-1.2.0-jar-with-dependencies.jar"
java_import com.quicktravel.ticket_printer.TicketPrintCommand

require 'quickets/available_printers'

module Quickets
  class TicketPrinter
    attr_reader :printer_name

    def initialize(params)
      @api_key      = params.fetch('api_key')
      @printer_name = params.fetch('printer_name')
      @page_format  = params.fetch('page_format')
      @tickets      = params.fetch('tickets')
    end

    def can_print?
      AvailablePrinters.all(@api_key).include? @printer_name
    end

    def print
      ticket_print_command = TicketPrintCommand.new
      ticket_print_command.printer_name                  = @printer_name
      ticket_print_command.ticket_page_settings_from_map = @page_format
      ticket_print_command.tickets_from_data_list        = @tickets

      Thread.new do
        ticket_print_command.execute
      end
    end
  end
end
