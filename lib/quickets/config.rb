require 'yamload'

module Quickets
  class Config
    def initialize
      @config = Yamload::Loader.new("quickets").content
    end

    def api_key
      @config.fetch('api_key')
    end

    def printers
      @config.fetch('printers')
    end
  end
end
