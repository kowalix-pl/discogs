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
        artists = results.select{|result| result["type"] == "artist"}         
        artists.map do |artist| 
         {artist: artist,albums: search_artist_albums(artist["id"])}
        end 
    end 

    def search_album(phrase)  
      results = get_results(phrase)
      albums = results.select {|result| result["type"] == "release"}
      new_albums = albums.group_by do |element|
       element["title"]
      end
      new_albums.keys.map do |album_title|
       h = Hash.new 
       data = new_albums[album_title]
       h["title"] = album_title
       h["year"] = (data.map {|element| element["year"].to_i}).select {|year| year > 0}.sort.uniq.join(", ")
       h["genre"] = (data.map {|element| element["genre"]}).flatten.sort.uniq
       h["style"] = (data.map {|element| element["style"]}).flatten.sort.uniq
       h["label"] = (data.map {|element| element["label"]}).flatten.sort.uniq.take(5)
       album = album_data(data.first["id"])
       h["tracklist"] = album["tracklist"]
       h["artist"] = album["artist"]
       h
      end 
    end 

    def album_data(album_id)
      json = @json_client.get "/releases/#{album_id}"
      album = {}
      album["tracklist"] = json["tracklist"].select {|track| track["type_"] != "heading"}
      album["artist"] = json["artists_sort"]
      album
    end 

    def search_artist_albums(artist_id)
       json = @json_client.get "/artists/#{artist_id}/releases"
       albums = json["releases"].select do |release|
         format = release["format"]
         next true if format == nil
         next true if format.include?("CD")
         next true if format.include?("Album")
         false
      end 
       albums
    end 

    def find_album(album_url)
        @json_client.get(album_url)
    end 

end 
