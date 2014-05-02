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
    user = User.where(name: current_user)

    if !user.exists?
      User.create(name: current_user, progress: 1)
      current_page = 1
    elsif user.first.progress != -1
      current_page = user.first.progress
    else
      render plain: 100
      return
    end

    scraper = LastfmHelper::Scraper.new(current_user)
    if !scraper.error.nil?
      render plain: scraper.error
      return
    end

    @progress = ((current_page.to_f / scraper.total_pages) * 100).to_i

    if @progress >= 100
      user.first.update_attributes(
          progress: -1
      )

      render plain: @progress
      return
    end

    tracks = scraper.get_tracks(current_page)

    # Store timestamp last play if initial scrape
    if current_page == 1
      user.first.update_attributes(
          last_play: tracks.first['date']['#text']
      )
    end

    tracks.each do |tr|
      begin
        Play.create(user: current_user, title: tr['name'], artist: tr['artist']['#text'], time: tr['date']['#text'])
      rescue
        # Duplicate, just skip
      end
    end

    user.first.update_attributes(
        progress: current_page + 1
    )

    render plain: @progress
  end

  def sl
    sleep(3)

    render plain: 42
  end
end
