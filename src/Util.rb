
class Util
	def matchWatchedEpisode(result, watchedList)
		title = result.css("p[class='title']")
		
		watchedList.each { |episodeName|
			# puts "compare '#{title.text}' to '#{episodeName.strip}'"
			if title.text == episodeName.strip
				return true 
			end
		}
		return false
	end

	def readWatchedList(filepath)
		list = []
		if filepath
			begin
		    	file = File.new(filepath, "r")
			    while (line = file.gets)

			    	list.push(line)
			    end
			    file.close
			rescue => err
			    puts "Exception: #{err}"
			    err
			end
		else
			puts "Specify a file"
		end
		return list
	end
end

