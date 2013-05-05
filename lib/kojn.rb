require 'active_support/core_ext'
require 'active_support/inflector'
require 'active_model'

String.send(:include, ActiveSupport::Inflector)

require 'base64'
require 'openssl'
require 'digest/sha2'
require 'json'
require 'net/http'
require 'uri'

require 'kojn/model'
require 'kojn/collection'

require 'kojn/crypto'
require 'kojn/net'
require 'kojn/invoice'
require 'kojn/ipn'

module Kojn
  # Api key
  mattr_accessor :api_key

  # The crypto module
  mattr_accessor :crypto

  # The transactios module
  mattr_accessor :invoices

  # Type of ipn security
  mattr_accessor :ipn_sec
  @@ipn_sec = :integrity

  def self.crypto
    raise MissingConfigExecption.new("API key not set") unless self.api_key

    @@crypto ||= Kojn::Crypto.new

    return @@crypto
  end

  def self.invoices
    raise MissingConfigExecption.new("API key not set") unless self.api_key

    @@transacions ||= Kojn::Invoices.new

    return @@transacions
  end

  def self.ipn(params)
    raise MissingConfigExecption.new("API key not set") unless self.api_key

    return Kojn::Ipn.new(params)
  end

  # Config setters/getters
  def self.[](key)
    self.send(key)
  end

  def self.[]=(key, value)
    self.send("#{key}=", value)
  end

  def self.setup
    yield self
  end

  class MissingConfigExecption<Exception;end;
end
