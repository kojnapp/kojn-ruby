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

  class Invoices < Kojn::Collection
  end

  class Invoice < Kojn::Model
    UNCONFIRMED = 1
    INSUFFICIENT = 2
    SEEN = 3
    CANCELLED = 4

    attr_accessor :internal_id, :external_id, :address, :currency, :amount, :amount_in_euro, :exchange_rate, :status, :received_amount, :description, :seen, :received_amount_in_euro
    attr_accessor :paid, :amount_left, :redirect_uri
    attr_accessor :error, :message, :errors

    def save
      # Uses the invoices helper class to create and update
      # Copies the returned invoices' attributes over to its own.
      if self.new_record?
        self.attributes = Kojn.invoices.create(self.attributes).attributes
      else
        self.attributes = Kojn.invoices.update(self.internal_id, self.attributes).attributes
      end
    end

    # Returns whether this 'record' is new. Inspired by rails :)
    # TODO Make sure if a newly initialized object's internal_id is actually set to nil.
    def new_record?
      self.internal_id == nil
    end
  end
end
