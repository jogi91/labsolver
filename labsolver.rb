
# Das ist die Klasse zum Lösen der Labyrinthe. Ihr werden ein Labyrinth, die Höhe und die Breite übergeben.
class Labsolver
  #Der Labsolver wird initialisiert, neben den Eingaben wird direkt auch eine Instanzvariable für die Ausgabe angelegt
  def initialize(labyrinth,breite,hoehe)
    @labyrinth = labyrinth
    @hoehe = hoehe
    @breite = breite
    @ausgabe = @labyrinth
  end

#gibt einen Array zurück, der sämtliche Knotennamen enthält, in die ein o geschrieben werden soll  
  def solve
    baum = Labyrinth.new(@labyrinth,@breite,@hoehe) #Labyrinthobjekt wird angelegt
    @loesung = Array.new
    baum.createTree.parentage.each { |e| # Baum wird erzeugt, vom Zielknoten geht man zu Root und notiert den Namen von jeden Knoten auf dem Weg dahin.
      @loesung.push e.name }
    @loesung.push("#{@breite-1},#{@hoehe-1}") #Der Zielkonoten wird dabei nicht erwischt, daher wird er hier von Hand hinzugefügt
  end
  
  #gibt das gelöste labyrinth aus
  def print
    if @loesung.nil?
      self.solve # Nur lösen, wenn die Lösung noch nicht berechnet wurde (Spart Zeit, wenn der Baum mehrmals gezeichnet werden muss)
    end
    @loesung.each { |element|
      draw(element.split(",").to_i) #Jeder Knotenname wird in die Koordinaten konvertiert und dann wird an der Stelle ein o gezeichnet
    }
    puts @ausgabe
  end
  
  #Zeichnet ein o in die mitte des Feldes mit den angegebenen Koordinaten
  def draw(koordinaten)
    ypos = koordinaten[1]*2+1
    xpos = koordinaten[0]*4+2
    @ausgabe[ypos][xpos,1] = "o"
  end
end
