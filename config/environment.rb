# frozen_string_literal: true

require 'bundler'

Bundler.setup

require 'redis'
require 'json'

# Config read from ENV['REDIS_URL']
$redis = Redis.new
