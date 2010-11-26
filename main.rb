# = Labyrinth-Aufgabe
#
# Dies ist die Lösung von Jogi zu folgender Aufgabe: http://bl.kanti-wohlen.ch/index.php?title=Einf-2011/Graphentheorie#Labyrinth
#
# == Lösungsansatz 
#
# Der zum Labyrinth gehörende Graph ist ein Baum. In einem ersten Schritt soll ein Baum erzeugt werden, in dem jedes Feld ein Knoten ist. Das übernimmt die Klasse Labyrinth.
# Root-Knoten ist der Startpunkt. Somit lässt sich der Weg vom Blatt, dass den Zielknoten enthält, zur Wurzel dadurch erreichen, indem man stets zum Elternknoten geht,
# bis Root erreicht ist. Das und das Zeichnen des Labyrinths wird von der Klasse Labsolver übernommen.
#
# == Installation
#
# Es muss lediglich der Rubygem rubytree installiert werden:
# * sudo apt-get install rubygems
# * sudo gem install rubytree

require "rubygems"
require "tree"

require "tools"
require "labyrinth"
require "labsolver"
require "labgenerator"




if ARGV.length != 0
  breite = gets.to_i
  hoehe = gets.to_i
  labyrinth = Array.new
  (hoehe*2+1).times { |x|
    labyrinth[x] = gets.chomp
  }
  a = Labsolver.new(labyrinth, breite, hoehe)
  a.print
  b = Labgenerator.new
  #puts b.feld("rechtslinks")
end