module Kojn
  class Crypto
    protected
    attr_writer :access_token, :crypt_method, :aes

    public
    attr_reader :access_token, :crypt_method, :aes

    def initialize
      self.access_token = Kojn.api_key
      self.crypt_method = 'AES-256-CFB'

      self.aes = OpenSSL::Cipher.new(self.crypt_method)
    end

    def decrypt_params(params)
      return self.decrypt(Base64.decode64(params['payload']), params['iv'])
    end

    def decrypt(data, iv)
      self.aes.decrypt
      self.aes.key = @access_token
      self.aes.iv = iv

      JSON.parse(aes.update(data) + aes.final)
    end

    def encrypt_params(params, key)
      iv = rand.to_s[0..15]

      return {iv: iv, payload: Base64.encode64(encrypt(params, iv, key))}
    end

    def encrypt(data, iv, key)
      @aes.encrypt
      @aes.key = key
      @aes.iv = iv

      @aes.update(data.to_json) + @aes.final
    end

    def self.encrypt(key, data)
      Kojn::Crypto.new(key).encrypt_params(data)
    end

    def self.decrypt(key, data)
      Kojn::Crypto.new(key).decrypt_params(data)
    end
  end
end
