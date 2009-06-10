# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  FLASH_NOTICE_KEYS = [:error, :notice, :warning]

  def flash_messages
    return unless messages = flash.keys.select{|k| FLASH_NOTICE_KEYS.include?(k)}
    formatted_messages = messages.map do |type|
      content_tag :div, :class => type.to_s do
        message_for_item(flash[type], flash["#{type}_item".to_sym])
      end
    end
    formatted_messages.join
  end

  def message_for_item(message, item = nil)
    if item.is_a?(Array)
      message % link_to(*item)
    else
      message % item
    end
  end
  
  def name_trunc(name, length=25)
    names = name.split
    shortname_length = names[0].length + names[-1].length + 2
    middlenames = names[1..-2].join(" ") #TODO check for long tweo word names
    names[0] + " " + truncate(middlenames, length - shortname_length) + " " + names[-1]
  end
  # Awesome truncate
  # First regex truncates to the length, plus the rest of that word, if any.
  # Second regex removes any trailing whitespace or punctuation (except ;).
  # Unlike the regular truncate method, this avoids the problem with cutting
  # in the middle of an entity ex.: truncate("this &amp; that",9)  => "this &am..."
  # though it will not be the exact length.
  def awesome_truncate(text, length = 20, truncate_string = "...")
    return if text.nil?
    l = length - truncate_string.length
    half = l/2
    pref = text[/\A.{#{half}}\w*\;?/m][/.*[\w\;]/m]
    text.length > length ? text[/\A.{#{half}}\w*\;?/m][/.*[\w\;]/m] + truncate_string : text
#    text.length > length ? text[/\A.{#{l}}\w*\;?/m][/.*[\w\;]/m] + truncate_string : text
  end
  
  def format_amount(amount)
    amount > 0 ? "#{amount},-" : "<span class='neg'>#{amount},-</span>"
  end
  
end
