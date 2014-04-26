require 'open-uri'

module LastfmHelper
  class Scraper
    attr_accessor :total_tracks

    @tracks_per_page = 200  # Maximum allowed by the last.fm API

    def initialize(user)
      @url = 'http://ws.audioscrobbler.com/2.0/?method=user.getrecenttracks'
      @url += '&user=' + user
      @url += '&api_key=' + Settings.lastfm_key
      @url += '&format=json'

      # Get some meta data from @attr
      attr = JSON.load(open(@url + '&limit=1'))['recenttracks']['@attr']
      @total_tracks = attr['total']

      # Append tracks limit
      @url += '&limit=' + @tracks_per_page
    end

    def get_tracks
      JSON.load(open(@url))
    end
  end
end
