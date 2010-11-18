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

#Klasse zum Lösen der Labyrinthe
class Labsolver
  def initialize(Baum)
    @Baum = Baum
  end
end

# Erzeugt aus einem gegebenen Text-File mit einem Labyrinth den dazugehörigen Graphen
class Labyrinth
end