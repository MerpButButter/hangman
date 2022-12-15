require_relative "display"
require "yaml"
require_relative "styles"

# SaveLoad class which saves data in to files and loads data from them by prompting for the file name
class SaveLoad
  include Display
  def save_data(data)
    data = ::YAML.dump(data)
    name = prompt_filename(0)
    file = ::File.new("saves/#{name}.txt", "w")
    file.write(data)
    puts(display_created_file(name))
  end

  def prompt_filename(mode)
    saves = ::Dir.glob("saves/*")
    puts(display_saves(saves))
    prompt_name(mode)
  end

  def prompt_name(mode)
    puts(display_name_prompt(mode))
    name = gets.chomp
    return name if valid_name?(name, mode)
    
    puts(display_error(" Invalid name."))
    prompt_name(mode)
  end

  def valid_name?(name, mode)
    if mode.zero?
      !::File.exist?("saves/#{name}.txt") && name.match?(/[a-z]/i) && !name.include?(".") && name.length.between?(3, 100)
    else
      ::File.exist?("saves/#{name}.txt")
    end
  end

  def get_data
    if Dir.glob("saves/*").empty?
      return puts("There are no saves!".style("red", "bold"))
    end
    
    name = prompt_filename(1)
    ::YAML.load_file("saves/#{name}.txt")
  end
end