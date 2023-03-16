class LanguagesBench < AppBench
  main_dsl

  ALGORITHMS = [
    # :fastest_for,
    :fastest_while,
  ]

  NUMBERS = {
    one_million: 1_000_000,
    one_billion: 1_000_000_000
  }

  FORMATS = {
    ruby: :rb,
    # node: :js,
    # deno: :ts,
    python: :py
  }

  setup do
    ALGORITHMS.each do |name|
      NUMBERS.each do |n_human, n|
        FORMATS.each do |command, ext|
          #
          write_file name, command, ext, n_human, n
          #
        end
      end
    end
  end

  def self.write_file name, command, ext, n_human, n
    bench = new
    bench.instance_variable_set(:@n, n)
    fname = "tmp/#{self.to_s.snakefy}_#{command}_#{name}_#{n_human}.#{ext}"
    content = bench.render("#{name}.#{ext}")
    TextShell.write(fname, content)
  end

  def self.define_mark name, command, ext, n_human, n
    fname = "tmp/#{self.to_s.snakefy}_#{command}_#{name}_#{n_human}.#{ext}"

    mark "#{n_human} - #{command.to_s.ljust_blanks 10} - #{name.to_s.ljust_blanks 16}" do
      Shell.log %|#{"running a new process".light_green} #{command} "tmp/#{name}_#{n_human}.#{ext}"|
      call_command command, fname
    end
  end

  def self.call_command command, fname
    case command
    when :ruby, :node, :python
      `#{command} "#{fname}"`
    when :deno
      `deno run --allow-read "#{fname}"`
    else
      raise "unknown command: #{command}"
    end
  end

  ALGORITHMS.each do |name|
    NUMBERS.each do |n_human, n|
      FORMATS.each do |command, ext|
        #
        define_mark name, command, ext, n_human, n
        #
      end
    end
  end

end

__END__

# ruby.rb.erb

# fastest_for.rb.erb

for i in 0..<%= @n %> do

end

# fastest_while.rb.erb

i = 0
while i <= <%= @n %> do
  i += 1
end



# node.js.erb

# fastest_for.js.erb

for (var i = 0; i <= <%= @n %>; i++) {

}

# fastest_while.js.erb

var i = 0;
while (i <= <%= @n %>) { i += 1; }



# deno.ts.erb

# fastest_for.ts.erb

for (let i = 0; i <= <%= @n %>; i++) {
  
}

# fastest_while.ts.erb

let i = 0;
while (i <= <%= @n %>) { i += 1; }



# python.py.erb

# fastest_for.py.erb

for i in range(<%= @n %>):
  pass

# fastest_while.py.erb

i = 0
while i <= <%= @n %>:
  i += 1

