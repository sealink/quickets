require 'yaml'

module Quickets
  def self.configure(file_name)
    @config = Config.new(YAML.load_file(file_name))
  end

  def self.config
    @config
  end

  class Config
    def initialize(printers_by_api_key)
      @printers_by_api_key = printers_by_api_key
    end

    def check_api_key!(api_key)
      return if valid_api_key? api_key
      fail ArgumentError, 'Invalid API key'
    end

    def valid_api_key?(api_key)
      @printers_by_api_key.key? api_key
    end

    def printers_for(api_key)
      @printers_by_api_key.fetch(api_key)
    end
  end
end
