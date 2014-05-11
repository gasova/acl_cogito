module AclCogito
  module Controllers
    module Helpers

      def comments_for(object, options = {})        
        puts object
        render_comments(object, options) +
        ( render_comments_form(object, options) unless options[:no_new] ).to_s
      end

      def render_comments(object, options = {})
        limit = options.delete(:limit) || AclCogito.model_name.constantize.default_per_page
        page  = options.delete(:page)  || 1
        render( :partial => "acl_cogito/comments/comments", 
                :locals => { :comments => object.comments.page(page).limit(limit), 
                             :commentable => object, 
                             :options => options} )
      end

      def render_comments_form(object, options = {})
        render( :partial => "acl_cogito/comments/new", :locals => {:commentable => object, :options => options} )
      end
    end
    
  end
end