class DevSystem::TerminalCommand < DevSystem::Command

  def call args
    # 1. LOG

    log "args = #{args.inspect}"
    puts

    # 2. FIND terminal

    terminal = args[0] || "irb"

    log({terminal:})

    terminal_klass = Liza.const "#{terminal}_terminal"

    # 3. CALL

    terminal_klass.call Array(args[1..-1])
  end

  def pallet args
    log "args = #{args.inspect}"

    # 2. FIND terminal

    if args[0]
      args[0] = "#{args[0]}_pallet"
      call args
    else
      DevBox[:terminal].pallet.call args
    end
  end

end
