require 'yaml'

module Quickets
  class Config
    def initialize
      @config = YAML.load_file ENV['QUICKETS_CONFIG_FILE']
    end

    def api_key
      @config.fetch('api_key')
    end

    def printers
      @config.fetch('printers')
    end
  end
end
