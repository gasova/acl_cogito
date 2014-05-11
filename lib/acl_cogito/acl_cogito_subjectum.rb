module AclCogito
  module AclCogitoSubjectum
    extend ActiveSupport::Concern
  
    module ClassMethods
      def acl_cogito_subjectum(*args)
        options = args.extract_options!

        default_options = { :class_name => AclCogito.model_name,
                            :as => :commentable,
                            :order => "created_at #{AclCogito.sort_order}",
                            :dependent => :destroy }

        has_many :comments, default_options.merge(options)

      end
    end
  
  end
end