class DiscogsClient

    def initialize
      @json_client = JSONClient.new 'https://api.discogs.com'
      @json_client.authenticate(:Discogs, "key=wWWyDqOgmbTRFyKSQWzS, secret=uYzJSMRGcjueIJIQuPykXEDRhLvkhrYk")
    end 
  
    def get_results(phrase)
      json = @json_client.get'/database/search', {q: phrase}
      json["results"]
    end 
    def display_album(hash)
        array = []
        array << "Album Title: #{hash["title"]}"
        array << "Album genre: #{hash["genre"].join(", ")}" unless hash["genre"] == nil
        array << "Album Year: #{hash["year"]}" unless hash["year"] == nil
        array << "Album Style: #{hash["style"].join(", ")}" unless hash["style"] == nil
        array.join("\n")
    end 
    def search_artist(phrase)  
      results = get_results(phrase)
        artists = results.select {|result| result["type"] == "artist"}
        artist_tid = artists.map do |artist| 
        artist_array = []
        artist_array << artist["title"] 
        artist_array << search_artist_data(artist["id"])
        artist_array
      end 
       artist_tid
    end 

    def search_album(phrase)  
      results = get_results(phrase)
      albums = results.select {|result| result["type"] == "release"}
      albums.map {|hash| display_album(hash)} 
    end 

    def search_artist_data(artist_id)
      json = @json_client.get "/artists/#{artist_id}/releases"
      json["releases"].map {|hash| display_album(hash)} 
    end 

    def find_album(album_url)
        @json_client.get(album_url)
    end 
end 