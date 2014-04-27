class ScrapeController < ApplicationController
  def index
    
  end

  # Gets called from javascript
  def go
    current_user = params['user']

    if current_user.nil?
      render plain: -1
      return
    end

    # See whether scrape was already started earlier
    stored_progress = ScrapeProgress.where(user: current_user)

    current_page = (stored_progress.exists?) ? stored_progress.first.to : 1

    scraper = LastfmHelper::Scraper.new(current_user)
    if !scraper.error.nil?
      render plain: scraper.error
      return
    end

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

    # Delete progress and store new
    if stored_progress.exists?
      stored_progress.delete
    end

    ScrapeProgress.create(user: current_user, to: current_page + 1)

    render plain: @progress
  end

  def sl
    sleep(3)

    render plain: 42
  end
end
