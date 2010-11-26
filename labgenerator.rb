class Labgenerator
  def initialize(hoehe=5,breite=5)
    @hoehe = hoehe
    @breite = breite
  end
  
  
  def createFeld(oeffnungen)
    feld = Array.new
    if oeffnungen.include? "oben"
      feld[0]= "+   +"
    else
      feld[0] = "+---+"
    end
    mittelstring = "|   |"
    if oeffnungen.include? "links" 
      mittelstring[0,1]=" "
    end
    if oeffnungen.include? "rechts"
      mittelstring[4,1]=" "
    end
    feld[1] = mittelstring
    if oeffnungen.include? "unten"
      feld[2]= "+   +"
    else
      feld[2] = "+---+"
    end 
    return feld  
  end

end
