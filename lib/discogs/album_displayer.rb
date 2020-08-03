class AlbumDisplayer
    def display_album(hash)
      array = []
      array << "1.Album Title: ".colorize(:yellow)+"#{hash["title"].colorize(:blue)}"
      array << "1.Album Artist: ".colorize(:yellow)+"#{hash["artist"]}"
      array << "2.Album Genre: ".colorize(:yellow)+"#{hash["genre"].join(", ")}" unless hash["genre"] == nil
      array << "3.Album Years: ".colorize(:yellow)+"#{hash["year"]}" unless hash["year"] == nil
      array << "4.Album Styles: ".colorize(:yellow)+"#{hash["style"].join(", ")}" unless hash["style"] == nil
      array << "5.Album Labels: ".colorize(:yellow)+"#{display_string_or_array(hash["label"])}" unless hash["label"] == nil
      tracklist = hash["tracklist"].map.with_index(1) do |track,i|
        position = i.to_s.rjust(3)+ " "
        duration = "[#{track["duration"]}]".rjust(6)
        track = track["title"]
        result = position + track
        result = result + " " + duration unless track["duration"].nil?
        result
      end
      tracklist = ["  # Title ".colorize(:blue)] + tracklist
      array << "6.Album Tracklist:\n ".colorize(:yellow)+"#{tracklist.join("\n ")}" 
      array.join("\n")
    end 
  
    def display_string_or_array(arg)
      if arg.instance_of?(String) 
        return arg
      else 
       return arg.join(", ")
      end 
    end 
  end 