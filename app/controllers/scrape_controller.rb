class ScrapeController < ApplicationController
  def index
    @scraper = LastfmHelper::Scraper.new(params['user'])
  end
end
