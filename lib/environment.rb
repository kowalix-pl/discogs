require 'bundler/setup'

require 'json'
require 'faraday'
require 'awesome_print'

require_relative './discogs/user_interface'
require_relative './discogs/json_client'
require_relative './discogs/discogs_client'
require_relative './discogs/album_formatter' 
require_relative './discogs/discogs_app' 