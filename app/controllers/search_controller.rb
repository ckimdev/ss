class SearchController < ApplicationController
  include TrendingCampaign

  def index
    if params[:search]
      @result = TrendingCampaign.search(params[:search])
    else
      @result = TrendingCampaign.all
    end
  end
end
