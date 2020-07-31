class UserInterface

def initialize
 @message = "Welcome to our program. What is your name?" 
end 

def print_message
 puts @message
end 

def list_artist
 puts "I am the artist"
end 

def list_album
 puts " I am the album"
end 

def collect_user_input
 @name = gets.strip

 
 puts "Hi #{@name}! Select 1. if you would like to learn more about the artist, or select 2 to find out about the album, or select 3 to exit the program"
  while @choice !=3 do 
 @choice = gets.strip.to_i
 if @choice == 1
    list_artist
 elsif @choice == 2 
    list_album
 elsif  @choice == 3
    puts "Goodbye" #the loop will exit
 else 
    puts "I do not understand your choice!"
 end 
 end 
end 

end 

# Welcome message
# Choose from 2 options
# 1. Search by album name
# 2. Search by artist name
# 1
# please enter the album name end 
