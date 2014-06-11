module AclCogito
  module Controllers
    module Helpers

      def discovery_for(object, options = {})
        render( :partial => "acl_cogito/comments/discovery", :locals => {:commentable => object, :options => options} )
      end

      def comments_for(object, options = {})        
        render_comments(object, options) +
        ( render_comments_form(object, options) unless options[:no_new] ).to_s
      end

      def render_comments(object, options = {})
        page  = options.delete(:page)  || 1
        render( :partial => "acl_cogito/comments/comments", 
                :locals => { :comments => object.comments.page(1).per(10), 
                             :commentable => object, 
                             :options => options} )
      end

      def render_comments_form(object, options = {})
        render( :partial => "acl_cogito/comments/new", :locals => {:commentable => object, :options => options} )
      end

    end    
  end
end