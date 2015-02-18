module ApplicationHelper

  def persian_to_english_num_string(str)
    str.tr('۰۲۳۴۵۶۷۸۹۱','0234567891')
  end

  def persianNumber (to_convert, locale=nil, text = nil)
    to_convert = to_convert.to_i.to_s
    case locale
      when 'ar'
        to_convert = to_convert.unpack('U*').map{ |e| e + 1584 }.pack('U*')
        text ? to_convert + ' ' + text : to_convert
      when 'fa'
        to_convert = to_convert.unpack('U*').map{ |e| e + 1728 }.pack('U*')
        text ? to_convert + ' ' + text : to_convert
      when 'hi'
        to_convert = to_convert.unpack('U*').map{ |e| e + 2358 }.pack('U*')
        text ? to_convert + ' ' + text : to_convert
      else
        to_convert = to_convert.unpack('U*').map{ |e| e + 1728 }.pack('U*')
        text ? to_convert + ' ' + text : to_convert
    end
  end

end
