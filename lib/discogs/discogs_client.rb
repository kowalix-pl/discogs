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
    
    # def display_artist(hash)
    #   #To be checked#
    #   array = []
    #   array << "1.Artist Name: ".colorize(:yellow)+"#{hash["title"].colorize(:blue)}"
    #   array << "2.Artist Albums: ".colorize(:yellow)+"#{hash["tilte"].join(", ")}" unless hash["title"] == nil
    #   array << "2.Artist Genre: ".colorize(:yellow)+"#{hash["genre"].join(", ")}" unless hash["genre"] == nil
    #   array << "4.Artist Style: ".colorize(:yellow)+"#{hash["style"].join(", ")}" unless hash["style"] == nil
    #   array << "5.Artist Label: ".colorize(:yellow)+"#{display_string_or_array(hash["label"])}" unless hash["label"] == nil
    #   array.join("\n")
    # end 

    def search_artist(phrase)  
        results = get_results(phrase)
         artists = results.select{|result| result["type"] == "artist"}  
       
        
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
       albums = json["releases"].select do |release|
         format = release["format"]
         next true if format == nil
         next true if format.include?("CD")
         next true if format.include?("Album")
         false
      end 
       albums.map do |hash| 
        display_album(hash)
      end 
    end 

    def find_album(album_url)
        @json_client.get(album_url)
    end 
end 
