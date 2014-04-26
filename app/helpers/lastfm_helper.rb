require 'open-uri'

module LastfmHelper
  class Scraper
    attr_accessor :total_tracks, :total_pages

    def initialize(user)
      @url = 'http://ws.audioscrobbler.com/2.0/?method=user.getrecenttracks'
      @url += '&user=' + user
      @url += '&api_key=' + Settings.lastfm_key
      @url += '&format=json'

      # Get some meta data from @attr
      attr = JSON.load(open(@url + '&limit=1'))['recenttracks']['@attr']
      @total_tracks = attr['total'].to_i

      @total_pages = (@total_tracks.to_f / 200).round

      # Append tracks limit
      @url += '&limit=' + @tracks_per_page.to_s
    end

    def get_tracks(page)
      JSON.load(open(@url))
    end
  end
end
