require 'rails'

module AclCogito
  class Railtie < ::Rails::Railtie #:nodoc:
    initializer 'acl_cogito' do |app|
      ActiveSupport.on_load(:active_record) do
        require File.join(File.dirname(__FILE__), 'acl_cogito_model')
        require File.join(File.dirname(__FILE__), 'acl_cogito_subjectum')
        ::ActiveRecord::Base.send :include, AclCogito::AclCogitoModel
        ::ActiveRecord::Base.send :include, AclCogito::AclCogitoSubjectum
      end
      ActiveSupport.on_load(:action_view) do
        require File.join(File.dirname(__FILE__), 'controllers', 'helpers')
        ::ActionView::Base.send :include, AclCogito::Controllers::Helpers
      end
      ActiveSupport.on_load(:action_controller) do
        require File.join(File.dirname(__FILE__), 'controllers', 'extensions')
        ::ActionController::Base.send :include, AclCogito::Controllers::Extensions
        ::ActionController::Base.send :include, AclCogito::Controllers::CurrentCommenter
      end
    end
  end
end