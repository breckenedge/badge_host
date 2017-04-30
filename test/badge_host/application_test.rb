# frozen_string_literal: true

require 'test_helper'

module BadgeHost
  class ApplicationTest < Minitest::Test
    include Rack::Test::Methods

    def test_that_application_can_render
      get '/'
      assert_equal 200, last_response.status
    end

    def test_get_a_badge
      get '/badges/014eaa63d1ab9d0e139c85519a4100cb6ec0b06e57a81cff0db831a1eb928118' # rubocop:disable Metrics/LineLength
      assert_equal 200, last_response.status
    end

    def test_post_redirects_to_badge
      post '/badges',
           organization: 'rails',
           project: 'rails',
           subject: 'chunkybacon',
           status: '66',
           color: 'red'
      assert_equal 302, last_response.status
      # SHA256 Hash calculated from 'rails/rails/chunkybacon'
      assert_equal 'http://example.org/badges/014eaa63d1ab9d0e139c85519a4100cb6ec0b06e57a81cff0db831a1eb928118',
                   last_response.location
    end

    private

    def app
      @app ||= BadgeHost::Application.new
    end
  end
end
