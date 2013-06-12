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
      parse_objects! Kojn::Net::get(self.path).body, self.model
    end

    def create(options = {})
      parse_object! Kojn::Net::post(self.path, {invoice: options}).body, self.model
    end

    def find(id, options = {})
      parse_object! Kojn::Net::get("#{self.path}/#{id}").body, self.model
    end

    def update(id, options = {})
      parse_object! Kojn::Net::patch("#{self.path}/#{id}", options).body, self.model
    end

    protected
    def parse_objects!(string, klass)
      objects = JSON.parse(string)
      objects.collect do |t_json|
        parse_object!(t_json, klass)
      end
    end

    def parse_object!(object, klass)
      object = JSON.parse(object) if object.is_a? String

      klass.new(object)
    end
  end
end
