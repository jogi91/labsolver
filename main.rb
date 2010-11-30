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

require "tools" #Enthält im Moment nur ein Werkzeug
require "labyrinth"
require "labsolver"




if ARGV.length != 0
  #Das File wird eingelesen
  breite = gets.to_i
  hoehe = gets.to_i
  labyrinth = Array.new
  (hoehe*2+1).times { |x|
    labyrinth[x] = gets.chomp
  }
  #In das entsprechende Objekt gepackt
  a = Labsolver.new(labyrinth, breite, hoehe)
  #Kommt richtig gelöst wieder Raus
  a.print
else
  puts "Kein Labyrinth zum Lösen angegeben"
  puts "Usage: ruby main.rb labyrinthfile.txt"
end