class DiscogsClient

    def initialize
      @json_client = JSONClient.new 'https://api.discogs.com'
      @json_client.authenticate(:Discogs, "key=wWWyDqOgmbTRFyKSQWzS, secret=uYzJSMRGcjueIJIQuPykXEDRhLvkhrYk")
    end 

    def search(phrase)
      puts "Welcome to the album universe, our program will where you will be able to get more information about your favourite album."
      
       json = @json_client.get'/database/search', {q: phrase}
       results = json["results"]
       release = results.find {|e| e["type"] == "release" && e["format"].include?("CD") && e["format"].include?("Album") }
       release
    end 

    def find_album(album_url)
        @json_client.get(album_url)
    end 
end 