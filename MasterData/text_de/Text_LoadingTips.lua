__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_LoadingTips = readonly({
  LoadingTips_17465_LoadingTips = {
    Text = "\nAffinitätsrate: Der Grad der mentalen Synchronisation zwischen dem Ermittler, dem Hüter und ihrem Partner-Erwacher.\nJe höher die Affinitätsrate, desto tiefer das Verständnis, desto näher die Beziehung und desto stärker das Vertrauen zwischen ihnen."
  },
  LoadingTips_17466_LoadingTips = {
    Text = "Im Bereich können Emotionen, Gedanken, Ideen und Obsessionen als sichtbare Projektionen erscheinen. Diese Projektionen sind allgemein immaterielle Objekte, täuschende Illusionen, die von der Geisterdimension geschaffen werden, um die Sinne von Individuen in der realen Dimension zu täuschen."
  },
  LoadingTips_17467_LoadingTips = {
    Text = "Der Gnosis-Transfer ist ein spezielles Gerät, das in den Aktentaschen von Ermittlern und Hütern installiert ist und den Transfer des Bewusstseins in hochdimensionalen Karten ermöglicht: Befehlskarten, die nur durch Auflösungs-Beobachtungsgeräte sichtbar sind."
  },
  LoadingTips_17468_LoadingTips = {
    Text = "Sobald ein D-Riss entsteht, kann er sich nicht verkleinern oder beendet werden.\nGewöhnliche Mittel können einen D-Riss nicht beeinflussen, aber ein Silber-Schlüssel kann ihn unterdrücken oder sogar bis zu einem gewissen Grad \"schließen\"."
  },
  LoadingTips_17469_LoadingTips = {
    Text = "Die meisten von der Auflösung betroffenen Individuen erfahren mentale Störungen, wie Paranoia, Zwangsstörungen und Manie, sowie Gedächtnisverlust."
  },
  LoadingTips_17470_LoadingTips = {
    Text = "Auflösungs-Korrosion kann bei organischen Wesen, einschließlich Menschen, Tieren und Pflanzen, sowie bei anorganischen Substanzen wie Mineralien und Metallen auftreten. \nKein Material wurde gefunden, das immun gegen das D-Phänomen ist."
  },
  LoadingTips_17471_LoadingTips = {
    Text = "Die meisten Menschen können das D-Phänomen nicht mit bloßem Auge beobachten."
  },
  LoadingTips_17472_LoadingTips = {
    Text = "Aufgelöste Körper können allgemein anhand verschiedener Abweichungen klassifiziert werden. Die häufigsten Typen sind kooperative aufgelöste Körper, interferierende aufgelöste Körper und zusammengesetzte aufgelöste Körper."
  },
  LoadingTips_17473_LoadingTips = {
    Text = "Manifestationen des D-Phänomens auf Materialien erscheinen als einzelne oder mehrere kleine umgekehrte dreieckige Löcher. \nDiese Löcher variieren in der Größe von etwa 3 mm bis 1 cm, wobei sich die D-Marken mit fortschreitender Auflösung vergrößern."
  },
  LoadingTips_17474_LoadingTips = {
    Text = "Auflösung ist ein einzigartiges Phänomen der materiallichen Zerfall und Auflösung, mit regionalen Eigenschaften."
  },
  LoadingTips_17475_LoadingTips = {
    Text = "In einer bestimmten Phase der D-Phänomen-Entwicklung besteht eine gewisse Wahrscheinlichkeit, dass Auswüchse aus D-Markierungen hervortreten. \nDiese könnten zusätzliche Gliedmaßen, Tentakel oder vielleicht Zahnräder und Metallteile sein..."
  },
  LoadingTips_17476_LoadingTips = {
    Text = "D-Schleim ist wasserabweisend, undurchlässig und schwer in Wasser zu lösen, mit mittlerer Viskosität und etwas Elastizität.\nVor Hunderten von Jahren versuchten rücksichtslose Menschen, ihn als industrielles und künstlerisches Material zu nutzen."
  },
  LoadingTips_17477_LoadingTips = {
    Text = "\"Willkommen im Scheun—wo wir die meisten Aktenschränke und die wenigsten Beerdigungen haben.\"\nDas CMT-Archiv- und Aufzeichnungsbüro wird von dem Ausschuss humorvoll \"die Scheune\" genannt, aufgrund seiner phonetischen Ähnlichkeit."
  },
  LoadingTips_17478_LoadingTips = {
    Text = "Mitglieder der Bildhauer nennen sich oft \"Pygmalion\", und ihr organisatorisches Logo ist ebenfalls ein Meißel."
  },
  LoadingTips_17479_LoadingTips = {
    Text = "Die Auflösung ist dem Banalen unbekannt, aber in bestimmten geheimen Gesellschaften glauben die Menschen fest daran, dass sie kein Unheil, sondern vielmehr ein Segen von Gott ist."
  },
  LoadingTips_17480_LoadingTips = {
    Text = "\nEine massive D-Marke mit einem Durchmesser von über 5 Metern und dem Potenzial für weitere Expansion ist als D-Riss bekannt.\nDer Kern des Risses wird „Katastrophen“ genannt."
  },
  LoadingTips_17481_LoadingTips = {
    Text = "Notfall-Gnosis hat direkten Einfluss auf den Geist des Erweckers, schaltet ihr Potenzial frei und stellt ihren Zustand sofort wieder her. Der einzige Nachteil ist die hohe Kosten."
  },
  LoadingTips_17482_LoadingTips = {
    Text = "Feldmissionen sind hochgradig unvorhersehbar und voller unkontrollierbarer Faktoren.\nUm dem entgegenzuwirken, stellt die Mythag Universität den Feldpersonal Notfallgeräte zur Verfügung, um ihre Sicherheit zu maximieren."
  },
  LoadingTips_17483_LoadingTips = {
    Text = "Ermittler und Hüter befassen sich im Allgemeinen nicht mit gewöhnlichen realen Ereignissen, sondern mit besonderen Ereignissen, die mit Auflösung, Aufgelösten Körpern und bedeutenden Verbindungen zur Geistdimension verbunden sind."
  },
  LoadingTips_17484_LoadingTips = {
    Text = "In Gebieten mit D-Phänomen sind Projektionen der Geisterdimension klarer und Bereiche leichter zu beobachten, obwohl sie volatiler und gefährlicher sind."
  },
  LoadingTips_17485_LoadingTips = {
    Text = "Erwachende werden grob in vier Reiche unterteilt: Aequor, Caro, Ultra und Chaos, basierend auf ihren Eigenschaften."
  },
  LoadingTips_17486_LoadingTips = {
    Text = "Nachdem das Schlüsselhügelritual durchgeführt wurde, müssen Ermittler und Hüter eine beaufsichtigte Feldaufgabe mit ihren Partner-Erweckern abschließen, um sicherzustellen, dass sie in der Lage sind, zukünftige Feldaufgaben selbstständig durchzuführen."
  },
  LoadingTips_17487_LoadingTips = {
    Text = "Das Mystia-Ausschuss (abgekürzt als CMT) ist eine geheime Organisation, die aus gewöhnlichen Menschen besteht und gemeinsam von Regierungen gegründet wurde, jedoch unabhängig von ihnen existiert.\nEs ist der erste Entdecker und erste Reagierende auf das D-Phänomen,\nund auch die erste Verteidigungslinie für gewöhnliche Menschen gegen die Auflösung."
  },
  LoadingTips_17488_LoadingTips = {
    Text = "Verschiedene Erwecker im gleichen Reich können besser zusammenarbeiten, während zwischen verschiedenen Reichen vielleicht einige Abstoßung herrscht.\nNur das Chaos-Reich zeigt dieses Phänomen nicht."
  },
  LoadingTips_17489_LoadingTips = {
    Text = "Silber existiert in der realen Welt allgemein in zwei Formen: Silberprime und rhomboedrisches Silber."
  },
  LoadingTips_17490_LoadingTips = {
    Text = "Der gnostische Index misst die Stabilität von Geist Fragmenten in Silber.\nErwecker mit höheren Indizes verlieren weniger wahrscheinlich die Kontrolle, und selbst wenn sie es tun, verursachen sie weniger Opfer."
  },
  LoadingTips_17491_LoadingTips = {
    Text = "Die Herstellung eines Silber-Schlüssels umfasst eine Reihe komplexer Prozesse, die in der Gravur einer einzigartigen Nummer gipfeln.\nSilber-Schlüssel dürfen keinesfalls gehandelt oder verschenkt werden und werden zu Mythag zurückgebracht, wenn sie keinen Eigentümer haben."
  },
  LoadingTips_17492_LoadingTips = {
    Text = "Die Tabu-Bücher sind auf dem höchsten Regal in der Bibliothek eingeschlossen und können nur von autorisiertem Personal erreicht werden."
  },
  LoadingTips_17493_LoadingTips = {
    Text = "Mythag Universität wird Unterstützung von Silver Chip Technology an den Mystia Treaty Ausschuss gemäß den relevanten Bestimmungen im Mystia Vertrag leisten, um gemeinsam der Auflösung zu widerstehen und die Krise zu bewältigen"
  },
  LoadingTips_17494_LoadingTips = {
    Text = "Jeder Einzelne ergibt unterschiedliche Mengen an Silber bei der Auflösung.\nIndividuen mit stärkeren Geisterkräften ergeben mehr Silber bei der Auflösung, während diejenigen mit schwächeren Geisterkräften weniger ergeben."
  },
  LoadingTips_17495_LoadingTips = {
    Text = "Vertreterartikel in der Silberchip-Technologie umfassen Auflösungsbeobachtungsgeräte, Mythag-Universitätskommunikator und Silber-Schlüssel.\nDer einzigartigste und kostbarste unter ihnen ist der Silber-Schlüssel."
  },
  LoadingTips_17496_LoadingTips = {
    Text = "Bei der Erwachen-Zeremonie verwenden Ermittler und Hüter Silberne Schlüssel, um die Verbindung zwischen dem Silber und der Geist-Dimension zu stärken.\nDurch diese Verbindung können Ermittler und Hüter die umherirrenden Geist-Fragmenten in der Geist-Dimension erfassen und sie innerhalb des Silbers verankern."
  },
  LoadingTips_17497_LoadingTips = {
    Text = "Erwachende werden zwangsweise erschaffen, wenn das Silber die Geistfragmente aus der Geist-Dimension einfängt und fixiert. Diese Fragmente werden von der Geist-Dimension beeinflusst, sodass alle Erwachenden natürlicherweise in einen Zustand des Wahnsinns eintreten, sobald sie erweckt werden. Dieser Zustand hält an, bis ein Ermittler oder Hüter eine Verknüpfung mit ihnen herstellt."
  },
  LoadingTips_17498_LoadingTips = {
    Text = "Die Mythag Universität, gegründet am 16. Oktober 187 Hongji, ist eine Hochschule, die sich der Forschung und Bekämpfung der Auflösung widmet."
  },
  LoadingTips_17499_LoadingTips = {
    Text = "Der Vorgänger von Mythag Universität, Mythag College, wurde am 16. Oktober des Jahres 90 der Hongji-Ära von Wald Phillips und zwei anderen Gründern gegründet."
  },
  LoadingTips_17500_LoadingTips = {
    Text = "Ermittler und Hüter mit einem Silbernen Schlüssel können durch den Schulhofnebel gehen und den Campus mit verknüpften Erwachenden betreten."
  },
  LoadingTips_17501_LoadingTips = {
    Text = "Vor 315 Jahren fegte eine massive Katastrophe über den Globus.\nDieses Jahr wurde als Beginn einer neuen Ära – der Flut-Epoche – bezeichnet."
  },
  LoadingTips_17502_LoadingTips = {
    Text = "\"Möge der Silberne Schlüssel deinen Weg leiten.\"\nEin gängiger Segen unter den Mitgliedern der Mythag-Universität, der ihren unbezwingbaren Geist verkörpert."
  },
  LoadingTips_17503_LoadingTips = {
    Text = "\"Schwöre, die Dunkelheit mit der Klinge zu durchbohren.\"\nEin gelübtes Eid der Mitglieder des Mystia-Vertragsausschusses, der ihren unerschütterlichen Willen widerspiegelt, gegen die Auflösung zu kämpfen."
  },
  LoadingTips_17504_LoadingTips = {
    Text = "Diese besonderen Talente, die über mehr Fähigkeiten verfügen und mehr Erwacher als gewöhnliche Ermittler verbinden können, erhalten den Titel Hüter. \nBisher trugen nur wenige in der Welt den Namen Hüter."
  },
  LoadingTips_17505_LoadingTips = {
    Text = "Im Allgemeinen kann ein Ermittler nur mit einem Erwachen gleichzeitig verbunden werden. Ausnahmen gibt es jedoch."
  },
  LoadingTips_17506_LoadingTips = {
    Text = "Wenn keine Einsatzmissionen vorhanden sind, ruhen Ermittler, Hüter und ihre Erwachenden an der Mythag Universität.\nSie besuchen Klassen, schreiben Prüfungen und erledigen lange Zusatzaufgaben."
  },
  LoadingTips_17507_LoadingTips = {
    Text = "Alle Erwachten müssen die Vorschriften des Mystia-Vertrags einhalten und sich nach dem Erwachen registrieren"
  },
  LoadingTips_17508_LoadingTips = {
    Text = "Streng genommen sind Erwachte auch eine Form der Silberchip-Technologie."
  },
  LoadingTips_36756_LoadingTips = {
    Text = "Je nach Art der Spalte kann eine Spalte einen oder mehrere Kerne haben, die als „Verderben\" bekannt sind."
  },
  LoadingTips_36757_LoadingTips = {
    Text = "Mythag entwickelte, verfeinerte und passte eine Reihe von Screening-Prozessen basierend auf der Theorie der \"Ermittler-Mentalzusammensetzung und -Potenzial\" an, um potenzielle Ermittler zu entdecken, ohne die allgemeine Öffentlichkeit zu alarmieren."
  },
  LoadingTips_36758_LoadingTips = {
    Text = "Der Geist jedes Einzelnen ist unterschiedlich, und die einzigartigen Fähigkeiten jedes Hüters variieren ebenfalls.\nDerzeit bekannte Fähigkeiten sind: geteilte Erinnerung, geteilte Emotionen und Wahrnehmung der Stimmung, unter anderem."
  },
  LoadingTips_36759_LoadingTips = {
    Text = "Vor 315 Jahren fegte eine große Flut über die Welt. Die Ordnung brach zusammen, Städte zerfielen und Berge, die unter dem Meer lagen, erhoben sich plötzlich und bildeten neues Land."
  },
  LoadingTips_36760_LoadingTips = {
    Text = "Leo Fang, die gemeinsame Währung des Königreichs Leo. Hilfswährungen wie Mane und Pensh sind ebenfalls im Umlauf. 1 Leo Fang entspricht 10 Mane, und 1 Mane entspricht 10 Pensh."
  },
  LoadingTips_36761_LoadingTips = {
    Text = "Ein spezieller Raum, der mit Hilfe von Instrumenten und Silber vorübergehend isoliert ist und von anderen Geistern oder der realen Dimension unberührt bleibt, wird als Künstlicher Bereich bezeichnet."
  },
  LoadingTips_36762_LoadingTips = {
    Text = "Durch den Aufzug kannst du den unterirdischen Raum von Mythag erreichen.\nNeben dem größten Riss L-01 \"Schwarzer Pool\" in Londinium gibt es verschiedene gesperrte Bereiche, die ein gewisses Sicherheitsniveau erfordern, um betreten zu werden."
  },
  LoadingTips_36763_LoadingTips = {
    Text = "Aufgrund der Verbindung zwischen dem Silberschlüssel und der Geisterdimension könnte der Schlüssel reagieren, wenn er in der Nähe von Individuen mit abnormen Geisterzuständen ist"
  },
  LoadingTips_36764_LoadingTips = {
    Text = "Bündnisse sind mysteriöse Runen, die mit Silbers unter besonderen Methoden auf Materialien aufgezeichnet sind.\nUnterschiedliche Bündnisse bieten unterschiedliche Hilfen, und dieselbe Reihe von Bündnissen kann mehr Unterstützung bieten."
  },
  LoadingTips_36765_LoadingTips = {
    Text = "D-Schleim ist ein schwarzes Schlammpack, das aus D-Marken sickert.\nWie das D-Phänomen selbst können gewöhnliche Menschen es ohne spezielle Instrumente nicht direkt beobachten."
  },
  LoadingTips_36766_LoadingTips = {
    Text = "Einige aufgelöste Körper verwandeln sich nach dem Tod in einen schwarzen Staub, bekannt als D-Staub."
  },
  LoadingTips_36767_LoadingTips = {
    Text = "Das Königreich Leo liegt im Osten des Atlanta-Ozeans, grenzt an die Constante-Federation und die Evergreen-Union.\nDas Königreich ist klein in der Größe, aber mächtig, da es eines der ersten war, das nach der Flut den Wiederaufbau abschloss."
  },
  LoadingTips_36768_LoadingTips = {
    Text = "Die Aglo-Republik liegt an der Westseite des Atlanta-Ozeans, umgeben vom Meer und mit großen Binnengebieten.\nDie Aglo-Republik ist hochentwickelt in Industrie und Finanzen, wobei das Finanzzentrum Fletcher ein geschäftiger Knotenpunkt ist, den viele besuchen möchten."
  },
  LoadingTips_36769_LoadingTips = {
    Text = "Im Bereich können Emotionen, Gedanken, Ideen und Obsessionen als sichtbare Projektionen manifestieren.\nDiese Projektionen sind normalerweise immateriell oder verschwinden beim Berühren, Illusionen aus der Geisterdimension, die die Sinne von Individuen in der physischen Dimension täuschen."
  },
  LoadingTips_36770_LoadingTips = {
    Text = "Die Constante Föderation befindet sich auf dem Kontinent Ost-Laureasien, eine Föderation, die aus mehreren kleinen Ländern gebildet wurde. In der Föderation ist Kunst ein gemeinsames Bestreben für alle."
  },
  LoadingTips_36771_LoadingTips = {
    Text = "Einige spezielle Projektionen können durch die Gnosis-Transfer erfasst und an Befehlskarten angehängt werden, was den Erwachten Boni gewährt. Diese Projektionen werden Orison genannt."
  },
  LoadingTips_36772_LoadingTips = {
    Text = "Basierend auf der Größe der D-Rifts können sie grob in sechs Kategorien unterteilt werden: C, B, A, S, SS und SSS."
  },
  LoadingTips_36773_LoadingTips = {
    Text = "Die Bildhauer, eine extremistische Organisation, die besessen von sündhaften Menschenversuchen ist, wurde von Robert Rosenthal, einem Landesverräter von Mythag, gegründet."
  },
  LoadingTips_36774_LoadingTips = {
    Text = "Der Seefahrer ist eine alte religiöse Organisation, die von Miryam geleitet wird.\nSie arbeiten mühsam, alles mit dem Ziel, ihren einzigen Gott-König wiederzubeleben."
  },
  LoadingTips_36775_LoadingTips = {
    Text = "Verschiedene Bereiche des Bereichs liefern während der Ermittlung unterschiedliche Gegenstände. Selbst scheinbar identische Gegenstände können ganz unterschiedliche Essenzen besitzen."
  },
  LoadingTips_36776_LoadingTips = {
    Text = "Ein Bereich ist eine spezielle Dimension zwischen der Geisterdimension und der physischen Dimension und der nächste Raum, den Menschen physisch zur Geisterdimension betreten können."
  },
  LoadingTips_36777_LoadingTips = {
    Text = "Mythag Universität ist eine absolut neutrale dritte Partei. Alle Angelegenheiten, groß oder klein, werden gemeinsam vom Direktor und dem Verwaltungsteam durch Beratung entschieden, frei von organisatorischen Einschränkungen."
  },
  LoadingTips_36778_LoadingTips = {
    Text = "D-Risse benötigen keine physischen Objekte, um zu existieren; sie können am Himmel, im Ozean und an anderen Orten erscheinen."
  },
  LoadingTips_36779_LoadingTips = {
    Text = "Die Tempellicht-Kirche, eine geheime und böse Sekte, scheint enge Verbindungen zu den Bildhauern und Seefahrern zu haben."
  },
  LoadingTips_36780_LoadingTips = {
    Text = "Der Mystia-Vertrag Ausschuss ist eine äußerst große Organisation.\nNeben dem Königreich Leo hat sie Niederlassungen in der Aglo-Republik, der Constante-Föderation und sogar im Remouahe-Reich."
  }
})
return Text_LoadingTips
