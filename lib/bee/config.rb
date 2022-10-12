require 'uri'
require 'net/http'
require 'json'

module Bee
  BASE_URL = 'https://integrationtest.beedelivery.com.br/api/v1/public/'

  module Company
    def self.create(external_id:, doc_type:, document:, api_key:)
      uri = URI("#{BASE_URL}companies/link")
      body = {
        externalId: external_id.to_s,
        docType: doc_type,
        doc: document
      }.to_json

      headers = {
        "Content-Type": "application/json",
        "Authorization": api_key
      }

      response = Net::HTTP.post(uri, body, headers)

      if response.code_type == Net::HTTPFound
        return 'Invalid company'
      end
      JSON.parse(response.body)
    end

    def self.consult(external_id:, api_key:)
      uri = URI("#{BASE_URL}companies/#{external_id}")
      req = Net::HTTP::Get.new(uri)

      req['Content-Type'] = 'application/json'
      req['Authorization'] = api_key

      res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) {|http|
        http.request(req)
      }

      if res.code_type == Net::HTTPOK
        JSON.parse(res.body)
      else
        begin
          JSON.parse(res.body)
        rescue => exception
          "Response body could not be read. Code #{res.code}. #{res.body}"
        end
      end
    end
  end
end

binding.irb
