class DevSystem::SimpleCommand < DevSystem::BaseCommand

  #

  def call(env)
    env[:simple] = [""]
    super
  end

  #

  def log_simple_remember
    log :lower, "env[:remember] is now #{stick system.color, (env[:simple].join " ")}", kaller: caller
  end
  
  # 

  # key=value
  def simple_string(key, &block)
    string = env[:args].find { _1.start_with? "#{key}=" }.to_s.sub("#{key}=", "")
    return string unless string.empty?

    value = yield.to_s.split(" ")[0]
    log :high, value.inspect

    env[:simple] << "#{key}=#{value}"

    log_simple_remember

    value
  end

  #

  # key=value
  def simple_color(key, string: "I LOVE RUBY")
    simple_string key do
      TtyInputCommand.pick_color string: string
    end.to_sym.tap do |color|
      log :high, color.inspect
    end
  end

  #

  # key=value
  def simple_controller_placement(key, places)
    simple_string key do
      options = places.map do |place, path|
        [
          "#{place.ljust 30} path: #{path}",
          place
        ]
      end.to_h
      TtyInputCommand.pick_one "Where should the controller be placed?", options
    end.tap do |place|
      log :high, place.inspect
    end
  end

  #

  # arg0 arg1 arg2
  def simple_arg(index, &block)
    string = env[:args][index]
    return string if string

    value = yield
    value = "" if value.nil?
    value = value.inspect if value.include? " "
    log :high, value.inspect

    string = env[:simple][0]
    string << " " unless string.empty?
    string << value

    log_simple_remember

    value
  end

  #

  # arg0 arg1 arg2
  def simple_arg_ask(index, title)
    simple_arg index do
      TtyInputCommand.prompt.ask(title)
    end
  end

  #

  # arg0 arg1 arg2
  def simple_arg_ask_snakecase(index, title)
    simple_arg index do
      TtyInputCommand.prompt.ask(title) do |q|
        q.required true
        q.validate /^[a-zA-Z_]*$/
      end.snakecase
    end
  end

end
