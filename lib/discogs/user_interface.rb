class UserInterface

   def initialize
    @message = "Welcome to our program. What is your name?" 
   end 

def run  
 print_message
 collect_user_input
end 

def print_message
 puts @message.colorize(:yellow)
end 

def list_artist(search_artist)
 @discogs_client = DiscogsClient.new
 puts @discogs_client.search_artist(search_artist)
end 

def list_album(search_album)
 @discogs_client = DiscogsClient.new
 data = @discogs_client.search_album(search_album)

 data.each do |album|
   album_displayer = AlbumDisplayer.new
   puts album_displayer.display_album(album)
 end
end 

def collect_user_input
 @name = gets.strip

 puts "Hi #{@name}! please type 1. if you would like to learn more about the artist, or type 2 to find out about the album, or type 3 to exit the program".colorize(:yellow)
  
 while @choice !=3 do 
 @choice = gets.strip.to_i
 if @choice == 1
   puts "Please enter the name of the artists you are interested in:".colorize(:yellow)
    search_artist = gets.strip
    list_artist(search_artist)
 elsif @choice == 2 
   puts "Please enter the name of the album you are interested in".colorize(:yellow)
    search_album = gets.strip
    list_album(search_album)
 elsif  @choice == 3
    puts "Goodbye" #the loop will exit
 else 
    puts "I do not understand your choice!"
 end 
 end 
end 

end
