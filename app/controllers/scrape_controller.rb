class ScrapeController < ApplicationController
  def index
    
  end

  def go
    @status = 'running'

    current_user = params['user']

    if current_user.nil?
      redirect_to 'index'
    end

    scraper = LastfmHelper::Scraper.new(current_user)

    scraper.get_tracks(1).each do |tr|
      # Skip currently playing item
      next if tr['date'].nil?

      begin
        Play.create(user: current_user, title: tr['name'], artist: tr['artist']['#text'], time: tr['date']['#text'])
      rescue
        # Duplicate, just skip
      end

      @status = 'ended'
    end
  end

  def test
    @progress = Hash.new
    @progress[:total] = 10
    @progress[:current] = 2
  end
end
