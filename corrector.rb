class Corrector
  def correct_name(name)
    name = name.capitalize
    name = name.delete(' ') if name.length > 10
    name
  end
end
