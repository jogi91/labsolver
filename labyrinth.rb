# Erzeugt aus einem gegebenen Text-File mit einem Labyrinth den dazugehörigen Graphen
#
# Die Knoten enthalten als Name ihre Koordinaten als String der Form "x,y". So kann leicht auf sie zugegriffen werden, indem sie beim Namen benannt werden,
# denn ein Array mit den Koordinaten kann einfach mit join(",") zu einem String zusammengefügt werden. Der umgekehrte Weg läuft über die Methode split(","). 
# Da sie jedoch einen Array aus Strings erzeugt, wurde die Klasse Array mit der Methode to_i erweitert.
#
# Für jedes Feld wird berechnet, wie viele Richtungen es gibt, und welche davon besucht wurden. Diese Information wird als Array in den Knoten gespeichert.
# So kann der Algorithmus einfach umgesetzt werden.
#
# == Algorithmus zu Erzeugung des Baums
#
# 1. Starte beim Feld oben links
# 2. Wenn das Feld noch nicht im Baum ist, erzeuge einen neuen Knoten als Kind des Feldes, von dem man gekommen ist.
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
        aktueller_knoten.content = aktuelle_richtungen
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
        aktueller_knoten << Tree::TreeNode.new(aktueller_name, aktuelle_richtungen) #Der neue Knoten wird an den aktuellen Knoten angehängt
        letzter_name = aktueller_name
        aktueller_knoten
        aktueller_knoten = aktueller_knoten[aktueller_name]  #Der aktuelle Knoten geht zum gerade hinzugefügten knoten
        

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
      end  
    end
    return aktueller_knoten
  end
end
