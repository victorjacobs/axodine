class ScrapeController < ApplicationController
  def index
    
  end

  def go
    current_user = params['user']
    current_page = params['step'].nil? ? 1 : params['step']

    if current_user.nil?
      redirect_to :action => 'index'
      return
    end

    scraper = LastfmHelper::Scraper.new(current_user)
    @progress = ((current_page.to_f / scraper.total_pages) * 100).to_i

    if @progress >= 100
      redirect_to :action => 'success'
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

    redirect_to :action => 'go', :step => current_page.to_i + 1, :user => current_user
  end

  def success

  end
end
