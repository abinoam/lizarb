class DevSystem::TerminalPanel < Liza::Panel

  set :log_details, false

  def pallet name = nil
    return @pallet if @pallet
    @pallet = find_pallet name
  end

  # def color_for key
  #   log "key = #{key.inspect}" if get :log_details

  #   color = key

  #   while color[0] != "#"
  #     log "color = #{color.inspect}" if get :log_details
  #     color = @pallet.read_color color
  #   end

  #   color
  # end

  def find_pallet string
    k = Liza.const "#{string}_pallet_terminal"
  rescue Liza::ConstNotFound
    # k = Liza::NotFoundTerminal
    k = Liza::NotFoundCommand
  ensure
    # log k.to_s if get :log_details
    k
  end

end
