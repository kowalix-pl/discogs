module DiscogsCommander
class UserInterface

 @@message = "Welcome to our program. What is your name?"

 def run  
  UserInterface.print_message
  collect_user_input
 end 

 def self.print_message
  puts @@message.colorize(:yellow)
 end 

 def list_artist(search_artist)
  @discogs_client = DiscogsClient.new
  artist_data = @discogs_client.search_artist(search_artist)
   if artist_data.empty?
   puts "No results found!"
   else 
   artist_data.each do |artist|
   artist_displayer = ArtistDisplayer.new(artist)
   puts artist_displayer.display_artist
   end
 end 
end 

def list_album(search_album)
 @discogs_client = DiscogsClient.new
 data = @discogs_client.search_album(search_album)
 if data.empty?
   puts "No results found!"
  else 
   data.each do |album|
    album_displayer = AlbumDisplayer.new(album)
    puts album_displayer.display_album
   end
 end
end 
 
 def self.my_class_method
 end 

def collect_user_input
 @name = gets.strip
 user_prompt
 while @choice !=4 do 
 @choice = gets.strip.to_i
 if @choice == 1
   puts "Please enter the name of the artist you are interested in:".colorize(:yellow)
    search_artist = gets.strip
    list_artist(search_artist)
 elsif @choice == 2 
   puts "Please enter the name of the album you are interested in".colorize(:yellow)
    search_album = gets.strip
    list_album(search_album)
 elsif  @choice == 3
   user_prompt  
 elsif @choice == 4
  puts "Thank you for visiting our program, Have a nice day, Goodbye!".colorize(:yellow) 
 else 
    puts "I do not understand your choice!"
 end 
 end 
end 

 def user_prompt
  array = []
  array << "Hello".colorize(:yellow) +" #{@name}!".colorize(:blue) 
  array << " please choose one of the following options:".colorize(:yellow)
  array << "Enter:".colorize(:yellow) + " 1 ".colorize(:blue) + "if you would like to learn more about your favourite" + " artist".colorize(:blue) 
  array << "Enter:".colorize(:yellow) + " 2 ".colorize(:blue) + "to learn more about your favourite" + " album".colorize(:blue) 
  array << "Enter:".colorize(:yellow) + " 3 ".colorize(:blue) + "to" + " display your" + " options ".colorize(:blue) 
  array << "Enter:".colorize(:yellow) + " 4 ".colorize(:red) + "to" + " exit ".colorize(:red) + "the program"
  puts array.join("\n")
end 
 end
end 
