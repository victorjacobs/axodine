class ScrapeController < ApplicationController
  def index
    
  end

  # Gets called from javascript
  def go
    current_user = params['user']
    current_page = params['step'].nil? ? 1 : params['step']

    if current_user.nil?
      render plain: -1
      return
    end

    scraper = LastfmHelper::Scraper.new(current_user)
    @progress = ((current_page.to_f / scraper.total_pages) * 100).to_i

    if @progress >= 100
      render plain: @progress
      return
    end

    scraper.get_tracks(current_page).each do |tr|
      # Skip currently playing item
      next if tr['date'].nil?

      begin
        Play.create(user: current_user, title: tr['name'], artist: tr['artist']['#text'], time: tr['date']['#text'])
      rescue
        # Duplicate, just skip
      end
    end

    render plain: @progress
  end

  def test

  end

  def sl
    sleep(3)

    render plain: 42
  end
end
