Welcome to the Discogs Commander! This gem will help you list and look up details on all of the artists and albums listed on www.Discogs.com. 
All information is pulled from the https://api.discogs.com/ api and is updated accordingly.

## Installation

Add this line to your application's Gemfile:
gem 'discogs_commander', git:'https://github.com/kowalix-pl/discogs.git'

And then execute:
$ bundle install 

## Usage
```ruby
require 'discogs_commander'

start = DiscogsCommander::UserInterface.new
start.run
```
After running the program, follow the prompts to get information about all the albums or artists you want to get more details about.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kowalix-pl/discogs. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the Contributor Covenant code of conduct.

## License

The gem is available as open source under the terms of the [MIT](https://opensource.org/licenses/MIT) License.
Code of Conduct
Everyone interacting in the DiscogsCommander project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the code of conduct.
 

