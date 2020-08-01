class DiscogsClient

    def initialize
      @json_client = JSONClient.new 'https://api.discogs.com'
      @json_client.authenticate(:Discogs, "key=wWWyDqOgmbTRFyKSQWzS, secret=uYzJSMRGcjueIJIQuPykXEDRhLvkhrYk")
    end 
  
    def get_results(phrase)
      json = @json_client.get'/database/search', {q: phrase}
      json["results"]
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
      albums.map do |hash|
        array = []
        array << "Title: #{hash["title"]}"
        array << "Album genre: #{hash["genre"].join(", ")}"
        array << "Year: #{hash["year"]}" unless hash["year"] == nil
        array << "Style: #{hash["style"].join(", ")}"
        array.join("\n")
      end 
    end 

    def search_artist_data(artist_id)
      json = @json_client.get "/artists/#{artist_id}/releases"
      releases = json["releases"].map do |release| 
      "Release:#{release["title"]} \nAlbum label: #{release["label"]}\nYear: #{release["year"]}"
      
    end 
      releases
    end 

    def find_album(album_url)
        @json_client.get(album_url)
    end 
end 