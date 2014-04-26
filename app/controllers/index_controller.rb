class IndexController < ApplicationController
  def index
    @data = LastfmHelper::Scraper.new('vikking')
  end
end
