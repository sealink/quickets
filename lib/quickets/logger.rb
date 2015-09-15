require 'logger'

module Quickets
  def self.logger
    @logger ||= Logger.new($stdout).tap do |log|
      log.progname = 'quickets'
    end
  end
end
