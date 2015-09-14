#!/usr/bin/env ruby
require "bundler/setup"

require "quickets"
run Quickets::App.freeze.app
