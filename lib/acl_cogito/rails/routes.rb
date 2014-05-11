module ActionDispatch::Routing
  class Mapper
    def acl_cogito(*args)
      options       = args.extract_options!.symbolize_keys
      route_name    = options[:path_name] || AclCogito.model_name.pluralize.downcase
      options[:controller] ||= 'acl_cogito/comments'

      get "#{ route_name }(/:page)" => "#{options[:controller].to_s}#index", :as => :comments 
    end

    def acl_cogito_model(*args)
      options = args.extract_options!
      options[:controller] ||= 'acl_cogito/comments'
      resources :comments, options do
        get 'reply', :on => :member if AclCogito.accept_replies
      end
    end

  end
end