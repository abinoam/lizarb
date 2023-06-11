class DevSystem::PalletTerminal < DevSystem::Terminal

  # def self.call args
  #   log "args = #{args.inspect}"

  #   log "TODO: demo output of pallet"
  # end

  def self.hex_to_rgb(hex)
    raise "Invalid hex color: #{hex}" unless hex =~ /^#?[0-9a-fA-F]{6}$/

    r = hex[1..2].to_i(16)
    g = hex[3..4].to_i(16)
    b = hex[5..6].to_i(16)
    return r, g, b
  end

  def self.call args
    log "args = #{args.inspect}"

    log "Demo"

    # # puts "source_color: #{source_color.inspect} y: #{y.inspect} rgb: #{rgb}".underline
    # s = "\e[1m\e[38;2;#{rgb[0]};#{rgb[1]};#{rgb[2]}m#{source}\e[0m"

    colors = get(:colors)
    colors.each do |k,v|
      color = DevBox[:terminal].color_for(v)
      # color = v
      # color = colors[color] until color[0] == "#"

      rgb = hex_to_rgb(color)

      source = (self.is_a? Class) ? self : self.class
      s = "#{source} #{k.inspect} = #{v.inspect}"

      # s = "settings[#{k.inspect}] = #{v.inspect}"

      t = []
      # make it bold
      log "\e[1m\e[38;2;#{rgb[0]};#{rgb[1]};#{rgb[2]}m#{s}\e[0m"

      # make it bold and italic
      log "\e[1;3m\e[38;2;#{rgb[0]};#{rgb[1]};#{rgb[2]}m#{s}\e[0m"

      # make it italic
      log "\e[3m\e[38;2;#{rgb[0]};#{rgb[1]};#{rgb[2]}m#{s}\e[0m"

      log "\e[38;2;#{rgb[0]};#{rgb[1]};#{rgb[2]}m#{s}\e[0m"

    end
  end


end
