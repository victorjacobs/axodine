require 'open-uri'

module LastfmHelper
  class Scraper
    attr_accessor :total_tracks, :total_pages

    def initialize(user)
      tracks_per_page = 10

      @url = 'http://ws.audioscrobbler.com/2.0/?method=user.getrecenttracks'
      @url += "&user=#{ user }"
      @url += "&api_key=#{ Settings.lastfm_key }"
      @url += '&format=json'

      # Get some meta data from @attr
      attr = JSON.load(open(@url + '&limit=1'))['recenttracks']['@attr']
      @total_tracks = attr['total'].to_i

      @total_pages = (@total_tracks.to_f / tracks_per_page).round

      # Append tracks limit
      @url += '&limit=' + tracks_per_page.to_s
    end

    def get_tracks(page)
      JSON.load(open(@url))['recenttracks']['track']
    end
  end
end
