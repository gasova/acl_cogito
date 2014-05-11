module AclCogito
  module Controllers
    module CurrentCommenter
      extend ActiveSupport::Concern

      def current_commenter
        send AclCogito.current_user_method
      end

      included do
        helper_method :current_commenter
      end
    end
  end
end