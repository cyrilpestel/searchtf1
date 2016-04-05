require 'rubygems'
require 'nokogiri'
require 'open-uri'
require "cgi"

require_relative 'Util'

class TF1SearchProvider
	def search(tvSerieId)
		# tvSerieIdEncoded = CGI::escape(tvSerieId)

		url = "http://www.tf1.fr/tf1/#{tvSerieId}/videos/"
		puts "===================================="
		puts "  Looking for : #{tvSerieId}"
		puts "  Getting url : #{url}"
		puts "===================================="
		begin
			page = Nokogiri::HTML(open(url))
			# puts page
			results = page.css("a[class='videoLink']")
			# puts results.length
			# puts results

			util = Util.new()
			watchedList = util.readWatchedList("#{tvSerieId}.txt")
			# puts watchedList

			results.each { |result|
				found = false
				category = result.css("strong[class='colorCategory']")
				title = result.css("p[class='title']")

				if category.text == "Replay"

					if !util.matchWatchedEpisode(result, watchedList)
						found = true
					end

					puts title.text

					if found
						#puts quality.text
						puts " + http://www.tf1.fr#{result['href']}"
					else
						puts " - Got it !"
					end
					puts "============================================"
				end

			}
		rescue OpenURI::HTTPError => error
		  response = error.io
		  response.status
		end 
	end
end
