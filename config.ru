# frozen_string_literal: true

require 'bundler'

Bundler.setup

require_relative './config/environment'
require_relative './lib/badge_host/application'

run BadgeHost::Application
