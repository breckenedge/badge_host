# frozen_string_literal: true

require 'bundler'

Bundler.setup

require 'irb'
require 'minitest/autorun'
require 'rack/test'

ENV['RACK_ENV'] = 'test'

require_relative '../config/environment'
require 'badge_host/application'

$redis.flushdb
