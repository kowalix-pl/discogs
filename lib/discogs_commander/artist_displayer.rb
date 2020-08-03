module DiscogsCommander
class ArtistDisplayer

    def initialize(artist_hash)
     @artist = artist_hash[:artist]
     @albums = artist_hash[:albums]
    end 

    def display_artist
        header = [
          "Artist Name: #{@artist['title']}",
          "Album Title & Release Year:"
          ]
        body = @albums.map.with_index(1) do |album_data, index|
          "  #{index}. #{album_data["title"]} - #{album_data["year"]}"
        end
        (header+body).join("\n")
    end
 end 
end 