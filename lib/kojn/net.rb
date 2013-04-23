module Kojn
  module Net
    def self.http
      if defined?(Rails) && Rails.env == 'development'
        http    = ::Net::HTTP.new('sandbox.kojn.nl')
      else
        http    = ::Net::HTTP.new('kojn.nl', 443)

        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      end


      return http
    end

    def self.get(uri, options={})
      request = ::Net::HTTP::Get.new(uri)

      request.content_type = 'application/json'
      request.basic_auth '', Kojn.api_key
      request.body = options.to_json

      self.http.request(request)
    end

    def self.post(uri, options={})
      request = ::Net::HTTP::Post.new(uri)

      request.content_type = 'application/json'
      request.basic_auth '', Kojn.api_key
      request.body = options.to_json

      self.http.request(request)
    end

    def self.patch(uri, options={})
      request = ::Net::HTTP::Patch.new(uri)

      request.content_type = 'application/json'
      request.basic_auth '', Kojn.api_key
      request.body = options.to_json

      self.http.request(request)

    end

    def self.delete(uri, options={})
      request = ::Net::HTTP::Delete.new(uri)

      request.content_type = 'application/json'
      request.basic_auth '', Kojn.api_key
      request.body = options.to_json

      self.http.request(request)
    end
  end
end
