module ActionDispatch::Routing
  class Mapper
    def acl_cogito(*args)
      options       = args.extract_options!.symbolize_keys
      route_name    = options[:path_name] || AclCogito.model_name.pluralize.downcase
      options[:controller] ||= 'acl_cogito/'

      get "#{ route_name }(/:page)" => "#{options[:controller].to_s}comments#index", :as => :comments 
    end

    def acl_cogito_model(*args)
      options = args.extract_options!
      options[:controller] ||= 'acl_cogito/comments'
      resources :comments, :controller => 'acl_cogito/comments' do
        get 'reply', :on => :member if AclCogito.accept_replies
      end
      resources :discovery, :controller => 'acl_cogito/discovery'      
    end

  end
end