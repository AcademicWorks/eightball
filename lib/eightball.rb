require 'iconv'
module Eightball

	def eightball
		string = self.dup
		string.force_encoding("UTF-8")
		#http://po-ru.com/diary/fixing-invalid-utf-8-in-ruby-revisited/
		ic = Iconv.new('UTF-8//IGNORE', 'UTF-8')
		string = ic.iconv(string + ' ')[0..-2]
		#drop the BOM
		string.gsub!("\xEF\xBB\xBF".force_encoding("UTF-8"), '')
		string
	end

end

String.send(:include, Eightball)