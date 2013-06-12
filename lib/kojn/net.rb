module Kojn
  module Net
    def self.base_host
      return "http#{Kojn.ssl ? "s" : ""}://#{Kojn.host}:#{Kojn.port}"
    end

    def self.request(verb, path, options={})
      conn = Faraday.new(:url => self.base_host) do |faraday|
        faraday.request  :url_encoded             # form-encode POST params
        faraday.response :logger                  # log requests to STDOUT
        faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
      end
      conn.basic_auth(Kojn.api_key, '')

      response = conn.send(verb.to_s.downcase, path, options)

      return response
    end

    def self.get(path, options={})
      request = self.request(:GET, path, options)

      return request
    end

    def self.post(path, options={})
      request = self.request(:POST, path, options)

      return request
    end

    def self.patch(path, options={})
      request = self.request(:PATCH, path, options)

      return request
    end

    def self.delete(path, options={})
      request = self.request(:DELETE, path, options)

      return request
    end
  end
end
