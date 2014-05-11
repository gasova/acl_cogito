module AclCogito
  module AclCogitoModel
    module Validations

      extend ActiveSupport::Concern

      included do

        validates :body, :presence => true
        validates :commentable, :presence => true
        validates :owner, :presence => true, :associated => true

      end

    end
  end
end