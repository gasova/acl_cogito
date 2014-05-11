module AclCogito
  module AclCogitoSubjectum
  
    def self.included(base)
      base.extend(ClassMethods)
    end
  
    module ClassMethods
      def acl_cogito_subjectum(*args)
        options = args.extract_options!
        options.delete(:as)

        default_options = { :class_name => AclCogito.model_name,
                            :as => :commentable,
                            :order => "created_at #{AclCogito.sort_order}",
                            :dependent => :destroy }

        has_many :comments, default_options.merge(options)

      end
    end
  
  end
end