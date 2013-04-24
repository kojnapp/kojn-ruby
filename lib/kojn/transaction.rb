module Kojn
  def self.parse_objects!(string, klass)
    objects = JSON.parse(string)
    objects.collect do |t_json|
      Kojn.parse_object!(t_json, klass)
    end
  end

  def self.parse_object!(object, klass)
    object = JSON.parse(object) if object.is_a? String

    klass.new(object)
  end

  class Transactions
    attr_accessor :access_token

    def initialize
      self.access_token = Kojn.api_key
    end

    def all(options = {})
      Kojn.parse_objects! Kojn::Net::get('/api/transactions').read_body, Kojn::Tx
    end

    def create(options = {})
      Kojn.parse_object! Kojn::Net::post('/api/transactions', {transaction: options}).read_body, Kojn::Tx
    end

    def find(id, options = {})
      Kojn.parse_object! Kojn::Net::get("/api/transactions/#{id}").read_body, Kojn::Tx
    end

    def update(id, options = {})
      Kojn.parse_object! Kojn::Net::patch("/api/transactions/#{id}", options).read_body, Kojn::Tx
    end
  end

  class Tx
    UNCONFIRMED = 1
    INSUFFICIENT = 2
    SEEN = 3
    CANCELLED = 4

    if ActiveModel::VERSION::MAJOR <= 3
      include ActiveModel::Validations
      include ActiveModel::Conversion
      extend ActiveModel::Naming

      def initialize(attributes = {})
        self.attributes = attributes
      end
    else
      include ActiveModel::Model
    end

    include Kojn::Model

    attr_accessor :internal_id, :external_id, :address, :currency, :amount, :amount_in_euro, :exchange_rate, :status, :received_amount, :description, :seen, :received_amount_in_euro, :confirmed
    attr_accessor :paid, :amount_left, :redirect_uri
    attr_accessor :error, :message, :errors

    def save
      # Uses the transactions helper class to create and update
      # Copies the returned transactions' attributes over to its own.
      if self.new_record?
        self.attributes = Kojn.transactions.create(self.attributes).attributes
      else
        self.attributes = Kojn.transactions.update(self.internal_id, self.attributes).attributes
      end
    end

    # Returns whether this 'record' is new. Inspired by rails :)
    # TODO Make sure if a newly initialized object's internal_id is actually set to nil.
    def new_record?
      self.internal_id == nil
    end
  end
end

