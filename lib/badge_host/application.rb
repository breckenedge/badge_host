# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader' if 'development' == ENV['RACK_ENV']
require 'curb'
require 'digest'

module BadgeHost
  DEFAULT_BADGE = {
    'subject' => 'unknown',
    'status' => 'unknown',
    'color' => 'lightgrey'
  }.freeze

  # The HTTP-based interface
  class Application < Sinatra::Base
    configure :development do
      register Sinatra::Reloader
    end

    get '/' do
      slim :index, layout: :layout
    end

    get '/badges/:badge_key' do
      badge_key = params[:badge_key].chomp '.svg'
      badge_doc = $redis.get "badge_host/#{badge_key}"
      @badge = badge_doc ? JSON.parse(badge_doc) : DEFAULT_BADGE
      if request.path.end_with? '.svg'
        headers 'Content-Type' => 'image/svg+xml'
        url = 'https://img.shields.io/badge/' \
          "#{@badge['subject']}-#{@badge['status']}-#{@badge['color']}.svg"
        stream { |out| out << cache_or_fetch(url) }
      else
        slim :show, layout: :layout
      end
    end

    post '/badges' do
      badge_params = %i[owner project subject password].map { |k| params[k] }
      badge_id = badge_params.join '/'
      badge_key = Digest::SHA2.hexdigest badge_id
      badge_doc = {
        subject: params[:subject],
        status: params[:status],
        color: params[:color]
      }
      $redis.set "badge_host/#{badge_key}", badge_doc.to_json
      redirect to "/badges/#{badge_key}"
    end

    private

    # Get the passed URL from the cache if it exists, or fetch and cache it if
    # it does not.
    def cache_or_fetch(url)
      cache_key = "badge_host_urls/#{url}"
      if (cache = $redis.get cache_key)
        cache
      else
        body = Curl.get(url).body_str
        $redis.set cache_key, body
        body
      end
    end
  end
end
