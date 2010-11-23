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
# 3. Stelle die Anzahl der Richtungen fest, in die man vom aktuellen Feld aus gehen kann
# 4. Wenn noch eine Richtung unbesucht ist, gehe zu einem unbesuchten Nachbarfeld, markiere im alten Feld die Richtung als besucht, gehe zu Schritt 2
# 5. Sonst gehe einen Knoten/Feld zurück und gehe zu 2
# 6. Wenn man wieder am Startknoten ist und keine Richtung unbesucht ist, dann ist der Baum feddich!
class Labyrinth
  def initialize(labyrinth, laenge, breite)
    @labyrinth = labyrinth
    @laenge = laenge
    @breite = breite
    @baum = Tree::TreeNode.new("0,0")
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
# gibt die möglichen Richtungen eines Feldes zurück. 
  def richtungen(koordinaten)
    feld = feld(koordinaten)
    richtungen = Array.new
    if feld[1][4,1] == " "
      puts "richtung rechts frei"
    else
      puts "richtung rechts besetzt"
    end
  end
  def to_s
    #@baum.print_tree
    #puts @baum.name
    @baum << Tree::TreeNode.new("0,1")
    @baum << Tree::TreeNode.new("1,1")
    @aktuellerKnoten = @baum["0,0"]
    puts @baum["0,1"].siblings
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
  a.richtungen([5,5])
end