# encoding: utf-8

module Eightball

  def eightball(replacement_string = '?')
    string = self
    string = string.force_encoding(Encoding::UTF_8) if not_utf8?
    string = reencode(string, replacement_string)
    string = drop_bom(string)
    string
  end

  private

  def not_utf8?
    !self.valid_encoding? || self.encoding != Encoding::UTF_8
  end

  def reencode(string, replacement_string)
    string = string.encode(Encoding::UTF_16, :invalid => :replace, :undef => :replace, :replace => replacement_string)
    string = string.encode(Encoding::UTF_8, :invalid => :replace, :undef => :replace, :replace => replacement_string)
    string
  end

  def drop_bom(string)
    string.sub(/^\xEF\xBB\xBF/, '')
  end

end

String.send(:include, Eightball)
