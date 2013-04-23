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
        attributes.each do |name, value|
          send("#{name}=", value)
        end
      end
    else
      include ActiveModel::Model
    end

    attr_accessor :internal_id, :external_id, :address, :currency, :amount, :amount_in_euro, :exchange_rate, :status, :received_amount, :description, :seen, :received_amount_in_euro
    attr_accessor :paid, :amount_left, :redirect_uri
    attr_accessor :error, :message, :errors
  end
end

