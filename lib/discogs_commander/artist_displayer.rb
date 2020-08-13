module DiscogsCommander
class ArtistDisplayer

    def initialize(artist)
     @artist = artist
    end 

    def display_artist
        header = [
          "Artist Name: #{@artist.name}",
          "Album Title & Release Year:"
          ]
        body = @artist.albums.map.with_index(1) do |album_data, index|
          "  #{index}. #{album_data["title"]} - #{album_data["year"]}"
        end
        (header+body).join("\n")
    end
 end 
end 