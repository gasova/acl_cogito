module AclCogito
  module Schema

    def acl_cogito(options = {})
      null    = options[:null] || false
      default = options.key?(:default) ? options[:default] : ("" if null == false)

      apply_schema :owner_id, :integer, :null => false
      apply_schema :commentable_id, :integer, :null => false
      apply_schema :commentable_type, :string, :null => false
      apply_schema :title, :string, :default => default, :null => null if options[:title]
      apply_schema :body, :text, :null => false
    end

    # Overwrite with specific modification to create your own schema.
    def apply_schema(name, type, options={})
      raise NotImplementedError
    end
    
  end
end