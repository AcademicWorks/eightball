require 'iconv'
module Eightball

	def eightball
		string = self.encode(Encoding::UTF_8, :invalid => :replace, :undef => :replace)
		begin
    		string.empty?
  		rescue ArgumentError => e
	    	if e.message == "invalid byte sequence in UTF-8"
	      		Thread.current["iconv"] ||= Iconv.new('UTF-8//IGNORE', 'UTF-8')
	      		string = Thread.current["iconv"].iconv(string)
	    	else
	      		raise
	    	end
  		end
  		#drop the BOM
    string.force_encoding("UTF-8").gsub("\xEF\xBB\xBF".force_encoding("UTF-8"), '')
	end

end

String.send(:include, Eightball)