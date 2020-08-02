class DiscogsClient

    def initialize
      @json_client = JSONClient.new 'https://api.discogs.com'
      @json_client.authenticate(:Discogs, "key=wWWyDqOgmbTRFyKSQWzS, secret=uYzJSMRGcjueIJIQuPykXEDRhLvkhrYk")
    end 
  
    def get_results(phrase)
      json = @json_client.get'/database/search', {q: phrase}
      json["results"]
    end

    def display_string_or_array(arg)
      if arg.instance_of?(String) 
        return arg
      else 
       return arg.join(", ")
      end 
    end 
     
    def display_album(hash)
        array = []
        array << "1.Album Title: ".colorize(:yellow)+"#{hash["title"].colorize(:blue)}"
        array << "2.Album Genre: ".colorize(:yellow)+"#{hash["genre"].join(", ")}" unless hash["genre"] == nil
        array << "3.Album Year:  ".colorize(:yellow)+"#{hash["year"]}" unless hash["year"] == nil
        array << "4.Album Style: ".colorize(:yellow)+"#{hash["style"].join(", ")}" unless hash["style"] == nil
        array << "5.Album Label: ".colorize(:yellow)+"#{display_string_or_array(hash["label"])}" unless hash["label"] == nil
        array.join("\n")
    end 
    
    def display_artist(artist_hash,artist_albums)
      header = [
        "Artist Name: #{artist_hash['title']}",
        "Album Title & Release Year:"
        ]
      body = artist_albums.map.with_index(1) do |album_data, index|
        "  #{index}. #{album_data["title"]} - #{album_data["year"]}"
      end
      (header+body).join("\n")
    end 

    def search_artist(phrase)  
        results = get_results(phrase)
        artists = results.select{|result| result["type"] == "artist"}         
        artists.map do |artist| 
          display_artist(artist,search_artist_albums(artist["id"]))
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
       h["label"] = (data.map {|element| element["label"]}).flatten.sort.uniq
       display_album(h)
      end 
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
