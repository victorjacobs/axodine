class ScrapeController < ApplicationController
  def index
    current_user = params['user']

    scraper = LastfmHelper::Scraper.new(current_user)

    scraper.get_tracks(1).each do |tr|
      next if tr['date'].nil?
      Play.create(user: current_user, title: tr['name'], artist: tr['artist']['#text'], time: tr['date']['#text'])
    end
  end
end
