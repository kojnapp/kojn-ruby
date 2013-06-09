module Kojn
  class Ipn
    ENCRYPTION = 1
    INTEGRITY  = 2

    attr_accessor :mode, :content, :invoice, :token

    def initialize params
      self.content = params

      self.ensure_secure(params)

      if params['token']
        self.mode = Kojn::Ipn::INTEGRITY
        self.invoice = params['invoice']
        self.token = params['token']

        raise AuthenticityException.new("ERROR -*- IPN Could not be verified. Please notify Kojn authors. This message has been fabricated. -*- ERROR") unless self.authentic?
      elsif params['iv']
        self.mode = Kojn::Ipn::ENCRYPTION
        self.decrypt
      end

      # Create a real object.
      self.invoice = Kojn::Invoice.new(self.invoice)
    end

    def authentic?
      raise AuthenticityException.new("Checking if message is authentic while mode is set to Encryption") unless self.mode == Kojn::Ipn::INTEGRITY

      sha = Digest::SHA2.hexdigest "#{Kojn.api_key}#{self.invoice['internal_id']}#{self.invoice['received_amount']}"
      Rails.logger.info "sha: #{sha} tokne: #{self.token}"

      sha == self.token
    end

    def decrypt
      self.invoice = Kojn::crypto.decrypt_params(self.content)
    end

    def ensure_secure(params)
      if (params['token'] && Kojn.ipn_sec == :integrity) || (params['iv'] && Kojn.ipn_sec == :encryption)
        true
      else
        raise Kojn::AuthenticityException.new("ERROR -*- IPN security expected: #{Kojn.ipn_sec}. Opposite was found. -*- ERROR")
      end
    end
  end

  class AuthenticityException<Exception;end
end
