require 'iconv'
module Eightball

  def eightball
    string = self
    string = Helpers.version2(string) if Helpers.needs_help?(string)
    string = Helpers.version1(string) if Helpers.needs_help?(string)
    string
  end

  module Helpers
    extend(self)

    def needs_help?(string)
      string.force_encoding(Encoding::UTF_8)
      begin
        string.sub("", "")
      rescue ArgumentError => e
        e.message == "invalid byte sequence in UTF-8"
      else
        false
      end
    end

    def version1(string)
      string = string.encode(Encoding::UTF_8, :invalid => :replace, :undef => :replace)
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

    def version2(string)
      string.encode(Encoding::UTF_8, Encoding::ASCII_8BIT, :invalid => :replace, :undef => :replace)
    end

  end

end

String.send(:include, Eightball)
