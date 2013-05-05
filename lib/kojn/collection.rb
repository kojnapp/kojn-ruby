module Kojn
  class Collection
    attr_accessor :access_token, :module, :name, :model, :path

    def initialize(api_prefix="/api")
      self.access_token = Kojn.api_key

      self.module = self.class.to_s.singularize.underscore
      self.name   = self.module.split('/').last
      self.model  = self.module.camelize.constantize
      self.path   = "#{api_prefix}/#{self.name.pluralize}"
    end

    def all(options = {})
      Kojn.parse_objects! Kojn::Net::get(self.path).read_body, self.model
    end

    def create(options = {})
      Kojn.parse_object! Kojn::Net::post(self.path, {invoice: options}).read_body, self.model
    end

    def find(id, options = {})
      Kojn.parse_object! Kojn::Net::get("#{self.path}/#{id}").read_body, self.model
    end

    def update(id, options = {})
      Kojn.parse_object! Kojn::Net::patch("#{self.path}/#{id}", options).read_body, self.model
    end
  end
end
