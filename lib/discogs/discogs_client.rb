class DiscogsClient

    def initialize
      @json_client = JSONClient.new 'https://api.discogs.com'
      @json_client.authenticate(:Discogs, "key=wWWyDqOgmbTRFyKSQWzS, secret=uYzJSMRGcjueIJIQuPykXEDRhLvkhrYk")
    end 
  
    def get_results(phrase)
      json = @json_client.get'/database/search', {q: phrase}
      json["results"]
    end 

    def search(phrase) 
       results = get_results(phrase)
       results.select {|result| result["type"] == "artist"}
       search_artist_data
       []
      #  release = results.find {|e| e["type"] == "release" && e["format"].include?("CD") && e["format"].include?("Album") }
      #  release
    end 

    def search_artist_data
      json = @json_client.get '/artists/716297/releases'
      releases = json["releases"].map do |release| 
        "Release:#{release["title"]} \nLabel: #{release["label"]}\nYear: #{release["year"]}"
      end 
      puts releases
    end 

    def find_album(album_url)
        @json_client.get(album_url)
    end 
end 