  # Die Klasse Array wird um eine Methode erweitert
  class Array
    #Konvertiert jedes Element im Array in einen Integer
    def to_i
      self.each_index{ |element|
        self[element] = self[element].to_i
      }
    end
  end