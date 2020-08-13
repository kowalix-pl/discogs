module DiscogsCommander
class Artist
    attr_accessor :name, :albums 
        @@all = []
        @@stored_artists_queries = []

    def initialize(name,albums)
     @name = name
     @albums = albums
     @@all << self
    end 

    def self.find(name_query)
       if @@stored_artists_queries.include?(name_query)
         @@all.select {|artist| artist.name.downcase.include?(name_query.downcase)}
       else  
         nil 
       end 
    end 

    def self.store(name_query)
     @@stored_artists_queries << name_query
    end 
     
    def self.all
     @@all
    end
 end 
end 