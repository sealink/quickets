#!/usr/bin/env ruby

# Add lib path
require 'pathname'
Pathname.new(__FILE__).dirname.join('lib').tap {|lib_dir|
  $:.unshift(lib_dir) unless $:.include?(lib_dir)
}

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
