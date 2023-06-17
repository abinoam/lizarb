class DevSystem::GeneratorGenerator < Liza::Generator
  main_dsl

  FOLDER = "app/dev/generators"

  generate :controller do
    folder FOLDER
    filename "#{name}_generator.rb"
    content render "generator.rb"
  end

  generate :controller_test do
    folder FOLDER
    filename "#{name}_generator_test.rb"
    content render "generator_test.rb"
  end

  generate :template do
    folder "#{FOLDER}/#{name}_generator"
    filename "#{name}.rb.erb"
    content render "template.rb"
  end

  generate :template_test do
    folder "#{FOLDER}/#{name}_generator"
    filename "#{name}_test.rb.erb"
    content render "template_test.rb"
  end

  #

  def self.install args
    log "args = #{args.inspect}"

    new(nil, nil, nil).install args
  end

  def install args
    log "args = #{args.inspect}"

    # if app_env_exists?
    #   log "env files already exist".red.blink
    # else
    #   write_env_files
    # end

    puts
    log "done"
  end

end
