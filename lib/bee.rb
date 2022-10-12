# frozen_string_literal: true

require 'uri'
require 'net/http'


require_relative "bee/version"

# module Bee
#   class Error < StandardError; end
#   # Your code goes here...
# end

module Bee
  BASE_URL = 'https://tudoligeiro.webapi.bee.app/api/'

  module Auth
    def self.login(email:, password:)
      uri = URI("#{BASE_URL}auth/login")
      params = { email: email, password: password }
      uri.query = URI.encode_www_form(params)
      res = Net::HTTP.get_response(uri)
    end
  end
end

binding.irb
