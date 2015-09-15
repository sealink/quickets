#!/usr/bin/env ruby
require "bundler/setup"
require "rack/cors"
require "quickets"

use Rack::Cors do
  allow do
    origins '*'
    resource '/*', :headers => :any, :methods => [:get, :post, :options]
  end
end

run Quickets::App.freeze.app
