module DiscogsCommander
class AlbumDisplayer

    def initialize(hash)
      @hash = hash
    end 

    def display_album
      array = []
      array << "1.Album Title: ".colorize(:yellow)+"#{@hash["title"].colorize(:blue)}"
      array << "2.Album Artist: ".colorize(:yellow)+"#{@hash["artist"]}"
      array << "3.Album Genre: ".colorize(:yellow)+"#{@hash["genre"].join(", ")}" unless @hash["genre"] == nil
      array << "4.Album Years: ".colorize(:yellow)+"#{@hash["year"]}" unless @hash["year"] == nil
      array << "5.Album Styles: ".colorize(:yellow)+"#{@hash["style"].join(", ")}" unless @hash["style"] == nil
      array << "6.Album Labels: ".colorize(:yellow)+"#{display_string_or_array(@hash["label"])}" unless @hash["label"] == nil
      array << "7.Album Tracklists:\n\n".colorize(:yellow)+"#{format_tracklist}" 
      array.join("\n")+"\n "
    end 

    def format_tracklist
        tracklist = @hash["tracklist"].map.with_index(1) do |track,i|
         format_track(track,i)
        end
          (["  # Tracklists titles: ".colorize(:blue)] + tracklist).join("\n")   
    end 

    def format_track(track,i)
      position = i.to_s.rjust(3)+ ". "
      duration = "[#{track["duration"]}]".rjust(6)
      track = track["title"]
      result = position + track
      result = result + " " + duration unless track["duration"].nil?
      result
    end 
  
    def display_string_or_array(arg)
      return arg if arg.instance_of?(String) 
      arg.join(", ")
    end 

  end 
end 