module AclCogito
  module Controllers
    module Extensions

      def self.included(base)
        base.extend ClassMethods
        base.send :include, InstanceMethods

        #base.class_eval do
        #  (class << self; self; end).instance_eval do
        #    define_method "#{AclCogito.model_name.underscore}_destroy_conditions" do |&block|
        #      AclCogito.set_destroy_conditions( &block )
        #    end
        #  end
        #end
      end

      module ClassMethods
        def acl_cogito_identifier(&block)
          AclCogito.acl_cogito_identifier(block)
        end
      end

      module InstanceMethods
        #def can_destroy_acl_cogito?(opinio)
        #  self.instance_exec(opinio, &AclCogito.destroy_conditions)
        #end

        def acl_cogito_after_create_path(resource)
          resource.is_a?(AclCogito.model_name.constantize) ? resource.commentable : resource
        end

        def acl_cogito_after_destroy_path(comment)
          comment.commentable
        end
      end
    end
  end
end