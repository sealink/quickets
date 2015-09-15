require 'yamload'

module Quickets
  class Config
    def initialize
      # Yamload::Loader.new("quickets").content
      @config = YAML.load_file ENV['QUICKETS_CONFIG_FILE']
      #"config/quickets.yml"
    end

    def api_key
      @config.fetch('api_key')
    end

    def printers
      @config.fetch('printers')
    end
  end
end
