class DevSystem::PalletTerminal < DevSystem::Terminal

  # def self.call args
  #   log "args = #{args.inspect}"

  #   log "TODO: demo output of pallet"
  # end

  def self.call args
    log "args = #{args.inspect}"

    log "Demo"

    colors = get(:colors)
    colors.each do |k,v|
      color = color_for(v)

      source = (self.is_a? Class) ? self : self.class
      s = "#{source} #{k.inspect} = #{v.inspect}"

      _log_ansi_color s, color
    end
  end

  def self._log_ansi_color s, color
    t = ansi_color(s, fg: "#000000", bg: "#ffffff")
    log "#{t}#{t}"

    f = ansi_color(s, :b, fg: color)
    b = ansi_color(s, :b, bg: color)
    log "#{b}#{f}"
    
    f = ansi_color(s, :b, :i, fg: color)
    b = ansi_color(s, :b, :i, bg: color)
    log "#{b}#{f}"
    
    f = ansi_color(s, :i, fg: color)
    b = ansi_color(s, :i, bg: color)
    log "#{b}#{f}"
    
    f = ansi_color(s, fg: color)
    b = ansi_color(s, bg: color)
    log "#{b}#{f}"

    t = ansi_color(s, fg: "#ffffff", bg: "#000000")
    log "#{t}#{t}"
  end

  OFF = "\e[0m"
  BOLD = 1
  ITALIC = 3
  
  def self.ansi_color s, *styles, fg: "#000000", bg: nil
    styles = styles.map do |style|
      case style
      when :b, :bold   then BOLD
      when :i, :italic then ITALIC
      else raise "Invalid style: #{style.inspect}"
      end
    end

    styles = styles.any? ? "\e[#{styles.join(";")}m" : ""
    fg = hex_to_rgb(fg).join(";")
    bg = hex_to_rgb(bg).join(";") if bg

    colors = bg ? "\e[38;2;#{fg};48;2;#{bg}m" : "\e[38;2;#{fg}m"

    "#{styles}#{colors}#{s}#{OFF}"
  end

  def self.read_color k
    get(:colors)[k] || k
  end

  def self.color_for key
    log "key = #{key.inspect}" if get :log_details

    color = key

    while color[0] != "#"
      log "color = #{color.inspect}" if get :log_details
      color = read_color color
    end

    color
  end

  def self.hex_to_rgb(hex)
    raise "Invalid hex color: #{hex}" unless hex =~ /^#?[0-9a-fA-F]{6}$/

    r = hex[1..2].to_i(16)
    g = hex[3..4].to_i(16)
    b = hex[5..6].to_i(16)
    return r, g, b
  end

end

__END__

The default view can be rendered by calling `render "inline.txt`"

Self is the instance of the class that called `render`:
  self: <%= self %>

# view text.txt.erb

This named view can be rendered by calling `render "text.txt`"

Instance variables are accessible from the view:
  @args: <%= @args %>

Written at <%= Time.now %>

# view lalala.txt.erb.ignored

This named view will be ignored.
