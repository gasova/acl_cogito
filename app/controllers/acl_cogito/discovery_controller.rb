class AclCogito::discoveryController < ApplicationController
  include AclCogito::Controllers::InternalHelpers

  def index
    @discovery = resource.comments.where("created_at > ?", 2.month.ago).order("RAND()").limit(4)      
  end
end