class AclCogito::DiscoveriesController < ApplicationController
  #include AclCogito::Controllers::InternalHelpers

  def index
    @discoveries = resource.comments.where("created_at > ?", 2.month.ago).order("RAND()").limit(4)      
  end

  def show
    @discoveries = resource.comments.where("created_at > ?", 2.month.ago).order("RAND()").limit(4)      
  end
  
  
end