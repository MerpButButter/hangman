require_relative "display"
require "yaml"

class SaveLoad
  include Display
  def save_data(data)
    data = ::YAML.dump(data)
    name = prompt_filename
    file = ::File.new("saves/#{name}.txt", "w")
    file.write(data)
    puts(display_created_file(name))
  end

  def prompt_filename 
    saves = ::Dir.glob("saves/*")
    puts(display_saves(saves))
    prompt_name
  end

  def prompt_name
    puts(display_name_prompt)
    name = gets.chomp
    return name if valid_name?(name)

    puts(display_error(" Invalid name."))
    prompt_name
  end

  def valid_name?(name)
    !::File.exist?("saves/#{name}.txt") && name.match?(/[a-z]/i) && !name.include?(".") && name.length.between?(3, 100)
  end

  def get_data
    data = ::YAML.load_file("saves/#{name}.txt")
  end
end
