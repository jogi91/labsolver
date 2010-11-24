# = Labyrinth-Aufgabe
#
# Dies ist die Lösung von Jogi zu folgender Aufgabe: http://bl.kanti-wohlen.ch/index.php?title=Einf-2011/Graphentheorie#Labyrinth
#
# == Lösungsansatz 
#
# Der zum Labyrinth gehörende Graph ist ein Baum. In einem ersten Schritt soll ein Baum erzeugt werden, in dem jedes Feld ein Knoten ist. 
# Die Root-Node ist der Startpunkt. Somit lässt sich der Weg vom Blatt, dass den Zielknoten enthält, zur Wurzel dadurch erreichen, indem man stets zum Elternknoten geht,
# bis Root erreicht ist.
#
# == Installation
#
# Es muss lediglich der Rubygem rubytree installiert werden:
# * sudo apt-get install rubygems
# * sudo gem install rubytree

require "rubygems"
require "tree"

# kleine Hilfsmethode, die jedes Element in einem Array in einen Integer umwandelt
class Array
  def to_i
    self.each_index{ |element|
      self[element] = self[element].to_i
    }
  end
end

#Klasse zum Lösen der Labyrinthe
class Labsolver
  def initialize(baum)
    @baum = baum
  end
  
  #gibt das gelöste labyrinth aus
  def print
  end
  #Methode zum debuggen
  def to_s
    self.inspect
  end
  #gibt einen Array zurück, der sämtliche Knoten enthält, in die ein o geschrieben werden soll
  def solution?
  end
end

# Erzeugt aus einem gegebenen Text-File mit einem Labyrinth den dazugehörigen Graphen
#
# Die Knoten enthalten als Name ihre Koordinaten im Feld als Array.
#
# Für jedes Feld wird berechnet, wie viele Richtungen es gibt, und welche davon besucht wurden. 
#
# == Algorithmus zu Erzeugung des Baums
#
# 1. Starte beim Feld oben links
# 2. Wenn das Feld noch nicht im Baum ist, erzeuge einen Knoten als Kind des Feldes, von dem man gekommen ist.
# 3. Stelle die Anzahl der Richtungen fest, in die man vom aktuellen Feld aus gehen kann und speichere sie als Information in den Knoten
# 4. Wenn noch eine Richtung unbesucht ist, gehe zu einem unbesuchten Nachbarfeld, markiere im alten Feld die Richtung als besucht, gehe zu Schritt 2
# 5. Sonst gehe einen Knoten/Feld zurück und gehe zu 2
# 6. Wenn man das Zielfeld zum Baum hinzugefügt hat, kann man abbrechen.
class Labyrinth
  def initialize(labyrinth, breite, hoehe)
    @labyrinth = labyrinth
    @hoehe = hoehe
    @breite = breite
    @baum = Tree::TreeNode.new("0,0", richtungen([0,0]))
  end
  
# Der Koordinatenursprung liegt oben links, x geht nach rechts, y nach unten
# Ziel ist es, die Möglichen Richtungen zu bestimmen
# Die koordinaten sind ein Array von Integers
# Die Funktion gibt ein Array aus 3 Strings zurück
  def feld(koordinaten)
    yfeld = (koordinaten[1]*2)
    xfeld = koordinaten[0]*4
    return [@labyrinth[yfeld][xfeld,5],@labyrinth[yfeld+1][xfeld,5],@labyrinth[yfeld+2][xfeld,5]]
  end
  
# gibt die möglichen Richtungen eines Feldes als Array zurück. 
  def richtungen(koordinaten)
    feld = self.feld(koordinaten)
    richtungen = Array.new
    if feld[1][4,1] == " "
      richtungen.push "rechts"
    end
    if feld[1][0,1] == " "
      richtungen.push "links"
    end
    if feld[0][1,1] == " "
      richtungen.push "oben"
    end
    if feld[2][1,1] == " "
      richtungen.push "unten"
    end
    return richtungen
  end
  
  #Hauptmethode der Klasse, verfährt nach dem obigen Algorithmus, um den Baum zu erzeugen
  def createTree
    
    aktuelle_richtungen = self.richtungen([0,0])
    koordinaten = [0,0]
    letzter_name = ""
    gekommen_von = [""]
    aktueller_name = koordinaten.join(",")
    aktueller_knoten = @baum
    while true
      if !aktuelle_richtungen.empty?
        #Gehe weiter
        direction = aktuelle_richtungen.pop
        puts aktueller_knoten.content
        aktueller_knoten.content = aktuelle_richtungen
        puts aktueller_knoten.content
        case direction
        when "links"
          koordinaten[0] -= 1
          gekommen_von = ["rechts"]
        when "rechts"
          koordinaten[0] += 1
          gekommen_von = ["links"]
        when "oben"
          koordinaten[1] -= 1
          gekommen_von = ["unten"]
        when "unten"
          koordinaten[1] += 1
          gekommen_von = ["oben"]
        end
        aktueller_name = koordinaten.join(",")
        aktuelle_richtungen = richtungen(koordinaten)-gekommen_von #Richtung, aus der man gekommen ist, ist keine Neue möglichkeit
        puts "Aktuelle Richtungen: #{aktuelle_richtungen.inspect}"
        aktueller_knoten << Tree::TreeNode.new(aktueller_name, aktuelle_richtungen) #Der neue Knoten wird an den aktuellen Knoten angehängt
        letzter_name = aktueller_name
        aktueller_knoten
        aktueller_knoten = aktueller_knoten[aktueller_name]  #Der aktuelle Knoten geht zum gerade hinzugefügten knoten
        @baum.print_tree
        

        if koordinaten == [(@breite-1),(@hoehe-1)] # Wenn man jetzt auf den Koordinaten unten rechts ist, dann hat man den letzten nötigen Knoten hinzugefügt
          "endkoordinaten erreicht"
          break
        end
        
      else
        #Gehe zurück
        aktueller_knoten = aktueller_knoten.parent
        aktuelle_richtungen = aktueller_knoten.content
        #Da die Koordinaten im Namen des Knotens verpackt sind, holen wir sie da wieder raus, 
        #indem der Namensstring erst in ein Array aus Strings und diese dann in Integers umgewandelt werden.
        koordinaten = aktueller_knoten.name.split(",").to_i
        @baum 
      end  
    end
    
    puts "Baum erfolgreich erstellt"
    return @baum
  end
  def to_s
    #@baum.print_tree
    #puts @baum.name
    @baum << Tree::TreeNode.new("0,1", "hallo2")
    @baum << Tree::TreeNode.new("1,1", "hallo3")
    
    @baum.content = "content"
    puts @baum[1].content
    #@baum.print_tree
  end
end

if ARGV.length != 0
  breite = gets.to_i
  hoehe = gets.to_i
  labyrinth = Array.new
  (hoehe*2+1).times { |x|
    labyrinth[x] = gets
  }
  a = Labyrinth.new(labyrinth, breite, hoehe)
  a.createTree.print_tree
end