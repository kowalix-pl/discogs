require 'rake'
Gem::Specification.new do |s|  
    s.name = 'discogs_commander' 
    s.version = '0.0.1'  
    s.date = '2020-08-23'  
    s.summary = "Great Search Tool For Albums & Artists"  
    s.description = "This program uses DISCOGS API and allows users to search for information about artist and albums"  
    s.authors = ["kowalix-pl"]  
    s.email = 'kowalix007@gmail.com'  
    s.files = FileList['lib/*.rb','lib/discogs_commander/*.rb','Gemfile'].to_a 
    s.license = 'MIT'
end