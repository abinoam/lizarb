class DevSystem::TerminalPanel < Liza::Panel

  def pallet name
    return @pallet if @pallet
    @pallet = find_pallet name
  end

  def color_for key
    colors = @pallet.get :colors

    color = key
    while color[0] != "#"
      log "color = #{color.inspect}" if get :log_details
      color = colors[color]
    end
    color
  end

  def find_pallet string
    k = Liza.const "#{string}_pallet_terminal"
  rescue Liza::ConstNotFound
    k = Liza::NotFoundTerminal
  ensure
    # log k.to_s if get :log_details
    k
  end

end
