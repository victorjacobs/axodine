require 'open-uri'

module LastfmHelper
  class Scraper
    attr_accessor :total_tracks, :total_pages, :error

    def initialize(user)
      tracks_per_page = Settings.scrape_step

      @url = 'http://ws.audioscrobbler.com/2.0/?method=user.getrecenttracks'
      @url += "&user=#{ user }"
      @url += "&api_key=#{ Settings.lastfm_key }"
      @url += '&format=json'

      # Load metadata
      meta_data = JSON.load(open(@url + '&limit=1'))

      # Get some meta data from @attr
      begin
        attr = meta_data['recenttracks']['@attr']
        @total_tracks = attr['total'].to_i

        @total_pages = (@total_tracks.to_f / tracks_per_page).ceil

        # Append tracks limit
        @url += '&limit=' + tracks_per_page.to_s
      rescue
        @error = meta_data['message']
      end
    end

    def get_tracks(page)
      if @error.nil?
        # Add page
        local_url = @url + "&page=#{ page }"

        JSON.load(open(local_url))['recenttracks']['track'].delete_if { |tr| tr['date'].nil? }
      else
        false
      end
    end
  end
end
