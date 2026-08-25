__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_Event = readonly({
  Event_116371_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_116371_Desc = {
    Text = "Du nimmst den Kontakt der Schule an, die vertraute Stimme beruhigt dich. Du sammelst dich und gehst weiter"
  },
  Event_116371_Name = {
    Text = "Kontaktstelle"
  },
  Event_116372_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_116372_Desc = {
    Text = "Du hast den unbekannten Raum aktiviert."
  },
  Event_116372_Name = {Text = "Unbekannt"},
  Event_116373_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_116373_Desc = {
    Text = "Du hast den Schatz gefunden."
  },
  Event_116373_Name = {Text = "Schatz"},
  Event_116374_ChoiceDesc1 = {
    Text = "[Verbinden] Arg2 Lebenspunkte heilen"
  },
  Event_116374_Desc = {
    Text = "Du erkundest den Nebel, plötzlich leuchtet das Abzeichen auf deiner Brust schwach silbern. Wer ruft dich am anderen Ende des Kommunikators?"
  },
  Event_116374_Name = {
    Text = "Kontaktstelle"
  },
  Event_116389_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_116389_Desc = {
    Text = "Gesicht formen schläft noch...zzZZ"
  },
  Event_116389_Name = {
    Text = "Gesicht formen"
  },
  Event_116429_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_116429_Desc = {
    Text = "Du hast das zufällige Ereignis 3 ausgelöst."
  },
  Event_116429_Name = {
    Text = "Zufälliges Ereignis 3"
  },
  Event_116430_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_116430_Desc = {
    Text = "Du hast das zufällige Ereignis 1 ausgelöst."
  },
  Event_116430_Name = {
    Text = "Zufälliges Ereignis 1"
  },
  Event_116431_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_116431_Desc = {
    Text = "Du hast das zufällige Ereignis 2 ausgelöst."
  },
  Event_116431_Name = {
    Text = "Zufälliges Ereignis 2"
  },
  Event_117279_ChoiceDesc1 = {
    Text = "[Du hast dir Unschuld gewünscht] Lege 3 “(Skill.Arg1)“ in das Deck."
  },
  Event_117279_Desc = {
    Text = "\nEin dünner, weißer Nebel erhebt sich über dem Meeresspiegel und hüllt alles in eine verschwommene Atmosphäre. \nDu überquerst die Grenze zwischen Leben und Tod, überwindest die Distanz zwischen innen und außen der Tür, überbrückst die lang verblassten Erinnerungen und siehst die Silhouette einer Dame mit Sonnenschirm im Gegenlicht. \nDie Zeit, die du mit ihr verbracht hast, ist vergangen, wie ihre zarte, aber lebendige jugendliche Schönheit. \nDu wartest auf den Aufstieg der falschen Sonnenscheibe, der Nebel zerbricht ins Nichts, und ihr Schatten wankt im Traum und verwandelt sich in schwebende, illusorische Blasen, die dir stumm Lebewohl sagen."
  },
  Event_117279_Name = {
    Text = "Murphys Phantom"
  },
  Event_117280_ChoiceDesc1 = {
    Text = "[Du hast dir Naivität gewünscht] Wähle 2 Karten und verleihe das Gebet “Echos der tiefen See“."
  },
  Event_117280_Desc = {
    Text = "\nAm Meeresspiegel erhebt sich ein dünner weißer Nebel, der alles in eine verschwommene Hülle hüllt. \nÜber die Grenze von Leben und Tod, über die Distanz innerhalb und außerhalb der Tür, über die lange verblasste Erinnerung, siehst du die Silhouette der Dame, die einen Sonnenschirm hält, im Gegenlicht. \nDie Zeit, die du mit ihr verbracht hast, ist vergangen, so wie ihre dünne, aber lebendige, leuchtende Jugend. \nWarte darauf, dass die falsche Sonnenscheibe aufgeht, der Nebel zerbricht im Nichts, und ihr Schatten schwankt im Traum und verwandelt sich in schwebende, illusorische Blasen, die dir ein stummes Lebewohl zurufen."
  },
  Event_117280_Name = {
    Text = "Murphys Phantom"
  },
  Event_118414_ChoiceDesc1 = {
    Text = "[Drei Punkte]"
  },
  Event_118414_ChoiceDesc2 = {
    Text = "[Sechs Uhr]"
  },
  Event_118414_ChoiceDesc3 = {
    Text = "[Ein Punkt]"
  },
  Event_118414_Desc = {
    Text = "Der Würfel rollt und gibt ein gurgelndes Geräusch von sich.\nWann wird er aufhören?\nDas weißt du nicht, aber du musst eine Antwort geben."
  },
  Event_118414_Name = {
    Text = "Schicksals Glücksspiel"
  },
  Event_118415_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_118415_Desc = {
    Text = "Ihre Antwort macht den \"Himmel\" noch sanfter.  \nEr legt Ihnen sanft einen Kuss auf die Stirn.  \nDann blüht eine Welle von Blumen auf Ihrer Stirn."
  },
  Event_118415_Name = {
    Text = "Umarmung des Meeres"
  },
  Event_118416_ChoiceDesc1 = {
    Text = "[In Fantasien versinken] Wähle 1 von 3 Befehlskarten aus, um ein Gebet zu erhalten: „(EnchantConfig.Arg1)\", infiziere „(Skill.Arg2)\""
  },
  Event_118416_ChoiceDesc2 = {
    Text = "[Verstand bewahren] Erhalte 15 Schwarze Male für jeden Erweckten Körper mit 50 oder mehr Aliemus"
  },
  Event_118416_ChoiceDesc3 = {
    Text = "[Gewaltsam verlassen] Erhalte 1 aus 3 Gebeten"
  },
  Event_118416_Desc = {
    Text = "Vielleicht ist es der lange Kampf, der dich verwirrt hat, oder vielleicht hat einfach nur dein Gehirn deinen Körper verraten.\n Ein Gefühl der Schwerelosigkeit erscheint in deinem Geist.\n Im Handumdrehen verwandelt sich dein Verstand plötzlich in ein Kaleidoskop, brillant bunt, blitzend in allen Lichtnuancen.\n Unzählige Einsichten, Überlegungen und Fantasien strömen in dein Gehirn, besetzen jede Ecke der Spalten deines Geistes.\n Wenn das so weitergeht, wird dein Gehirn bald durch diese chaotischen Gedanken explodieren."
  },
  Event_118416_Name = {
    Text = "Kaleidoskop des Denkens"
  },
  Event_118417_ChoiceDesc1 = {
    Text = "[Am Schicksalsspiel teilnehmen] Entwickle [(Skill.Arg1), ] betrete das Schicksalsspiel"
  },
  Event_118417_ChoiceDesc2 = {
    Text = "[Lass es bleiben]Erhalte 25 das schwarze Siegel"
  },
  Event_118417_Desc = {
    Text = "In einem Zustand der Benommenheit trieb dein Bewusstsein durch Schichten von Nebel und zerstreute sich in den unbekannten Raum.\nZwei Würfel wurden vor dir geworfen, doch die unbekannte Existenz, die dich gewaltsam hierher brachte, blieb unsichtbar.\nDu konntest nur die chaotischen Stimmen aus allen Richtungen hören.\n„Willst du zurück? Dann lass uns eine Runde spielen.\"\n„Mit deinem Leben als Einsatz – lass das Schicksalsspiel beginnen.\""
  },
  Event_118417_Name = {
    Text = "Schicksals Glücksspiel"
  },
  Event_118418_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_118418_Desc = {
    Text = "Transzendente Erfahrungen sind immer kurz. Sie kommen still und verschwinden plötzlich. \nAber zumindest ist dein Kopf noch hier, er ist nicht wirklich explodiert."
  },
  Event_118418_Name = {
    Text = "Kaleidoskop des Denkens"
  },
  Event_118419_ChoiceDesc1 = {
    Text = "[Verlassen]Erhalte Silberrelikt“(RelicConfig.Arg1)“"
  },
  Event_118419_Desc = {
    Text = "Du hast nicht verloren, aber auch nicht gewonnen; das Ergebnis ist weder gut noch schlecht. \n„Es ist ein Unentschieden...\" \nDie unbekannte Existenz seufzte, doch in ihrer Stimme war keine Spur von Bedauern. \n„Was für ein netter kleiner Zeitvertreib.\""
  },
  Event_118419_Name = {
    Text = "Schicksals Glücksspiel"
  },
  Event_118420_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_118420_Desc = {
    Text = "Allmählich wird die rasende Musik in deinen Ohren harmonisch und heilig. \n Du verstehst endlich, warum sie als “perfekte Hymne“ bezeichnet wird. \n Denn sie ist tatsächlich “makellos“."
  },
  Event_118420_Name = {
    Text = "“Perfekt“ Hymne"
  },
  Event_118421_ChoiceDesc1 = {
    Text = "[Nimm das Gehirn wahr] Wähle eine Karte aus drei Befehlskarten und erhalte Gebet: [(EnchantConfig.Arg1)]"
  },
  Event_118421_ChoiceDesc2 = {
    Text = "[Seele wahrnehmen] infiziere “(Skill.Arg1)“, erneuere das Gebet, höchstens 2 Mal"
  },
  Event_118421_Desc = {
    Text = "Der erste Käfig des Menschen ist sein eigener Körper.\nIn diesem Käfig ist das Gehirn der letzte und wichtigste Käfig.\n“Schatz, denkst du, nur weil du lebst und atmest, bist du sicher?“\nWenn dein Gehirn deine Seele verrät, wirst du die qualvollsten Pein der Welt erfahren.\nUnd diese Pein wird dich dein ganzes Leben begleiten."
  },
  Event_118421_Name = {
    Text = "Gedankengefängnis"
  },
  Event_118422_ChoiceDesc1 = {
    Text = "[Treffe Schmetterling] Lösche 2 Karten"
  },
  Event_118422_ChoiceDesc2 = {
    Text = "[Schmetterlinge vertreiben] Erhalte ein verfluchtes Relikt“(RelicConfig.Arg1)“、infiziere“(Skill.Arg2)“"
  },
  Event_118422_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte Arg1 schwarze Siegel"
  },
  Event_118422_Desc = {
    Text = "Im tiefen Meer gibt es keine Schmetterlinge. Diese Lebewesen wurden von einem Mädchen, das in einem Raum gefangen ist, erdacht. \n Sie sind so schön und fliegen frei in der Luft. \n “Wenn ich nur wie sie wäre und von hier wegfliegen könnte...“ \n Ein Schmetterling gab ein Schluchzen von sich, aber dieser Klang ging in den unzähligen Flügelschlägen unter, verborgen im Klappern der Tasten, kaum hörbar."
  },
  Event_118422_Name = {
    Text = "Die Seele fliegt wie ein Schmetterling"
  },
  Event_118423_ChoiceDesc1 = {
    Text = "[Schrei „sie“ an] infiziere „(Skill.Arg1)\", erhalte ein verfluchtes Relikt „(RelicConfig.Arg2)\""
  },
  Event_118423_ChoiceDesc2 = {
    Text = "[Vertreibe „sie“] Infiziere zweimal „(Skill.Arg1)\", erhalte das Silberrelikt „(RelicConfig.Arg2)\" und „(RelicConfig.Arg3)\""
  },
  Event_118423_ChoiceDesc3 = {
    Text = "[Angriff auf „sie“] Erhalte das Silberrelikt [(RelicConfig.Arg1)]"
  },
  Event_118423_Desc = {
    Text = "„Es wird gesagt, dass unendliches Verlangen die treibende Kraft des Menschen ist.\"\n„Aber wenn dieses Verlangen so stark wird, dass es nicht ignoriert oder durchtrennt werden kann, fühle ich nur, dass dieses Verlangen aus mir selbst in ein Gefängnis verwandelt wurde, das mich gefangen hält.\"\nAus der Dunkelheit ertönte eine kraftlose Stimme, deren Gesicht du nicht sehen kannst, nur ein Paar gefesselte Hände. \n„Dieses Verlangen nährt sich von meiner Angst, Schwäche, Hoffnung und Schmerzen und verstärkt wiederum mein Verlangen.\"\nDie kraftlose Stimme äußerte ihren letzten Hilferuf. \n„Ich bin bereit, alles zu opfern! Gutherziger Mensch, rette mich... oder gib mir Erlösung...\""
  },
  Event_118423_Name = {
    Text = "Bindende Wünsche"
  },
  Event_118424_ChoiceDesc1 = {
    Text = "[Nimm das Gehirn wahr] Wähle eine Karte aus drei Befehlskarten und erhalte Gebet: [(EnchantConfig.Arg1)]"
  },
  Event_118424_Desc = {
    Text = "Du spürst, wie sich dein Hirnmark zusammenzieht. \n “Hat das eine besondere Bedeutung?“ \n fragst du dich, während dein Gehirn still bleibt. \n Nicht jede Selbstbefragung kann eine Antwort liefern."
  },
  Event_118424_Name = {
    Text = "Gedankengefängnis"
  },
  Event_118425_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_118425_Desc = {
    Text = "Du kämpfst gegen die Strömung an und springst schließlich aus dem Wasser. \n Die mit dem Geruch des Meeres vermischte Luft strömt in deine Lungen und erinnert dich daran, dass du der Gefahr nicht wirklich entkommen bist. \n Aber du weißt, der wahre Himmel ist über dir. \n Wie die Wahrheit wird sie niemals von sanften Lügen verdeckt."
  },
  Event_118425_Name = {
    Text = "Umarmung des Meeres"
  },
  Event_118426_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_118426_Desc = {
    Text = "In dem Moment, in dem du das Seil des Verlangens berührst, durchzuckt ein stechender Schmerz tief aus deiner Seele.\nDeine Angst, Schwäche, Hoffnung und Schmerz steigen aus dir empor und verwandeln sich in ein blutiges Seil, das deine Hände fesselt.\nIn diesem Moment hörst du die bösartigen Jubelrufe dieser Stimme.\n\"Guter Mensch, du wirst belohnt... natürlich gibt es auch einen Fluch.\""
  },
  Event_118426_Name = {
    Text = "Bindende Wünsche"
  },
  Event_118427_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_118427_Desc = {
    Text = "Deine Berührung lässt die Schmetterlinge zittern. \n Seit ihrer Geburt haben sie nie eine so sanfte Behandlung erfahren. \n Die Schmetterlinge werden von überwältigenden Emotionen beherrscht und vergessen sogar das Fliegen. \n So fallen unzählige Schmetterlinge und enthüllen die Schreibmaschine, die zuvor von unzähligen Flügeln verborgen war. \n Das arme Ding, das bereits das Leben verloren hat, spielt mit letzter Kraft die beiden Worte “Freiheit“."
  },
  Event_118427_Name = {
    Text = "Die Seele fliegt wie ein Schmetterling"
  },
  Event_118428_ChoiceDesc1 = {
    Text = "[Kampfbereit machen] Wähle 1 von 3 Befehlskarten aus, um ein Gebet zu erhalten: „(EnchantConfig.Arg1)\", infiziere „(Skill.Arg2)\""
  },
  Event_118428_ChoiceDesc2 = {
    Text = "[Versuch, einen Umweg zu nehmen] Erhalte 25 schwarze Siegel"
  },
  Event_118428_Desc = {
    Text = "In der tiefen See, wo das Sternenlicht herabfällt, haben die Seefahrer hunderte von Jahren lang geruht. \n Das unendliche Wasser hat ihren Wahnsinn, ihre Ausdauer und ihren frommen Glauben an die Gottheit bezeugt. \n Niemand kann das große Erscheinen der Gottheit aufhalten. \n Jeder, der im Weg steht, wird in der Wut der Seefahrer zu Asche."
  },
  Event_118428_Name = {
    Text = "Warten unter den Sternen"
  },
  Event_118429_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_118429_Desc = {
    Text = "Du hast instinktiv deine Ohren zugehalten.\nUnglaublich, die Geräusche aus tief in deiner Seele verschwanden.\nNatürlich war es nur vorübergehend."
  },
  Event_118429_Name = {
    Text = "Entweihende Melodie"
  },
  Event_118430_ChoiceDesc1 = {
    Text = "[Vergangenheit erneut erleben] Erhalte eine Auswahl von 3 für 1 fortgeschrittenes Gebet"
  },
  Event_118430_ChoiceDesc2 = {
    Text = "[Spähen in die Zukunft]Erhalte goldene Kreation“(RelicConfig.Arg1)“、Infektion“(Skill.Arg2)“"
  },
  Event_118430_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte 50 schwarze Siegel"
  },
  Event_118430_Desc = {
    Text = "Nichts in der Welt kann statisch bleiben.\n Selbst das von der Göttin Mutter geformte Paradies ist keine Ausnahme.\n In einem flüchtigen Moment erhaschst du einen Blick auf etwas aus den Rissen von Zeit und Raum.\n Vergangenheit, Gegenwart und Zukunft verwickeln sich in diesem rissigen Spalt und ändern sich ständig.\n Wartend auf dein neugieriges Ausspähen"
  },
  Event_118430_Name = {
    Text = "Raum-Zeit-Riss"
  },
  Event_118431_ChoiceDesc1 = {
    Text = "[Erhalte 100 schwarze Siegel]"
  },
  Event_118431_ChoiceDesc2 = {
    Text = "[2 zufällige Befehlskarten erhalten ein Gebet: „(EnchantConfig.Arg1)\"]"
  },
  Event_118431_Desc = {
    Text = "Der ungreifbare Wille akzeptiert deine Wahl nicht. Er ist bereit, dir eine weitere Chance zu geben, eine Veränderung zu bewirken—\n Sei vorsichtig, denn selbst wenn die Musik unsichtbar ist, kann sie Leben ernten."
  },
  Event_118431_Name = {
    Text = "“Perfekt“ Hymne"
  },
  Event_118432_ChoiceDesc1 = {
    Text = "[Widerlegen] erhält Silberrelikt [(RelicConfig.Arg1)], wählt 1 Symptom zur Infektion"
  },
  Event_118432_ChoiceDesc2 = {
    Text = "[folge ihnen] Wählen Sie 1 Karte aus 3 Befehlskarten und erhalten Sie das Gebet:„(EnchantConfig.Arg1)\", Infektion„(Skill.Arg2)\""
  },
  Event_118432_ChoiceDesc3 = {
    Text = "[Neue Perspektive einbringen]erhalte 25 schwarze Siegel"
  },
  Event_118432_Desc = {
    Text = "Alles auf diesem Schiff ist in der Zeitschleife gefangen.\nSelbst diese widerlichen, pelzigen kleinen Kreaturen, die hier ums Überleben kämpfen, können ihrem Schicksal nicht entkommen.\nZyklus um Zyklus verschlingen sie alles in Sichtweite, doch ihr Hunger wird nie gestillt.\n„So... hungrig...\"\nHorden von Ratten stoßen krankhaft durchdringende Schreie aus.\nDie endlosen Zyklen haben sie ausgehungert und wahnsinnig gemacht — sie müssen etwas fressen.\nJetzt. Sofort."
  },
  Event_118432_Name = {
    Text = "Hungrige Rattenbande"
  },
  Event_118433_ChoiceDesc1 = {
    Text = "[Ihrem Blick ausweichen] Erhalte Goldene Kreation „(RelicConfig.Arg1),\" aber entwickle „(Skill.Arg2)\""
  },
  Event_118433_ChoiceDesc2 = {
    Text = "[Starre in die Augen] Wecke zufällig 2 Erwecker, infiziere 2 mal [(Skill.Arg1)]"
  },
  Event_118433_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte 50 schwarze Siegel"
  },
  Event_118433_Desc = {
    Text = "So wie die Sterne am Himmel gibt es sicherlich viele Augen im tiefen Meer.\nDiese Augen gehören zu Fischen, die am Meeresboden leben, zu den entweihten Kiemenspezies und zum Ozean selbst.\nShh, störe sie nicht.\nStöre nicht den Wahnsinn des tiefen Meeres."
  },
  Event_118433_Name = {
    Text = "Auge der Tiefsee"
  },
  Event_118434_ChoiceDesc1 = {
    Text = "[Das Flüstern ignorieren]"
  },
  Event_118434_ChoiceDesc2 = {
    Text = "[Dem Flüstern lauschen]"
  },
  Event_118434_ChoiceDesc3 = {
    Text = "[Etwas erfinden]"
  },
  Event_118434_Desc = {
    Text = "„Begehrst du die Gunst Gottes? Willst du deine eigene Bedeutung erfahren?\"\nEin Seufzen ertönt in deinem Ohr, wie das Selbstgespräch eines Geistesgestörten, oder das intime Flüstern von etwas Formlosem.\nMit Vernunft und Wachsamkeit weist du diese Stimme zurück, doch sie spricht weiter zu sich selbst.\n„Bitte höre geduldig zu. Was du erfahren wirst, ist die Wahrheit über das Schicksal der Welt...\""
  },
  Event_118434_Name = {
    Text = "Predigt des Unfassbaren"
  },
  Event_118435_ChoiceDesc1 = {
    Text = "[Nimm das Gehirn wahr] Wähle eine Karte aus drei Befehlskarten und erhalte Gebet: [(EnchantConfig.Arg1)]"
  },
  Event_118435_ChoiceDesc2 = {
    Text = "[Wahrnehmung der Seelen] Infektion “(Skill.Arg1)“, erneut zufälliges Gebet"
  },
  Event_118435_Desc = {
    Text = "Das Gehirn, das sicher im Kopf geschützt ist, vermittelt dir bestimmte Informationen. \n Du weißt nicht, ob diese Informationen durch den Austausch von Neurotransmittern und die Übertragung von bioelektrischen Strömen beeinträchtigt wurden. \n Die einzige Tatsache, die sicher ist, ist, dass du diese Informationen empfangen hast und in der objektiven Existenz deines Körpers dein Überleben wahrgenommen hast."
  },
  Event_118435_Name = {
    Text = "Gedankengefängnis"
  },
  Event_118436_ChoiceDesc1 = {
    Text = "[Verlassen]Erhalte 50 schwarze Siegel"
  },
  Event_118436_Desc = {
    Text = "„Gute Antwort, aber leider nicht die richtige Antwort.\"\n„Was ist die richtige Antwort?\"\nDie unbekannte Existenz beantwortete deine Frage nicht, nur ein verächtliches Lachen war zu hören.\n„Wer hat dir gesagt, dass das Schicksal eine richtige Antwort hat?\""
  },
  Event_118436_Name = {
    Text = "Schicksals Glücksspiel"
  },
  Event_118437_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_118437_Desc = {
    Text = "„Dach denkst du, ich hätte nicht versucht, sie zu durchtrennen? Nein, wenn du dich dem Verlangen widersetzt, werden sie nur stärker!\"\nWährend du spürst, wie sich die Seile des Verlangens immer fester um dich ziehen, sogar in dein Fleisch schneiden, ertönt ein verzweifelter Schrei. \n„Ich werde niemals von ihnen loskommen... niemals!\""
  },
  Event_118437_Name = {
    Text = "Bindende Wünsche"
  },
  Event_118438_ChoiceDesc1 = {
    Text = "[Gesang hören] erhalte 25 schwarze Siegel, Infektion “(Skill.Arg2)“, weiter wählen"
  },
  Event_118438_ChoiceDesc2 = {
    Text = "[Lass es bleiben]Verlassen"
  },
  Event_118438_Desc = {
    Text = "Der pechschwarze Rabe weint.\nDer pechschwarze Rabe schreit.\nDer pechschwarze Rabe heult.\nDoch für die Menschen klingt es nur wie Singen.\n\"Ah, was für ein unbeschwerter Song. Ich wünschte, ich wäre ein Rabe, fernab von den Sorgen der Welt.\""
  },
  Event_118438_Name = {
    Text = "Nicht wahrgenommene Klage"
  },
  Event_118439_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_118439_Desc = {
    Text = "Der Schmetterling zerstreute sich, und du siehst endlich die Schreibmaschine darunter. \n Das arme Ding, das bereits das Leben verloren hatte, spielte mit seiner letzten Kraft die beiden Wörter “Verlassen“."
  },
  Event_118439_Name = {
    Text = "Die Seele fliegt wie ein Schmetterling"
  },
  Event_118440_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_118440_Desc = {
    Text = "Im Schatten der Vergangenheit winkt ein Mädchen in einem flauschigen Mantel dir zu.\nDu kannst nicht hören, was sie sagt, aber du siehst das Lächeln des Mädchens."
  },
  Event_118440_Name = {
    Text = "Raum-Zeit-Riss"
  },
  Event_118441_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_118441_Desc = {
    Text = "Das Aequor hat erneut seine Dunkelheit und Stille wiedererlangt. \n In dieser Dunkelheit und Stille hörst du erneut den Herzschlag. \n Dieses Geräusch kommt aus deinem Inneren. \n In den Augen anderer bist du nur ein Herz, das im dunklen Aequor umher schwimmt."
  },
  Event_118441_Name = {
    Text = "Schwache werden gefressen"
  },
  Event_118442_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_118442_Desc = {
    Text = "Diesmal waren es nicht die Störenfriede, die zu Asche wurden, sondern die Seefahrer. \n Die Sterne schauten schweigend auf diese Szene herab, wie sie es seit tausend Jahren getan hatten, und blieben still."
  },
  Event_118442_Name = {
    Text = "Warten unter den Sternen"
  },
  Event_118443_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_118443_Desc = {
    Text = "Trotz zahlenmäßiger Überlegenheit sind diese dreckigen Ratten mutiger als ihre eigenen Körper.\nSie sind von deiner starken Haltung eingeschüchtert und verstreuen sich panisch."
  },
  Event_118443_Name = {
    Text = "Hungrige Rattenbande"
  },
  Event_118444_ChoiceDesc1 = {
    Text = "[Hilfe anbieten]wecke zufällig 1 Erwecker, Infektion “(Skill.Arg1)“"
  },
  Event_118444_ChoiceDesc2 = {
    Text = "[Stille Beobachtung] Erhalte 3 aus 1 Gebet"
  },
  Event_118444_Desc = {
    Text = "Ein schlagendes Herz schwebt in der pechschwarzen Tiefe des Aequors. \n Es gehört vielleicht einem Fisch oder einem Wesen mit Kiemen. \n Du kannst es nicht klar erkennen. Das Einzige, was du klar sehen kannst, ist das unaufhörlich schlagende Herz und das große, sich allmählich öffnende Maul dahinter. \n Jagen oder gejagt werden, das ist das Gesetz der Natur. \n Egal, ob an Land oder im Ozean."
  },
  Event_118444_Name = {
    Text = "Schwache werden gefressen"
  },
  Event_118445_ChoiceDesc1 = {
    Text = "[Mit der Hand verscheuchen] Wähle 1 von 3 Befehlskarten aus, die das Gebet erhält: „(EnchantConfig.Arg1)\", infiziert „(Skill.Arg2)\""
  },
  Event_118445_ChoiceDesc2 = {
    Text = "[Lass es verweilen]Erhalte ein Silberrelikt „(RelicConfig.Arg1)“, infiziere „(Skill.Arg2)“"
  },
  Event_118445_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte 25 schwarze Siegel"
  },
  Event_118445_Desc = {
    Text = "Ein leises Geräusch dringt aus der Dunkelheit.\nEs ist ein Schmetterling, der höflich fragt:\n„Darf ich in deiner Handfläche ruhen?\"\n„Ich bin nur so müde... Ich möchte einen Moment rasten.\"\nWährend er fragt, spiralt der Schmetterling durch die Dunkelheit auf dich zu.\nSchwarze, klebrige Flüssigkeit tropft von seinen Flügeln—ein Geschenk der Schatten, durch die er flog."
  },
  Event_118445_Name = {
    Text = "Die Bitte des Schmetterlings"
  },
  Event_118446_ChoiceDesc1 = {
    Text = "[Verlassen]Erhalte goldenes Relikt“(RelicConfig.Arg1)“"
  },
  Event_118446_Desc = {
    Text = "Nach einem Moment der Stille wurde dir etwas in die Arme geworfen.\n„Nimm es und geh.\"\n„Das Schicksal ist immer großzügig zu den Glücklichen.\""
  },
  Event_118446_Name = {
    Text = "Schicksals Glücksspiel"
  },
  Event_118447_ChoiceDesc1 = {
    Text = "[Der Führung folgen] Wähle 1 von 3 Befehlskarten aus, um das Gebet zu erhalten: „(EnchantConfig.Arg1)\", infiziere „(Skill.Arg2)\""
  },
  Event_118447_ChoiceDesc2 = {
    Text = "[Führung ignorieren] Wähle 1 von 3 Befehlskarten aus, um das Gebet zu erhalten: „(EnchantConfig.Arg1)\", infiziere „(Skill.Arg2)\""
  },
  Event_118447_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte 25 schwarze Siegel"
  },
  Event_118447_Desc = {
    Text = "Das Fest hat begonnen.\nUnter den Flammen des Geistes und den Segnungen des Blutes sind unzählige gläubige Seelen zu Leuchtfeuern geworden—\nDie ätherischen Geister verstreuen sich um dich wie leitende Elfen, leuchtend und wartend auf deine Wahl."
  },
  Event_118447_Name = {
    Text = "Seelenlaterne"
  },
  Event_118448_ChoiceDesc1 = {
    Text = "[Verlassen]Infiziere“(Skill.Arg1)“，erhalte 50 schwarze Siegel"
  },
  Event_118448_Desc = {
    Text = "„Unwissende Menschen!\"\nDiese Stimme stieß eine frustrierte Klage aus, aber nicht bis zum Punkt des Zorns.\nDenn sie weiß, die Unwissenden werden immer Momente der Erleuchtung haben.\nSie muss nur auf diesen Tag warten.\nUnd bevor dieser Tag kommt, wird sie dich mit dem Siegel Gottes zeichnen und die Zugehörigkeit deiner Seele bestätigen."
  },
  Event_118448_Name = {
    Text = "Predigt des Unfassbaren"
  },
  Event_118449_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_118449_Desc = {
    Text = "[@2 von @3......]\nEine Flut von Wissen, begleitet von jener blasphemischen Melodie, strömt in dein Gehirn.\nDoch deine sterbliche Hülle begrenzt dich und macht kosmische Weisheit unerreichbar.\nWelch trauriges Bedauern."
  },
  Event_118449_Name = {
    Text = "Entweihende Melodie"
  },
  Event_118450_ChoiceDesc1 = {
    Text = "[Verlassen]Infiziere“(Skill.Arg1)“，erhalte 50 schwarze Siegel"
  },
  Event_118450_Desc = {
    Text = "„Eigentlich habe auch ich eine Wahrheit über die Welt, die ich dir erzählen möchte...\"\n„Die Welt wurde von einem fliegenden Nudel-Gott erschaffen, bestehend aus zwei weisen Fleischbällchen-Augen und Nudeln, die unendliche Fähigkeit symbolisieren...\"\nDu erzählst ernsthaft eine lustige Geschichte, die du gehört hast, und wartest auf die Reaktion der anderen Seite.\nDoch nach langer Zeit bleibt die andere Seite still.\n„Ach, es scheint, eifrige Gläubige verstehen keinen Humor.\"\nSeufzend bleibt dir nichts anderes übrig, als zu gehen."
  },
  Event_118450_Name = {
    Text = "Predigt des Unfassbaren"
  },
  Event_118451_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_118451_Desc = {
    Text = [[
Deine Stimmung hat diese chaotischen Silben nicht harmonisch gemacht. 
 Aber zumindest hat der unsichtbare Wille deinen Versuch gesehen. 
 Das ist ein guter Beginn.]]
  },
  Event_118451_Name = {
    Text = "“Perfekt“ Hymne"
  },
  Event_118452_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_118452_Desc = {
    Text = "Drei Figuren zitterten, weinten schweigend.\nIhr Glaube wurde von dir in Frage gestellt, und das war die größte Beleidigung, die ein Fanatiker nicht ertragen konnte."
  },
  Event_118452_Name = {
    Text = "Das beste Opfer"
  },
  Event_118453_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_118453_Desc = {
    Text = "In der Bilderwelt der Zukunft warf dir das Mädchen mit Tentakeln einen verächtlichen Blick zu und schimpfte.\n„Die wahre Gestalt der Göttlichen Mutter darf nicht entweiht werden.\"\nDann verschwand die Bilderwelt, und der Raum-Zeit-Riss schloss sich augenblicklich, sodass du nur noch die Szene von eben in Erinnerung behalten konntest."
  },
  Event_118453_Name = {
    Text = "Raum-Zeit-Riss"
  },
  Event_118454_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_118454_Desc = {
    Text = "Du hast den Seefahrer erfolgreich hinter dir gelassen und stürmst weiter vorwärts. \n Über dir leuchten die Sterne still, so wie sie es in den letzten tausend Jahren getan haben."
  },
  Event_118454_Name = {
    Text = "Warten unter den Sternen"
  },
  Event_118455_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_118455_Desc = {
    Text = "Die unbekannte Existenz hat dich nicht aufgehalten.\n„Eines Tages wirst du zurückkehren.\"\n„Niemand kann dem Schicksal widerstehen.\""
  },
  Event_118455_Name = {
    Text = "Schicksals Glücksspiel"
  },
  Event_118456_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_118456_Desc = {
    Text = "Mit einer schnellen und entscheidenden Bewegung fielen diese Hände schwach nieder.\nAber du hast den letzten Seufzer der anderen Person nicht verpasst.\nEr befreite sich schließlich von seinen endlosen Begierden."
  },
  Event_118456_Name = {
    Text = "Bindende Wünsche"
  },
  Event_118457_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_118457_Desc = {
    Text = "Nicht wahrgenommen zu werden, ist das unausweichliche Schicksal dieser Welt.\nNiemand kann vollständig mit einem anderen Leben mitfühlen."
  },
  Event_118457_Name = {
    Text = "Nicht wahrgenommene Klage"
  },
  Event_118458_ChoiceDesc1 = {
    Text = "[Gesang hören] erhält 35 schwarze Siegel, infiziert “(Skill.Arg2)“, weiter wählen"
  },
  Event_118458_ChoiceDesc2 = {
    Text = "[Lass es bleiben]Verlassen"
  },
  Event_118458_Desc = {
    Text = "Der pechschwarze Rabe weint.\nDer pechschwarze Rabe schreit.\nDer pechschwarze Rabe heult.\nDoch für die Menschen klingt es nur wie Singen.\n\"Ah, was für ein unbeschwerter Song. Ich wünschte, ich wäre ein Rabe, fernab von den Sorgen der Welt.\""
  },
  Event_118458_Name = {
    Text = "Nicht wahrgenommene Klage"
  },
  Event_118459_ChoiceDesc1 = {
    Text = "[Lauscher] erhält Silberrelikt „(RelicConfig.Arg1)“, Infektion „(Skill.Arg2)“"
  },
  Event_118459_ChoiceDesc2 = {
    Text = "[Ohren zuhalten]erhalte 3 Auswahlen für das Gotteszeichen"
  },
  Event_118459_Desc = {
    Text = "Im formlosen Wahnsinn scheinst du ein Klavier zu sehen.\nEin Paar verschwommenen Händen tanzte auf den formlosen Tasten und spielte profane Melodien.\nDie bizarre Musik hallte aus den Tiefen deiner Seele wider, reiste durch die Blutgefäße und erreichte dein zitterndes Gehirn."
  },
  Event_118459_Name = {
    Text = "Entweihende Melodie"
  },
  Event_118460_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_118460_Desc = {
    Text = "Diese Inspirationen, Gedanken und Fantasien verweben sich, mischen sich zu den prächtigsten Farben der Welt.\nDu siehst, wie Raum in deinem eigenen Körper gefaltet wird, die Zeit sich nach deinem Willen dreht.\nIn diesem Moment nimmst du Zeit und Raum wahr, omnipotent und omniscient.\nNatürlich hast du auch einen Preis gezahlt."
  },
  Event_118460_Name = {
    Text = "Kaleidoskop des Denkens"
  },
  Event_118461_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_118461_Desc = {
    Text = "Die chaotische Seele weist dir den Weg mit scharfen Klagen.\nIst das ein sicherer Weg? Du weißt es nicht.\nDeine einzige Wahl ist es, weiter vorwärts zu gehen."
  },
  Event_118461_Name = {
    Text = "Seelenlaterne"
  },
  Event_118462_ChoiceDesc1 = {
    Text = "[Höre das Lied]erhält 40 das schwarze Siegel, infiziert “(Skill.Arg2)“, weiter wählen"
  },
  Event_118462_ChoiceDesc2 = {
    Text = "[Lass es sein]erhalte 25 das schwarze Siegel, verlasse"
  },
  Event_118462_Desc = {
    Text = "Der pechschwarze Rabe weint.\nDer pechschwarze Rabe schreit.\nDer pechschwarze Rabe heult.\nDoch für die Menschen klingt es nur wie Singen.\n\"Ah, was für ein unbeschwerter Song. Ich wünschte, ich wäre ein Rabe, fernab von den Sorgen der Welt.\""
  },
  Event_118462_Name = {
    Text = "Nicht wahrgenommene Klage"
  },
  Event_118463_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_118463_Desc = {
    Text = "Die chaotische Seele lässt ein klagendes Seufzen hören.\nSie verblasst allmählich, aber dieser traurige Seufzer, hätte er Substanz, fällt auf dein Herz.\nThump thump, dein Herzschlag resoniert synchron mit der Melodie des Rituals."
  },
  Event_118463_Name = {
    Text = "Seelenlaterne"
  },
  Event_118464_ChoiceDesc1 = {
    Text = "[Verlassen]Erhalte Silberrelikt“(RelicConfig.Arg1)“"
  },
  Event_118464_Desc = {
    Text = "„Ah, ah, was für ein frommes Lamm das ist!\"\nDiese Stimme seufzt, erfüllt von jubelndem Lob.\n„Wenn mein Herr erwacht, werden Lämmer wie du sicherlich einen Platz finden in jenem erhabenen und großen Göttlichen Reich...\""
  },
  Event_118464_Name = {
    Text = "Predigt des Unfassbaren"
  },
  Event_118465_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_118465_Desc = {
    Text = "„Der Himmel\" umarmt deine Widerspenstigkeit.\nEines Tages wird das verlorene Kind in die Arme der Mutter zurückkehren.\nDenn du hast nirgendwo hin zu fliehen."
  },
  Event_118465_Name = {
    Text = "Umarmung des Meeres"
  },
  Event_118466_ChoiceDesc1 = {
    Text = "[Zustimmung zeigen] Erhalte das Silberrelikt„(RelicConfig.Arg1)\", infiziere„(Skill.Arg2)\""
  },
  Event_118466_ChoiceDesc2 = {
    Text = "[Überbringe ein Geschenk] Erhalte Silberrelikt „(RelicConfig.Arg1)\", infiziere „(Skill.Arg2)\""
  },
  Event_118466_ChoiceDesc3 = {
    Text = "[Schwimme an die Oberfläche] Erhalte 25 Schwarze Imprägnierungen"
  },
  Event_118466_Desc = {
    Text = "Die Welt liegt vor deinen Augen.\n In diesem Moment ist der tiefblaue Ozean um dich herum der \"Himmel\".\n In der Qual des fast Ertrinkens nähert sich dieser tiefblaue \"Himmel\" sanft und beabsichtigt, dich zu umarmen.\n Er wird nicht urteilen, sondern nur geben."
  },
  Event_118466_Name = {
    Text = "Umarmung des Meeres"
  },
  Event_118467_ChoiceDesc1 = {
    Text = "[Sängerin am Hals packen] erhalte verfluchtes Relikt „(RelicConfig.Arg1)\", infektiere „(Skill.Arg2)\""
  },
  Event_118467_ChoiceDesc2 = {
    Text = "[Auf sie reagieren] Wähle 1 von 3 Befehlskarten aus, um das Gebet zu erhalten: [(EnchantConfig.Arg1)]"
  },
  Event_118467_ChoiceDesc3 = {
    Text = "[Ignorieren]du erhälst 50 Schwarze Imprägnierung"
  },
  Event_118467_Desc = {
    Text = "Drei vage geformte Seelen blockierten deinen Weg.\nEine Gestalt verbeugte sich feierlich vor dir und flehte darum, dir Blut abzunehmen. Dein fließendes Blut ist das beste Opfer für die Götter.\nEine Gestalt hob kalt ein Messer gegen dich, mit der Absicht, dein Fleisch zu schneiden. Dieses nicht mutierte Menschenfleisch würde sicherlich die Gunst der Götter gewinnen.\nDie letzte betrachtete dich schweigend, in der Hoffnung, dass du dir selbst das Leben nehmen würdest, um den tiefsten Glauben zu beweisen."
  },
  Event_118467_Name = {
    Text = "Das beste Opfer"
  },
  Event_118468_ChoiceDesc1 = {
    Text = "[Rufen der Melodie]erhält 30 das schwarze Siegel, infiziert “(Skill.Arg2)“, weiter wählen"
  },
  Event_118468_ChoiceDesc2 = {
    Text = "[Lass es bleiben]Verlassen"
  },
  Event_118468_Desc = {
    Text = "Der pechschwarze Rabe weint.\nDer pechschwarze Rabe schreit.\nDer pechschwarze Rabe heult.\nDoch für die Menschen klingt es nur wie Singen.\n\"Ah, was für ein unbeschwerter Song. Ich wünschte, ich wäre ein Rabe, fernab von den Sorgen der Welt.\""
  },
  Event_118468_Name = {
    Text = "Nicht wahrgenommene Klage"
  },
  Event_118469_ChoiceDesc1 = {
    Text = "[Verlassen]Infektion“(Skill.Arg1)“"
  },
  Event_118469_ChoiceDesc2 = {
    Text = "[Verlassen]Infektion“(Skill.Arg1)“"
  },
  Event_118469_ChoiceDesc3 = {
    Text = "[Verlassen]Infektion“(Skill.Arg1)“"
  },
  Event_118469_Desc = {
    Text = "„Nein! Das lehnen wir ab! Wir verlangen etwas... Köstlicheres.\"\n„Dann soll es... euer Blut und Fleisch sein!\"\nEin Schwarm Ratten kreischt und stürzt sich auf dich.\nEs scheint, dass ein überfließendes gutes Herz manchmal mehr Ärger als Erleichterung bringen kann."
  },
  Event_118469_Name = {
    Text = "Hungrige Rattenbande"
  },
  Event_118470_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_118470_Desc = {
    Text = "Ihr Respekt gewinnt die Gunst dieser Augen.  \nBevor sie verschwinden, schenken sie Ihnen ein Geschenk durch das aufgeregte Meer.  \nDas ist der Beweis, dass die Tiefsee Sie zähmt."
  },
  Event_118470_Name = {
    Text = "Auge der Tiefsee"
  },
  Event_118471_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_118471_Desc = {
    Text = "Unter deinem unverschämten Blick erwacht der tiefen Meer langsam.\nDas Meer schwankt chaotisch um dich herum und bringt unbeschreibliche Murmeln.\nFühle die Wut des tiefen Meeres, dies ist sowohl ein Segen als auch ein Fluch."
  },
  Event_118471_Name = {
    Text = "Auge der Tiefsee"
  },
  Event_118472_ChoiceDesc1 = {
    Text = "[Gesang hören] erhält 20 schwarze Siegel, infiziere “(Skill.Arg2)“"
  },
  Event_118472_ChoiceDesc2 = {
    Text = "[Lass es bleiben]Verlassen"
  },
  Event_118472_Desc = {
    Text = "Der pechschwarze Rabe weint.\nDer pechschwarze Rabe schreit.\nDer pechschwarze Rabe heult.\nDoch für die Menschen klingt es nur wie Singen.\n\"Ah, was für ein unbeschwerter Song. Ich wünschte, ich wäre ein Rabe, fernab von den Sorgen der Welt.\""
  },
  Event_118472_Name = {
    Text = "Nicht wahrgenommene Klage"
  },
  Event_118473_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_118473_Desc = {
    Text = "Blut, Fleisch, Leben.\nDas Opfer ist bereit, nun musst du nur still auf das göttliche Festmahl warten."
  },
  Event_118473_Name = {
    Text = "Das beste Opfer"
  },
  Event_118474_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_118474_Desc = {
    Text = "Der Schmetterling verstand deine Ablehnung.\nSeine Flügel, bedeckt mit pechschwarzem Schleim, vibrierten erneut und flatterten unruhig in der Dunkelheit.\nBald schlang die Dunkelheit den Schmetterling erneut ein. Diesmal hatte er nicht mehr die Kraft, sich zu winden."
  },
  Event_118474_Name = {
    Text = "Die Bitte des Schmetterlings"
  },
  Event_118475_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_118475_Desc = {
    Text = "Der Schmetterling fiel in deine Handfläche, zusammen mit dem schwarzen, klebrigen Schleim auf seinen bunten Flügeln. \n In deinem Seufzer schmolzen die bunten Flügel allmählich und verbanden sich mit dem schwarzen Schleim zu einer unbekannten chaotischen Form. \n Dieser Schmetterling muss die Dunkelheit nicht mehr erleben. \n Er schläft in deiner Handfläche."
  },
  Event_118475_Name = {
    Text = "Die Bitte des Schmetterlings"
  },
  Event_118477_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_118477_Desc = {
    Text = "Der krächzende Rabe schloss schließlich die Augen. \n In einem Groll, den niemand kannte und der nicht wahrgenommen wurde, hauchte er seinen letzten Atemzug aus und verwandelte sich in einen Pfütze schwarzen Schleims."
  },
  Event_118477_Name = {
    Text = "Nicht wahrgenommene Klage"
  },
  Event_118478_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_118478_Desc = {
    Text = "“Danke dir...“\nDas pochende Herz springt fröhlich in die Ferne. \nBald ertönt im schwarzen Aequor das Geräusch des Kauens von Fleisch."
  },
  Event_118478_Name = {
    Text = "Schwache werden gefressen"
  },
  Event_118479_ChoiceDesc1 = {
    Text = "[Einladung annehmen] Entwickle „(Skill.Arg1),\" erhalte Fluchkreatur „(RelicConfig.Arg2)\""
  },
  Event_118479_ChoiceDesc2 = {
    Text = "[Weigere die Einladung] Wähle 1 Relikt zum Zerstören und erhalte 1 Belohnung"
  },
  Event_118479_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte 50 schwarze Siegel"
  },
  Event_118479_Desc = {
    Text = "“Alles auf diesem Schiff muss Teil dieses sich ständig auflösenden und wieder startenden Kreislauf-Paradieses werden.“\nRasende Klänge erklingen in deinem Geist, das ist der Anstoß des unsichtbaren Willens für dich. \n“Hier gibt es kein Weinen, kein Trauern, nur reine heilige Musik und ewiges Lachen.“\n“Möchtest du dem Paradies beitreten und Teil dieser perfekten Melodie werden?“"
  },
  Event_118479_Name = {
    Text = "“Perfekt“ Hymne"
  },
  Event_118480_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_118480_Desc = {
    Text = "In deiner Stille verschwinden die Seelen lautlos.\nDiejenigen, die die Gläubigen nicht verstehen, sind ihre Zeit nicht wert."
  },
  Event_118480_Name = {
    Text = "Das beste Opfer"
  },
  Event_123616_ChoiceDesc1 = {
    Text = "[Relikt der Standardklasse erhalten]"
  },
  Event_123616_Desc = {
    Text = "Setze das Aliemus aller Erwecker auf 100, Keyflare auf 1000 und die HP auf 80%.\nEntferne 2 Karten und füge 3 Symptomkarten hinzu.\nSetze Crimson Forge auf 12,5%, wähle 4 Karten, um in den Ultra-Raum einzutreten.\nErhalte das Standard-Reliquienpaket."
  },
  Event_123616_Name = {
    Text = "Ein-Klick-Überspringen auf dem Weg"
  },
  Event_125696_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_125696_Desc = {
    Text = "Grundloser Zorn treibt dich an. Du hebst die Hand und schlägst aus, um sie zu vertreiben. Du hast zu lange in Rätseln verweilt; vielleicht sehnst du dich nach einem unerbittlichen Kampf, oder einfach nach einem Ende...\nDoch die Krähen tun nichts. Unter deinem Blick löst sich der Abgrund auf.\nDer Schwarm verschwindet zum Ende der Bühne – dem Ort, wohin du gehen musst."
  },
  Event_125696_Name = {
    Text = "Spiralabgrund der Krähen"
  },
  Event_125697_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_125697_Desc = {
    Text = "„Feigling.\" Sie macht keinen Versuch, den Spott in ihrem Lachen zu verbergen.\n„Dann geh. Je weiter, desto besser.\""
  },
  Event_125697_Name = {
    Text = "Die Blutketten des Schicksals"
  },
  Event_125698_ChoiceDesc1 = {
    Text = "[Verscheuchen] Wähle 1 von 3 Befehlskarten aus, die das Gebet erhält: „(EnchantConfig.Arg1)\", infiziert „(Skill.Arg2)\""
  },
  Event_125698_ChoiceDesc2 = {
    Text = "[Listen] Die Silberne Schöpfung „(RelicConfig.Arg1)\" erhalten, aber „(Skill.Arg2)\" entwickeln"
  },
  Event_125698_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte 25 schwarze Siegel"
  },
  Event_125698_Desc = {
    Text = "Ein leises Geräusch ertönte in der Dunkelheit. Ein Schmetterling fiel in deine Handfläche. Du erinnerst dich an ihn. \n„Fräulein Arachne... du hast uns nie verlassen, oder?\" \nDie wunderschönen Muster des Schmetterlings, schaue zu den Menschen neben dir."
  },
  Event_125698_Name = {
    Text = "Das restliche Leben des Schmetterlings"
  },
  Event_125699_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_125699_Desc = {
    Text = "Die Geräusche und Schriften bohren sich wie ein schwärmendes Bienenvolk in deinen Geist. Du hältst den Atem an und vertreibst das nutzlose Rauschen aus deinem Bewusstsein.\nZu ignorieren ist weit mühsamer als zu lesen – doch du hast es geschafft."
  },
  Event_125699_Name = {
    Text = "Dimension Telegramm"
  },
  Event_125700_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_125700_Desc = {
    Text = "Es ist eine Illusion, die vom Feind beschworen wurde!\nDu schüttelst den Kopf, die Klarheit kehrt zurück, und du umfasst den Silberschlüssel fester."
  },
  Event_125700_Name = {
    Text = "Spiegelbild im Wein"
  },
  Event_125701_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_125701_Desc = {
    Text = "Du richtest deinen Blick auf dieses Auge und strengst dich an, zu beobachten, zu lauschen. Du versuchst, in das Herz des Schauspielers einzutreten und die Qual zu spüren, die er erduldet.\nDu kommst näher und immer näher. Du durchdringst seine Gestalt und berührst seine Seele...\nDu reißt die Augen auf und findest dich in der Mitte der Bühne wieder, Tränen rinnen an deinen Fingerspitzen herab.\nDas ist das Geständnis, das du dem Publikum darbietest."
  },
  Event_125701_Name = {
    Text = "Das Geständnis eines Schauspielers"
  },
  Event_125702_ChoiceDesc1 = {
    Text = "[Mit ihr diskutieren] Zerstöre eine Befehlskarte, erhalte Arg1 Schwarzes Mal"
  },
  Event_125702_ChoiceDesc2 = {
    Text = "[Schweigen]"
  },
  Event_125702_Desc = {
    Text = "„Ein glückliches Ende ist schön, doch solch hohle Freude kann die Herzen des Publikums niemals berühren...\"\nDie Dramatikerin schließt die Augen in Besinnung. Sie ist mit diesem Schluss unzufrieden."
  },
  Event_125702_Name = {
    Text = "Ende des Stücks"
  },
  Event_125703_ChoiceDesc1 = {
    Text = "[Gesang hören] erhält 35 schwarze Siegel, infiziert “(Skill.Arg2)“, weiter wählen"
  },
  Event_125703_ChoiceDesc2 = {
    Text = "[Lass es bleiben]Verlassen"
  },
  Event_125703_Desc = {
    Text = "„Knarrend – knarrend – dreht die Schicksalsgöttin ihr Spinnrad.\nKnarrend – knarrend – laufen die Schicksalsfäden in ihren Händen zusammen.\""
  },
  Event_125703_Name = {
    Text = "Letzte Prophezeiung"
  },
  Event_125704_ChoiceDesc1 = {
    Text = "[Yourself] Dupliziere 1 von 3 zufälligen Befehlskarten aus dem Deck"
  },
  Event_125704_ChoiceDesc2 = {
    Text = "[Wilhelm] Wähle 1 von 3 Befehlskarten aus, um ein Gebet zu erhalten: „(EnchantConfig.Arg1)\", infiziere „(Skill.Arg2)\""
  },
  Event_125704_ChoiceDesc3 = {
    Text = "[Niemand] Erhalte 25 Schwarze Male"
  },
  Event_125704_Desc = {
    Text = [[
Du bist dir sicher, nicht betrunken zu sein, doch als du in den Alkohol blickst, versinkst du in einem stillen See.
Eine elegante Gestalt erscheint im Glas. Wer ist es?]]
  },
  Event_125704_Name = {
    Text = "Spiegelbild im Wein"
  },
  Event_125705_ChoiceDesc1 = {
    Text = "[Listen] Erhalte die Silberne Schöpfung [(RelicConfig.Arg1)]"
  },
  Event_125705_ChoiceDesc2 = {
    Text = "[Dispel] Erhalte 75 Schwarze Imprägnierungen, aber entwickle das Symptom [(Skill.Arg2)]"
  },
  Event_125705_Desc = {
    Text = "Als du dich der Kraft des Plasmids in dir näherst, erscheint in deinem Geist ein Schwarm Krähen, der durch dein aufgewühltes Geisterreich kreist.\n\nDie Krähen spiralen um dich herum, wie ein Strudel des Abgrunds, der umgekehrt über dir hängt.\nHunderttausend Krähen schreien im Einklang, wie eine spöttische Prophezeiung."
  },
  Event_125705_Name = {
    Text = "Spiralabgrund der Krähen"
  },
  Event_125706_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_125706_Desc = {
    Text = "Du und Arachne versucht, das neben euch zerbrochene Schicksal zu stabilisieren. Eure Bemühungen zeigen nur geringe Erfolge, aber das ist bereits genug. Mit der gewonnenen Zeit nähert ihr euch Nefraea. \n Du bist hierher gekommen, um ihr Erlösung zu bringen."
  },
  Event_125706_Name = {
    Text = "Schlussvorhang für das Netz des Schicksals"
  },
  Event_125707_ChoiceDesc1 = {
    Text = "[Gesang hören] erhält 20 schwarze Siegel, infiziere “(Skill.Arg2)“"
  },
  Event_125707_ChoiceDesc2 = {
    Text = "[Lass es bleiben]Verlassen"
  },
  Event_125707_Desc = {
    Text = "„Sie sterben mit dem großen Netz, lautlos.\""
  },
  Event_125707_Name = {
    Text = "Letzte Prophezeiung"
  },
  Event_125708_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_125708_Desc = {
    Text = "Es ist ein Telegramm, adressiert an den Spiralabgrund.\n„Sorgt euch nicht, meine Kinder. Die Tore des Gefängnisses werden sich bald weit öffnen; eure Befreiung steht bevor.\""
  },
  Event_125708_Name = {
    Text = "Dimension Telegramm"
  },
  Event_125709_ChoiceDesc1 = {
    Text = "[Vertreiben] Eine zufällige Befehlskarte erhält Gebet: „(EnchantConfig.Arg1)\", infiziert „(Skill.Arg2)\""
  },
  Event_125709_ChoiceDesc2 = {
    Text = "[Listen] Gravur des Orison [(EnchantConfig.Arg1)] auf 1 von 3 Befehlskarten"
  },
  Event_125709_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte 25 schwarze Siegel"
  },
  Event_125709_Desc = {
    Text = "Ein Schmetterling landet sanft auf deiner Handfläche. Seine erlesenen Muster ähneln unblinkenden Augen, die dich schweigend anstarren.\nVielleicht möchte er dir etwas mitteilen?"
  },
  Event_125709_Name = {
    Text = "Pausieren des Schmetterlings"
  },
  Event_125710_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_125710_Desc = {
    Text = "Zwanzig Paar traurige Augen richten sich auf dich. Die Krähe beendet ihren Gesang und verlässt dieses zerfallende Netz mit ihrer letzten Prophezeiung."
  },
  Event_125710_Name = {
    Text = "Letzte Prophezeiung"
  },
  Event_125711_ChoiceDesc1 = {
    Text = "[Beuge dich und schaue]infiziere“(Skill.Arg1)“、erhalte das goldene Relikt“(RelicConfig.Arg2)“"
  },
  Event_125711_ChoiceDesc2 = {
    Text = "[Gib die Überprüfung auf]erhalte 50 das schwarze Siegel"
  },
  Event_125711_Desc = {
    Text = "Als du um die Straßenecke gehst, entdeckst du einen bescheidenen Vorführsaal. Du kannst dich nicht erinnern, dass ein solcher Ort in Lentiniën existiert hätte."
  },
  Event_125711_Name = {
    Text = "Erinnerungskino"
  },
  Event_125712_ChoiceDesc1 = {
    Text = "[Schicksal annehmen] Graviere das Orison [(EnchantConfig.Arg1)] auf 1 von 3 Befehlskarten.(Nutzungen: 0/2)"
  },
  Event_125712_ChoiceDesc2 = {
    Text = "[Schicksal trotzen] Entwickle das Symptom [(Skill.Arg1)] und ändere das Orison für die Gravur.(Nutzungen: 2/2)"
  },
  Event_125712_Desc = {
    Text = "„Ah, wir begegnen uns wieder, mein Schatz.\"\nDu beginnst, die Stimme jener Dame zu genießen, die in deinem Geist widerhallt. Sie ist zart und verführerisch, wie ein Netz zum Fangen von Fliegen.\n„Komm, sag mir – bist du bereit, dein Schicksal anzunehmen?\""
  },
  Event_125712_Name = {
    Text = "Der Käfig des Schicksals"
  },
  Event_125713_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_125713_Desc = {
    Text = "„Törichter Mensch, kennen wir uns?\"\nDie schwarze Katze verdreht verächtlich die Augen und wendet sich ab.\n„Geh. Und tu nie wieder etwas so Dummes.\""
  },
  Event_125713_Name = {
    Text = "Formenwandel"
  },
  Event_125714_ChoiceDesc1 = {
    Text = "[Foto machen] Gravur des Orison [(EnchantConfig.Arg1)] auf 1 von 3 Befehlskarten.(Nutzungen: 0/2)"
  },
  Event_125714_ChoiceDesc2 = {
    Text = "[Pose wechseln] Infiziere [(Skill.Arg1)] und tausche das zu gravierende Orison aus.(Nutzungen: 2/2)"
  },
  Event_125714_Desc = {
    Text = "Eine einzelne Kamera steht auf der Bühne, ihr pechschwarzes Objektiv auf dich gerichtet wie das rätselhafte Facettenauge eines mechanischen Gottes.\nDieses Theater stand so lange leer... Willkommen! Willkommen! Komm, lass ein Foto machen! Es ist völlig kostenlos!\nDie Kamera kreischt vor Aufregung. Auf dieser verlassenen Bühne ist sie die einzige Protagonistin."
  },
  Event_125714_Name = {
    Text = "Schnappschüsse von den Rängen"
  },
  Event_125715_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_125715_Desc = {
    Text = "„Wie kann jemand, der nichts vom Schicksal verlangt, auf eine Antwort des Schicksals hoffen?\""
  },
  Event_125715_Name = {
    Text = "Die Blutketten des Schicksals"
  },
  Event_125716_ChoiceDesc1 = {
    Text = "[Einen Ausweg finden] Die Silberne Schöpfung „(RelicConfig.Arg1)\" erhalten, aber „(Skill.Arg2)\" entwickeln"
  },
  Event_125716_ChoiceDesc2 = {
    Text = "[Lass es sein] Die Goldene Kreation „(RelicConfig.Arg1)\" erhalten, aber „(Skill.Arg2)\" und „(Skill.Arg3)\" entwickeln"
  },
  Event_125716_ChoiceDesc3 = {
    Text = "[An die Oberfläche kommen]Erhalte 25 schwarze Siegel"
  },
  Event_125716_Desc = {
    Text = "Eine neue Bühne, zwei überlappende Leben... Auf dem Weg, den Polizisten zu entkommen, ordnest du die Dinge, die dir Arachne erzählt hat. \n In den verworrenen Gedanken versinkst du in das ruhige Aequor."
  },
  Event_125716_Name = {Text = "Stille"},
  Event_125717_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_125717_Desc = {
    Text = "Der Schmetterling gleitet auf deine Schulter und nähert sich deinem Ohr. Du horchst aufmerksam, hörst jedoch nur das leise Summen der Flügel – ein Klang wie ein lautloser Seufzer.\nWährend du lauschst, beginnen die schillernden Flügel sich aufzulösen, und der Schmetterling fällt auf deiner Schulter in einen ewigen Schlaf.\nDie Botschaft, die er trug, ist für dich für immer verloren."
  },
  Event_125717_Name = {
    Text = "Das restliche Leben des Schmetterlings"
  },
  Event_125718_ChoiceDesc1 = {
    Text = "[Einen Biss nehmen] Erwecke zufällig 1 Erweckten Körper, Infektion [(Skill.Arg1)]"
  },
  Event_125718_ChoiceDesc2 = {
    Text = "[Weigere dich] Erhalte eine Auswahl von 3 für 1 Gebet"
  },
  Event_125718_Desc = {
    Text = "„Hungrig, mein lieber Gast?\"\nEine zähflüssige Stimme erhebt sich hinter der Bar. Du drehst dich um, siehst aber nichts.\n„Die Snacks auf dem Mitternachtsmaskenball sind ebenfalls recht bekannt. Möchtest du kosten?\""
  },
  Event_125718_Name = {
    Text = "Der Geschmack des Schicksals"
  },
  Event_125719_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_125719_Desc = {
    Text = "Du wagst es nicht, die obenstehenden Worte leichtfertig zu lesen, sondern betrachtest sorgfältig den eleganten Umschlag. \n Auf dem Umschlag ist ein verschwommenes Wappen mit einem Siegellack geprägt, darüber steht in schöner Kursive: \n „An die neugeborene Arachne, Fräulein.\" \n „Ihr treuer Hausdiener, Edgar.\""
  },
  Event_125719_Name = {
    Text = "Gute Nacht, Herr Edgar"
  },
  Event_125720_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_125720_Desc = {
    Text = "„Ich verstehe. Ich begreife es jetzt, Schwester...\"\n„Eine Dramatikerin kann das Ende einer Figur niemals umschreiben. Dieses elende Schicksal war längst besiegelt; selbst du konntest es niemals ändern...\"\nDas traurige Schluchzen verblasst. Die Schreibmaschine der Dramatikerin löst sich in Schmetterlinge auf, die sich im leeren Theater des Schicksals zerstreuen, bis keine Spur mehr übrig bleibt."
  },
  Event_125720_Name = {
    Text = "Ende des Stücks"
  },
  Event_125721_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_125721_Desc = {
    Text = "Unbekannte Schauspieler, gefährliche Schritte... was spielt das für eine Rolle? Nichts kann schlimmer sein als das Schicksal selbst.\nDu streckst die Hand aus und betrittst die Bühne. Die Puppen nehmen deine Hand und wirbeln dich in einen fröhlichen Tanz.\nDu hörst den Applaus."
  },
  Event_125721_Name = {Text = "Dreiertanz"},
  Event_125722_ChoiceDesc1 = {
    Text = "[Gesang hören] erhalte 25 schwarze Siegel, Infektion “(Skill.Arg2)“, weiter wählen"
  },
  Event_125722_ChoiceDesc2 = {
    Text = "[Lass es bleiben]Verlassen"
  },
  Event_125722_Desc = {
    Text = "„Sie tanzen. Sie singen. Knarrend—knarrend—\""
  },
  Event_125722_Name = {
    Text = "Letzte Prophezeiung"
  },
  Event_125723_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_125723_Desc = {
    Text = "Der Führer, der Kamerad – der einzige Begleiter in dieser einsamen Dimension.\nIhr werdet hier gemeinsam alles lösen und nach Kardas zurückkehren. Daran hast du nie gezweifelt."
  },
  Event_125723_Name = {
    Text = "Spiegelbild im Wein"
  },
  Event_125724_ChoiceDesc1 = {
    Text = "[Wagen]Infiziere “(Skill.Arg1)“，betrete das Glücksspiel"
  },
  Event_125724_ChoiceDesc2 = {
    Text = "[Lass es bleiben]Erhalte 25 das schwarze Siegel"
  },
  Event_125724_Desc = {
    Text = "An einer Gassenkurve versperrt dir ein Paar schmutziger Hände den Weg.\nEin zerlumpter Bettler nähert sich, seine Augen so gierig wie die einer Hyäne, die Aas wittert.\n„Komm! Eine Runde! Ich werde dir alles sagen, was du wissen möchtest... wenn du nur gewinnst...\""
  },
  Event_125724_Name = {
    Text = "Straßenwette"
  },
  Event_125725_ChoiceDesc1 = {
    Text = "[Ignore] Zerstöre eine Befehlskarte und erhalte 25 Schwarze Male"
  },
  Event_125725_ChoiceDesc2 = {
    Text = "[Read] Kopiere 1 Karte aus dem Deck, Infektion [(Skill.Arg1)]"
  },
  Event_125725_Desc = {
    Text = "Tipp, tipp, tipp... Tipp, tipp, tipp...\nDie Ecke der Bar ist verlassen; das Faxgerät klingelt mit einem klaren, rhythmischen Klang, wie eine anmutige Klaviersonate."
  },
  Event_125725_Name = {
    Text = "Dimension Telegramm"
  },
  Event_125726_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_125726_Desc = {
    Text = "„Stille. Ich bin eine Katze. Deine langweiligen Geschichten interessieren mich nicht.\"\n\nDie Katze seufzt und wendet sich ab.\n\n„Geh. Und tu nie wieder etwas so Dummes.\""
  },
  Event_125726_Name = {
    Text = "Formenwandel"
  },
  Event_125727_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_125727_Desc = {
    Text = "Vielleicht hat sie recht. Das bist du – die verborgensten, übelsten Gedanken tief in deiner Seele.\nJeder Mensch ist selbstsüchtig; du warst nie so edel, wie andere glaubten.\nDu kostest diesen elenden Schmerz aus. Du weißt, dass die Vergangenheit vergangen ist, und deine Erlösung liegt vor dir."
  },
  Event_125727_Name = {
    Text = "Ausbreitende Agonie"
  },
  Event_125728_ChoiceDesc1 = {
    Text = "[Mit ihr diskutieren] Zerstöre eine Befehlskarte, erhalte Arg1 Schwarzes Mal"
  },
  Event_125728_ChoiceDesc2 = {
    Text = "[Schweigen]"
  },
  Event_125728_Desc = {
    Text = "„Ein tragisches Ende ist wahrhaftig, doch unsere Wirklichkeit ist bereits so elend. Können wir ihr nicht einmal in einer Geschichte ein sanfteres Schicksal gewähren...?\"\nDie Dramatikerin schließt die Augen in Besinnung. Sie ist mit diesem Schluss unzufrieden."
  },
  Event_125728_Name = {
    Text = "Ende des Stücks"
  },
  Event_125729_ChoiceDesc1 = {
    Text = "[Verlassen]Erhalte goldenes Relikt“(RelicConfig.Arg1)“"
  },
  Event_125729_Desc = {
    Text = "Ratsch-ratsch. Der Würfel tanzt wild im Becher, dreht sich bis zur Erschöpfung.\n\n„Warum... warum gewinnt nie jemand?!\""
  },
  Event_125729_Name = {
    Text = "Straßenwette"
  },
  Event_125730_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_125730_Desc = {
    Text = "Du lehnst dich näher heran und strengst dich an, sein Flüstern zu hören.\nDer Schmetterling schlägt mit den Flügeln und verlässt deine Handfläche.\nDu hörst rein gar nichts."
  },
  Event_125730_Name = {
    Text = "Pausieren des Schmetterlings"
  },
  Event_125731_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_125731_Desc = {
    Text = "Der Schmetterling lässt sich von deinen Gesten nicht beeindrucken.\nEr verfolgt deine Handfläche mit stiller Beharrlichkeit – und erst als du deinen Arm ein letztes Mal hebst, entscheidet er sich zu gehen.\nEin Hauch von Bedauern regt sich. Vielleicht... hättest du zuhören sollen?"
  },
  Event_125731_Name = {
    Text = "Pausieren des Schmetterlings"
  },
  Event_125732_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_125732_Desc = {
    Text = "Schwarzer Nebel zittert trostlos; die qualvollen Schreie des Bettlers sind herzzerreißend.\nIn einem einzigen Augenblick verschwinden der Würfel und der Bettler. Im zerlumpten Hut verbleibt die Belohnung des Spiels."
  },
  Event_125732_Name = {
    Text = "Straßenwette"
  },
  Event_125733_ChoiceDesc1 = {
    Text = "[Am Rausch teilnehmen] Erhalte die Fluchkreatur „(RelicConfig.Arg2),\" aber entwickle „(Skill.Arg1)\""
  },
  Event_125733_ChoiceDesc2 = {
    Text = "[Stoppt die Musik] Zerstören 1 Relikt und erhalte 1 Belohnung"
  },
  Event_125733_ChoiceDesc3 = {
    Text = "[Ohren zuhalten] Erhalte 50 Schwarze Imprägnierungen"
  },
  Event_125733_Desc = {
    Text = "„Ah! Musik! Wie kann eine große Aufführung ohne Musik existieren!!\"\nEine dissonante Symphonie erhebt sich im zerschmetterten Theater, wie ein Fest des Chaos. Schauspieler aus dem Spiralabgrund tanzen und jubeln in dieser ungeordneten Ode und schwelgen in den Noten, die sie am Leben erhalten."
  },
  Event_125733_Name = {
    Text = "Schicksalslied"
  },
  Event_125734_ChoiceDesc1 = {
    Text = "[Erhalte 100 schwarze Siegel]"
  },
  Event_125734_ChoiceDesc2 = {
    Text = "[2 zufällige Befehlskarten erhalten ein Gebet: „(EnchantConfig.Arg1)\"]"
  },
  Event_125734_Desc = {
    Text = "Unsichtbare Schicksalsfäden tanzen inmitten der Noten. In diesem chaotischen Lärm beginnst du, den Faden der fesselnden Melodie zu verfolgen — das ist tatsächlich der wahre Klang des Schicksals.\nDie Verstoßenen des Spiralabgrunds jubeln dir zu, drängen sich um dich und ziehen dich in ihr ungeordnetes Fest hinein.\nHerzlichen Glückwunsch, glücklicher Zuschauer! Nun wirst du dich den Schauspielern beim Schlussvorhang des Schicksals anschließen."
  },
  Event_125734_Name = {
    Text = "Schicksalslied"
  },
  Event_125735_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_125735_Desc = {
    Text = "Du kannst die Bedeutung dieses Klangs nicht erkennen, aber du weißt, dass er aufhören muss.\nSilbernes Licht schlägt wie eine rasende Klinge. Sein Rhythmus fügt sich irgendwie perfekt in den Takt der Noten ein.\nBevor du es merkst, hat die Musik aufgehört. Du hörst nichts mehr. Du siehst nur die Nacht; du hörst nur Stille.\nChaotischer Lärm oder absolute Stille — was ist erschreckender... Schutzherr?"
  },
  Event_125735_Name = {
    Text = "Schicksalslied"
  },
  Event_125736_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_125736_Desc = {
    Text = "Du streckst die Hand aus; ein Schmetterling landet sanft auf deiner Hand.\nIn der Tat. Tod, Auflösung, das Vergehen der Zeit... Der Schmetterling wird aus dem Kokon geboren; Qual ist der ewige Boden der Kunst.\nAls ausgezeichneter Zuschauer ist dies eine Wahrheit, die du begreifen musst."
  },
  Event_125736_Name = {
    Text = "Im Verschwinden erblühen"
  },
  Event_125737_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_125737_Desc = {
    Text = "Das könnte vielleicht wieder ein Trick von Nefraea sein. \n Der Schmetterling hat deine Worte verstanden, und in der Dunkelheit ertönt sein lautloses Seufzen. Die Flügel, die mit pechschwarzem, klebrigem Schleim bedeckt sind, vibrieren, und bald wird die schwere Gestalt des Schmetterlings in der unendlichen Dunkelheit verschlungen. \n Du kannst niemals erfahren, was es dir mitteilen wollte."
  },
  Event_125737_Name = {
    Text = "Das restliche Leben des Schmetterlings"
  },
  Event_125738_ChoiceDesc1 = {
    Text = "[Verlassen]Erhalte 50 schwarze Siegel"
  },
  Event_125738_Desc = {
    Text = "Ratsch-ratsch. Der Würfel tanzt wild im Becher, dreht sich bis zur Erschöpfung.\n\n„Warum... warum gewinnt nie jemand?!\""
  },
  Event_125738_Name = {
    Text = "Straßenwette"
  },
  Event_125739_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_125739_Desc = {
    Text = "Deine Gedanken jetzt unkontrolliert treiben zu lassen, ist gefährlich. Du schüttelst den Kopf und tauchst sofort auf."
  },
  Event_125739_Name = {Text = "Stille"},
  Event_125740_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_125740_Desc = {
    Text = "Nicht jede Note braucht einen Zuhörer; nicht jedes Schicksal braucht eine Antwort.\nDu presst die Hände fest auf die Ohren und verlässt die lärmende Bühne.\nDu bist noch immer neugierig auf die Bedeutung dieser dissonanten Musik, doch du weißt, dass du die einzig richtige Wahl getroffen hast."
  },
  Event_125740_Name = {
    Text = "Schicksalslied"
  },
  Event_125741_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_125741_Desc = {
    Text = "Silbernes Licht durchdringt die Illusion; die schwarzen Katzen lösen sich in Pfützen schwarzen Schlamms auf.\nSich in Katzengestalt zu verwandeln, um sich zu verstecken... das Monster kann deinen Augen nicht entkommen."
  },
  Event_125741_Name = {
    Text = "Formenwandel"
  },
  Event_125742_ChoiceDesc1 = {
    Text = "[Schicksal annehmen] Graviere das Orison [(EnchantConfig.Arg1)] auf 1 von 3 Befehlskarten.(Nutzungen: 0/2)"
  },
  Event_125742_Desc = {
    Text = "„Niemand kann dem Schicksal wirklich trotzen, mein Schatz. Wir besaßen nie das Recht zu wählen.\"\nDie Stimme wird niedergeschlagen und fern. Du bist dir nicht sicher, ob sie zu dir spricht oder zu etwas ganz anderem."
  },
  Event_125742_Name = {
    Text = "Der Käfig des Schicksals"
  },
  Event_125743_ChoiceDesc1 = {
    Text = "[Rufen der Melodie]erhält 30 das schwarze Siegel, infiziert “(Skill.Arg2)“, weiter wählen"
  },
  Event_125743_ChoiceDesc2 = {
    Text = "[Lass es bleiben]Verlassen"
  },
  Event_125743_Desc = {
    Text = "„Die Marionetten stellen sich für ihren Auftritt an und treten in das große Netz des Schicksals.\""
  },
  Event_125743_Name = {
    Text = "Letzte Prophezeiung"
  },
  Event_125744_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_125744_Desc = {
    Text = "Du blickst auf zum Abgrundstrudel und strengst dich an, das Orakel der Krähen zu hören.\nDoch sie sagen nichts. Unter deinem Blick löst sich der Abgrund auf.\nDer Schwarm verschwindet zum Ende der Bühne – dem Ort, wohin du gehen musst."
  },
  Event_125744_Name = {
    Text = "Spiralabgrund der Krähen"
  },
  Event_125745_ChoiceDesc1 = {
    Text = "[Agree] Entferne 2 Karten"
  },
  Event_125745_ChoiceDesc2 = {
    Text = "[Disagree] Erhalte die Fluchkreatur „(RelicConfig.Arg1),\" entwickle aber „(Skill.Arg2)\""
  },
  Event_125745_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte Arg1 schwarze Siegel"
  },
  Event_125745_Desc = {
    Text = "Der Bühnenvorhang flattert im Wind. Inmitten des schwarzen Schlamms, der aus einer gefallenen Leiche sickert, entdeckst du eine Gruppe Schmetterlinge.\n„Wahre Kunst erblüht stets in der Auflösung... würdest du nicht zustimmen, Schutzherr?\"\nDie Leiche der Tänzerin lächelt dich an. Du hörst das Flattern von Flügeln."
  },
  Event_125745_Name = {
    Text = "Im Verschwinden erblühen"
  },
  Event_125746_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_125746_Desc = {
    Text = "Sophisterei kann dich niemals beirren. Du weißt klar, welchen Weg du gehst und welches Ziel du anstrebst.\nDie Dornen lösen sich in dir auf. Du setzt deinen Fuß auf den Weg, wie du es immer getan hast."
  },
  Event_125746_Name = {
    Text = "Ausbreitende Agonie"
  },
  Event_125747_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_125747_Desc = {
    Text = "Du wendest dich ab und versuchst, die Augen hinter dir zu vergessen. Doch du stellst fest, dass sich dein Körper nicht mehr so frei bewegt wie einst.\nDu weißt es – diesen starrenden Blicken wirst du niemals entkommen."
  },
  Event_125747_Name = {
    Text = "Das Publikum"
  },
  Event_125748_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_125748_Desc = {
    Text = "Egal ob aus Respekt oder Furcht, du bist nicht bereit, ihn leicht zu berühren, und legst den Umschlag an seinen Platz zurück. Als du dich zum Gehen bereit machst, ertönt eine trübe, aber sanfte Stimme aus der Dunkelheit hinter dem Umschlag. \n „Danke, dass Sie sich an mich erinnern, Fräulein Arachne...\""
  },
  Event_125748_Name = {
    Text = "Gute Nacht, Herr Edgar"
  },
  Event_125749_ChoiceDesc1 = {
    Text = "[Kraft zum Beschützen] Erhalte die Silberne Schöpfung [(RelicConfig.Arg1)]"
  },
  Event_125749_ChoiceDesc2 = {
    Text = "[Freiheit zur Flucht] Gravur des Orison [(EnchantConfig.Arg1)] auf 1 zufällige Befehlskarte"
  },
  Event_125749_ChoiceDesc3 = {
    Text = "[Antwort verweigern] Erhalte 50 Schwarze Imprägnierungen"
  },
  Event_125749_Desc = {
    Text = "Der Likör der Mitternachtsmaske schleicht sich in deinen Geist wie Ketten, die sich fest um dich winden. Entlang der kalten eisernen Glieder verfolgt die Stimme einer jungen Frau dein Bewusstsein.\n„Sag mir, Liebes. Welches Schicksal begehrst du wirklich?\""
  },
  Event_125749_Name = {
    Text = "Die Blutketten des Schicksals"
  },
  Event_125750_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_125750_Desc = {
    Text = "Selbst die kompliziertesten Angelegenheiten müssen von deiner Hand gelöst werden.\nDie Last wird schwerer, doch mit ihr erhebt sich eine neue, unbekannte Kraft."
  },
  Event_125750_Name = {Text = "Stille"},
  Event_125751_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_125751_Desc = {
    Text = "Unbekannte Schauspieler, gefährliche Schritte. Tatsächlich ist die Flucht der einzige sichere Hafen.\nDu drehst dich um und läufst davon, reißt die Theatervorhänge auf – nur um dich auf der Bühne stehend wiederzufinden. Die Puppen nehmen deine Hand und wirbeln dich in einen fröhlichen Tanz.\nAuf der Bühne des Schicksals gibt es niemals eine Wahl."
  },
  Event_125751_Name = {Text = "Dreiertanz"},
  Event_125752_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_125752_Desc = {
    Text = "Jetzt ist keine Zeit für einen Film."
  },
  Event_125752_Name = {
    Text = "Erinnerungskino"
  },
  Event_125753_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_125753_Desc = {
    Text = "Die Gefahren auf dem Weg haben keinen Einfluss auf dein Denken. Du gehst an dem zerstörten Schicksal vorbei und näherst dich Nefraea. \n Du bist hierher gekommen, um ihr Erlösung zu bringen."
  },
  Event_125753_Name = {
    Text = "Schlussvorhang für das Netz des Schicksals"
  },
  Event_125754_ChoiceDesc1 = {
    Text = "[Öffne den Umschlag] Erhält Goldene Kreation „(RelicConfig.Arg1)\", entwickelt „(Skill.Arg2)\""
  },
  Event_125754_ChoiceDesc2 = {
    Text = "[Brief lesen] Wähle 1 von 3 Befehlskarten aus, um Gravur zu erhalten: [(EnchantConfig.Arg1)]"
  },
  Event_125754_ChoiceDesc3 = {
    Text = "[Freigeben]Erhalte 50 schwarze Siegel"
  },
  Event_125754_Desc = {
    Text = "Deine Bewegungen reißen die dichten Spinnennetze auseinander; ein alter Brief fällt aus der Seide.\nSein Gewicht übersteigt bei weitem das, was dünnes Papier tragen sollte."
  },
  Event_125754_Name = {
    Text = "Gute Nacht, Herr Edgar"
  },
  Event_125755_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_125755_Desc = {
    Text = "Tränen fallen aus den Augen der Krähe. Blut fließt aus ihrem Schnabel. Mit dem Letzten ihres Lebens singt die Krähe ihre letzte Prophezeiung für dich."
  },
  Event_125755_Name = {
    Text = "Letzte Prophezeiung"
  },
  Event_125756_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_125756_Desc = {
    Text = "„Hehe... Hahahaha!\"\n„Wie ist es, mein Gast? Der Geschmack des Schicksals... du wirst dich danach sehnen, wahnsinnig, endlos...\""
  },
  Event_125756_Name = {
    Text = "Der Geschmack des Schicksals"
  },
  Event_125757_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_125757_Desc = {
    Text = "„Langweilig.\" Sie gähnt träge.\n„Nimm deine Macht und geh im Klub raufen.\""
  },
  Event_125757_Name = {
    Text = "Die Blutketten des Schicksals"
  },
  Event_125758_ChoiceDesc1 = {
    Text = "[Schicksalsnetz stabilisieren] Erhalte 1 aus 3 Fortg. Gravuren"
  },
  Event_125758_ChoiceDesc2 = {
    Text = "[Gefahr missachten] Erhalte die Goldene Kreation „(RelicConfig.Arg1),\" aber entwickle „(Skill.Arg2)\""
  },
  Event_125758_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte 50 schwarze Siegel"
  },
  Event_125758_Desc = {
    Text = "Sie ist das schöne Kind. Sie ist das ausgesetzte Kind des Schicksals. Sie ist die Rächerin, die aus der Tiefe emporsteigt, dem schwachen Licht folgend. Sie ist hierher gekommen, um Erlösung für alles zu bringen. \n Das Schicksalsnetz bricht um euch herum zusammen. Du stehst auf der Bühne des Theaters, nicht weit entfernt von Nefraea."
  },
  Event_125758_Name = {
    Text = "Schlussvorhang für das Netz des Schicksals"
  },
  Event_125759_ChoiceDesc1 = {
    Text = "[Indifferent] Erhalte die Silberne Schöpfung [(RelicConfig.Arg1)]"
  },
  Event_125759_ChoiceDesc2 = {
    Text = "[Empathetic] Erhalte die Goldene Kreation „(RelicConfig.Arg1),\" aber entwickle „(Skill.Arg2)\""
  },
  Event_125759_Desc = {
    Text = "Durchdringende Schreie brechen von der Bühne aus, als das einzige Scheinwerferlicht auf eine einsame Gestalt fällt.\nEr bietet dir seine aufrichtigste Darbietung – er entblößt seine Brust, um jedem Zuschauer seine Eingeweide zu präsentieren.\nWas quält diese Figur so sehr?"
  },
  Event_125759_Name = {
    Text = "Das Geständnis eines Schauspielers"
  },
  Event_125760_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_125760_Desc = {
    Text = "Du streckst die Hand nach rechts aus.\nDort liegt deine Zukunft – deine intensivste Sehnsucht, dein letztes Refugium und das Ziel, das du letztendlich erreichen wirst.\nDeine Existenz dient einzig dazu, der Sonne voraus zu jagen."
  },
  Event_125760_Name = {
    Text = "Vergangenheit, Zukunft"
  },
  Event_125761_ChoiceDesc1 = {
    Text = "[Drei Punkte]"
  },
  Event_125761_ChoiceDesc2 = {
    Text = "[Sechs Uhr]"
  },
  Event_125761_ChoiceDesc3 = {
    Text = "[Ein Punkt]"
  },
  Event_125761_Desc = {
    Text = "Du könntest einfach gehen, doch der exquisite Würfel fesselt dich vollständig.\nDie Verfolger in deinem Rücken vergessend, nimmst du ihn ehrfürchtig auf und wirfst ihn in den Zylinder –"
  },
  Event_125761_Name = {
    Text = "Straßenwette"
  },
  Event_125762_ChoiceDesc1 = {
    Text = "[Verlassen]Erhalte Silberrelikt“(RelicConfig.Arg1)“"
  },
  Event_125762_Desc = {
    Text = "Ratsch-ratsch. Der Würfel tanzt wild im Becher, dreht sich bis zur Erschöpfung.\n\n„Warum... warum gewinnt nie jemand?!\""
  },
  Event_125762_Name = {
    Text = "Straßenwette"
  },
  Event_125763_ChoiceDesc1 = {
    Text = "[Schicksal annehmen] Graviere das Orison [(EnchantConfig.Arg1)] auf 1 von 3 Befehlskarten.(Nutzungen: 0/2)"
  },
  Event_125763_ChoiceDesc2 = {
    Text = "[Schicksal trotzen] Entwickle das Symptom [(Skill.Arg1)] und ändere das Orison zur Gravur.(Nutzungen: 1/2)"
  },
  Event_125763_Desc = {
    Text = "„Ah, du Ungezogener. Das Schicksal ist stets gnädig... doch jeder Widerstand hat seinen Preis. Nun, bist du bereit, es anzunehmen?\""
  },
  Event_125763_Name = {
    Text = "Der Käfig des Schicksals"
  },
  Event_125764_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_125764_Desc = {
    Text = "Du schaust dich in diesen Blicken um und hebst eine Hand zum Gruß.\nBald wirst du ihnen den Höhepunkt der Geschichte schenken."
  },
  Event_125764_Name = {
    Text = "Das Publikum"
  },
  Event_125765_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_125765_Desc = {
    Text = "„Liebe Fräulein Arachne, heute ist Ihr Geburtstag, und ich freue mich für den Herrn und die Dame sowie für Sie. Willkommen in dieser schönen Welt. Ich widme Ihnen dieses sanfte Schlaflied und wünsche Ihnen, dass Sie von diesem Tag Ihrer Geburt an ein sorgenfreies Leben führen......\""
  },
  Event_125765_Name = {
    Text = "Gute Nacht, Herr Edgar"
  },
  Event_125766_ChoiceDesc1 = {
    Text = "[Foto machen] Gravur des Orison [(EnchantConfig.Arg1)] auf 1 von 3 Befehlskarten.(Nutzungen: 0/2)"
  },
  Event_125766_ChoiceDesc2 = {
    Text = "[Erneut wechseln] Infiziere [(Skill.Arg1)] und tausche das zu gravierende Orison aus.(Nutzungen: 1/2)"
  },
  Event_125766_Desc = {
    Text = "Du spürst ein Flackern der Beklommenheit vor der Linse. Vielleicht wäre diese Pose besser? Oder jene?"
  },
  Event_125766_Name = {
    Text = "Schnappschüsse von den Rängen"
  },
  Event_125767_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_125767_Desc = {
    Text = "Du möchtest den Inhalt sehen, doch die Leinwand ist leer. Nur das Geräusch sich drehender Filmrollen hallt durch den Saal.\nVielleicht wird es lange dauern, bis du erfährst, was auf den Rollen verborgen liegt."
  },
  Event_125767_Name = {
    Text = "Erinnerungskino"
  },
  Event_125768_ChoiceDesc1 = {
    Text = "[Blick abwenden]wecke zufällig 1 Erwecker"
  },
  Event_125768_ChoiceDesc2 = {
    Text = "[Direkter Blick]Wähle 1 Erwecker aus und reduziere die Arithmetica-Kosten der Wachenkarten um 2 Punkte. Infektion“(Skill.Arg1)“"
  },
  Event_125768_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte 50 schwarze Siegel"
  },
  Event_125768_Desc = {
    Text = "Als du die Bühne betrittst, hörst du ein Flüstern. Du drehst dich um; zehntausend Augenpaare schweben um die Bühne herum und starren dich an.\nKomm!, sagen sie. Das erlesene Drama endet doch sicher nicht hier?\nTanz!, sagen sie. Bring uns den Höhepunkt dieses Tanzes!"
  },
  Event_125768_Name = {
    Text = "Das Publikum"
  },
  Event_125769_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_125769_Desc = {
    Text = "Du verstehst seinen Schmerz nicht, noch hast du die Notwendigkeit dazu.\nDas Theater hat viele Bühnen, und die Bühnen viele Puppen; du bist nur eine davon.\nDu hast Wichtigeres zu tun."
  },
  Event_125769_Name = {
    Text = "Das Geständnis eines Schauspielers"
  },
  Event_125770_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_125770_Desc = {
    Text = "Tod, Auflösung, das Vergehen der Zeit... Kunst existiert nicht, um Schmerz zuzufügen. Wenn Schönheit nur im Leiden wohnt, dann ist solche Schönheit besser ungeboren.\nDu schlägst aus, um sie zu vertreiben. Die Schmetterlinge zerstreuen sich und hinterlassen eine traurige Leiche."
  },
  Event_125770_Name = {
    Text = "Im Verschwinden erblühen"
  },
  Event_125771_ChoiceDesc1 = {
    Text = "[Höre das Lied]erhält 40 das schwarze Siegel, infiziert “(Skill.Arg2)“, weiter wählen"
  },
  Event_125771_ChoiceDesc2 = {
    Text = "[Lass es sein]erhalte 25 das schwarze Siegel, verlasse"
  },
  Event_125771_Desc = {
    Text = "Die verstreuten Krähen, die deinen Weg gekreuzt haben, vereinen sich zu einer. Sie sitzt vor dir und singt, ihre Melodie trostlos—wie die Letzte Prophezeiung."
  },
  Event_125771_Name = {
    Text = "Letzte Prophezeiung"
  },
  Event_125772_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_125772_Desc = {
    Text = "Du streckst die Hand nach links aus.\nDort liegt deine Vergangenheit – deine kostbarsten Erinnerungen, der Weg, den du einst gegangen bist, und der Ort, zu dem du letztendlich zurückkehren wirst.\nAlles, was gewesen ist, formt alles, was du bist."
  },
  Event_125772_Name = {
    Text = "Vergangenheit, Zukunft"
  },
  Event_125773_ChoiceDesc1 = {
    Text = "[Foto machen] Gravur des Orison [(EnchantConfig.Arg1)] auf 1 von 3 Befehlskarten.(Nutzungen: 0/2)"
  },
  Event_125773_Desc = {
    Text = "Du spürst ein Zittern der Beklommenheit vor dem Objektiv. Vielleicht wäre diese Pose besser? Oder jene?\nDu zögerst noch immer, doch du kannst die wachsende Ungeduld der Kamera spüren."
  },
  Event_125773_Name = {
    Text = "Schnappschüsse von den Rängen"
  },
  Event_125774_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_125774_Desc = {
    Text = "Du nimmst eine Pose vor der Kamera ein – gefasst, neugierig, versunken. Wie ein echter Zuschauer.\nGluckern –\nDer Verschluss klickt. Schwarzer Schlamm bricht aus dem Kameragehäuse hervor und bespritzt die gesamte Bühne.\nIn der hohlen Mitte des Kameragehäuses bleibt der Film leer."
  },
  Event_125774_Name = {
    Text = "Schnappschüsse von den Rängen"
  },
  Event_125775_ChoiceDesc1 = {
    Text = "[Accept] Erhalte 1 aus 3 Silbernen Schöpfungen"
  },
  Event_125775_ChoiceDesc2 = {
    Text = "[Flee] Erhält Silberne Schöpfung „(RelicConfig.Arg1)\" & „(RelicConfig.Arg2)\", entwickelt „(Skill.Arg3)\" zweimal"
  },
  Event_125775_Desc = {
    Text = "Tipp-tipp, tipp-tipp... Absätze schlagen mit einem hellen, fröhlichen Knacken auf die Dielen.\nZwei Puppen in Schuluniformen tanzen auf der Bühne. Plötzlich halten sie inne – und drehen sich um, um dir ihre Hände entgegenzustrecken."
  },
  Event_125775_Name = {Text = "Dreiertanz"},
  Event_125776_ChoiceDesc1 = {
    Text = "[Qual Ausdauer] Erhöhe Max LP um Arg1"
  },
  Event_125776_ChoiceDesc2 = {
    Text = "[Dem Schmerz widersprechen] 1 zufällige Befehlskarte erhält ein Gebet: „(EnchantConfig.Arg1)\", infiziere 1 „(Skill.Arg2)\""
  },
  Event_125776_Desc = {
    Text = "„Du hast dich nie um Liz' Tod gekümmert. Du hast dich nie um irgendjemanden gekümmert.\"\n„Du kümmerst dich nur um dich selbst... alle um dich herum sind lediglich Werkzeuge für deine Reise in Richtung Freiheit und Frieden.\"\n„Ist es nicht so... Schutzherr?\"\nDas Flüstern des Ansagers kratzt an deinem Ohr. Dein Herz zieht sich zusammen; ein stechender Schmerz breitet sich mit ihren Worten durch deinen Körper aus..."
  },
  Event_125776_Name = {
    Text = "Ausbreitende Agonie"
  },
  Event_125777_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_125777_Desc = {
    Text = "Überlasst euch dem Abstieg; das Meer besitzt seinen eigenen Auftrieb, und das Schicksal wird euch beiden den Weg weisen."
  },
  Event_125777_Name = {Text = "Stille"},
  Event_125778_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_125778_Desc = {
    Text = "Du selbst bist es. Die Quelle der Kraft, der Träger der Pflicht, das einzige Objekt der Loyalität.\nDu gehst den Weg, der nur dir gehört."
  },
  Event_125778_Name = {
    Text = "Spiegelbild im Wein"
  },
  Event_125779_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_125779_Desc = {
    Text = "„Wie schade, mein Gast. Der Geschmack des Schicksals... du wirst nie wieder die Gelegenheit haben, ihn zu kosten...\""
  },
  Event_125779_Name = {
    Text = "Der Geschmack des Schicksals"
  },
  Event_125780_ChoiceDesc1 = {
    Text = "[Mit ihr diskutieren] Zerstöre eine Befehlskarte, erhalte Arg1 Schwarzes Mal"
  },
  Event_125780_ChoiceDesc2 = {
    Text = "[Schweigen]"
  },
  Event_125780_Desc = {
    Text = "„Was für ein trauriges Stück... Wurde dieses arme Mädchen von dem verlassen, den sie liebte, Schwester?\"\nIn dieser vertrauten Stimme ist keine Spur von Wahnsinn oder Bosheit. Sie ist klar und trauervoll, wie ein sanfter Bach durch einen Wald.\n„Die Sängerin, ein welkes Blatt, das hilflos treibt, dem Spiel des Schicksals überlassen... Was für eine bemitleidenswerte Seele...\"\n„Schwester, wenn ich der Autor wäre... welches Ende sollte ich ihr schreiben?\""
  },
  Event_125780_Name = {
    Text = "Ende des Stücks"
  },
  Event_125781_ChoiceDesc1 = {
    Text = "[Streicheln] 50% Wahrscheinlichkeit, 125 Schwarze Imprägnierung zu erhalten; 50% Wahrscheinlichkeit, [(Skill.Arg2)] zu entwickeln"
  },
  Event_125781_ChoiceDesc2 = {
    Text = "[Explain] 75% Wahrscheinlichkeit, 100 Schwarze Imprägnierung zu erhalten; 25% Wahrscheinlichkeit, [(Skill.Arg2)] zu entwickeln"
  },
  Event_125781_ChoiceDesc3 = {
    Text = "[Durchschauen] erhalte 50 Schwarze Imprägnierung"
  },
  Event_125781_Desc = {
    Text = "Als du das Monster in die Hintergasse der Bar verfolgst, verschwindet seine Silhouette. Eine Gruppe schwarzer Katzen versperrt dir den Weg.\n„Hey, du.\" Eine schwarze Katze leckt ihre Pfote und schaut zu dir.\n„Was machst du in unserem Revier?\""
  },
  Event_125781_Name = {
    Text = "Formenwandel"
  },
  Event_125782_ChoiceDesc1 = {
    Text = "[Umgehe das Phantasma] Erhält Goldene Kreation „(RelicConfig.Arg1)\", entwickelt „(Skill.Arg2)\""
  },
  Event_125782_ChoiceDesc2 = {
    Text = "[Begrüße die Zukunft] Erhalte 1 aus 3 Goldene Kreationen, entwickle aber das Symptom [(Skill.Arg1)]"
  },
  Event_125782_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte Silberrelikt“(RelicConfig.Arg1)“"
  },
  Event_125782_Desc = {
    Text = "Das Erscheinen von Nefraea störte die Fäden. In dem chaotischen Schicksal siehst du zwei verschwommene Phantasma. \n Das ist deine Vergangenheit, das ist deine Zukunft. Du gehst auf sie zu und streckst deine Hand aus..."
  },
  Event_125782_Name = {
    Text = "Vergangenheit, Zukunft"
  },
  Event_125855_ChoiceDesc1 = {
    Text = "[Perceive] Aufstieg 1 Relikt zur Goldenen Kreation [(RelicConfig.Arg1)]"
  },
  Event_125855_ChoiceDesc2 = {
    Text = "[Blick]Erhalte das silberne Relikt “(RelicConfig.Arg1)“, infiziere “(Skill.Arg2)“"
  },
  Event_125855_ChoiceDesc3 = {
    Text = "[Ignoriere] erhalte 25 das schwarze Siegel"
  },
  Event_125855_Desc = {
    Text = "In den Straßen von Kasalim zieht dich der strahlende Glanz eines Kristallladens an. Du stehst vor dem Schaufenster und nimmst einen Kristall in die Hand, der wie ein Silberkern geformt ist."
  },
  Event_125855_Name = {
    Text = "Das Geheimnis des Kristalls"
  },
  Event_125856_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_125856_Desc = {
    Text = "Du schließt die Augen und nimmst es achtsam wahr.\nEin Lichtschimmer flackert in deinem Bewusstsein, als ob er dir etwas mitteilen möchte..."
  },
  Event_125856_Name = {
    Text = "Das Geheimnis des Kristalls"
  },
  Event_125857_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_125857_Desc = {
    Text = "Jeder Widerstand oder jedes Ergründen des Schicksals ist zwecklos. Du schließt still die Augen und erlaubst dem Schicksal, dich dorthin zu führen, wo du hingehörst."
  },
  Event_125857_Name = {
    Text = "Die Schlinge des Schicksals"
  },
  Event_125858_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_125858_Desc = {
    Text = "„Emotion ist der Sinn der Existenz. Mögest du deine Wahl niemals bereuen.\""
  },
  Event_125858_Name = {
    Text = "Preis der Wahl"
  },
  Event_125859_ChoiceDesc1 = {
    Text = "[Emotion] Stelle Arg1 LP wieder her"
  },
  Event_125859_ChoiceDesc2 = {
    Text = "[Reason] Gravur des Orison [(EnchantConfig.Arg1)] auf 1 zufällige Befehlskarte"
  },
  Event_125859_ChoiceDesc3 = {
    Text = "[Weigere die Wahl] erhält +25 das schwarze Siegel"
  },
  Event_125859_Desc = {
    Text = "Eine Waage erscheint auf der Bühne.\n„Gehirn und Herz, Vernunft und Emotion, Grau und Rot... wir können der Wahl nicht entgehen; es ist unser Schicksal.\"\n„Das Ende der Bühne ist bereits gezeichnet. Nun wähle den Weg, den diese Aufführung beschreiten soll.\""
  },
  Event_125859_Name = {
    Text = "Preis der Wahl"
  },
  Event_125860_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_125860_Desc = {
    Text = "„Schau nicht nach oben. Verlasse diesen Ort.\"\nDu hörst die Stimme des Schicksals. Obwohl du dich danach sehnst, den Himmel zu betrachten, weißt du, dass sie recht hat."
  },
  Event_125860_Name = {Text = "Hochblick"},
  Event_125861_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_125861_Desc = {
    Text = "Du akzeptierst das Schicksal nie. Du akzeptierst Gefangenschaft nie.\nDu kämpfst mit aller Kraft. Nachdem du ein Glied der Motte geopfert hast, gelingt dir schließlich die Flucht..."
  },
  Event_125861_Name = {
    Text = "Die Schlinge des Schicksals"
  },
  Event_125862_ChoiceDesc1 = {
    Text = "[Friendship] Erhalte 50 Schwarze Male"
  },
  Event_125862_ChoiceDesc2 = {
    Text = "[Help] Erhalte 75 Schwarze Male, infiziere [(Skill.Arg2)]"
  },
  Event_125862_Desc = {
    Text = "In der Hintergasse der Bar begegnest du erneut diesen schwarzen Katzen.\n„Ich habe davon gehört. Diese schwarzen Schleimwesen haben unsere Gestalt angenommen und dir einige Schwierigkeiten bereitet.\"\n„Als Entschuldigung, sag mir – was möchtest du?\"\nDie schwarzen Katzen umkreisen deine Beine zweimal und schauen zu dir auf."
  },
  Event_125862_Name = {
    Text = "Erstes Geschenk"
  },
  Event_125863_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_125863_Desc = {
    Text = [[
Rohe Gewalt kann das Schicksal nicht entwirren, aber vielleicht Weisheit?
Du beobachtest das Netz genau und suchst darin nach einem Faden des Schicksalsplans...]]
  },
  Event_125863_Name = {
    Text = "Die Schlinge des Schicksals"
  },
  Event_125864_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_125864_Desc = {
    Text = "Du lehnst dich vor und betrachtest es aufmerksam.\nEin Lichtschimmer flackert in deinen Augen, als ob er dir etwas mitteilen möchte..."
  },
  Event_125864_Name = {
    Text = "Das Geheimnis des Kristalls"
  },
  Event_125865_ChoiceDesc1 = {
    Text = "[Struggle] Zerstöre 1 von 3 zufälligen Befehlskarten und erhalte 75 Schwarze Male"
  },
  Event_125865_ChoiceDesc2 = {
    Text = "[Rest] Dupliziere 1 von 3 Befehlskarten und erhalte 25 Schwarze Male"
  },
  Event_125865_ChoiceDesc3 = {
    Text = "[Rest] Erhalte 50 Schwarze Male"
  },
  Event_125865_Desc = {
    Text = "Ein vertrautes Gefühl überfällt dich. Doch diesmal ist die zähe Berührung und der Instinkt der Hilflosigkeit intensiver, tödlicher.\nDie Motte fällt ins Spinnennetz. Und du hast bereits die Bühne betreten."
  },
  Event_125865_Name = {
    Text = "Die Schlinge des Schicksals"
  },
  Event_125866_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_125866_Desc = {
    Text = "„Vernunft ist der Sinn der Existenz. Mögest du deine Wahl niemals bereuen.\""
  },
  Event_125866_Name = {
    Text = "Preis der Wahl"
  },
  Event_125867_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_125867_Desc = {
    Text = "Neugier entfacht sich. Du mischst dich unter die Menge und hebst den Kopf wie sie.\nDort ist nichts, doch aus unbekannten Gründen kannst du den Blick nicht abwenden. Du möchtest so schauen – für immer schauen..."
  },
  Event_125867_Name = {Text = "Hochblick"},
  Event_125868_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_125868_Desc = {
    Text = "„Die Auswahl zu verweigern ist selbst eine Auswahl — das ist der Fluch des Schicksals. Mögest du die Wahl, die du getroffen hast, niemals bereuen.\""
  },
  Event_125868_Name = {
    Text = "Preis der Wahl"
  },
  Event_125869_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_125869_Desc = {
    Text = "„Nun, es gehört dir.\"\nDie Katzen streifen an deinem Schienbein entlang und verschwinden bald.\nWo sie verschwunden sind, wartet ein Geschenk."
  },
  Event_125869_Name = {
    Text = "Erstes Geschenk"
  },
  Event_125870_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_125870_Desc = {
    Text = "„Nun, es gehört dir.\"\nDie Katzen streifen an deinem Schienbein entlang und verschwinden bald.\nWo sie verschwunden sind, wartet ein Geschenk."
  },
  Event_125870_Name = {
    Text = "Erstes Geschenk"
  },
  Event_125871_ChoiceDesc1 = {
    Text = "[Den Kopf heben] Wähle 1 von 3 Befehlskarten aus, um ein Gebet zu erhalten: „(EnchantConfig.Arg1)\", infiziere „(Skill.Arg2)\""
  },
  Event_125871_ChoiceDesc2 = {
    Text = "[Verlassen]Erhalte 25 schwarze Siegel"
  },
  Event_125871_Desc = {
    Text = "Der Lärm verstummt für einen flüchtigen Moment. Die Menschenmenge auf der Straße verfällt in Stille und hebt die Köpfe gen Himmel."
  },
  Event_125871_Name = {Text = "Hochblick"},
  Event_129176_ChoiceDesc1 = {
    Text = "[Platzhalter] Temporärer Text."
  },
  Event_129176_Name = {
    Text = "Vergessenheit Kapitel 1@"
  },
  Event_129177_ChoiceDesc1 = {
    Text = "[Platzhalter] Temporärer Text."
  },
  Event_129177_Name = {
    Text = "Sterne Kapitel 1@"
  },
  Event_129178_ChoiceDesc1 = {
    Text = "[Richtung weisen]Erhalte das Silberrelikt „(RelicConfig.Arg1)“, infiziere „(Skill.Arg2)“"
  },
  Event_129178_ChoiceDesc2 = {
    Text = "[Gemeinsam beten] Graviere 1 von 3 Gebeten zweimal."
  },
  Event_129178_Desc = {
    Text = "Die Klänge des Klaviers und der Orgel verweben sich im grauen Wind. Es scheint, als ob eine magische Melodie durch die verlassenen Gassen schwebt. \n Eine namenlose Nonne betet im Klang der Musik. \n “Ein einfaches Gebet bedarf keiner feierlichen Zeremonie, der große All-Vater wird uns Hoffnung säen, so wie er uns einst fromme Lehren gegeben hat.“"
  },
  Event_129178_Name = {
    Text = "Gebet der Orgel"
  },
  Event_129179_ChoiceDesc1 = {
    Text = "[Platzhalter]Temporärer Text."
  },
  Event_129179_Name = {
    Text = "Sterne Kapitel 1@"
  },
  Event_129180_ChoiceDesc1 = {
    Text = "[Aktiv kämpfen]Erhalte ein verfluchtes Relikt „(RelicConfig.Arg1)“, infiziere „(Skill.Arg2)“"
  },
  Event_129180_ChoiceDesc2 = {
    Text = "[Surrender] Wähle 1 von 3 Befehlskarten aus, um zweimal das Gebet zu gravieren: [(EnchantConfig.Arg1)]"
  },
  Event_129180_ChoiceDesc3 = {
    Text = "[Mach schnell einen Abgang]Erhalte 50 schwarze Siegel"
  },
  Event_129180_Desc = {
    Text = "Einige Wachsfiguren blockierten deinen Weg.\nSie waren schief und grob, nicht auf Rogers üblichem Niveau.\n„Befehl... der Befehl des Meisters...“"
  },
  Event_129180_Name = {Text = "Übung"},
  Event_129181_ChoiceDesc1 = {
    Text = "[Gib das Denken auf]erhalte ein verfluchtes Relikt“(RelicConfig.Arg1)“，infiziere“(Skill.Arg2)“"
  },
  Event_129181_ChoiceDesc2 = {
    Text = "[Einblick einholen] Eine zufällige Befehlskarte erhält das Gebet graviert: [(EnchantConfig.Arg1)] zweimal"
  },
  Event_129181_Desc = {
    Text = "Ein ANG auf den Hafen, ein mysteriöser Frachter ohne Rückkehr und neue „Freunde“ mit Flossen... Ist das eine sorgfältig geplante Falle oder nur eine weitere unvorhersehbare Reise?\nRealität und Vernunft zerren aneinander, unzählige Inspirationen und Gedanken strömen aus dem Kopf"
  },
  Event_129181_Name = {
    Text = "Inspirationsschub"
  },
  Event_129182_ChoiceDesc1 = {
    Text = "[Join] Infiziert „(Skill.Arg1)\" zweimal, eine zufällige Karte erhält das Gebet: „(EnchantConfig.Arg2)\" zweimal"
  },
  Event_129182_ChoiceDesc2 = {
    Text = "[Dispel] Infiziert „(Skill.Arg1)\" zweimal, eine zufällige Karte erhält das Gebet: „(EnchantConfig.Arg2)\" zweimal"
  },
  Event_129182_ChoiceDesc3 = {
    Text = "[Disregard] Wähle 1 von 3 Befehlskarten aus, die das Gebet erhalten: [(EnchantConfig.Arg1)] zweimal"
  },
  Event_129182_Desc = {
    Text = "Du hörst das schwache Hornsignal der Knochenschnecken aus der Ferne. \n Die Ratten schießen aus dem schwarzen Schlamm hervor und nagen an den namenlosen Leibern, die auf dem ausgetrockneten Flussbett liegen. \n Sie bilden einen Kreis, dessen Mittelpunkt der bereits hohle Leichnam ist, während der Umfang ein neues Königreich ist, dessen Gesetz das Vergessen ist. \n Und du stehst am Eingang dieses Königreichs."
  },
  Event_129182_Name = {
    Text = "Verbanntes Königreich"
  },
  Event_129183_ChoiceDesc1 = {
    Text = "[Platzhalter]Temporärer Text."
  },
  Event_129183_Name = {
    Text = "Vergessenheit Kapitel 5@"
  },
  Event_129184_ChoiceDesc1 = {
    Text = "[Platzhalter] Temporärer Text."
  },
  Event_129184_Name = {
    Text = "Vergessenheit Kapitel 8@"
  },
  Event_129185_ChoiceDesc1 = {
    Text = "[Platzhalter]Temporärer Text."
  },
  Event_129185_Name = {
    Text = "Vergessenheit Kapitel 1@"
  },
  Event_129186_ChoiceDesc1 = {
    Text = "[Porträt retten] Wähle 1 von 3 Befehlskarten aus, die das Gebet erhalten: „(EnchantConfig.Arg1)\" zweimal, infiziert „(Skill.Arg2)\" zweimal"
  },
  Event_129186_ChoiceDesc2 = {
    Text = "[Leere akzeptieren] Wähle 1 von 3 Befehlskarten aus, die das Gebet erhalten: „(EnchantConfig.Arg1)\" zweimal, infiziert „(Skill.Arg2)\" zweimal"
  },
  Event_129186_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte 25 schwarze Siegel"
  },
  Event_129186_Desc = {
    Text = "Du stehst vor Pickmans Geschenk. \n Es ist ein Porträt, das mit Blut gemalt wurde, während die schwarze Flamme ruhig brennt. \n Durch die leeren Augenhöhlen der Person im Bild siehst du – \n deine Erinnerungen toben und brennen, sich dehnen, verzerren, leuchten, als würde ein unsichtbares Feuer die Gänge in deinem Kopf lecken. Im Dämmerzustand hörst du eine Stimme. \n “Es ist Zeit, in den Topf zu kommen, die Temperatur ist genau richtig.“ \n Das ist genau das Bild deiner eigenen Erinnerungen, in dem du in den Flammen kämpfst und dich verformst."
  },
  Event_129186_Name = {
    Text = "Brennendes Porträt"
  },
  Event_129187_ChoiceDesc1 = {
    Text = "[Was bist du bereit zu zahlen?] Verbessere zweimal die Gebetsqualität einer zufälligen Karte."
  },
  Event_129187_ChoiceDesc2 = {
    Text = "[Spendiere ihnen einen abgelaufenen Bloody Mary] Wähle 1 von 3 Befehlskarten aus, um zweimal das Gebet zu gravieren: „(EnchantConfig.Arg1)\", zweimal infiziert mit „(Skill.Arg2)\""
  },
  Event_129187_Desc = {
    Text = "“Willkommen, mein wertvoller Gast. Wählen Sie nach Belieben, all diese Pracht existiert nur für Sie.“\n“Ähm, entschuldigen Sie bitte, sind Sie... die Zwillingsschwester von Frau Daffodil?“\n“Ich bin Daffodil selbst. Darf ich fragen, was Sie heute hierher führt...?“\n“Entschuldigung, Entschuldigung, Sie sind noch anmutiger als zuvor, ich habe Sie nicht erkannt. Erinnern Sie sich? Vor zwanzig Jahren haben Sie einen Unhold aus meiner Bar entfernt... Gestern ist der Albtraum zurückgekehrt, er hat die Bar eingenommen, mit seinen Geschwistern, in Scharen...“"
  },
  Event_129187_Name = {
    Text = "Erinnerungsfragment: Alte Träume wiederbelebt"
  },
  Event_129188_ChoiceDesc1 = {
    Text = "[Platzhalter]Temporärer Text."
  },
  Event_129188_Name = {
    Text = "Sterne Kapitel 3@"
  },
  Event_129189_ChoiceDesc1 = {
    Text = "[Platzhalter]Temporärer Text."
  },
  Event_129189_Name = {
    Text = "Vergessenheit Kapitel 8@"
  },
  Event_129190_ChoiceDesc1 = {
    Text = "[Platzhalter] Temporärer Text."
  },
  Event_129190_Name = {
    Text = "Vergessenheit Kapitel 1@"
  },
  Event_129191_ChoiceDesc1 = {
    Text = "[Platzhalter] Temporärer Text."
  },
  Event_129191_Name = {
    Text = "Vergessenheit Kapitel 6@"
  },
  Event_129192_ChoiceDesc1 = {
    Text = "[Zündholz festhalten]erhöhe Arg1 Punkte maximale Gesundheit"
  },
  Event_129192_ChoiceDesc2 = {
    Text = "[Dem Inneren ins Gesicht sehen] 2 zufällige Befehlskarten erhalten das Gebet graviert: „(EnchantConfig.Arg1)\" zweimal, entwickle 2 „(Skill.Arg2)\" zweimal"
  },
  Event_129192_Desc = {
    Text = "In dieser gewaltigen Jagd verfolgt Goliath wie ein Raubtier in der Nacht, das jede Hoffnung verschlingen will. Doch diese gnadenlose Jagd hat dich nicht eingefroren, sondern das Feuer in deinem Inneren entfacht, das in deiner Brust immer heißer brennt"
  },
  Event_129192_Name = {
    Text = "Lichtverfolgung"
  },
  Event_129193_ChoiceDesc1 = {
    Text = "[Platzhalter]Temporärer Text."
  },
  Event_129193_Name = {
    Text = "Vergessenheit Kapitel 6@"
  },
  Event_129194_ChoiceDesc1 = {
    Text = "[Den Weg der Vorgänger lesen] Wähle 1 von 3 Befehlskarten aus, die das Gebet erhält: „(EnchantConfig.Arg1)\", infiziert „(Skill.Arg2)\""
  },
  Event_129194_ChoiceDesc2 = {
    Text = "[Eigene Wege schreiben]Erhalte ein Silberrelikt „(RelicConfig.Arg1)“, infiziere „(Skill.Arg2)“"
  },
  Event_129194_ChoiceDesc3 = {
    Text = "[Blick in die Dunkelheit]Erhalte 25 das schwarze Siegel"
  },
  Event_129194_Desc = {
    Text = "Wenn du in dem Bereich allein umherwanderst, wirst du dir sicherlich nicht so sicher über deinen Weg erscheinen wie jetzt.\nDie Fußstapfen im Bereich teilten sich in drei Wege, jeder Abdruck schrieb eine unsichtbare Zukunft"
  },
  Event_129194_Name = {Text = "Ausweg"},
  Event_129195_ChoiceDesc1 = {
    Text = "[Den Fehler aufzeigen] Wähle 1 von 3 Befehlskarten aus, um zweimal das Gebet zu gravieren: „(EnchantConfig.Arg1)\", infiziere zweimal „(Skill.Arg2)\""
  },
  Event_129195_ChoiceDesc2 = {
    Text = "[Nach dem Spiel hören]für jede aufgewachte Energie mit 50 oder mehr erhält 15 das schwarze Siegel"
  },
  Event_129195_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte eine Auswahl von 3 für 1 Gebet"
  },
  Event_129195_Desc = {
    Text = "Die Wachsfigur des Jungen saß am Klavier und spielte eine Übung.\nSein Lehrer – ebenfalls aus Wachs – stand daneben und gab Anweisungen.\n133, 355, 244...\nFalsch, jeder Ton war falsch"
  },
  Event_129195_Name = {
    Text = "Piano-Unterricht"
  },
  Event_129196_ChoiceDesc1 = {
    Text = "[Platzhalter]Temporärer Text."
  },
  Event_129196_Name = {
    Text = "Vergessenheit Kapitel 5@"
  },
  Event_129197_ChoiceDesc1 = {
    Text = "[Platzhalter] Temporärer Text."
  },
  Event_129197_Name = {
    Text = "Stern Kapitel 4@"
  },
  Event_129198_ChoiceDesc1 = {
    Text = "[Klagelied anhören] Wähle 1 von 3 Befehlskarten aus, um zweimal das Gebet zu gravieren: „(EnchantConfig.Arg1)\", aber entwickle „(Skill.Arg2)\" zweimal"
  },
  Event_129198_ChoiceDesc2 = {
    Text = "[Freude hören] für jede aufgewachte Energie mit 50 oder mehr erhält 15 schwarze Siegel"
  },
  Event_129198_ChoiceDesc3 = {
    Text = "[Leave] Erhalte 2-mal ein Gebet aus 3 zur Auswahl"
  },
  Event_129198_Desc = {
    Text = "Sanfte, lyrische, frohe, traurige... Melodien hallen im Bereich, schwer zu erkennen, woher sie stammen.\n Ist das die Sonate, die aus dem Klang des Geisterschiffes fließt, oder ein Mitternachtsrausch, der im Bereich gefangen ist?"
  },
  Event_129198_Name = {
    Text = "Unbekannter Ton"
  },
  Event_129199_ChoiceDesc1 = {
    Text = "[Platzhalter] Temporärer Text."
  },
  Event_129199_Name = {
    Text = "Stern Kapitel 1@"
  },
  Event_129200_ChoiceDesc1 = {
    Text = "[Öffne den Umschlag] Erhalte goldenes Relikt '(RelicConfig.Arg1)', infiziere '(Skill.Arg2)'"
  },
  Event_129200_ChoiceDesc2 = {
    Text = "[Read] Wähle 1 von 3 Befehlskarten aus, um zweimal das Gebet zu erhalten: [(EnchantConfig.Arg1)]"
  },
  Event_129200_ChoiceDesc3 = {
    Text = "[Put it back] Erhalte 50 Das schwarze Siegel"
  },
  Event_129200_Desc = {
    Text = "In einer verwahrlosten Ecke wurde ein Brief zurückgelassen.\nViele Wörter auf dem Brief sind unkenntlich geworden, aber ein Wort bleibt. Es durchbohrt das Papier.\nDieses Wort ist \"Mutter\"."
  },
  Event_129200_Name = {
    Text = "Verblassende Sehnsucht"
  },
  Event_129201_ChoiceDesc1 = {
    Text = "[Platzhalter]Temporärer Text."
  },
  Event_129201_Name = {
    Text = "Sterne Kapitel 4@"
  },
  Event_129202_ChoiceDesc1 = {
    Text = "[Aufmerksam zuhören] Wähle 1 von 3 Befehlskarten aus, um zweimal das Gebet zu gravieren: „(EnchantConfig.Arg1)\", aber entwickle „(Skill.Arg2)\" zweimal"
  },
  Event_129202_ChoiceDesc2 = {
    Text = "[Ohren zuhalten]für jeden Erwecker mit einem Aelius-Wert von 50 oder mehr erhalte 15 schwarze Siegel"
  },
  Event_129202_ChoiceDesc3 = {
    Text = "[Examine] Graviere 1 von 3 Gebeten zweimal."
  },
  Event_129202_Desc = {
    Text = "Als ihr die Etage mit den Überresten erreicht, ertönt in der leeren, verlassenen Fabrik plötzlich ein angenehmes Klingeln, das Kontrast zwischen den klaren Klängen des Klaviers und den rostigen Stahlruinen ist frappierend"
  },
  Event_129202_Name = {
    Text = "verwegene Tonleiter"
  },
  Event_129203_ChoiceDesc1 = {
    Text = "[Platzhalter]Temporärer Text."
  },
  Event_129203_Name = {
    Text = "Vergessenheit Kapitel 3@"
  },
  Event_129204_ChoiceDesc1 = {
    Text = "[Platzhalter] Temporärer Text."
  },
  Event_129204_Name = {
    Text = "Vergessenheit Kapitel 6@"
  },
  Event_129205_ChoiceDesc1 = {
    Text = "[Lass sie frei]erhalte ein verfluchtes Relikt“(RelicConfig.Arg1)“，infiziere“(Skill.Arg2)“"
  },
  Event_129205_ChoiceDesc2 = {
    Text = "[Ihr helfen] Wähle 1 von 3 Befehlskarten aus, um zweimal das Gebet zu gravieren: [(EnchantConfig.Arg1)]"
  },
  Event_129205_ChoiceDesc3 = {
    Text = "[Ich gehe meinen eigenen Weg]erhalte 50 das schwarze Siegel"
  },
  Event_129205_Desc = {
    Text = "Drei Schatten blockieren deinen Weg. \n “Du kannst sie freigeben“, sagt die Gestalt mit dem mit A-Schleim bedeckten Teddybär in den Armen, “sie ist nur ängstlich und nicht böse. Sie möchte niemandem schaden.“ \n “Du kannst ihr helfen“, sagt die Gestalt, die eine kunstvoll verpackte Süßigkeit in den Händen hält, “du kannst das tun, was sie nicht kann, du kannst das alles beenden.“ \n “Du musst uns nicht zuhören“, sagt die Gestalt, die mit leeren Händen dasteht, “du hast deinen eigenen Weg.“"
  },
  Event_129205_Name = {
    Text = "verzweigter Pfad"
  },
  Event_129206_ChoiceDesc1 = {
    Text = "[Widerlegen] erhält Silberrelikt [(RelicConfig.Arg1)], wählt 1 Symptom zur Infektion"
  },
  Event_129206_ChoiceDesc2 = {
    Text = "[Ratten vertreiben] Graviere das Gebet „(EnchantConfig.Arg1)\" zweimal auf 1 von 3 Befehlskarten, entwickle aber „(Skill.Arg2)\" zweimal."
  },
  Event_129206_ChoiceDesc3 = {
    Text = "[Neue Perspektive einbringen]erhalte 25 schwarze Siegel"
  },
  Event_129206_Desc = {
    Text = "Alles auf diesem Schiff ist in der Zeitschleife gefangen.\nSelbst diese widerlichen, pelzigen kleinen Kreaturen, die hier ums Überleben kämpfen, können ihrem Schicksal nicht entkommen.\nZyklus um Zyklus verschlingen sie alles in Sichtweite, doch ihr Hunger wird nie gestillt.\n„So... hungrig...\"\nHorden von Ratten stoßen krankhaft durchdringende Schreie aus.\nDie endlosen Zyklen haben sie ausgehungert und wahnsinnig gemacht — sie müssen etwas fressen.\nJetzt. Sofort."
  },
  Event_129206_Name = {
    Text = "Hungrige Rattenbande"
  },
  Event_129207_ChoiceDesc1 = {
    Text = "[Platzhalter]Temporärer Text."
  },
  Event_129207_Name = {
    Text = "Vergessenheit Kapitel 8@"
  },
  Event_129208_ChoiceDesc1 = {
    Text = "[Gehirn berühren] Eine zufällige Befehlskarte erhält das Gebet: [(EnchantConfig.Arg1)] zweimal"
  },
  Event_129208_ChoiceDesc2 = {
    Text = "[Herz berühren]Erhöhe Arg1 Punkte maximale Gesundheit, infiziere „(Skill.Arg2)“"
  },
  Event_129208_Desc = {
    Text = "Du trittst in den grauen Saal ein, in dem niemand flüstert, eine Waage erscheint im schwarzen Nebel. \n Links liegt ein ruhiges Gehirn wie ein See, silberne Ritzen blitzen schwach; rechts befindet sich ein glühendes, dampfendes Herz. \n Plötzlich nimmst du einen Duft wahr, das Verlangen wächst unaufhörlich, die Vernunft wird von seiner grenzenlosen Dunkelheit erdrückt. \n Du streckst die Hand aus."
  },
  Event_129208_Name = {
    Text = "Hunger Games"
  },
  Event_129209_ChoiceDesc1 = {
    Text = "[Platzhalter]Temporärer Text."
  },
  Event_129209_Name = {
    Text = "Vergessenheit Kapitel 4@"
  },
  Event_129210_ChoiceDesc1 = {
    Text = "[Schatten erschlagen] Wähle 1 von 3 Befehlskarten aus, um zweimal das Gebet zu gravieren: „(EnchantConfig.Arg1)\", aber entwickle „(Skill.Arg2)\" zweimal"
  },
  Event_129210_ChoiceDesc2 = {
    Text = "[Embryo zermalmen] Wähle 1 von 3 Befehlskarten aus, um das Gebet zu gravieren: „(EnchantConfig.Arg1)\" zweimal, entwickle „(Skill.Arg2)\" zweimal"
  },
  Event_129210_ChoiceDesc3 = {
    Text = "[Schließe die Augen]Erhalte 25 das schwarze Siegel"
  },
  Event_129210_Desc = {
    Text = "Benommen siehst du die Menschen, die du einst bei Aram getroffen hast, sich dir nähern. \n Sie lachen und laden dich ein, zu trinken, zu tanzen und köstliches Essen zu probieren. \n Dann schält sich ihr Fleisch Schicht für Schicht ab, und das, was zu Boden fällt, kriecht und wächst zu neuen Embryonen. \n Sie strecken dir die Hände entgegen und laden dich ein, an der Feier von Fleisch und Neugeboren teilzunehmen."
  },
  Event_129210_Name = {
    Text = "Schatten der Vergangenheit"
  },
  Event_129211_ChoiceDesc1 = {
    Text = "[Füttere sie]erhalte das silberne Relikt „(RelicConfig.Arg1)“, wähle 1 Mal ein Symptom zur Infektion"
  },
  Event_129211_ChoiceDesc2 = {
    Text = "[Nicht beachten] Wähle 1 von 3 Befehlskarten aus, um das Gebet zu erhalten: „(EnchantConfig.Arg1)\" zweimal, infiziere „(Skill.Arg2)\" zweimal"
  },
  Event_129211_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte 25 schwarze Siegel"
  },
  Event_129211_Desc = {
    Text = "Die Bewohner kommen und gehen, aber die Ratten bleiben lange Zeit. \n Im Vergleich zu den Menschen sind sie die “Ureinwohner“ dieser Burg. \n Doch sie haben nichts gegen das Eindringen der Menschen. \n Denn diese schmackhaften, zarten, hässlichen Wesen füttern sie mit ebenso schmackhaften, zarten, hässlichen Wesen. \n “Und du, hässliches Wesen, zu welcher Art gehörst du?“"
  },
  Event_129211_Name = {
    Text = "Das Geheimnis der Burg"
  },
  Event_129212_ChoiceDesc1 = {
    Text = "[Platzhalter]Temporärer Text."
  },
  Event_129212_Name = {
    Text = "Vergessenheit Kapitel 5@"
  },
  Event_129213_ChoiceDesc1 = {
    Text = "[Discern Man's Voice] Ziehe zufällig 3 Befehlskarten aus dem Deck und wähle 1 zur Duplikation aus."
  },
  Event_129213_ChoiceDesc2 = {
    Text = "[Die Stimme der Frau unterscheiden] Wähle 1 von 3 Befehlskarten aus, um das Gebet zu gravieren: „(EnchantConfig.Arg1)\" zweimal, entwickle „(Skill.Arg2)\" zweimal"
  },
  Event_129213_ChoiceDesc3 = {
    Text = "[Discern the Elder's Voice] Erhalte 25 [Das schwarze Siegel]"
  },
  Event_129213_Desc = {
    Text = "Du stehst allein in einem dunklen Sumpf.\nDurch den Dunst hörst du chaotische Murmeln, die sich wie Gezeiten überlagern - einige von alten Männern, einige von plappernden Kindern, einige von ängstlichen Frauen und einige von unheimlich ängstlichen Männern..."
  },
  Event_129213_Name = {
    Text = "Letzte Worte"
  },
  Event_129214_ChoiceDesc1 = {
    Text = "[Genauer hinsehen] Graviere zweimal 1 von 3 Gebeten."
  },
  Event_129214_ChoiceDesc2 = {
    Text = "[Plakat abreißen] Eine zufällige Befehlskarte erhält zweimal das Gebet: „(EnchantConfig.Arg1)\", zweimal infiziert mit „(Skill.Arg2)\""
  },
  Event_129214_Desc = {
    Text = "Ein überall im Wachsfigurenkabinett zu findender Kerzenhalter.\nIm krankenhaften orangefarbenen Licht entdeckst du ein handgezeichnetes Plakat an der Wand"
  },
  Event_129214_Name = {
    Text = "Lachen in der Dunkelheit"
  },
  Event_129215_ChoiceDesc1 = {
    Text = "[Platzhalter]Temporärer Text."
  },
  Event_129215_Name = {
    Text = "Vergessenheit Kapitel 4@"
  },
  Event_129216_ChoiceDesc1 = {
    Text = "[Platzhalter] Temporärer Text."
  },
  Event_129216_Name = {
    Text = "Vergessenheit Kapitel 7@"
  },
  Event_129217_ChoiceDesc1 = {
    Text = "[Blick]Erhalte das silberne Relikt “(RelicConfig.Arg1)“, infiziere “(Skill.Arg2)“"
  },
  Event_129217_ChoiceDesc2 = {
    Text = "[Ignore] Graviere 1 von 3 Gebeten zweimal."
  },
  Event_129217_Desc = {
    Text = "Die Aramer knieten in dem Sandsturm.\nDer Sturm peitschte gegen ihre Körper, der Sand verschlang ihre Andacht.\nInmitten des Staubwirbels scheinen unzählige riesige Augen die verzerrte Erde zu überblicken"
  },
  Event_129217_Name = {Text = "Sandriesen"},
  Event_129218_ChoiceDesc1 = {
    Text = "[Schmetterlinge vertreiben] Eine zufällige Befehlskarte erhält das Gebet: „(EnchantConfig.Arg1)\" zweimal, infiziert „(Skill.Arg2)\" zweimal"
  },
  Event_129218_ChoiceDesc2 = {
    Text = "[Wunsch anhören] Wähle 1 von 3 Befehlskarten aus, die das Gebet erhalten: [(EnchantConfig.Arg1)] zweimal"
  },
  Event_129218_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte 25 schwarze Siegel"
  },
  Event_129218_Desc = {
    Text = "Der kleine Schmetterling trägt viele Träume.\nDiese Träume sind in den Blumenmeeren, in den Krankenzimmern und auf dem mit Blut und Fleisch von @2 gefüllten Altar verstreut.\nNun hat er endlich auf seine Bindung gewartet und fragt sich, ob du bereit bist, seinen kleinen, kleinen Wunsch zu hören."
  },
  Event_129218_Name = {
    Text = "SchmetterlingsTraum"
  },
  Event_129219_ChoiceDesc1 = {
    Text = "[Führung folgen] Graviere das Gebet „(EnchantConfig.Arg1)\" zweimal auf 1 von 3 Befehlskarten, entwickle aber „(Skill.Arg2)\" zweimal."
  },
  Event_129219_ChoiceDesc2 = {
    Text = "[Führung ignorieren] Graviere das Gebet „(EnchantConfig.Arg1)\" zweimal auf 1 von 3 Befehlskarten, entwickle aber „(Skill.Arg2)\" zweimal."
  },
  Event_129219_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte 25 schwarze Siegel"
  },
  Event_129219_Desc = {
    Text = "Das Fest hat begonnen.\nUnter den Flammen des Geistes und den Segnungen des Blutes sind unzählige gläubige Seelen zu Leuchtfeuern geworden—\nDie ätherischen Geister verstreuen sich um dich wie leitende Elfen, leuchtend und wartend auf deine Wahl."
  },
  Event_129219_Name = {
    Text = "Seelenlaterne"
  },
  Event_129220_ChoiceDesc1 = {
    Text = "[Glocke ignorieren] Erhalte 2-mal ein hochwertiges Gebet aus 3 zur Auswahl"
  },
  Event_129220_ChoiceDesc2 = {
    Text = "[Hörer abheben]Erhalte das goldene Relikt „(RelicConfig.Arg1)“, infiziere „(Skill.Arg2)“"
  },
  Event_129220_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte 50 schwarze Siegel"
  },
  Event_129220_Desc = {
    Text = "Es hätte nicht läuten sollen – das Telefon, eingekringelt hinter der Leinwand. \n Das Kabel des Hörers ist um den massiven Körper gewickelt, wie eine verrostete Nabelschnur, die scheinbar aus deinem Gehirn herausragt. \n Du versuchst, die Frequenz der Vibrationen genau zu erkennen, das unheimliche Geräusch ähnelt Pickmans surrealer Kunst."
  },
  Event_129220_Name = {
    Text = "Verpasster Anruf"
  },
  Event_129221_ChoiceDesc1 = {
    Text = "[Wir sind alle sicher] Wähle 1 von 3 Befehlskarten aus, um zweimal das Gebet zu gravieren: „(EnchantConfig.Arg1)\", infiziere zweimal „(Skill.Arg2)\""
  },
  Event_129221_ChoiceDesc2 = {
    Text = "[Wer bist Du?] Wähle 1 von 3 Befehlskarten aus, um zweimal das Gebet zu gravieren: „(EnchantConfig.Arg1)\", zweimal infiziert mit „(Skill.Arg2)\""
  },
  Event_129221_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte 25 schwarze Siegel"
  },
  Event_129221_Desc = {
    Text = "Die Schreibmaschine spritzt plötzlich Tinte, die ! auf ihr blenden wie nie zuvor.\n„Doll, geht es dir gut??? Warum ist der Hüter verschwunden und du auch!!! Bitte antworte, wenn du wohlauf bist!!! Wenn das so weitergeht, verliert William seine Haare!!!“"
  },
  Event_129221_Name = {
    Text = "Notfallkommunikation"
  },
  Event_129222_ChoiceDesc1 = {
    Text = "[Rote Schnur durchtrennen] entfernt 1 Befehlskarte und erhält Arg1 das schwarze Siegel"
  },
  Event_129222_ChoiceDesc2 = {
    Text = "[Widerstand]Kopiere 1 Befehlskarte, infiziere “(Skill.Arg1)“"
  },
  Event_129222_ChoiceDesc3 = {
    Text = "[Ramona rufen] Wähle 1 von 3 Befehlskarten aus, um das Gebet zu gravieren: [(EnchantConfig.Arg1)] zweimal"
  },
  Event_129222_Desc = {
    Text = "Casiah wirft das rote Satinband aus, das sich sofort um deinen Koffer wickelt"
  },
  Event_129222_Name = {
    Text = "Verwirbelte Seide"
  },
  Event_129223_ChoiceDesc1 = {
    Text = "[Platzhalter] Temporärer Text."
  },
  Event_129223_Name = {
    Text = "Vergessenheit Kapitel 6@"
  },
  Event_129224_ChoiceDesc1 = {
    Text = "[Platzhalter]Temporärer Text."
  },
  Event_129224_Name = {
    Text = "Sternenkapitel 3@"
  },
  Event_129225_ChoiceDesc1 = {
    Text = "[Platzhalter]Temporärer Text."
  },
  Event_129225_Name = {
    Text = "Vergessenheit Kapitel 3@"
  },
  Event_129226_ChoiceDesc1 = {
    Text = "[Platzhalter]Temporärer Text."
  },
  Event_129226_Name = {
    Text = "Vergessenheit Kapitel 4@"
  },
  Event_129227_ChoiceDesc1 = {
    Text = "[Wegwinken] Wähle 1 von 3 Befehlskarten aus, die das Gebet erhalten: „(EnchantConfig.Arg1)\" zweimal, infiziert „(Skill.Arg2)\" zweimal"
  },
  Event_129227_ChoiceDesc2 = {
    Text = "[Lass es verweilen]Erhalte ein Silberrelikt „(RelicConfig.Arg1)“, infiziere „(Skill.Arg2)“"
  },
  Event_129227_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte 25 schwarze Siegel"
  },
  Event_129227_Desc = {
    Text = "Ein leises Geräusch dringt aus der Dunkelheit.\nEs ist ein Schmetterling, der höflich fragt:\n„Darf ich in deiner Handfläche ruhen?\"\n„Ich bin nur so müde... Ich möchte einen Moment rasten.\"\nWährend er fragt, spiralt der Schmetterling durch die Dunkelheit auf dich zu.\nSchwarze, klebrige Flüssigkeit tropft von seinen Flügeln—ein Geschenk der Schatten, durch die er flog."
  },
  Event_129227_Name = {
    Text = "Die Bitte des Schmetterlings"
  },
  Event_129228_ChoiceDesc1 = {
    Text = "[Platzhalter]Temporärer Text."
  },
  Event_129228_Name = {
    Text = "Vergessenheit Kapitel 7@"
  },
  Event_129229_ChoiceDesc1 = {
    Text = "[Platzhalter] Temporärer Text."
  },
  Event_129229_Name = {
    Text = "Vergessenheit Kapitel 7@"
  },
  Event_129230_ChoiceDesc1 = {
    Text = "[Platzhalter]Temporärer Text."
  },
  Event_129230_Name = {
    Text = "Vergessenheit Kapitel 1@"
  },
  Event_129231_ChoiceDesc1 = {
    Text = "[Erkenne die Texte]Erhalte Silberrelikt „(RelicConfig.Arg1)“, infiziere „(Skill.Arg2)“"
  },
  Event_129231_ChoiceDesc2 = {
    Text = "[Leise summen] Graviere 1 von 3 Gebeten zweimal."
  },
  Event_129231_Desc = {
    Text = "Das alte Seelied hallt im Bereich wider.\nDie von der Dimension gefangenen Erinnerungen singen mit dir in einer Sprache, die du noch nie gehört hast, vom Meer, vom Himmel und vom hochprozentigen Alkohol"
  },
  Event_129231_Name = {Text = "Meereslied"},
  Event_129232_ChoiceDesc1 = {
    Text = "[Platzhalter]Temporärer Text."
  },
  Event_129232_Name = {
    Text = "Vergessenheit Kapitel 8@"
  },
  Event_129233_ChoiceDesc1 = {
    Text = "[Platzhalter]Temporärer Text."
  },
  Event_129233_Name = {
    Text = "Sterne Kapitel 1@"
  },
  Event_129234_ChoiceDesc1 = {
    Text = "[Handfläche durchtrennen] Wähle 1 von 3 Befehlskarten aus, die das Gebet erhalten: „(EnchantConfig.Arg1)\" zweimal, infiziert „(Skill.Arg2)\" zweimal"
  },
  Event_129234_ChoiceDesc2 = {
    Text = "[Akzeptiere Wachstum]Erhalte das silberne Relikt “(RelicConfig.Arg1)“, infiziere “(Skill.Arg2)“"
  },
  Event_129234_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte 25 schwarze Siegel"
  },
  Event_129234_Desc = {
    Text = "Der Schmetterling kommt nicht geflogen, sondern wächst langsam aus deiner Handfläche. \n Zunächst dachtest du, es sei nur Schweiß, doch zwischen deinen Fingern siehst du, wie eine schwarze Flüssigkeit wie Blutgefäße zurückfließt und sich zu kalten, pulsierenden Flügeln verfestigt. \n Bei jedem Flügelschlag entstehen Wellen in deinem Blut."
  },
  Event_129234_Name = {
    Text = "Parasit der Oberschicht"
  },
  Event_129235_ChoiceDesc1 = {
    Text = "[Weiter stöbern] 1 zufällige Befehlskarte erhält zweimal das Gebet: [(EnchantConfig.Arg1)]"
  },
  Event_129235_ChoiceDesc2 = {
    Text = "[Verlassen]Erhöhe Arg1 maximale Gesundheit, infiziere“(Skill.Arg2)“"
  },
  Event_129235_Desc = {
    Text = "Eine Waage zum Wiegen.\nDahinter sind unzählige Organe in rotem Formalin eingelegt.\nSie sind ordentlich im Regal gestapelt.\nDu greifst nach einem Notizbuch und blätterst: „Herz: 8 Unzen, Gehirn: 50 Unzen...“"
  },
  Event_129235_Name = {
    Text = "Organregistrierung"
  },
  Event_129236_ChoiceDesc1 = {
    Text = "[Umweg machen]Entferne 1 Befehlskarte, erhalte Arg1 schwarzes Siegel"
  },
  Event_129236_ChoiceDesc2 = {
    Text = "[Warum gesunken]Kopiere 1 Befehlskarte, infiziere “(Skill.Arg1)“"
  },
  Event_129236_ChoiceDesc3 = {
    Text = "[Besatzung begrüßen] Wähle 1 von 3 Befehlskarten aus, um das Gebet zu gravieren: [(EnchantConfig.Arg1)] zweimal"
  },
  Event_129236_Desc = {
    Text = "Auf dem Weg zum Kraftwerk begegnetst du erneut einigen „Erinnerungen“, die im Bereich festgehalten sind.\nSie sind keine Geister, sondern nur Kapitän EltonS Sorge um die verstorbenen Mannschaftsmitglieder"
  },
  Event_129236_Name = {
    Text = "Besitzer des Sonanir"
  },
  Event_129237_ChoiceDesc1 = {
    Text = "[Platzhalter]Temporärer Text."
  },
  Event_129237_Name = {
    Text = "Vergessenheit Kapitel 3@"
  },
  Event_129238_ChoiceDesc1 = {
    Text = "[Platzhalter] Temporärer Text."
  },
  Event_129238_Name = {
    Text = "Sternen Kapitel 1@"
  },
  Event_129239_ChoiceDesc1 = {
    Text = "[Platzhalter] Temporärer Text."
  },
  Event_129239_Name = {
    Text = "Vergessenheit Kapitel 6@"
  },
  Event_129240_ChoiceDesc1 = {
    Text = "[Platzhalter]Temporärer Text."
  },
  Event_129240_Name = {
    Text = "Vergessenheit Kapitel 5@"
  },
  Event_129241_ChoiceDesc1 = {
    Text = "[Platzhalter]Temporärer Text."
  },
  Event_129241_Name = {
    Text = "Sternenkapitel 4@"
  },
  Event_129242_ChoiceDesc1 = {
    Text = "[Für ihn auftreten] Wähle 1 von 3 Befehlskarten aus, die das Gebet erhalten: „(EnchantConfig.Arg1)\" zweimal, infiziert „(Skill.Arg2)\" zweimal"
  },
  Event_129242_ChoiceDesc2 = {
    Text = "[Klängen lauschen]Für jeden Erwecker mit einem Wahnsinnswert von 50 oder mehr erhältst du 15 schwarze Siegel"
  },
  Event_129242_ChoiceDesc3 = {
    Text = "[Leave] Erhalte 2-mal ein Gebet aus 3 zur Auswahl"
  },
  Event_129242_Desc = {
    Text = "“Lieber John:\n    Kürzlich ist mir plötzlich aufgefallen, dass es schon mehrere Jahre her ist, seit du das letzte Mal für uns Klavier gespielt hast.\n    Ich bin jetzt 81 Jahre alt, und je älter ich werde, desto mehr wird mir der Wert der Erinnerungen aus meiner Jugend bewusst.\n    Wenn du diesen Brief erhältst, halte bitte das nächste Mal, wenn du durch Lentiniën kommst, vor meiner Wohnung an und spiele ein Stück für mich.“"
  },
  Event_129242_Name = {
    Text = "Sonata des Bedauerns"
  },
  Event_129243_ChoiceDesc1 = {
    Text = "[Platzhalter] Temporärer Text."
  },
  Event_129243_Name = {
    Text = "Sternenkapitel 3@"
  },
  Event_129244_ChoiceDesc1 = {
    Text = "[Sagen Sie, Sie haben keine Brieftasche] Graviere zweimal 1 von 3 Gebeten."
  },
  Event_129244_ChoiceDesc2 = {
    Text = "[Das Netz zerreißen] 1 zufällige Befehlskarte erhält zweimal ein Gebet: „(EnchantConfig.Arg1)\", infiziere zweimal „(Skill.Arg2)\""
  },
  Event_129244_Desc = {
    Text = "Das orange-gelbe Netz schwebt still in der Luft, seine Löcher sind spärlich und bei weitem nicht so kunstvoll wie die eines Verwandten, der an der Wand sitzt. \n Du kannst nicht anders, als deine Hand auszustrecken, das zerbrechliche Netz löst sich im Handumdrehen auf, das Lachen der Kinder ertönt in deinen Ohren. \n “Das goldene, das silberne, das gelbe, das rote, alle Geldbörsen gehören uns!“"
  },
  Event_129244_Name = {
    Text = "verirrtes Netzwerk"
  },
  Event_129245_ChoiceDesc1 = {
    Text = "[Choose emotion] Stellen Sie Arg1 Lebenspunkte wieder her"
  },
  Event_129245_ChoiceDesc2 = {
    Text = "[Vernunft bewahren] Eine zufällige Befehlskarte erhält das Gebet: [(EnchantConfig.Arg1)] zweimal"
  },
  Event_129245_ChoiceDesc3 = {
    Text = "[Refuse to choose] Erhalten Sie 25 das schwarze Siegel"
  },
  Event_129245_Desc = {
    Text = "\"Wähle, wähle.\"\nIn der rasenden Dunkelheit hallten unzählige Flüstern wider.\nDie Stimme ist sanft hypnotisch, scheint eine unendliche Magie zu tragen, die eine Art verrückte Phantasmagorie in dir entfacht.\nDein Gehirn sinkt in den Wahnsinn, windet sich vom Körper weg, während das Herz anscheinend ein gewisses Bewusstsein entwickelt hat und schreit und dich ruft.\n\"Wähle, wähle.\"\n\"Bewahre Rationalität oder Emotion; du musst eine Wahl treffen.\""
  },
  Event_129245_Name = {
    Text = "Der Preis der Menschlichkeit"
  },
  Event_129246_ChoiceDesc1 = {
    Text = "[Opfere die Opfergabe]Erhalte ein verfluchtes Relikt „(RelicConfig.Arg1)“, infiziere „(Skill.Arg2)“"
  },
  Event_129246_ChoiceDesc2 = {
    Text = "[Seil lösen] Wähle 1 von 3 Befehlskarten aus, um das Gebet zu gravieren: [(EnchantConfig.Arg1)] zweimal"
  },
  Event_129246_ChoiceDesc3 = {
    Text = "[Weiter voran]Erhalte 50 schwarze Siegel"
  },
  Event_129246_Desc = {
    Text = "Drei Aram wurden an der Spitze eines Podiums gefesselt.\nAuf ihren Körpern erschienen die tiefdunklen, rindenartigen Muster, die du schon bei einem Säugling gesehen hast, während sie in Stadtgebet murmeln"
  },
  Event_129246_Name = {
    Text = "drei Opfergaben"
  },
  Event_129247_ChoiceDesc1 = {
    Text = "[Platzhalter]Temporärer Text."
  },
  Event_129247_Name = {
    Text = "Sternen Kapitel 3@"
  },
  Event_129248_ChoiceDesc1 = {
    Text = "[Platzhalter] Temporärer Text."
  },
  Event_129248_Name = {
    Text = "Vergessenheit Kapitel 6@"
  },
  Event_129249_ChoiceDesc1 = {
    Text = "[Vorwärts kämpfen]entferne 1 Befehlskarte, erhalte Arg1 schwarzes Siegel"
  },
  Event_129249_ChoiceDesc2 = {
    Text = "[Faden durchtrennen]1 Befehlskarte kopieren, Infektion“(Skill.Arg1)“"
  },
  Event_129249_ChoiceDesc3 = {
    Text = "[Geduldig abwarten] Wähle 1 von 3 Befehlskarten aus, um das Gebet zu gravieren: [(EnchantConfig.Arg1)] zweimal"
  },
  Event_129249_Desc = {
    Text = "Den ganzen Weg wirst du vorwärts gedrängt, alle deine Entscheidungen werden von unsichtbaren Fäden kontrolliert. \n Du kämpfst darum, deine Hände zu bewegen, um alles, was dir wichtig ist, zu greifen. \n Das Schicksal der Welt hängt an deinen Fingerspitzen. \n Unzählige Fäden winden sich um dich und fesseln deinen ganzen Körper."
  },
  Event_129249_Name = {
    Text = "Manipulierte Hände"
  },
  Event_129250_ChoiceDesc1 = {
    Text = "[Nach dem Weg fragen] Wähle 1 von 3 Befehlskarten aus, um zweimal das Gebet zu gravieren: „(EnchantConfig.Arg1)\", infiziere zweimal „(Skill.Arg2)\""
  },
  Event_129250_ChoiceDesc2 = {
    Text = "[Es verlassen] Wähle 1 von 3 Befehlskarten aus, die das Gebet erhält: „(EnchantConfig.Arg1)\", infiziert „(Skill.Arg2)\""
  },
  Event_129250_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte 25 schwarze Siegel"
  },
  Event_129250_Desc = {
    Text = "Der Schatten steht unter der schmalen Straßenlaterne. \n “Darf ich bitte ein Feuer leihen, mein Herr?“ \n Du hast nicht die Gewohnheit, @2 zu benutzen, aber du hast nichts dagegen, ein wenig “Magie“ einzusetzen. \n Mit deiner Hilfe wird der entzündete @2 in den bodenlosen schwarzen Wirbel hineingestoßen. \n Nach einer Weile siehst du weißen Rauch aufsteigen. \n “Ah—“ \n Der Schatten gibt ein erfreutes Seufzen von sich."
  },
  Event_129250_Name = {
    Text = "Die Silhouette unter der Straßenlaterne"
  },
  Event_129251_ChoiceDesc1 = {
    Text = "[Platzhalter] Temporärer Text."
  },
  Event_129251_Name = {
    Text = "Vergessenheit Kapitel 1@"
  },
  Event_129252_ChoiceDesc1 = {
    Text = "[Platzhalter] Temporärer Text."
  },
  Event_129252_Name = {
    Text = "Vergessenheit Kapitel 8@"
  },
  Event_129253_ChoiceDesc1 = {
    Text = "[Platzhalter]Temporärer Text."
  },
  Event_129253_Name = {
    Text = "Vergessenheit Kapitel 3@"
  },
  Event_129254_ChoiceDesc1 = {
    Text = "[Die Illusion annehmen] 1 zufällige Befehlskarte erhält zweimal das Gebet: „(EnchantConfig.Arg1)\", infiziere zweimal „(Skill.Arg2)\""
  },
  Event_129254_ChoiceDesc2 = {
    Text = "[Trugbild leugnen] Wähle 1 von 3 Befehlskarten aus, um zweimal das Gebet zu gravieren: [(EnchantConfig.Arg1)]"
  },
  Event_129254_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte 25 schwarze Siegel"
  },
  Event_129254_Desc = {
    Text = "Unter der schweren, dunklen Eisenbrücke, am stillen Ufer mit Schilfrohr, fliegt plötzlich ein leuchtender Schmetterling heraus. \n Der Schmetterling landet sanft in deiner Handfläche, das schreckliche Geschrei verstummt und wird ersetzt durch das Dröhnen der Züge, die über die rostigen Stahlträger fahren, das Knistern der brennenden Kohle und das metallische Reiben der sich drehenden Achsen..."
  },
  Event_129254_Name = {
    Text = "Eisenbahnillusion"
  },
  Event_129255_ChoiceDesc1 = {
    Text = "[Die Ablehnung]Entferne 1 Befehlskarte, erhalte Arg1 das schwarze Siegel"
  },
  Event_129255_ChoiceDesc2 = {
    Text = "[Wahl des Gehorsams]Kopiere 1 Befehlskarte, infiziere “(Skill.Arg1)“"
  },
  Event_129255_ChoiceDesc3 = {
    Text = "[Umarmen wählen] Wähle 1 von 3 Befehlskarten aus, die das Gebet erhalten: [(EnchantConfig.Arg1)] zweimal"
  },
  Event_129255_Desc = {
    Text = "“Ich bin ein Vogel im Käfig, eingesperrt in einem Hof voller vieler Räume.“\nIm Dunkeln schwirren verschwommene Schatten umher, das sind die Besessenheiten der Verstorbenen.\n“Sie sagen, das ist eine Nervenheilanstalt, aber ich weiß, das ist ein spezieller Käfig der Menschheit, der die freien Vögel einsperrt, die sich nicht an die gesellschaftlichen Regeln halten wollen.“\n“Aber kann man einen Vogel noch einen Vogel nennen, wenn er nicht fliegen kann?“\nDie Besessenheiten nähern sich dir und bitten um Erlösung.\n“Bitte brecht mir die Flügel, ich habe es satt zu fliegen.“"
  },
  Event_129255_Name = {Text = "Hohlmann"},
  Event_129256_ChoiceDesc1 = {
    Text = "[Platzhalter]Temporärer Text."
  },
  Event_129256_Name = {
    Text = "Vergessenheit Kapitel 2@"
  },
  Event_129257_ChoiceDesc1 = {
    Text = "[Platzhalter]Temporärer Text."
  },
  Event_129257_Name = {
    Text = "Sterne Kapitel 2@"
  },
  Event_129258_ChoiceDesc1 = {
    Text = "[Schmetterling freilassen] Wähle 1 von 3 Befehlskarten aus, um zweimal das Gebet zu gravieren: „(EnchantConfig.Arg1)\", aber entwickle „(Skill.Arg2)\" zweimal"
  },
  Event_129258_ChoiceDesc2 = {
    Text = "[Werde ein Schmetterling]erhalte das silberne Relikt“(RelicConfig.Arg1)“、infiziere“(Skill.Arg2)“"
  },
  Event_129258_ChoiceDesc3 = {
    Text = "[Wieder schlucken]erhält 25 das schwarze Siegel"
  },
  Event_129258_Desc = {
    Text = "In dieser Nacht ist so viel passiert. \n Der ANG auf den Hafen, das Geisterschiff, die Seefahrer, Tulu, Murphy, Ramona ... alles dreht sich im Wirbel und wird zu dem Haferbrei, der um sieben Uhr im Misaq-Restaurant serviert wird. \n Du möchtest den Erwecker vor dir fragen, weißt aber nicht, wie du anfangen sollst, wie ein Kloß im Hals – oder besser gesagt, wie der Schmetterling im Magen."
  },
  Event_129258_Name = {
    Text = "Schmetterlingseffekt"
  },
  Event_129259_ChoiceDesc1 = {
    Text = "[Platzhalter] Temporärer Text."
  },
  Event_129259_Name = {
    Text = "Vergessenheit Kapitel 8@"
  },
  Event_129260_ChoiceDesc1 = {
    Text = "[Es verweilen lassen] Wähle 1 von 3 Befehlskarten aus, um zweimal das Gebet zu gravieren: „(EnchantConfig.Arg1)\", infiziere zweimal „(Skill.Arg2)\""
  },
  Event_129260_ChoiceDesc2 = {
    Text = "[Wegwinken]erhalte Silberrelikt „(RelicConfig.Arg1)“, infektiere „(Skill.Arg2)“"
  },
  Event_129260_ChoiceDesc3 = {
    Text = "[Begrüße die Biene]Erhalte 25 das schwarze Siegel"
  },
  Event_129260_Desc = {
    Text = "Ihr wandert durch das kalte Sanatorium, als ein schwarzer Schmetterling, der in dieser Jahreszeit nicht existieren sollte, heranflattert.\nSeine Flügel tragen schwarze Flüssigkeit, die beim Fliegen tropft und nach dem Trocknen abblättert.\nEr landet erschöpft auf deinem Finger"
  },
  Event_129260_Name = {
    Text = "Etwas, das nicht existieren sollte"
  },
  Event_129261_ChoiceDesc1 = {
    Text = "[Vergangenheit wiedererleben] Graviere zweimal 1 von 3 hochwertigen Gebeten."
  },
  Event_129261_ChoiceDesc2 = {
    Text = "[Spähen in die Zukunft]Erhalte goldene Kreation“(RelicConfig.Arg1)“、Infektion“(Skill.Arg2)“"
  },
  Event_129261_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte 50 schwarze Siegel"
  },
  Event_129261_Desc = {
    Text = "Nichts in der Welt kann statisch bleiben.\n Selbst das von der Göttin Mutter geformte Paradies ist keine Ausnahme.\n In einem flüchtigen Moment erhaschst du einen Blick auf etwas aus den Rissen von Zeit und Raum.\n Vergangenheit, Gegenwart und Zukunft verwickeln sich in diesem rissigen Spalt und ändern sich ständig.\n Wartend auf dein neugieriges Ausspähen"
  },
  Event_129261_Name = {
    Text = "Raum-Zeit-Riss"
  },
  Event_129262_ChoiceDesc1 = {
    Text = "[Platzhalter]Temporärer Text."
  },
  Event_129262_Name = {
    Text = "Vergessenheit Kapitel 7@"
  },
  Event_129263_ChoiceDesc1 = {
    Text = "[Ignorieren] Erhalte 2-mal ein Gebet aus 3 zur Auswahl"
  },
  Event_129263_ChoiceDesc2 = {
    Text = "[Berühren] Eine zufällige Befehlskarte erhält das Gebet: „(EnchantConfig.Arg1)\" zweimal, infiziert „(Skill.Arg2)\" zweimal"
  },
  Event_129263_Desc = {
    Text = "Ähnliche Sporen erregen deine Aufmerksamkeit.\nSie gleichen einer zarten, aus Fleisch gebildeten Qualle oder den Nervenfasern im tiefsten Gehirn, die Signale speichern.\n„Berühre mich.“, lockt es dich lautlos, „Ich werde dir eine grausame Erinnerung zeigen.“"
  },
  Event_129263_Name = {
    Text = "Tiefe Erinnerung"
  },
  Event_129264_ChoiceDesc1 = {
    Text = "[In Fantasien schwelgen] Wähle 1 von 3 Befehlskarten aus, die das Gebet erhalten: „(EnchantConfig.Arg1)\" zweimal, infiziert „(Skill.Arg2)\" zweimal"
  },
  Event_129264_ChoiceDesc2 = {
    Text = "[Verstand bewahren] Erhalte 15 Schwarze Male für jeden Erweckten Körper mit 50 oder mehr Aliemus"
  },
  Event_129264_ChoiceDesc3 = {
    Text = "[Zwangsweise gehen] Graviere zweimal 1 von 3 Gebeten."
  },
  Event_129264_Desc = {
    Text = "Vielleicht ist es der lange Kampf, der dich verwirrt hat, oder vielleicht hat einfach nur dein Gehirn deinen Körper verraten.\n Ein Gefühl der Schwerelosigkeit erscheint in deinem Geist.\n Im Handumdrehen verwandelt sich dein Verstand plötzlich in ein Kaleidoskop, brillant bunt, blitzend in allen Lichtnuancen.\n Unzählige Einsichten, Überlegungen und Fantasien strömen in dein Gehirn, besetzen jede Ecke der Spalten deines Geistes.\n Wenn das so weitergeht, wird dein Gehirn bald durch diese chaotischen Gedanken explodieren."
  },
  Event_129264_Name = {
    Text = "Kaleidoskop des Denkens"
  },
  Event_129265_ChoiceDesc1 = {
    Text = "[Platzhalter]Temporärer Text."
  },
  Event_129265_Name = {
    Text = "Vergessenheit Kapitel 5@"
  },
  Event_129266_ChoiceDesc1 = {
    Text = "[Platzhalter] Temporärer Text."
  },
  Event_129266_Name = {
    Text = "Vergessenheit Kapitel 4@"
  },
  Event_129267_ChoiceDesc1 = {
    Text = "[Listen] Graviere 1 von 3 hochwertigen Gebeten zweimal."
  },
  Event_129267_ChoiceDesc2 = {
    Text = "[Rufen]erhält goldenes Relikt „(RelicConfig.Arg1)“, infiziert „(Skill.Arg2)“"
  },
  Event_129267_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte 50 schwarze Siegel"
  },
  Event_129267_Desc = {
    Text = "Seit dem Unfall hast du keine Nachrichten mehr von deinem Partner erhalten. \n Unzählige Kontaktversuche wurden gestartet, doch sie verhallten wie ein Stein, der ins Meer geworfen wird. \n In dem Moment, als du schon die Hoffnung aufgegeben hattest, ertönte plötzlich ein Geräusch aus dem Kommunikationsgerät. \n Du öffnest den Koffer und hältst den Telefonhörer ans Ohr. \n „Hüter des Geheimnisses...“ \n In einem Dämmerzustand hörst du die Stimme, die du so sehr vermisst hast, wie ein ferner Widerhall, der durch Schichten von Leere dringt."
  },
  Event_129267_Name = {
    Text = "Sehnsuchtsvolle Echos"
  },
  Event_129268_ChoiceDesc1 = {
    Text = "[Platzhalter]Temporärer Text."
  },
  Event_129268_Name = {
    Text = "Vergessenheit Kapitel 1@"
  },
  Event_129269_ChoiceDesc1 = {
    Text = "[Platzhalter]Temporärer Text."
  },
  Event_129269_Name = {
    Text = "Sterne Kapitel 1@"
  },
  Event_129270_ChoiceDesc1 = {
    Text = "[Blick auf die Höllenhund-Quelle]Erhalte goldenes Relikt“(RelicConfig.Arg1)“，Infektion“(Skill.Arg2)“"
  },
  Event_129270_ChoiceDesc2 = {
    Text = "[Auf den Kampf konzentrieren] Wähle 1 von 3 Befehlskarten aus, um zweimal das Gebet zu gravieren: [(EnchantConfig.Arg1)]"
  },
  Event_129270_Desc = {
    Text = "Die Konturen des Höllenhundes verändern sich.\nSein Körper verbindet sich mit dem Spalt in der Wand und offenbart eine bizarre Illusion"
  },
  Event_129270_Name = {Text = "von Winkel"},
  Event_129271_ChoiceDesc1 = {
    Text = "[Platzhalter]Temporärer Text."
  },
  Event_129271_Name = {
    Text = "Vergessenheit Kapitel 2@"
  },
  Event_129272_ChoiceDesc1 = {
    Text = "[Füge das Papier zusammen] erhält goldenes Relikt „(RelicConfig.Arg1)“, Infektion „(Skill.Arg2)“"
  },
  Event_129272_ChoiceDesc2 = {
    Text = "[Read] Wähle 1 von 3 Befehlskarten aus, um zweimal das Gebet zu erhalten: [(EnchantConfig.Arg1)]"
  },
  Event_129272_ChoiceDesc3 = {
    Text = "[Es abwerfen]Erhalte 50 das schwarze Siegel"
  },
  Event_129272_Desc = {
    Text = "Ein vergilbtes Blatt Papier fiel aus dem Mantel der Laternenträger. \n Auf dem Papier war dicht mit seltsamen Texten beschriftet, einige ähnelten Hieroglyphen, andere waren merkwürdig nach oben geneigt, und einige Schriftzeichen überlappten sich sogar, sodass nur wenige Wörter mühsam zu erkennen waren. \n Der Titel lautet «@2 Geburt des Heiligen Sohnes»."
  },
  Event_129272_Name = {
    Text = "Geheimer Befehl · Unten"
  },
  Event_129273_ChoiceDesc1 = {
    Text = "[Platzhalter]Temporärer Text."
  },
  Event_129273_Name = {
    Text = "Vergessenheit Kapitel 2@"
  },
  Event_129274_ChoiceDesc1 = {
    Text = "[Platzhalter] Temporärer Text."
  },
  Event_129274_Name = {
    Text = "Sternenkapitel 2@"
  },
  Event_129275_ChoiceDesc1 = {
    Text = "[Auf den Kampf vorbereiten] Graviere das Gebet „(EnchantConfig.Arg1)\" zweimal auf 1 von 3 Befehlskarten, entwickle aber „(Skill.Arg2)\" zweimal."
  },
  Event_129275_ChoiceDesc2 = {
    Text = "[Versuch, einen Umweg zu nehmen] Erhalte 25 schwarze Siegel"
  },
  Event_129275_Desc = {
    Text = "In der tiefen See, wo das Sternenlicht herabfällt, haben die Seefahrer hunderte von Jahren lang geruht. \n Das unendliche Wasser hat ihren Wahnsinn, ihre Ausdauer und ihren frommen Glauben an die Gottheit bezeugt. \n Niemand kann das große Erscheinen der Gottheit aufhalten. \n Jeder, der im Weg steht, wird in der Wut der Seefahrer zu Asche."
  },
  Event_129275_Name = {
    Text = "Warten unter den Sternen"
  },
  Event_129276_ChoiceDesc1 = {
    Text = "[Mache ein paar Töne]erhalte das silberne Relikt“(RelicConfig.Arg1)“、infiziere“(Skill.Arg2)“"
  },
  Event_129276_ChoiceDesc2 = {
    Text = "[Den Deckel schließen] Graviere zweimal 1 von 3 Gebeten."
  },
  Event_129276_Desc = {
    Text = "Das Klavier an der Wand steht offen. Es hat vergilbte Tasten und rissige Kanten, die das Holz freilegen, aber jede Taste ist sehr sauber.\nEs ist die Quelle der Freude für so viele"
  },
  Event_129276_Name = {
    Text = "Kindheitsmelodie"
  },
  Event_129277_ChoiceDesc1 = {
    Text = "[Die Illusion annehmen] Wähle 1 von 3 Befehlskarten aus, um zweimal das Gebet zu gravieren: „(EnchantConfig.Arg1)\", infiziere zweimal „(Skill.Arg2)\""
  },
  Event_129277_ChoiceDesc2 = {
    Text = "[Illusion verleugnen]erhält Silberrelikt „(RelicConfig.Arg1)“, infiziert „(Skill.Arg2)“"
  },
  Event_129277_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte 25 schwarze Siegel"
  },
  Event_129277_Desc = {
    Text = "Unter der schweren, dunklen Eisenbrücke, am stillen Ufer mit Schilfrohr, fliegt plötzlich ein leuchtender Schmetterling heraus. \n Der Schmetterling landet sanft in deiner Handfläche, das schreckliche Geschrei verstummt und wird ersetzt durch den gleichmäßigen Gesang der Arbeiter, die Stahlträger transportieren, das Klopfen der Nagelköpfe und das klare metallische Geräusch der Nietverbindungen..."
  },
  Event_129277_Name = {
    Text = "Illusion der Stahlbrücke"
  },
  Event_129278_ChoiceDesc1 = {
    Text = "[Den Fluch zeigen] Wähle 1 von 3 Befehlskarten aus, um zweimal das Gebet zu gravieren: „(EnchantConfig.Arg1)\", infiziere zweimal „(Skill.Arg2)\""
  },
  Event_129278_ChoiceDesc2 = {
    Text = "[Raben ablehnen] Graviere 1 von 3 Gebeten zweimal."
  },
  Event_129278_ChoiceDesc3 = {
    Text = "[Ignorieren]"
  },
  Event_129278_Desc = {
    Text = "Ein schwarzer, kranker многоголовый Rabe fliegt aus dem schwarzen Umhang eines Tempellicht-Gläubigen und landet auf deiner Schulter.\n„Siehst du meinen Kopf? Wenn ich den Fluch koste, werde ich einen neuen Kopf wachsen lassen. Lass mich sehen, deinen Fluch!“"
  },
  Event_129278_Name = {Text = "Fluchrabe"},
  Event_129279_ChoiceDesc1 = {
    Text = "[Platzhalter]Temporärer Text."
  },
  Event_129279_Name = {
    Text = "Vergessenheit Kapitel 7@"
  },
  Event_129280_ChoiceDesc1 = {
    Text = "[Platzhalter]Temporärer Text."
  },
  Event_129280_Name = {
    Text = "Vergessenheit Kapitel 3@"
  },
  Event_129281_ChoiceDesc1 = {
    Text = "[Platzhalter]Temporärer Text."
  },
  Event_129281_Name = {
    Text = "Vergessenheit Kapitel 4@"
  },
  Event_129282_ChoiceDesc1 = {
    Text = "[Platzhalter] Temporärer Text."
  },
  Event_129282_Name = {
    Text = "Vergessenheit Kapitel 2@"
  },
  Event_129283_ChoiceDesc1 = {
    Text = "[Platzhalter]Temporärer Text."
  },
  Event_129283_Name = {
    Text = "Sternen Kapitel 2@"
  },
  Event_129900_ChoiceDesc1 = {
    Text = "[Beerdigen]Arg2 Lebenspunkte wiederherstellen [ExDesc1], 1 Befehlskarte zum Löschen wählen."
  },
  Event_129900_ChoiceDesc2 = {
    Text = "[Pray] Erhalte die Goldene Kreation „(RelicConfig.Arg1),\" aber entwickle „(Skill.Arg2)\"."
  },
  Event_129900_Desc = {
    Text = "Ein weißer Knochen, zur Hälfte in schwarzer Auflösungsschleim getaucht."
  },
  Event_129900_Name = {
    Text = "verblichene Knochen"
  },
  Event_130337_ChoiceDesc1 = {
    Text = "[Platz nehmen] Mische [Marionette] in dein Deck."
  },
  Event_130337_Desc = {
    Text = "In dem Moment, da du deinen Fuß auf die Stufen des Theaters setzt, kann dein Blick nie wieder von dieser Bühne losgerissen werden.\nDie Fäden des Schicksals ziehen unzählige Geschichten in ihren wirbelnden Strom — der Staub der Vergangenheit, das flackernde Licht der Gegenwart und die Nebel der Zukunft wogen unaufhörlich über die Bühne.\nDu hast deinen Ursprung und dein Ziel gleichermaßen vergessen. Jede Spur des „Selbst\" löst sich in den Schatten der schweren Vorhänge auf. In dieser Stunde bist du der stille Zuschauer im Parkett und der brennende Darsteller auf den Brettern.\nDein gesamtes Dasein verdichtet sich zu zwei einzigen Spuren: zu schauen und zu spielen."
  },
  Event_130337_Name = {
    Text = "Schicksalstheater"
  },
  Event_131264_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_131264_Desc = {
    Text = "Du wählst die Macht. Du wählst unerschütterliche Überzeugung und den Mut, immer weiter voranzuschreiten.\nDoch der Preis... Der eigentliche Zweck eines Preises ist es, bezahlt zu werden, nicht wahr?"
  },
  Event_131264_Name = {
    Text = "Alter Blick"
  },
  Event_131265_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_131265_Desc = {
    Text = "Die Qual in deinem Geist erduldend, greifst du fest nach den treibenden, zackigen Scherben. Durch deine grimmige Beharrlichkeit beginnen die Risse sich zu schließen.\nDu gehst, um dich zu erinnern, und du kämpfst, um dich zu erinnern. Du wirst keine Erinnerung entgleiten lassen."
  },
  Event_131265_Name = {
    Text = "Zersplitterte Erinnerungen"
  },
  Event_131266_ChoiceDesc1 = {
    Text = "[Erinnerung schützen] 1 von 3 Orisons mit Gravur versehen"
  },
  Event_131266_ChoiceDesc2 = {
    Text = "[Riss versiegeln] Das Orison „(EnchantConfig.Arg1)\" auf 1 von 3 Befehlskarten gravieren, aber „(Skill.Arg2)\" entwickeln"
  },
  Event_131266_Desc = {
    Text = "Du hast nie an deinen Erinnerungen gezweifelt. Sie waren warm, widerstandsfähig—dein sicherster Hafen und dein kostbarster Schatz.\nDoch nun, unter dem Einfluss des Spiralabgrunds, beginnen diese Erinnerungen zu brechen und zu splittern."
  },
  Event_131266_Name = {
    Text = "Zersplitterte Erinnerungen"
  },
  Event_131267_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_131267_Desc = {
    Text = "Ein Schwall spiritueller Energie durchflutet deinen Geist und näht die grauenvollen Risse zusammen. Mit jeder Faser deines Willens stellst du die Brüche wieder her.\nDu gehst, um dich zu erinnern, und du kämpfst, um dich zu erinnern. Du wirst keine Erinnerung entgleiten lassen."
  },
  Event_131267_Name = {
    Text = "Zersplitterte Erinnerungen"
  },
  Event_131268_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_131268_Desc = {
    Text = "„Ooh... Hahahha!!\"\nNiemand versteht deine Frage. Sie antworten mit Weinen und schrillem Gelächter."
  },
  Event_131268_Name = {Text = "Verlassene"},
  Event_131269_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_131269_Desc = {
    Text = "Du blickst in sie zurück. Fäden regen sich; dein sanfter Blick zieht die Erinnerungen heran und hüllt sie in eine Umarmung.\nDu beobachtest die Puppenspielerin des Schicksals schweigend. Wenn sie eine weitere Chance bekäme, welche Wahl würde sie treffen?"
  },
  Event_131269_Name = {
    Text = "Alter Blick"
  },
  Event_131270_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_131270_Desc = {
    Text = "„Ooh... Hahahha!!\"\nDie Schreie und das Gelächter ebben ab und lösen sich in der Luft auf. Keine Seele erhebt sich, um dir zu schaden — sie haben längst gelernt, mit dem Unsichtbarsein zu leben."
  },
  Event_131270_Name = {Text = "Verlassene"},
  Event_131271_ChoiceDesc1 = {
    Text = "[In die Erinnerung blicken] Die Goldene Kreation „(RelicConfig.Arg1)\" erhalten, aber „(Skill.Arg2)\" entwickeln"
  },
  Event_131271_ChoiceDesc2 = {
    Text = "[Erinnerung verwerfen] 2 zufällige Erweckte Körper erwecken, aber [(Skill.Arg1)] zweimal entwickeln"
  },
  Event_131271_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte 50 schwarze Siegel"
  },
  Event_131271_Desc = {
    Text = "Im Gefäß des Mädchens hallt das Geräusch zerspringenden Porzellans wider. Erinnerungen brechen aus ihren Behältern hervor und treiben zu deiner Seite.\nKindheitsgefährten, elterliche Geschenke, die reine Laune von Wolken und Vögeln, Ideale so unberührt wie der offene Himmel... Alle Erinnerungen öffnen ihre Augen und blicken dich schweigend an.\nSie fragen. Sie weinen. Sie warten."
  },
  Event_131271_Name = {
    Text = "Alter Blick"
  },
  Event_131272_ChoiceDesc1 = {
    Text = "[Fragen] Wähle 1 von 3 Befehlskarten aus, um das Gebet zu erhalten: „(EnchantConfig.Arg1)\", infiziere „(Skill.Arg2)\""
  },
  Event_131272_ChoiceDesc2 = {
    Text = "[Ignorieren] Wähle 1 von 3 Befehlskarten aus, um das Gebet zu erhalten: „(EnchantConfig.Arg1)\", infiziere „(Skill.Arg2)\""
  },
  Event_131272_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte 25 schwarze Siegel"
  },
  Event_131272_Desc = {
    Text = "Durchdringende Klagen kratzen an deinen Ohren; vor dir reißen gequälte Geister an ihren eigenen Gesichtern und Gestalten...\nWer sind sie? Gefangene des Spiralabgrunds? Verworfene Schicksale? Die Echos der Vergangenheit, vielleicht?"
  },
  Event_131272_Name = {Text = "Verlassene"},
  Event_133380_ChoiceDesc1 = {
    Text = "[Bestätigen]"
  },
  Event_133380_Desc = {
    Text = "Du hast dich in deinen Samtsitz niedergelassen, und die purpurroten Vorhänge teilen sich in leisem Flüstern.\nWerter Zuschauer, die Bühne wird all deinen Erwartungen gerecht werden.\nDie Hauptrolle dieses Stücks hat bereits ihre Position eingenommen."
  },
  Event_133380_Name = {
    Text = "Schicksalstheater"
  },
  Event_141995_ChoiceDesc1 = {
    Text = "[Einfacher Versuch] Lösche bis zu 5 beliebige Karten"
  },
  Event_141995_ChoiceDesc2 = {
    Text = "[Seiner Forschung überlassen] Lösche zufällig 5 Befehlskarten, erhalte das gesegnete Relikt [(RelicConfig.Arg1)]."
  },
  Event_141995_ChoiceDesc3 = {
    Text = "[Umgekehrtes Denken?] Wähle bis zu zwei Erwecker, generiere ein vollständiges Set ihrer Basis-Karten und lege es in das Deck"
  },
  Event_141995_Desc = {
    Text = "Du kommst auf einen Platz, auf dem viele Menschen eilig unterwegs sind – vielleicht lässt sich hier etwas Interessantes finden.\nDu klopfst an eine Tür, aus der gedämpftes gelbliches Licht dringt, und eine Person im Forscher-Outfit streckt den Kopf heraus. Du siehst viele unbekannte wissenschaftliche Geräte; er zieht dich herein und setzt dich hin, und behauptet, er sei ein „Evolutionsforscher\". Mit einem Gesicht voller Wahnsinn empfiehlt er dir nachdrücklich seine „wissenschaftliche Methode\".\n„Nur durch das Streichen des langweiligen Überschusses am Menschen liegt der wahre Weg der Evolution!\""
  },
  Event_141995_Name = {
    Text = "Evolutionsforscher"
  },
  Event_141996_ChoiceDesc1 = {
    Text = "[Angriffstraining] Füge allen Basisschlägen ohne Gebet ein zufälliges Gebet hinzu"
  },
  Event_141996_ChoiceDesc2 = {
    Text = "[Verteidigungstraining] Füge allen Basisverteidigungen ohne Gebet ein zufälliges Gebet hinzu"
  },
  Event_141996_ChoiceDesc3 = {
    Text = "[Rücksichtsloses Training] Füge zufälligen 15 Befehlskarten ein zufälliges Gebet hinzu, erhalte 5 zufällige Symptomkarten"
  },
  Event_141996_Desc = {
    Text = "Du kommst auf einen Platz, auf dem viele Menschen geschäftig umhereilen – vielleicht lässt sich hier etwas Interessantes finden.\nDas helle Klirren von Metall hallt über den freien Platz, einige Personen messen sich hier gegenseitig und verbessern ihre Kampfkünste. Ein junger Mann in alter Rüstung bemerkt dich, wirft dir ein Schwert zu und lädt dich ein, gemeinsam mit ihnen zu trainieren."
  },
  Event_141996_Name = {
    Text = "Trainingszeit"
  },
  Event_141997_ChoiceDesc1 = {
    Text = "[Auf Groß setzen] 50 % Chance, eine zufällige Gravur zu erhalten und erneut zu setzen; 50 % Chance, 75 Schwarzes Mal zu erhalten"
  },
  Event_141997_ChoiceDesc2 = {
    Text = "[Auf Klein setzen] 50 % Chance, eine zufällige Gravur zu erhalten und erneut zu setzen; 50 % Chance, 75 Schwarzes Mal zu erhalten"
  },
  Event_141997_Desc = {
    Text = "Der Kellner behält sein unverändertes Lächeln, hebt den Würfelbecher an, und ein klares Echo hallt durch den Raum, während die anderen Spieler ihre Wahl treffen. „Einsätze gelten\", sagt er, „bitte setzen —\""
  },
  Event_141997_Name = {
    Text = "Lärmiges Kasino"
  },
  Event_141998_ChoiceDesc1 = {
    Text = "[Ehrlich setzen] Lösche eine Befehlskarte"
  },
  Event_141998_ChoiceDesc2 = {
    Text = "[Mogeln versuchen] Lösche eine Symptomkarte"
  },
  Event_141998_ChoiceDesc3 = {
    Text = "[Verlassen]"
  },
  Event_141998_Desc = {
    Text = "Du gelangst an einen äußerst lebhaften Ort, auf jedem Gesicht strahlt Glück, und die wild blinkenden Buntlichter drängen die Nacht in die Enge. Überall sind Schilder zu sehen, auf denen steht: „Willkommen beim Karneval! Hier enden Träume nie, hier fällt der Vorhang der Freude nie!\"\nMitgerissen von der drängenden Menge wirst Du in ein prächtiges Gebäude gestoßen. Die Halle erstrahlt in Gold und Glanz, ein Stimmengewirr erfüllt den Raum, und in der Luft liegt der süßliche Duft von Wein. Ein Würfel rollt gurgelnd bis zu Deinen Füßen, und ein Kellner lächelt unterwürfig und erklärt Dir, das sei ein Zeichen des Glücks. Voller Neugier trittst Du einen Schritt vor — vielleicht kannst Du in diesem Spiel glänzen."
  },
  Event_141998_Name = {
    Text = "Lärmiges Kasino"
  },
  Event_141999_ChoiceDesc1 = {
    Text = "[Tauschhandel] 1 Relikt entfernen, 50% Wahrscheinlichkeit, 1 aus 3 Goldenen Kreationen zu erhalten, 50% Wahrscheinlichkeit, 25 Schwarze Male zu erhalten"
  },
  Event_141999_ChoiceDesc2 = {
    Text = "[Verlassen]"
  },
  Event_141999_Desc = {
    Text = "Du gelangst an einen äußerst lebhaften Ort, wo auf jedem Gesicht Glück erstrahlt und bunte Lichter, die wild aufblitzen, die Nacht vollständig verdrängen. Überall sind Schilder zu sehen, auf denen steht: „Willkommen im Karneval! Hier endet der Traum niemals, hier fällt der Vorhang der Freude nie!\"\nInmitten der Menge winkt Dir ein Händler zu, dessen Kleidung zerlumpt ist, der aber ein erstaunlich großes Bündel trägt. Er klopft auf das Paket neben sich, tritt näher und senkt die Stimme, um Dir eine Einladung zum Tauschhandel zu unterbreiten. Die alte Stofftasche schaukelt sanft mit seinen Worten und gibt dabei hin und wieder ein Knacken von sich."
  },
  Event_141999_Name = {
    Text = "Zerlumpter Händler"
  },
  Event_142000_ChoiceDesc1 = {
    Text = "[Wunsch versuchen] Verbrauche 50% der aktuellen LP, erhalte 2 zufällige Goldene Kreationen"
  },
  Event_142000_ChoiceDesc2 = {
    Text = "[Mit ganzem Herzen wünschen] Verbrauche 99% der aktuellen LP, erhalte das Zeitpendel [(RelicConfig.Arg2)]"
  },
  Event_142000_ChoiceDesc3 = {
    Text = "[Hand auf den Beckenboden tasten] Erhalte die Goldene Kreation [(RelicConfig.Arg1)]"
  },
  Event_142000_Desc = {
    Text = "Der Wind weht über das offene Land, ringsum herrscht Stille, nur das Rauschen der Bäume ist zu hören.\nPlötzlich hörst Du ein gurgelndes Fließen. Du folgst dem Geräusch, und ein schwerer, süßlich-blutiger Geruch trifft Dich zuerst. Schließlich erkennst Du die Quelle des Wassergeräuschs – ein Wunschbrunnen, gefüllt mit Rot, das Blut unzähliger Menschen surgt darin, als ob unter der Oberfläche etwas hervorbrechen wollte.\nEine Stimme erklingt tief in Deinem Herzen: „Opfere Dein Blut, und ich werde Dir Gunst gewähren.\""
  },
  Event_142000_Name = {Text = "Blutquelle"},
  Event_142001_ChoiceDesc1 = {
    Text = "[Einfache Verehrung] Wähle, 2 Relikte zu löschen, und erhalte das Sündige Schöpfung-Relikt [(RelicConfig.Arg1)]"
  },
  Event_142001_ChoiceDesc2 = {
    Text = "[Fromme Verehrung] Wähle, 4 Relikte zu löschen, und erhalte das Gesegnete Relikt [(RelicConfig.Arg1)]"
  },
  Event_142001_ChoiceDesc3 = {
    Text = "[Etwas Opfergabe stehlen – niemand wird es wissen] Goldene Kreation [(RelicConfig.Arg1)] erhalten"
  },
  Event_142001_Desc = {
    Text = "Der Wind weht über das offene Land, ringsum herrscht Stille, nur das Rauschen der Bäume ist zu hören.\nUnbemerkt stehst Du vor einem alten Altar, dessen gewaltige Statue Dich von oben herab mit ihrem Blick fixiert, als wolle sie Dir etwas aus den Händen nehmen. Du siehst, dass unterhalb des Altars verschwommene Worte eingraviert sind – „Geben und Nehmen im Gleichgewicht\"."
  },
  Event_142001_Name = {
    Text = "Altar des Gebens und Nehmens"
  },
  Event_142002_ChoiceDesc1 = {
    Text = "[Kostenlose Probe] Zufällig Arg2 Silberne Schöpfung(en) aufsteigen lassen"
  },
  Event_142002_ChoiceDesc2 = {
    Text = "[Normaler Service] Verbrauche Arg1 Schwarzes Mal: Zufällig Arg2 Silberne Schöpfung(en) aufsteigen lassen"
  },
  Event_142002_ChoiceDesc3 = {
    Text = "[Luxus-Service] Verbrauche Arg1 Schwarzes Mal: Zufällig Arg2 Silberne Schöpfung(en) aufsteigen lassen"
  },
  Event_142002_Desc = {
    Text = "Du kommst auf einen Platz, auf dem viele Menschen eilig unterwegs sind – vielleicht lässt sich hier etwas Interessantes finden.\nEin kleines Gebäude mit warmem Licht steht still in einer Ecke des Platzes. Es scheint ein gehobener Club zu sein, doch das dunkle Schild an der Wand trägt die auffällige Aufschrift: „Dieses Geschäft bedient ausschließlich Wesen, die keine Lebewesen sind.\""
  },
  Event_142002_Name = {
    Text = "Exklusiver Club"
  },
  Event_142003_ChoiceDesc1 = {
    Text = "[Einmal ziehen] Erhalte eine Symptomkarte"
  },
  Event_142003_ChoiceDesc2 = {
    Text = "[Verlassen] Erhalte 75 Schwarzes Mal"
  },
  Event_142003_Desc = {
    Text = "Du gelangst an einen äußerst lebhaften Ort, auf jedem Gesicht strahlt Glück, und die wild blinkenden Buntlichter drängen die Nacht in die Enge. Überall sind Schilder zu sehen, auf denen steht: „Willkommen beim Karneval! Hier enden Träume nie, hier fällt der Vorhang der Freude nie!\"\nDu bemerkst am Wegesrand einen Verlosungsstand, der von Menschen umringt ist. Alle Blicke sind auf den sorgfältig verhüllten Hauptgewinn gerichtet — der Händler preist seine Seltenheit lautstark an, und die Menschen drängen sich, um teilzunehmen."
  },
  Event_142003_Name = {
    Text = "Verlosungsherausforderung"
  },
  Event_142004_ChoiceDesc1 = {
    Text = "[Kurz ausleihen]"
  },
  Event_142004_ChoiceDesc2 = {
    Text = "[Verlassen]"
  },
  Event_142004_Desc = {
    Text = "Der Wind weht über das freie Land, ringsum herrscht Stille, nur das Rauschen der Bäume ist zu hören.\nPlötzlich erblickst du eine verfallene Strohhütte, in deren Mitte ein Amboss steht, daneben liegen viele verrostete Metallwaffen – dies scheint eine seit Langem verlassene Schmiede zu sein. Neben dem Amboss liegt eine ausführliche Gebrauchsanweisung, die dir erklärt, dass du Relikte hier umschmieden kannst."
  },
  Event_142004_Name = {Text = "Schmiede"},
  Event_142005_ChoiceDesc1 = {
    Text = "[Ehrlich setzen] Lösche eine Befehlskarte"
  },
  Event_142005_ChoiceDesc2 = {
    Text = "[Mogeln versuchen] Lösche eine Symptomkarte"
  },
  Event_142005_ChoiceDesc3 = {
    Text = "[Verlassen]"
  },
  Event_142005_Desc = {
    Text = "Der Jubel der Umstehenden verkündet Deinen Sieg. Im Stimmengewirr bist auch Du wie sie dem schillernden Traum verfallen, bei dem alles auf dem Spiel steht. Du blickst auf die Chips in Deiner Hand, als wären sie Deine treuesten Gefährten, die Dir Ruhm bringen. Flüstern dringt aus den Tiefen des Spieltisches, getränkt von einer zweideutigen Bitte: „Mach es noch einmal, gewinne noch einmal.\""
  },
  Event_142005_Name = {
    Text = "Lärmiges Kasino"
  },
  Event_142013_ChoiceDesc1 = {
    Text = "[Auf Groß setzen] 50 % Chance, ein zufälliges Silbernes Relikt zu erhalten und erneut zu setzen; 50 % Chance, 75 Schwarzes Mal zu erhalten und in einen Elite-Kampf einzutreten"
  },
  Event_142013_ChoiceDesc2 = {
    Text = "[Auf Klein setzen] 50 % Chance, ein zufälliges Silbernes Relikt zu erhalten und erneut zu setzen; 50 % Chance, 75 Schwarzes Mal zu erhalten und in einen Elite-Kampf einzutreten"
  },
  Event_142013_Desc = {
    Text = "Der Kellner behält sein unverändertes Lächeln, hebt den Würfelbecher an, und ein klares Echo hallt durch den Raum, während die anderen Spieler ihre Wahl treffen. „Einsätze gelten\", sagt er, „bitte setzen —\""
  },
  Event_142013_Name = {
    Text = "Lärmiges Kasino"
  },
  Event_142073_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_142073_Desc = {
    Text = "Der Kellner hebt den Würfelbecher an — für wenige Sekunden scheint die Luft in Stagnierung zu verharren. In dem Moment, als die Antwort enthüllt wird, hörst Du Jubel und Klagen durcheinander. Das Glück hat Dir keinen Segen geschenkt; die Würfel, die still auf dem Tisch liegen, zeigen das Gegenteil von dem, worauf Du gesetzt hast. Du wirfst einen letzten Blick in die Runde und schaust auf die wahnsinnigen Spieler. Es ist Zeit zu gehen."
  },
  Event_142073_Name = {
    Text = "Lärmiges Kasino"
  },
  Event_142074_ChoiceDesc1 = {
    Text = "[In den Kampf Eingeben]"
  },
  Event_142074_Desc = {
    Text = "Während Du voller Erwartung auf den Spieltisch starrst, wird Deine Hand plötzlich fest umklammert. Du blickst auf — der Boss des Kasinos schaut auf Dich herab und ist dabei, alle regelwidrigen Gäste hinauszubefördern. Im Nu richten sich alle Blicke auf Dich allein: erstaunte, feindselige, schadenfreudige... Du erkennst: Vielleicht kann jemand viele Male mogeln, aber Solange er nur einmal entdeckt wird, ist sein völliger Ruin besiegelt."
  },
  Event_142074_Name = {
    Text = "Lärmiges Kasino"
  },
  Event_142103_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_142103_Desc = {
    Text = "Du entkommst dem Kasino mit körperlichem Einsatz. Das Stimmengewirr der Menge lässt Du hinter Dir und beschleunigst Deine Schritte — was das Chaos angeht, das Du hinterlässt, wird sich schon jemand darum kümmern."
  },
  Event_142103_Name = {
    Text = "Lärmiges Kasino"
  },
  Event_142105_ChoiceDesc1 = {
    Text = "[Nochmals ziehen] Eine Symptomkarte erhalten"
  },
  Event_142105_ChoiceDesc2 = {
    Text = "[Verlassen] Erhalte 75 Schwarzes Mal"
  },
  Event_142105_Desc = {
    Text = "Du versuchst einmal zu ziehen — nichts passiert. Doch auf der Rückseite der Karte steht: „Beim nächsten Mal wird es einfacher\"\n... Soll es noch einmal versucht werden?"
  },
  Event_142105_Name = {
    Text = "Verlosungsherausforderung"
  },
  Event_142106_ChoiceDesc1 = {
    Text = "[Nochmals ziehen] Eine Symptomkarte erhalten"
  },
  Event_142106_ChoiceDesc2 = {
    Text = "[Verlassen] Erhalte 75 Schwarzes Mal"
  },
  Event_142106_Desc = {
    Text = "Du versuchst einmal zu ziehen — nichts passiert. Doch auf der Rückseite der Karte steht: „Beim nächsten Mal wird es einfacher\"\n... Soll es noch einmal versucht werden?"
  },
  Event_142106_Name = {
    Text = "Verlosungsherausforderung"
  },
  Event_142107_ChoiceDesc1 = {
    Text = "[Nochmals ziehen] Eine Symptomkarte erhalten"
  },
  Event_142107_Desc = {
    Text = "Du versuchst einmal zu ziehen — nichts passiert. Doch auf der Rückseite der Karte steht: „Beim nächsten Mal wird es einfacher\"\n... Soll es noch einmal versucht werden?"
  },
  Event_142107_Name = {
    Text = "Verlosungsherausforderung"
  },
  Event_142108_ChoiceDesc1 = {
    Text = "[Nochmals ziehen] Eine Symptomkarte erhalten"
  },
  Event_142108_ChoiceDesc2 = {
    Text = "[Verlassen] Erhalte 75 Schwarzes Mal"
  },
  Event_142108_Desc = {
    Text = "Du versuchst einmal zu ziehen — nichts passiert. Doch auf der Rückseite der Karte steht: „Beim nächsten Mal wird es einfacher\"\n... Soll es noch einmal versucht werden?"
  },
  Event_142108_Name = {
    Text = "Verlosungsherausforderung"
  },
  Event_142109_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_142109_Desc = {
    Text = "Du lauschst dem Herzschlag und deckst das Losticket auf – goldene, strahlende Buchstaben springen Dir ins Auge. Der Händler schüttelt aufgeregt die Glocke, und alle Passanten werfen Dir neidische Blicke zu.\n„Der Hauptgewinn wurde gezogen!\""
  },
  Event_142109_Name = {
    Text = "Verlosungsherausforderung"
  },
  Event_142110_ChoiceDesc1 = {
    Text = "[Nochmals ziehen] Eine Symptomkarte erhalten"
  },
  Event_142110_ChoiceDesc2 = {
    Text = "[Verlassen] Erhalte 75 Schwarzes Mal"
  },
  Event_142110_Desc = {
    Text = "Du versuchst einmal zu ziehen — nichts passiert. Doch auf der Rückseite der Karte steht: „Beim nächsten Mal wird es einfacher\"\n... Soll es noch einmal versucht werden?"
  },
  Event_142110_Name = {
    Text = "Verlosungsherausforderung"
  },
  Event_142118_ChoiceDesc1 = {
    Text = "[Tauschhandel] 1 Relikt entfernen, 25% Wahrscheinlichkeit, 1 aus 3 Zeitpendeln zu erhalten, 50% Wahrscheinlichkeit, 2 zufällige Goldene Kreationen zu erhalten, 25% Wahrscheinlichkeit, 25 Schwarze Male zu erhalten"
  },
  Event_142118_ChoiceDesc2 = {
    Text = "[Verlassen]"
  },
  Event_142118_Desc = {
    Text = "Der Händler nimmt die von Dir gereichten Gegenstände entgegen und dreht sie im Mondlicht hin und her, die Augen weit aufgerissen. Du wartest lange, bis er schließlich ein Grinsen aufsetzt und eine rostige Eisenbox aus dem Paket zieht. „Komm, öffne sie – das ist die derzeit beliebteste Überraschungsbox.\"\nDu öffnest sie, doch Du entdeckst Innen nur einige wenige enttäuschende Schwarze Imprägnierungen. Der Händler reibt sich die Hände und blickt Dich mit schuldbewusstem Blick an, dass Du es noch einmal versuchen kannst."
  },
  Event_142118_Name = {
    Text = "Zerlumpter Händler"
  },
  Event_142119_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_142119_Desc = {
    Text = "Der Händler nimmt die von Dir gereichten Gegenstände entgegen und dreht sie im Mondlicht hin und her, die Augen weit aufgerissen. Du wartest lange, bis er schließlich ein Grinsen aufsetzt und eine rostige Eisenbox aus dem Paket zieht. „Komm, öffne sie – das ist die derzeit beliebteste Überraschungsbox.\"\nDu öffnest sie, und darin liegt irgendetwas."
  },
  Event_142119_Name = {
    Text = "Zerlumpter Händler"
  },
  Event_142120_ChoiceDesc1 = {
    Text = "[Tauschhandel] 1 Goldene Kreation entfernen, 50% Wahrscheinlichkeit, 1 aus 3 Zeitpendeln zu erhalten, 50% Wahrscheinlichkeit, 1 aus 3 Gesegneten Relikten zu erhalten"
  },
  Event_142120_ChoiceDesc2 = {
    Text = "[Verlassen]"
  },
  Event_142120_Desc = {
    Text = "Du öffnest die Überraschungsbox erneut, doch Du findest noch immer nicht den gewünschten Gegenstand. Der Händler beeilt sich zu lächeln und zieht eine weitere Eisenbox hervor, die er Dir mit beiden Händen entgegenhält.\n„Sei nicht böse, Kunde! Ich schwöre, diesmal ist wirklich etwas Großartiges drin...\" sagt er, während er heimlich eine Hand herausstreckt und sie Dir offen entgegenhält: „Natürlich muss ein Schatz mit einem Schatz bezahlt werden.\""
  },
  Event_142120_Name = {
    Text = "Zerlumpter Händler"
  },
  Event_142138_ChoiceDesc1 = {
    Text = "[Kurz ausleihen]"
  },
  Event_142138_ChoiceDesc2 = {
    Text = "[Verlassen]"
  },
  Event_142138_Desc = {
    Text = "Du hast diese Werkzeuge erfolgreich benutzt – obwohl sie etwas beschädigt wurden, scheinen sie noch verwendbar zu sein."
  },
  Event_142138_Name = {Text = "Schmiede"},
  Event_142139_ChoiceDesc1 = {
    Text = "[Zerschmelzen] Wähle 1 Goldene Kreation zum Löschen aus, erhalte 2 Silberne Schöpfungen und 50 Schwarze Male"
  },
  Event_142139_ChoiceDesc2 = {
    Text = "[Härten] Wähle 2 Relikte zum Löschen aus, erhalte die Goldene Kreation [(RelicConfig.Arg1)]."
  },
  Event_142139_ChoiceDesc3 = {
    Text = "[Fortgeschrittenes Härten] Wähle 2 Goldene Kreationen zum Löschen aus, erhalte das Zeitpendel [(RelicConfig.Arg1)]."
  },
  Event_142139_Desc = {
    Text = "Du greifst nach dem Hammer daneben und hast vor, ..."
  },
  Event_142139_Name = {Text = "Schmiede"},
  Event_142140_ChoiceDesc1 = {
    Text = "[Kurz ausleihen]"
  },
  Event_142140_ChoiceDesc2 = {
    Text = "[Verlassen]"
  },
  Event_142140_Desc = {
    Text = "Du hast diese Werkzeuge erfolgreich benutzt – obwohl sie etwas beschädigt wurden, scheinen sie noch verwendbar zu sein."
  },
  Event_142140_Name = {Text = "Schmiede"},
  Event_142141_ChoiceDesc1 = {
    Text = "[Zerschmelzen] Wähle 1 Goldene Kreation zum Löschen aus, erhalte 2 Silberne Schöpfungen und 50 Schwarze Male"
  },
  Event_142141_ChoiceDesc2 = {
    Text = "[Härten] Wähle 2 Relikte zum Löschen aus, erhalte die Goldene Kreation [(RelicConfig.Arg1)]."
  },
  Event_142141_ChoiceDesc3 = {
    Text = "[Fortgeschrittenes Härten] Wähle 2 Goldene Kreationen zum Löschen aus, erhalte das Zeitpendel [(RelicConfig.Arg1)]."
  },
  Event_142141_Desc = {
    Text = "Du greifst nach dem Hammer daneben und hast vor, ..."
  },
  Event_142141_Name = {Text = "Schmiede"},
  Event_142142_ChoiceDesc1 = {
    Text = "[Zerschmelzen] Wähle 1 Goldene Kreation zum Löschen aus, erhalte 2 Silberne Schöpfungen und 50 Schwarze Male"
  },
  Event_142142_ChoiceDesc2 = {
    Text = "[Härten] Wähle 2 Relikte zum Löschen aus, erhalte die Goldene Kreation [(RelicConfig.Arg1)]."
  },
  Event_142142_ChoiceDesc3 = {
    Text = "[Fortgeschrittenes Härten] Wähle 2 Goldene Kreationen zum Löschen aus, erhalte das Zeitpendel [(RelicConfig.Arg1)]."
  },
  Event_142142_Desc = {
    Text = "Du greifst nach dem Hammer daneben und hast vor, ..."
  },
  Event_142142_Name = {Text = "Schmiede"},
  Event_142167_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_142167_Desc = {
    Text = "Nach drei Verwendungen ist der Amboss vollständig eingebeult und der Hammer stark abgenutzt – es sieht aus, als könnte er nicht mehr benutzt werden."
  },
  Event_142167_Name = {Text = "Schmiede"},
  Event_142235_ChoiceDesc1 = {
    Text = "[Ich werde voranschreiten] Erhalte „Makellosigkeit“ – alle Befehlskarten erhalten 20 permanente Stapelungen Verstärkung."
  },
  Event_142235_ChoiceDesc2 = {
    Text = "[Ich werde nicht umkehren] Erhalte „Sublimation“ – das Keyflare und das Wutlimit werden permanent um 20% gesenkt."
  },
  Event_142235_Desc = {
    Text = "Deine Augen werden plötzlich von einem Schleier bedeckt, die Welt beginnt sich zu trüben, und in einem Moment der Benommenheit erklingt eine Stimme in deinem Inneren:\n„Willst du noch weitergehen?\""
  },
  Event_142235_Name = {
    Text = "Das Ende naht"
  },
  Event_142925_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_142925_Desc = {
    Text = "Die Mitarbeiter des Clubs nahmen die Bezahlung entgegen und leisteten dir den Basisservice. Sie brachten die von dir übergebenen Gegenstände in eine dunkle Kammer. Die Wartezeit war nicht lang – als er wieder erschien, lagen die Dinge bereits auf dem Tablett, und sie schienen sich von vorher leicht verändert zu haben."
  },
  Event_142925_Name = {
    Text = "Exklusiver Club"
  },
  Event_142926_ChoiceDesc1 = {
    Text = "[Ein Goldenes Relikt löschen] (Goldenes Relikt erforderlich)"
  },
  Event_142926_ChoiceDesc2 = {
    Text = "[Verstärkte (Forged) Relikte zur Auswahl verfügbar]"
  },
  Event_142926_ChoiceDesc3 = {
    Text = "[Verlassen]"
  },
  Event_142926_Desc = {
    Text = "Test „Relikt-Anzahl\" „Relikt-Auswahlliste\""
  },
  Event_142927_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_142927_Desc = {
    Text = "Die Mitarbeiter des Clubs nahmen die Bezahlung entgegen und leisteten dir den Luxus-Service. Sie legten deine Gegenstände feierlich in eine Schatulle und trugen sie in eine dunkle Kammer. Du wartete lange, bis er erneut erschien und dir die Gegenstände mit beiden Händen überreichte – seine Miene so ruhig wie immer."
  },
  Event_142927_Name = {
    Text = "Exklusiver Club"
  },
  Event_142928_ChoiceDesc1 = {
    Text = "[Bis zu 2 Erwecker auswählen und mit Aliemus füllen]"
  },
  Event_142928_ChoiceDesc2 = {
    Text = "[Es müssen 2 Erwecker mit vollem Aliemus gewählt werden]"
  },
  Event_142928_ChoiceDesc3 = {
    Text = "[Verlassen]"
  },
  Event_142928_Desc = {
    Text = "Test „Erwecker nach Bedingung auswählen\""
  },
  Event_142929_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_142929_Desc = {
    Text = "Der Forscher kreiste immer wieder um dich herum, betrachtete dich eingehend und begann dann erst zu arbeiten – ohne dich um deine Meinung zu fragen. Nach einer Weile, als du das seltsame Labor verlassen wolltest, wusstest du, dass du tatsächlich vieles verloren hattest, doch er klatschte in die Hände und gratulierte dir: „Das ist das wahre Wesen der Evolution!\""
  },
  Event_142929_Name = {
    Text = "Evolutionsforscher"
  },
  Event_142930_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_142930_Desc = {
    Text = "Du streckst die Hand aus und tastest in das blutrote Beckenwasser, und ertastest etwas Nützliches."
  },
  Event_142930_Name = {Text = "Blutquelle"},
  Event_142931_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_142931_Desc = {
    Text = "Die Stimme verhallt, dein Herz ist voller Entschlossenheit und du spürst, wie Stärke in dir erscheint."
  },
  Event_142931_Name = {
    Text = "Das Ende naht"
  },
  Event_142932_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_142932_Desc = {
    Text = "Die Stimme verhallt, dein Herz ist voller Entschlossenheit und dein Geist wird klarer."
  },
  Event_142932_Name = {
    Text = "Das Ende naht"
  },
  Event_142933_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_142933_Desc = {
    Text = "Du nimmst Dir etwas aus dem zu einem kleinen Berg aufgehäuften Opfergaben und schleichst Dich dann schnell davon. Als Du gehst, scheinen sich die Augen der Statue einen Moment zu bewegen."
  },
  Event_142933_Name = {
    Text = "Altar des Gebens und Nehmens"
  },
  Event_142934_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_142934_Desc = {
    Text = "Du hast dein Training auf die Defensive ausgerichtet. Angesichts der Hinterhalte deines Gegners hast du dich ständig mit deiner Waffe gewehrt und dabei deine Verteidigungsfähigkeit und Reaktionsschnelligkeit verbessert."
  },
  Event_142934_Name = {
    Text = "Trainingszeit"
  },
  Event_142935_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_142935_Desc = {
    Text = "Der Forscher zog Handschuhe an, nahm einige seltsam geformte Geräte aus dem Schrank und fuchtelte damit vor dir herum. Du weißt nicht, was er genau getan hat, aber du fühlst dich tatsächlich etwas leichter."
  },
  Event_142935_Name = {
    Text = "Evolutionsforscher"
  },
  Event_142936_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_142936_Desc = {
    Text = "Du hast dich für keine bestimmte Richtung entschieden, sondern dich ohne Rücksicht auf deine körperlichen Grenzen mit anderen geübt, bis alle erschöpft waren. Du weißt, dass du dich erheblich verbessert hast, aber du hast auch einen Preis dafür bezahlt."
  },
  Event_142936_Name = {
    Text = "Trainingszeit"
  },
  Event_142937_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_142937_Desc = {
    Text = "Du nimmst wahllos einige Dinge aus Deinem Beutel und bringst sie als Opfergabe dar, woraufhin Du eine gleichwertige Belohnung erhältst."
  },
  Event_142937_Name = {
    Text = "Altar des Gebens und Nehmens"
  },
  Event_142938_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_142938_Desc = {
    Text = "Du bringst einige wertvolle Opfergaben dar und erhältst eine gleichwertige Belohnung."
  },
  Event_142938_Name = {
    Text = "Altar des Gebens und Nehmens"
  },
  Event_142939_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_142939_Desc = {
    Text = "Du hegst große Zweifel an seiner Forschungsmethode, und nach einer Debatte willigt er ein, dich die Geräte selbst benutzen zu lassen, um auf andere Weise nach „Evolution\" zu streben.\nMit denselben Werkzeugen hast du durch Zufall bewirkt, dass das, was eigentlich „gestrichen\" werden sollte, sich massenhaft „vermehrt\" hat. Beim Verlassen hörtest du das Jammern des Forschers."
  },
  Event_142939_Name = {
    Text = "Evolutionsforscher"
  },
  Event_142940_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_142940_Desc = {
    Text = "Die Mitarbeiter des Clubs haben dir einen kostenlosen Service geleistet. Sie nahmen die von dir übergebenen Gegenstände in eine dunkle Kammer, kehrten kurz darauf zurück und legten die Dinge wortlos wieder in deine Hände."
  },
  Event_142940_Name = {
    Text = "Exklusiver Club"
  },
  Event_142941_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_142941_Desc = {
    Text = "Du hast dem Wunschbecken eine große Menge Blut geopfert, und eine kostbare Gabe ist aus dem Becken aufgetaucht."
  },
  Event_142941_Name = {Text = "Blutquelle"},
  Event_142942_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_142942_Desc = {
    Text = "Du hast dein Training auf die Offensive ausgerichtet und im Aufeinanderprallen von Stahl deine Schlagtechnik und Geschwindigkeit verbessert."
  },
  Event_142942_Name = {
    Text = "Trainingszeit"
  },
  Event_142943_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_142943_Desc = {
    Text = "Du hast dem Wunschbecken ein wenig Blut geopfert, und eine Gabe ist aus dem Becken aufgetaucht."
  },
  Event_142943_Name = {Text = "Blutquelle"},
  Event_142944_ChoiceDesc1 = {
    Text = "[Relikt zum Aufstieg auswählen]"
  },
  Event_142944_ChoiceDesc2 = {
    Text = "[Zufälliges Relikt aufsteigen lassen]"
  },
  Event_142944_ChoiceDesc3 = {
    Text = "[Verlassen (Test)]"
  },
  Event_142944_Desc = {
    Text = "Test „Relikt-Aufstieg-Funktion\", Relikt fügt selbst hinzu"
  },
  Event_146258_ChoiceDesc1 = {
    Text = "[Ihn anrufen] Fluchkreatur „(RelicConfig.Arg1)“ erhalten, „(Skill.Arg2)“ infizieren"
  },
  Event_146258_ChoiceDesc2 = {
    Text = "[Auf sie reagieren] Wähle 1 von 3 Befehlskarten aus, um das Gebet zu erhalten: [(EnchantConfig.Arg1)]"
  },
  Event_146258_ChoiceDesc3 = {
    Text = "[Ignorieren]du erhälst 50 Schwarze Imprägnierung"
  },
  Event_146258_Desc = {
    Text = "Am Altar sind Juliettes weiße Gewänder in dichten Rauch gehüllt, die Asche des Weihrauchs vermischt mit einem süßlichen, kupfrigen Duft.\n\n„Die Lichtträgerin erbarmt sich der sündigen Kinder dieser Welt...“ ihre Stimme ist nicht laut, doch sie durchdringt klar das flüsternde Gebet des Tempels, „...wie eine liebende Mutter sich des Säuglings in ihren Armen erbarmt.“\n\nIm Kerzenlicht glänzen die Opfergaben auf dem Altar fettig. Blaue Rauchfäden winden sich an ihren Konturen empor und verschwimmen die Gesichter der Menge darunter.\n\nDurch diesen schwankenden Dunst blickst du zu Pollux hinüber. Er steht inmitten der Gemeinde, den Blick gesenkt, sein Gesicht trägt eine perfekt einstudierte, pflichtbewusste Frömmigkeit."
  },
  Event_146258_Name = {
    Text = "Ein alter Traum: III"
  },
  Event_146259_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_146259_Desc = {
    Text = "Achte nicht darauf. Es ist nur das Heulen des Schneewinds, das Seufzen des gefrorenen Sees oder die Klage der Gipfel.\n\nEs sind die trockenen, toten Äste, die flüstern, wenn sie aneinanderreiben.\n\nSie murmeln in ewiger, melancholischer Trauer für jeden Pionier, der je in den eisigen Spalten gestorben ist."
  },
  Event_146259_Name = {
    Text = "Arie des gefrorenen Sees"
  },
  Event_146260_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_146260_Desc = {
    Text = "Wenn Gerechtigkeit absolute Gleichheit bedeutet, teilt Helot: Kette dann dein Recht, einen Wunsch zu äußern?\n\nWenn ja, solltest du es einfach auf sich beruhen lassen, dass sie dir zuvorgekommen ist und die Konkurrenz vertrieben hat?\n\n„Hör auf zu träumen und kletter weiter!\" Caraboos Stimme bellt in deinem Ohr."
  },
  Event_146260_Name = {
    Text = "Absurde Fairness"
  },
  Event_146261_ChoiceDesc1 = {
    Text = "[Der Berg fürchtet den Hunger]"
  },
  Event_146261_ChoiceDesc2 = {
    Text = "[Der Berg fürchtet den Verlust]"
  },
  Event_146261_ChoiceDesc3 = {
    Text = "[Der Berg fürchtet den Tod]"
  },
  Event_146261_Desc = {
    Text = "Du gehst auf dem Körper des Berges. Sein Zittern verrät seine Geheimnisse. Was der Berg begehrt, bestimmt, was der Berg fürchtet."
  },
  Event_146261_Name = {
    Text = "Geheimnis des Berges"
  },
  Event_146262_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_146262_Desc = {
    Text = "Du verlierst dich in der Seide ihres Fells, ein williger Gefangener deiner eigenen Wünsche. Die Katze zu streicheln fühlt sich so befriedigend an. Was spielt es für eine Rolle, was unter der Haut liegt? Ist es wirklich von Bedeutung?"
  },
  Event_146262_Name = {
    Text = "Die kriechende schwarze Katze"
  },
  Event_146263_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_146263_Desc = {
    Text = "Du nimmst schweigend das Ende des Fadens und bindest ihn um dein Handgelenk.\n\nPollux tut dasselbe. Bald verbindet eine dünne rote Linie euch beide miteinander.\n\nEs schränkt ein, wie viel Boden ihr abdecken könnt, aber ihr wart doch immer dazu bestimmt, gemeinsam zu leben und zu sterben, oder?\n\nDu wirst das Schicksal den Rest regeln lassen."
  },
  Event_146263_Name = {
    Text = "Ein alter Traum: I"
  },
  Event_146264_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_146264_Desc = {
    Text = "„Ich weiß, dass es schwer ist, Kind. Natürlich weiß ich das. Aber die Welt war für keinen von uns jemals ein sanfter Ort.“\n\n„Eines Tages wird der Schmetterling deiner Handfläche entkommen, und er wird für immer fort sein.“"
  },
  Event_146264_Name = {
    Text = "Illusion, nicht Wahrheit"
  },
  Event_146265_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_146265_Desc = {
    Text = "Wilhelm blickt auf, sein Blick streift Sie, bevor er auf den schneebedeckten Kämmen in der Ferne verweilt.\n\n„Sie haben sich für nichts zu entschuldigen,\" sagt er leise, aber bestimmt. „Manche Fragen gehören mir allein, und nur ich kann sie beantworten.\"\n\n„Aber danke. Für Ihre scharfen Augen."
  },
  Event_146265_Name = {
    Text = "Sanftes Untertauchen"
  },
  Event_146266_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_146266_Desc = {
    Text = "Wilhelms Augen flackern.\n\nDu öffnest den Mund, entscheidest dich aber, nichts zu sagen. Schweigen ist hier die bessere Wahl. Es besteht noch immer ein seltenes, stilles Einverständnis zwischen euch beiden; es besteht kein Grund, es zu zerstören."
  },
  Event_146266_Name = {
    Text = "Sanftes Untertauchen"
  },
  Event_146267_ChoiceDesc1 = {
    Text = "[Verlassen]Erhalte Silberrelikt“(RelicConfig.Arg1)“"
  },
  Event_146267_Desc = {
    Text = "„Gib es zurück, gib es zurück! Das ist meine Macht!“\n\nDer Berg weint; der Berg klagt. Er kann es nicht ertragen, alles zu verlieren, was er einst besaß."
  },
  Event_146267_Name = {
    Text = "Geheimnis des Berges"
  },
  Event_146268_ChoiceDesc1 = {
    Text = "[Weiterlaufen] Graviere das Gebet „(EnchantConfig.Arg1)“ auf 1 von 3 Befehlskarten ein, aber entwickle „(Skill.Arg2)“"
  },
  Event_146268_ChoiceDesc2 = {
    Text = "[Abwarten] Erhalte 1 von 3 Gebeten"
  },
  Event_146268_ChoiceDesc3 = {
    Text = "[Langsam verschwinden]"
  },
  Event_146268_Desc = {
    Text = "„Vorsicht, Castor. Die Krähe beobachtet uns.“\n\nDu eilst vorwärts, Pollux auf dem Rücken. Seine panischen Augen schweifen durch jeden dunklen Winkel und finden nichts.\n\n„Über uns!“\n\nEin plötzlicher Schauer durchfährt dich. Du schaust nach oben.\n\nIn dem Schatten der Dachtraufe kauert lautlos eine Krähe. Groteske Augen bedecken ihren Körper, starren in alle Richtungen und richten nun ihren Blick vollständig auf euch beide."
  },
  Event_146268_Name = {
    Text = "Ein alter Traum: II"
  },
  Event_146269_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_146269_Desc = {
    Text = "Du erinnerst dich an die Warnungen aus deiner Ausbildung: Verlasse dich niemals vollständig auf das Sicherungsseil.\n\nDu stößt dich von der senkrechten Felswand ab und schaffst es verzweifelt, deinen Abstieg zu stabilisieren. Doch etwas entgleitet deinem Rucksack und stürzt die Felswand hinunter, bis es zu einem winzigen, unsichtbaren Punkt schrumpft.\n\nEinerlei. Wenigstens lebst du noch."
  },
  Event_146269_Name = {
    Text = "Lautloser Sturz"
  },
  Event_146270_ChoiceDesc1 = {
    Text = "[Lauscher] erhält Silberrelikt „(RelicConfig.Arg1)“, Infektion „(Skill.Arg2)“"
  },
  Event_146270_ChoiceDesc2 = {
    Text = "[Ohren zuhalten]erhalte 3 Auswahlen für das Gotteszeichen"
  },
  Event_146270_Desc = {
    Text = "Wind und Schnee peitschen gegen die Felswand und vermischen sich mit dem leisen, geisterhaften Knacken aus dem Inneren des Eises, das in eine Reihe weinender Seufzer zersplittert.\n\nAllein in der stillen Höhe stehend, vernimmst du plötzlich die Melodie des Berges.\n\nSie ist trostlos und feierlich – ein tiefer, dumpfer Gesang, der nur für die Toten bestimmt ist."
  },
  Event_146270_Name = {
    Text = "Phantasia der Natur"
  },
  Event_146271_ChoiceDesc1 = {
    Text = "[Es ist die Glocke] Entwickle „(Skill.Arg1)“, graviere das Gebet „(EnchantConfig.Arg2)“ auf 1 zufällige Befehlskarte"
  },
  Event_146271_ChoiceDesc2 = {
    Text = "[Es ist das Essen] Entwickle „(Skill.Arg1)“, graviere das Gebet „(EnchantConfig.Arg2)“ auf 1 zufällige Befehlskarte"
  },
  Event_146271_ChoiceDesc3 = {
    Text = "[Es ist die Vorfreude des Hundes] Graviere das Gebet „(EnchantConfig.Arg1)“ auf 1 zufällige Befehlskarte"
  },
  Event_146271_Desc = {
    Text = "„Pawlow läutet die Glocke und füttert dann den Hund. Mit der Zeit lässt das bloße Läuten der Glocke dem Hund das Wasser im Mund zusammenlaufen.“\n\n„Also. Was ist es wirklich, das dem Hund das Wasser im Mund zusammenlaufen lässt?“"
  },
  Event_146271_Name = {
    Text = "Pawlowscher Reflex"
  },
  Event_146272_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_146272_Desc = {
    Text = "Schau nicht zurück. Wilhelm ist genau dort, in Reichweite. Lass die Trauer dich nicht verschlucken. Du hast vieles verpasst, aber du kannst das noch in Ordnung bringen."
  },
  Event_146272_Name = {
    Text = "Vom anderen Ufer"
  },
  Event_146273_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_146273_Desc = {
    Text = "„Schließe deine Hand.\"\n\n„Was einst exquisit war, wird sich in deinem Griff in nichts als schwarzen Schlamm auflösen.“"
  },
  Event_146273_Name = {
    Text = "Illusion, nicht Wahrheit"
  },
  Event_146274_ChoiceDesc1 = {
    Text = "[Hey! Kehrt um!] Erhalte 50 Schwarze Male"
  },
  Event_146274_ChoiceDesc2 = {
    Text = "[Die Katze streicheln] Erhalte 75 Schwarze Male, aber entwickle „(Skill.Arg2)“"
  },
  Event_146274_Desc = {
    Text = "<Italic:„Miau.“> Eine schwarze Katze mit strahlend jadegrünen Augen reibt ihren Kopf mit leisen, lautlosen Schritten an deinem Schienbein.\n\nIn diesem Moment merkst du, dass „ N “ verschwunden ist."
  },
  Event_146274_Name = {
    Text = "Die kriechende schwarze Katze"
  },
  Event_146275_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_146275_Desc = {
    Text = "Du gibst keinen Laut von dir. Du lässt deinen Blick einfach durch den Dunst gleiten und auf Pollux' Augen verweilen, ohne wegzusehen.\n\nAuch er weicht deinem Blick nicht aus. Dein Bruder war immer so – stur bis ins Mark, nicht bereit, als Erster den Kopf zu senken.\n\nDas Singen im Saal, der Geruch von Asche, Juliettes Predigt über Barmherzigkeit und Opfer... plötzlich rücken sie alle in die Ferne. Es ist, als wären nur ihr beide übrig geblieben, die sich über diesen Saal hohlen Mitleids hinweg anstarren, über die weite Spanne der Zeit."
  },
  Event_146275_Name = {
    Text = "Ein alter Traum: III"
  },
  Event_146276_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_146276_Desc = {
    Text = "In diesem Moment bist du der einzige Wächter deiner langen, blassen Erinnerungen.\n\nDer Wendigo streckt astähnliche Klauen aus, zielt direkt auf dein Herz, doch du drängst ihn mit bloßem Willen zurück.\n\nEr stolpert und zieht sich in den verschlingenden Nebel zurück, hinterlässt nur ein trockenes, raues Flüstern:\n\n„Früher oder später wirst du sie mir anbieten... und du wirst es gerne tun.“"
  },
  Event_146276_Name = {
    Text = "Der Verschlinger"
  },
  Event_146277_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_146277_Desc = {
    Text = "Es ist ein ferner Traum. Ein Traum aus deiner Kindheit.\n\n„Reiß dich zusammen“, erinnerst du dich selbst. „Wir sind nicht mehr dort.“\n\nDu kehrst in die Realität zurück, nur um dich im eisigen Schnee stehend wiederzufinden, umgeben von einem Kreis von Kultisten, mit Pollux' Klinge direkt auf deine Brust gerichtet."
  },
  Event_146277_Name = {
    Text = "Ein alter Traum: I"
  },
  Event_146278_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_146278_Desc = {
    Text = "„Ich akzeptiere, dass der Tod kommen muss.“\n\n„Ich biete meine Knochen dieser mühseligen Pilgerreise willig an.“\n\n„Unter dem Abgrund werden Himmel und Erde mein Denkmal formen.“"
  },
  Event_146278_Name = {
    Text = "Omen des Todes"
  },
  Event_146279_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_146279_Desc = {
    Text = "Ein Spiegelbild ist nichts weiter als ein Trick des Lichts. Was Tinct sah, war wahrscheinlich nur ihr eigener Schatten.\n\nIhr Heimatplanet ist Millionen von Lichtjahren entfernt; der kleinste Navigationsfehler hätte sie in verschiedene Galaxien verstreut. Mit diesen Gedanken beruhigst du dich und hörst auf, dich damit zu beschäftigen, was sich unter deinen Füßen befindet."
  },
  Event_146279_Name = {
    Text = "Das versunkene Spiegelbild"
  },
  Event_146280_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_146280_Desc = {
    Text = "Er kommt von den Sternen. Aus der tiefen Morgendämmerung der Zeit. Von Dingen, die die Menschheit noch nicht kennt und vielleicht niemals kennen wird.\n\nFrage Sie nicht nach Antworten.\n\nDu kennst den Preis nicht."
  },
  Event_146280_Name = {
    Text = "Arie des gefrorenen Sees"
  },
  Event_146281_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_146281_Desc = {
    Text = "Du hältst inne und lässt diese düstere Musik deine Ohren erfüllen.\n\nDer Wind ist eine Violine, der beißende Schnee ein Trommelschlag und das ferne Donnern des brechenden Eises eine tiefe, lange unterdrückte Harmonie.\n\nDu kannst ihr Thema nicht entziffern, doch du weißt, dass sie – ob in der Vergangenheit oder in der Zukunft – immer weiter spielen wird, für die zahllosen Reisenden, die hier begraben liegen."
  },
  Event_146281_Name = {
    Text = "Phantasia der Natur"
  },
  Event_146283_ChoiceDesc1 = {
    Text = "[Blick gen Himmel] Alle Erwecker erhalten Arg1 Aliemus zurück"
  },
  Event_146283_ChoiceDesc2 = {
    Text = "[Den gefrorenen Gipfel betreten] Wähle 2 Erwecker zum Erwecken aus"
  },
  Event_146283_Desc = {
    Text = "Der Gipfel schimmert still hinter einem Schleier aus Wolken und Nebel. Die Schluchten, die senkrechten Felswände, die heulenden Stürme – nichts, was hier haust, war je für Sterblichenaugen bestimmt. Angesichts all dessen bist du so erschreckend zerbrechlich."
  },
  Event_146283_Name = {
    Text = "Den Gipfel berühren"
  },
  Event_146284_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_146284_Desc = {
    Text = "„Nein, es ist nicht deine Schuld. Du bist nur ein Uhrwerkspielzeug, aufgezogen vom Schicksal.“"
  },
  Event_146284_Name = {
    Text = "Gefräßige Ratte"
  },
  Event_146285_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_146285_Desc = {
    Text = "„Ich verstehe. Du bist jemand, der sich auf objektive Erfahrung verlässt. Aber vergiss nicht: Manchmal liegen unter identischen Oberflächen völlig unterschiedliche Wahrheiten verborgen.“\n\nDas Lachen der Glocke verhallt in der Ferne."
  },
  Event_146285_Name = {
    Text = "Pawlowscher Reflex"
  },
  Event_146286_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_146286_Desc = {
    Text = "Wenn Gerechtigkeit bedeutet, dass Gut und Böse entsprechend belohnt werden, wer sitzt dann zu Gericht?\n\nAnubis und seine Waage? Wenn die Schwerkraft der Unterwelt den Gesetzen der Physik gehorcht, bin ich nicht besonders zuversichtlich, dass mein Herz leichter ist als seine Feder."
  },
  Event_146286_Name = {
    Text = "Absurde Fairness"
  },
  Event_146287_ChoiceDesc1 = {
    Text = "[Nach Antworten drängen] Silberne Schöpfung „(RelicConfig.Arg1)“ erhalten, „(Skill.Arg2)“ entwickeln"
  },
  Event_146287_ChoiceDesc2 = {
    Text = "[Schweigen] Silberne Schöpfung „(RelicConfig.Arg1)“ erhalten, „(Skill.Arg2)“ entwickeln"
  },
  Event_146287_ChoiceDesc3 = {
    Text = "[Entschuldigen] 25 Schwarze Male erhalten"
  },
  Event_146287_Desc = {
    Text = "„Senior Wilhelm, als der Zauber des Wendigo alle anderen in seinen Bann zog, schienen Sie als Erster wieder zu sich zu kommen. Wir stehen kurz davor, ihnen direkt gegenüberzutreten. Haben Sie einen Rat?\n\"\nWilhelms Augen flackern. In ihnen erhaschen Sie einen flüchtigen Blick auf etwas Schwer Fassbares, Trauriges und Stilles – wie ein Körper, der durch sonnenbeschienenes Wasser treibt und langsam in die Dunkelheit des Meeresbodens sinkt.\n\n„Entschuldigung,\" sagt er. „Ich fürchte, ich kann Ihnen dabei nicht helfen.\""
  },
  Event_146287_Name = {
    Text = "Sanftes Untertauchen"
  },
  Event_146288_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_146288_Desc = {
    Text = "„So blind gegenüber der Kunst, so schrecklich blind“, murmelt ein dunkler Schatten und schüttelt den Kopf, während Er aus dem Dunkel tritt. „Die Wahrheit könnte Gift sein. Manchmal ist eine gut gehütete Illusion das Einzige, was unser zerbrechliches Glück bewahrt, nicht wahr?“"
  },
  Event_146288_Name = {
    Text = "Die kriechende schwarze Katze"
  },
  Event_146290_ChoiceDesc1 = {
    Text = "[Wer ist der Mörder?] Entwickle „(Skill.Arg1)“, graviere das Gebet „(EnchantConfig.Arg2)“ auf 1 zufällige Karte"
  },
  Event_146290_ChoiceDesc2 = {
    Text = "[Es ist meine Schuld] Entwickle „(Skill.Arg1)“, graviere das Gebet „(EnchantConfig.Arg2)“ auf 1 zufällige Karte"
  },
  Event_146290_ChoiceDesc3 = {
    Text = "[Es ist der Preis der Fresssucht] Graviere das Gebet „(EnchantConfig.Arg1)“ auf 1 von 3 Befehlskarten"
  },
  Event_146290_Desc = {
    Text = "<Italic:„Husch, husch, kleine Ratte,\n\nDurch die Kanalisation, lang und schwarz.\n\nSchnüffel die Luft und riech das Süße—\n\nEine köstliche Käserinde zum Fressen.\n\"\n\n\n„Schlep sie heim, lauf, lauf, lauf,\n\nNun hat das Summen angefangen.\n\nSummen, summen in deinem Kopf,\n\nSummen, summen, voller Graus.\n\"\n\n\n„Drück die Tür auf, drück die Tür auf,\n\nNiemand flüstert mehr.\n\"\n\n„Brüder, Schwestern, in einer Reihe,\n\nSeht, wie still sie alle werden.\n\nJeder Bauch hat ein Loch,\n\nEin hohles Loch, ein hohles Loch.“>"
  },
  Event_146290_Name = {
    Text = "Gefräßige Ratte"
  },
  Event_146291_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_146291_Desc = {
    Text = "Du kniест nieder und wischt die Nässe von ihrer Wange. Du fragst nicht, ob die Tränen echt sind.\n„Spielt keine Rolle, ob sie echt sind“, sagst du. „Du musst niemandem etwas beweisen.“\nCaraboo öffnet den Mund, doch die clevere, schlagfertige Bemerkung, die sie vorbereitet hatte, stirbt ihr im Hals. Stattdessen bricht der Damm. Ihre Tränen strömen ohne Vorwarnung, heiß und schwer auf den Handrücken."
  },
  Event_146291_Name = {
    Text = "Krokodilstränen"
  },
  Event_146292_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_146292_Desc = {
    Text = "„Es ist besser, nicht zu fragen. Es gibt Fragen, die keine Antworten brauchen.“"
  },
  Event_146292_Name = {
    Text = "Gefräßige Ratte"
  },
  Event_146293_ChoiceDesc1 = {
    Text = "[Rufen] Silberne Schöpfung „(RelicConfig.Arg1)“ erhalten, „(Skill.Arg2)“ entwickeln"
  },
  Event_146293_ChoiceDesc2 = {
    Text = "[Weiter zuhören] Alle Erwecker erhalten 50 Aliemus, „(Skill.Arg1)“ entwickeln"
  },
  Event_146293_ChoiceDesc3 = {
    Text = "[Ignorieren] 1 von 3 Gebeten erhalten"
  },
  Event_146293_Desc = {
    Text = "Wo Naraka fiel, bleibt nur Dunkelheit.\n\nEine feuchte Melodie driftet aus dem Morast, kalt und bleich wie ein Paar Hände, die zärtlich und verweilt deine Wangen streicheln.\n\nSie flüstert leise: „Komm zu mir. Komm zu mir in der Stille der Nacht.\""
  },
  Event_146293_Name = {
    Text = "Nachhallende Echos"
  },
  Event_146294_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_146294_Desc = {
    Text = "Du senkst den Kopf und lässt den Rauch Pollux' Umrisse verschwimmen, seinen Ausdruck im grau-weißen Nebel verbergen.\n\nDas ist am sichersten, sagst du dir. Kein Bedarf hinzusehen, kein Bedarf nachzudenken.\n\nJuliettes Predigt strömt weiter über dich hinweg. Du starrst unverwandt auf deine gefalteten Hände, schweigend.\n\nErs als die Ritualsglocke läutet, wagst du es, die Augen wieder zu heben.\n\nPollux hat seine fromme Haltung die ganze Zeit beibehalten.\n\nÜber die weite Ausdehnung von Zeit und Illusion hinweg kannst du nicht sicher sein, ob in genau diesem Augenblick etwas entglitten ist."
  },
  Event_146294_Name = {
    Text = "Ein alter Traum: III"
  },
  Event_146295_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_146295_Desc = {
    Text = "„Pollux!“\nDer Name hat kaum deine Kehle verlassen, da schluckst du ihn schon wieder hinunter. Er löst sich im Weihrauchrauch auf als nichts weiter als ein leiser, hauchiger Seufzer.\n\nUm dich herum stockt das Singen der Gläubigen nicht, doch einige stille, kaum merkliche Blicke wenden sich dir zu.\n\nPollux zuckt sofort zusammen, ein Aufflackern von Panik huscht durch seine Augen, wird jedoch schnell wieder von jenem eingeübten, unterwürfigen Ausdruck verdeckt.\n\nEr antwortet nicht. Er hält nur seinen Blick gesenkt, doch seine Finger ballen sich still in seinem Ärmel. Du weißt, dass er dich gehört hat."
  },
  Event_146295_Name = {
    Text = "Ein alter Traum: III"
  },
  Event_146297_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_146297_Desc = {
    Text = "Zumindest hättest du damals nicht tatenlos zusehen können, wie sie allein verstoßen wurde. Lass die Probleme von heute dem heutigen Ich überlassen."
  },
  Event_146297_Name = {
    Text = "Räder in Rädern"
  },
  Event_146298_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_146298_Desc = {
    Text = "„Pollux, wir sollten uns trennen. So haben wir bessere Chancen, den Rand des Waldes zu finden.\n\"\n„Aber wie wirst du mich finden, Bruder?\n\"\nDurch den Schleier der Erinnerungen siehst du sein trauriges Gesicht. Ein scharfer Stich dreht sich in deinem Herzen. Du atmest langsam und tief durch.\n\n„Keine Sorge. Wir sind Zwillinge; wir können den Herzschlag des anderen hören.\n\"\n„Wir sind nie wirklich getrennt.“"
  },
  Event_146298_Name = {
    Text = "Ein alter Traum: I"
  },
  Event_146299_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_146299_Desc = {
    Text = "Er richtet. Er verhört. Er wird all jenen, die es wagten, ihn herauszufordern, ein eisiges, stilles Ende bereiten."
  },
  Event_146299_Name = {
    Text = "Urteil der Schneegrenze"
  },
  Event_146300_ChoiceDesc1 = {
    Text = "[Von vorne beginnen] Graviere das Gebet „(EnchantConfig.Arg1)“ auf 1 von 3 Befehlskarten ein, aber entwickle „(Skill.Arg2)“"
  },
  Event_146300_ChoiceDesc2 = {
    Text = "[Es ist schwierig] Erhalte Silberne Schöpfung „(RelicConfig.Arg1)“, aber entwickle „(Skill.Arg2)“"
  },
  Event_146300_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte 25 schwarze Siegel"
  },
  Event_146300_Desc = {
    Text = "Der Wurm lehrte sie die Kunst der Lüge. Darüber hinaus lernte sie nichts über das Überleben.\n\nDoch eine Lüge bleibt stets eine Lüge; es kommt ein Tag, an dem das Gerüst verschwinden muss und man lernen muss, ohne seine Stütze zu stehen."
  },
  Event_146300_Name = {
    Text = "Illusion, nicht Wahrheit"
  },
  Event_146301_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_146301_Desc = {
    Text = "„In der Tat. Aber wie könnte eine so kleine Ratte jemals den Preis ihres Hungers kennen?“"
  },
  Event_146301_Name = {
    Text = "Gefräßige Ratte"
  },
  Event_146302_ChoiceDesc1 = {
    Text = "[Den roten Faden knüpfen] Lösche 1 Befehlskarte, erhalte Arg1 Schwarze Male"
  },
  Event_146302_ChoiceDesc2 = {
    Text = "[Den roten Faden ablehnen] Kopiere 1 Befehlskarte, aber entwickle „(Skill.Arg1)“"
  },
  Event_146302_ChoiceDesc3 = {
    Text = "[Zurück zur Realität] Graviere das Gebet „(EnchantConfig.Arg1)“ auf 1 von 3 Befehlskarten"
  },
  Event_146302_Desc = {
    Text = "Der erste Traum. Der Wald. Du und dein Bruder, kaum zehn Jahre alt, werdet von Lady Latern tief im dunklen Wald zurückgelassen.\n\n<Italic:„Wenn die Nacht hereinbricht, werden die schlafenden Bestien mit der Jagd beginnen. Flieht, bevor es so weit ist. Nur diejenigen, die es herausschaffen, dürfen meine braven Kinder sein.>\n\nDein Bruder ergreift deine Hand und zieht einen roten Faden hervor.\n\n„Castor, lass uns unsere Hände zusammenbinden. So werden wir uns nicht verlieren.“"
  },
  Event_146302_Name = {
    Text = "Ein alter Traum: I"
  },
  Event_146304_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_146304_Desc = {
    Text = "Du hörst Lachen.\n\nVerspielt, spöttisch, voller Belustigung.\n\nDas verzweifelte Streben der Menschheit, den Kosmos zu erforschen, ist in ihren Augen nichts weiter als das Kriechen von Ameisen."
  },
  Event_146304_Name = {
    Text = "Jene unter dem Blick"
  },
  Event_146306_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_146306_Desc = {
    Text = "Er reinigt. Er löscht aus. Er wird all jene, die klettern und nie zurückkehren, in seine stille Umarmung aufnehmen."
  },
  Event_146306_Name = {
    Text = "Urteil der Schneegrenze"
  },
  Event_146307_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_146307_Desc = {
    Text = "Du und die Krähe starren euch gegenseitig an.\n\nEs ist offensichtlich, dass du dieses Patt nicht gewinnen wirst.\n\nAber dann – gegen Juliette fühlt es sich an, als würdest du es nie tun."
  },
  Event_146307_Name = {
    Text = "Ein alter Traum: II"
  },
  Event_146308_ChoiceDesc1 = {
    Text = "[Wer beobachtet mich?] 1 Erwecker zufällig erwecken, „(Skill.Arg1)“ entwickeln"
  },
  Event_146308_ChoiceDesc2 = {
    Text = "[Auf die Gegenwart konzentrieren] 1 von 3 Befehlskarten zum Gravieren auswählen: „(EnchantConfig.Arg1)“"
  },
  Event_146308_Desc = {
    Text = "Ein eisiger, schneebeladener Wind heult über dieses hohe Heiligtum hinweg, unberührt von menschlichen Fußspuren.\n\nDu blickst auf. Noch höher gibt es nur die ewige, unverwandte Sonne.\n\nDoch du weißt, dass irgendwo noch höher, noch weiter, unzählige Augen sich öffnen und schließen.\n\nUnd einige dieser Augen starren still auf die gesamte Welt unter deinen Füßen herab."
  },
  Event_146308_Name = {
    Text = "Jene unter dem Blick"
  },
  Event_146309_ChoiceDesc1 = {
    Text = "[Ich kann noch nicht loslassen] Erhalte Fluchkreatur „(RelicConfig.Arg1)“, aber entwickle „(Skill.Arg2)“"
  },
  Event_146309_ChoiceDesc2 = {
    Text = "[Ich habe vergessen] Graviere das Gebet „(EnchantConfig.Arg1)“ auf 1 zufällige Karte ein"
  },
  Event_146309_Desc = {
    Text = "Du versuchst, die Kammern der Erinnerung zu verschließen. In jenem geheimen Kästchen liegen alle Antworten, die dich definieren – jeder beschämende Drang, jede verborgene Fantasie. Doch Begehren ist ein unbewusster Fluch, eine Besessenheit, die zu süß ist, um ihr zu widerstehen."
  },
  Event_146309_Name = {
    Text = "Unterbewusster Fluch"
  },
  Event_146310_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_146310_Desc = {
    Text = "Wilhelm weicht Ihrem Blick aus.\n„Der Verstand ist unser einziger Schutz gegen Täuschung. Doch ein Verstand wird durch ein ganzes Leben voller Erfahrungen geformt. Er lässt sich weder teilen noch lehren.\"\n\n„Das Einzige, was ich Ihnen sagen kann, ist dies: Lassen Sie nicht zu, dass Ihre eigene Schwäche Sie verschluckt.\""
  },
  Event_146310_Name = {
    Text = "Sanftes Untertauchen"
  },
  Event_146311_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_146311_Desc = {
    Text = "„Ich verstehe. Du bist jemand, der ein Philosoph sein möchte. Aber vergiss nicht: Die Abwesenheit von Hoffnung bedeutet nicht die Abwesenheit von Schmerz.“\nDas Lachen der Glocke verhallt in der Ferne."
  },
  Event_146311_Name = {
    Text = "Pawlowscher Reflex"
  },
  Event_146312_ChoiceDesc1 = {
    Text = "[Verlassen]Infiziere“(Skill.Arg1)“，erhalte 50 schwarze Siegel"
  },
  Event_146312_Desc = {
    Text = "„Hungrig, so hungrig.“\n\n\nDer Berg weint; der Berg klagt. Er kann die weite, hohle Leere in seinem Inneren nicht ertragen."
  },
  Event_146312_Name = {
    Text = "Geheimnis des Berges"
  },
  Event_146313_ChoiceDesc1 = {
    Text = "[Halt suchen] 1 Befehlskarte löschen, Arg1 LP heilen"
  },
  Event_146313_ChoiceDesc2 = {
    Text = "[Das Sicherheitsseil greifen] Goldene Kreation „(RelicConfig.Arg1)“ erhalten, „(Skill.Arg2)“ entwickeln"
  },
  Event_146313_Desc = {
    Text = "Ein Kaleidoskop aus Halluzinationen wühlt sich durch deinen Geist.\n\nZuerst lockeres Pulver. Dann ein brechender Gesims.\n\nDu kannst deinen Sturz nicht aufhalten; das Sicherungsseil sprüht blendende Funken an seiner Halterung, als es entgleitet. Doch vor den Bergen ist es so entsetzlich klein, so zerbrechlich."
  },
  Event_146313_Name = {
    Text = "Lautloser Sturz"
  },
  Event_146314_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_146314_Desc = {
    Text = "Komm zu mir in deinen Träumen. Lass mich mein Leben noch einmal leben.\n\nDas Grammophon stößt ein wimmerndes Seufzen aus. Dann verblasst das Geräusch des Atmens in der Dunkelheit. Nichts bleibt zurück als das Echo. Nur das Echo."
  },
  Event_146314_Name = {
    Text = "Nachhallende Echos"
  },
  Event_146315_ChoiceDesc1 = {
    Text = "[Die Wahl bereuen] Silberne Schöpfung „(RelicConfig.Arg1)“ erhalten"
  },
  Event_146315_ChoiceDesc2 = {
    Text = "[Dem Schicksal überlassen] Goldene Kreation „(RelicConfig.Arg1)“ erhalten, „(Skill.Arg2)“ entwickeln"
  },
  Event_146315_Desc = {
    Text = "Du wusstest schon immer, dass diese Reise nicht einfach sein würde. Die meisten Kletterer dieser Expedition hegen ihre eigenen finsteren Absichten.\n\nDoch als du das manische, spöttische Grinsen siehst, das sich auf Caraboos Gesicht ausbreitet, spürst du noch immer das scharfe, plötzliche Knacken von etwas, das in deiner Brust zerbricht.\n\nVielleicht hättest du eine andere Wahl treffen sollen, als Naraka sie aus der Gruppe verstoßen wollte."
  },
  Event_146315_Name = {
    Text = "Räder in Rädern"
  },
  Event_146316_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_146316_Desc = {
    Text = "Wie viele hat dieser Ort schon verschluckt?\n\nSchwarze Hände strecken sich aus dem dicken, klebrigen Tümpel heraus und versuchen, dich in ihre Welt hinabzuziehen. Doch du gehst einfach weiter. Sie unternehmen keinen Versuch, dich aufzuhalten, und gleiten still zurück in die Tiefe.\n\nDer Gipfel wartet noch immer vor dir."
  },
  Event_146316_Name = {
    Text = "Nachhallende Echos"
  },
  Event_146317_ChoiceDesc1 = {
    Text = "[Wegschauen] 25 Schwarze Male erhalten"
  },
  Event_146317_ChoiceDesc2 = {
    Text = "[Genauer hinsehen] Silberne Schöpfung „(RelicConfig.Arg1)“ erhalten, „(Skill.Arg2)“ entwickeln"
  },
  Event_146317_Desc = {
    Text = "Tincts Blick folgend, kannst du nicht umhin, in die Tiefen des Sees hinabzustarren.\n\nWas ist es dort unten, das sie so sehr in seinen Bann zieht?\n\nDu kannst es nicht sagen. Das Eis ist trüb und dunkel und spiegelt nichts wider als deinen eigenen Schatten."
  },
  Event_146317_Name = {
    Text = "Das versunkene Spiegelbild"
  },
  Event_146318_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_146318_Desc = {
    Text = "Der einzige Weg, den Hunger zu stillen, ist loszulassen. Niemand kann verlieren, was er nicht hält. Der Wendigo fletscht die Zähne, lässt ein frustriertes Knurren entweichen und schleicht zurück in den Nebel."
  },
  Event_146318_Name = {
    Text = "Unterbewusster Fluch"
  },
  Event_146319_ChoiceDesc1 = {
    Text = "[Der Schnee wird mich reinigen] Die Gebetsqualität von 1 Karte zufällig verbessern"
  },
  Event_146319_ChoiceDesc2 = {
    Text = "[Der Schnee wird mich richten] 1 von 3 Befehlskarten zum Gravieren auswählen: „(EnchantConfig.Arg1)“, „(Skill.Arg2)“ entwickeln"
  },
  Event_146319_Desc = {
    Text = "Vor dir liegt der letzte Aufstieg, wo sich die kalte, endlose Schneegrenze in die Ferne erstreckt.\n\nDer Schnee ist von einem blendenden, strahlenden Weiß. Hier sieht selbst der Tod sauber aus."
  },
  Event_146319_Name = {
    Text = "Urteil der Schneegrenze"
  },
  Event_146320_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_146320_Desc = {
    Text = "Lass kein Detail der Vision aus. Brenne sie in deinen Geist. Brenne die plötzliche Leere, den hohlen Schmerz und die scharfe Trauer, die folgte, ein. Lass sie niemals, niemals los."
  },
  Event_146320_Name = {
    Text = "Vom anderen Ufer"
  },
  Event_146321_ChoiceDesc1 = {
    Text = "[Gemeinsam kämpfen] Erhalte Silberne Schöpfung „(RelicConfig.Arg1)“"
  },
  Event_146321_ChoiceDesc2 = {
    Text = "[Sie trösten] Erhalte Goldene Kreation „(RelicConfig.Arg1)“, aber entwickle „(Skill.Arg2)“"
  },
  Event_146321_Desc = {
    Text = "Der Berg erschauert, ein sterbendes Tier. Gegliederte, blasse Fleischmassen drängen aus dem gebrochenen Stein, winden und klettern sich empor und schleudern Caraboo zu Boden.\n\nAls sie aufsteht, zeichnen feuchte Spuren ihre staubbedeckten Wangen. Sind es Tränen des Schmerzes? Das lässt sich nicht sagen.\n\nSo viele Lügen sind über ihre Lippen geflossen; wer kann den Tränen eines Krokodils trauen?"
  },
  Event_146321_Name = {
    Text = "Krokodilstränen"
  },
  Event_146322_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_146322_Desc = {
    Text = "Du stellst keine Fragen. Du nimmst einfach deinen Platz an ihrer Seite ein.\n„Steh auf“, sagst du. „Du bist erst auf halbem Weg durch deinen Auftritt. Gib jetzt nicht auf.“\nCaraboo zögert, wischt sich dann mit einer harten, plötzlichen Handbewegung das Gesicht ab. Sie erhebt sich schwankend, weiß geknöchelt an ihrer Waffe, um dem klaffenden, purpurroten Rachen an deiner Seite entgegenzutreten.\nSie hat so viele Lügen gesprochen, dass selbst sie nicht mehr sagen kann, welche Tränen Wasser und welche Salz sind. Aber im Moment zählt das niemand nach."
  },
  Event_146322_Name = {
    Text = "Krokodilstränen"
  },
  Event_146323_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_146323_Desc = {
    Text = "„Ich verstehe. Du bist jemand, der stolz darauf ist, Illusionen zu durchschauen. Aber vergiss nicht: In jenem kurzen Moment der Realität existierte das Essen nur in deiner Erinnerung und deinem Verlangen.“\nDas Lachen der Glocke verhallt in der Ferne."
  },
  Event_146323_Name = {
    Text = "Pawlowscher Reflex"
  },
  Event_146324_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_146324_Desc = {
    Text = "Du verlangsamst deinen Schritt und machst deine Schritte weicher.\n\nSanft, langsam, ohne ein Geräusch...\n\nDu gleitest um die nächste Ecke und verschwindest.\n\nHat die Krähe dich je verfolgt?\n\nDu erinnerst dich nicht mehr."
  },
  Event_146324_Name = {
    Text = "Ein alter Traum: II"
  },
  Event_146325_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_146325_Desc = {
    Text = "Die Melodie bricht ab.\n\nAus dem schwarzen Morast öffnet sich ein Paar gieriger, feuchter Augen und blickt dich an. Sie flüstern Worte, die du nicht verstehen kannst, und schließen sich dann langsam, ganz langsam."
  },
  Event_146325_Name = {
    Text = "Nachhallende Echos"
  },
  Event_146326_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_146326_Desc = {
    Text = "Du verweilst nicht. Die Melodie hinter dir lassend, knirscht dein Stiefel im Schnee und erzeugt ein Geräusch, das hastiger ist als der Wind selbst.\n\nDoch egal wie schnell du gehst, diese trostlose Weise klebt hartnäckig an deinen Fersen und fällt nie zurück.\n\nDu kannst ihr nicht entkommen – sie ist der Atem des Berges selbst. Und du bist nur ein winziger, vorübergehender Zuhörer, der sie zufällig vernommen hat."
  },
  Event_146326_Name = {
    Text = "Phantasia der Natur"
  },
  Event_146327_ChoiceDesc1 = {
    Text = "[Zuhören] Wähle 1 von 3 Befehlskarten zum Eingravieren: „(EnchantConfig.Arg1)“, entwickle „(Skill.Arg2)“"
  },
  Event_146327_ChoiceDesc2 = {
    Text = "[Ignorieren] Für jeden Erwecker mit einem Aliemus-Wert von 50 oder höher, erhalte 15 Schwarze Male"
  },
  Event_146327_ChoiceDesc3 = {
    Text = "[Gewaltsam verlassen] Erhalte 1 aus 3 Gebeten"
  },
  Event_146327_Desc = {
    Text = "Ein ferner Gesang treibt auf dem Wind.\n\nEr scheint aus jeder Richtung zu kommen, oder vielleicht aus den Tiefen der Erde.\n\nIn welche Richtung du dich auch wendest, um ihm zu folgen, er hallt mit der gleichen unerbittlichen Intensität in deinen Ohren wider."
  },
  Event_146327_Name = {
    Text = "Arie des gefrorenen Sees"
  },
  Event_146328_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_146328_Desc = {
    Text = "„O Stern des schlechten Omens, dies ist nicht die Stunde deines Leuchtens.“\n\n„Meine Pilgerreise hat Ziele, die sie noch nicht erreicht hat.“\n\n„Erlösche dich, wenn auch nur für jetzt, und lass den Frieden in den heutigen Nachthimmel zurückkehren.“"
  },
  Event_146328_Name = {
    Text = "Omen des Todes"
  },
  Event_146329_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_146329_Desc = {
    Text = "Eine nutzlose Welle der Reue überkommt dich. Aber dann sind wir immer gezwungen, die Unordnung aufzuräumen, die unser früheres Ich hinterlassen hat."
  },
  Event_146329_Name = {
    Text = "Räder in Rädern"
  },
  Event_146330_ChoiceDesc1 = {
    Text = "[Einen Biss nehmen] Erwecke zufällig 1 Erweckten Körper, Infektion [(Skill.Arg1)]"
  },
  Event_146330_ChoiceDesc2 = {
    Text = "[Weigere dich] Erhalte eine Auswahl von 3 für 1 Gebet"
  },
  Event_146330_Desc = {
    Text = "Tief im schneeerstickten Nebel kauert ein knochiges Wesen, trockene, rissige Haut straff über markante Rippen gespannt. Auf seinem Kopf durchstechen knorrige, verdorrte Geweihe den Nebel. Ein hohles, hungriges Grollen hallt aus seinem Bauch.\n\nAls sich eure Blicke treffen, wirbeln zerbrochene Bilder in seinen hohlen Augenhöhlen – deine Erinnerungen. Es hat die Witterung bereits aufgenommen; es hat sie bereits gekostet.\n\n„Nicht genug, niemals genug...“ stöhnt es, ein trockenes, raues Geräusch. Es streckt eine verdorrte Hand aus, seine Haltung fast... flehend."
  },
  Event_146330_Name = {
    Text = "Der Verschlinger"
  },
  Event_146332_ChoiceDesc1 = {
    Text = "[Himmelsbestattung durchführen] Erhalte Silberne Schöpfung „(RelicConfig.Arg1)“"
  },
  Event_146332_ChoiceDesc2 = {
    Text = "[Dispel] Erhalte 75 Schwarze Imprägnierungen, aber entwickle das Symptom [(Skill.Arg2)]"
  },
  Event_146332_Desc = {
    Text = "Hoch auf den Thermikaufwinden kreisen Bartgeier und patrouillieren ihr Revier. Unter denen, die klettern, war dies stets ein schlechtes Omen.\n\n„Sie sind auf Nahrungssuche. Ein Geier riecht das Nahen des Todes.“"
  },
  Event_146332_Name = {
    Text = "Omen des Todes"
  },
  Event_146333_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_146333_Desc = {
    Text = "Vertrau deinen Beinen. Du wirst diesen Gipfel bezwingen."
  },
  Event_146333_Name = {
    Text = "Den Gipfel berühren"
  },
  Event_146334_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_146334_Desc = {
    Text = "In dem Moment, in dem die Sehnsucht aufflammt, weißt du, dass du nicht dagegen ankämpfen kannst. Du kannst nur zusehen, wie sie die lang versiegelten Gewölbe deines Geistes durchbricht. Blasse, scharfe Fangzähne senken sich in deine Schläfen und reißen deine Erinnerungen, Bild für Bild, an ihren Wurzeln heraus."
  },
  Event_146334_Name = {
    Text = "Unterbewusster Fluch"
  },
  Event_146335_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_146335_Desc = {
    Text = "Es lehnt sich nah heran, seine Nase berührt fast deine Stirn, atmet dich mit einer verzückten, berauschten Hingabe ein, als wärst du der süßeste Honig.\n\nDeine rastlosen, brodelnden Ängste werden sauber von deinem Geist geleckt.\n\nEs zieht sich mit einem zufriedenen, leisen Summen zurück, ein wildes, verführerisches Licht flackert in seinen hohlen Augen. Deine Brust fühlt sich nun leer an, ein fehlendes Stück – und doch, seltsamerweise, fühlst du dich leichter."
  },
  Event_146335_Name = {
    Text = "Der Verschlinger"
  },
  Event_146336_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_146336_Desc = {
    Text = "„Achte auf deinen Tritt. Stelle sicher, dass jeder Schritt fest ist“, klingt Narakas Stimme in deinem Ohr. „Erwarte nicht, dass andere dich auffangen, wenn du fällst.“"
  },
  Event_146336_Name = {
    Text = "Jene unter dem Blick"
  },
  Event_146337_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_146337_Desc = {
    Text = "Die Menschheit gehört in die Höhen. Ein wahres Ziel lässt einen den schwindelerregenden Abgrund darunter vergessen. Der Himmel liegt offen, wartet direkt über dir."
  },
  Event_146337_Name = {
    Text = "Den Gipfel berühren"
  },
  Event_146338_ChoiceDesc1 = {
    Text = "[Die Gedenken loslassen] Erhalte Goldene Kreation „(RelicConfig.Arg1)“, aber entwickle „(Skill.Arg2)“"
  },
  Event_146338_ChoiceDesc2 = {
    Text = "[Am Pain festhalten] Erhalte 1 von 3 Goldenen Kreationen, aber entwickle „(Skill.Arg1)“"
  },
  Event_146338_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte Silberrelikt“(RelicConfig.Arg1)“"
  },
  Event_146338_Desc = {
    Text = "Die Person, die einst Wilhelm ermordete, steht nun vor dir.\n\nIn der stagnierenden, widerlichen Luft von Arams Zelt steigen die Erinnerungen wie Geister auf: Wilhelms blutleere, schwebende Gestalt; sein blasses, nach oben gewandtes Gesicht; und auf dem Tisch die sezierte, hohle Hülle jener kleinen Laterne."
  },
  Event_146338_Name = {
    Text = "Vom anderen Ufer"
  },
  Event_146339_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_146339_Desc = {
    Text = "Das Sicherungsseil reißt sofort unter deinem Gewicht.\n\nDu stürzt schwer in eine Schneewehe, jedes Organ schreit in dumpfem, qualvollem Protest. Du zwingst deine Augen durch den betäubenden Schmerz auf, nur um dich Auge in Auge mit einem namenlosen Skelett wiederzufinden.\n\nTief in seinen leeren, hohlen Augenhöhlen glitzert etwas."
  },
  Event_146339_Name = {
    Text = "Lautloser Sturz"
  },
  Event_146340_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_146340_Desc = {
    Text = "Es gibt keinen Ausweg. Du beißt die Zähne zusammen und rennst los, verzweifelt darum bemüht, deinem Beobachter zu entkommen. Die Krähe stößt einen rauen Schrei aus, schlägt mit den Flügeln und verfolgt dich mühelos von oben, dreht sogar um, um dich zu verhöhnen. Unter ihrem Blick kriecht eine eisige Verzweiflung durch deine Haut.\n\nDu kannst nicht vor ihnen fliehen."
  },
  Event_146340_Name = {
    Text = "Ein alter Traum: II"
  },
  Event_146341_ChoiceDesc1 = {
    Text = "[Wie man sät, so erntet man] Eine zufällige Befehlskarte erhält Gebet: „(EnchantConfig.Arg1)“"
  },
  Event_146341_ChoiceDesc2 = {
    Text = "[Absolute Gleichheit] Max LP um Arg1 erhöhen, „(Skill.Arg2)“ entwickeln"
  },
  Event_146341_Desc = {
    Text = "An der senkrechten Felswand hängend, driftet plötzlich eine völlig unzusammenhängende Frage in deinen Geist: Was ist Gerechtigkeit?"
  },
  Event_146341_Name = {
    Text = "Absurde Fairness"
  },
  Event_146342_ChoiceDesc1 = {
    Text = "[Verlassen]Infiziere“(Skill.Arg1)“，erhalte 50 schwarze Siegel"
  },
  Event_146342_Desc = {
    Text = "„Ich kann nicht sterben! Noch nicht!“\nDer Berg weint; der Berg klagt. In seiner unersättlichen Gier hat er sein eigenes Morgen verschlungen."
  },
  Event_146342_Name = {
    Text = "Geheimnis des Berges"
  },
  Event_146343_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_146343_Desc = {
    Text = "Du beugst dich hinunter, bis deine Wange das Eis berührt.\n\nEine tiefe, beißende Kälte dringt durch deine Haut bis in die Knochen und lässt dich erschaudern. Etwas Unergründliches und Langsames wälzt sich unter der gefrorenen Oberfläche. Ist es eine Strömung oder ein Lebewesen?\n\nWas auch immer es ist, es hat nichts mit deiner Reise zu tun."
  },
  Event_146343_Name = {
    Text = "Das versunkene Spiegelbild"
  },
  Event_148532_ChoiceDesc1 = {
    Text = "[Segen erhalten] Zu Beginn des Kampfes wird 1 zufällige „Wandlungsfrucht“ zu deinem Deck hinzugefügt."
  },
  Event_148532_Desc = {
    Text = "Die endlose Schneeebene erstreckt sich bis zum Horizont, der eisige Wind trägt keinen einzigen Laut mit sich, und eine Erscheinung unbekannter Herkunft taucht lautlos auf, um eine warme Frucht zu reichen.\nSüßer Duft vermischt sich mit Nebel und dringt in die erfrorene Nase des Reisenden.\nDiese Schneegebundenen sind längst vom Tod durchtränkt, die Luft erfüllt vom widerlichen Geruch von Verwesung und Kälte – einzig die Frucht in der Handfläche ist prall und saftig, gleich dem verführerischen Versprechen eines Mädchens."
  },
  Event_148532_Name = {
    Text = "Himmelswärts-Fata-Morgana"
  },
  Event_20778_ChoiceDesc1 = {
    Text = "[Ihr überlassen]Alle Erwachten heilen Arg1 Wahnsinn"
  },
  Event_20778_ChoiceDesc2 = {
    Text = "[benötige Unterstützung]Wählen Sie 2 Erwecker"
  },
  Event_20778_Desc = {
    Text = "“Hier ist eine Mitteilung aus Mythag. Abnormalitäten im gnostischen Index der Erwecker festgestellt, benötigen Sie Unterstützung?“"
  },
  Event_20778_Name = {
    Text = "Unterstützungskommunikation"
  },
  Event_20779_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_20779_Desc = {
    Text = "“Notfallhilfe wurde bereitgestellt, bitte bestätigen Sie den Empfang durch dreimaliges Klopfen auf die Brosche.“"
  },
  Event_20779_Name = {
    Text = "Unterstützungskommunikation"
  },
  Event_20780_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_20780_Desc = {
    Text = "Ein Phantasma aus ferner Zukunft, verborgen in den Bergschlucht von Elworth"
  },
  Event_20780_Name = {
    Text = "Vulkanphantom"
  },
  Event_20781_ChoiceDesc1 = {
    Text = "[Fernblick Phantasma]Alle Erwecker erhalten Arg1 Aelius"
  },
  Event_20781_ChoiceDesc2 = {
    Text = "[nähe Phantasma]Wähle 2 Erwecker"
  },
  Event_20781_Desc = {
    Text = "In der Ferne scheint ein Vulkankegel auszubrechen, Rauch in menschlicher Gestalt erhebt sich im windgepeitschten Himmel.\nDas ist Elworth, dort gibt es nur die unaufhörlichen, hohen Bergschneelandschaften und Karst-Höhlen.\nHast du dich durch die anhaltenden Anomalien verrückt gemacht?"
  },
  Event_20781_Name = {
    Text = "Vulkanphantom"
  },
  Event_20782_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_20782_Desc = {
    Text = "Das Phantasma winkte dir zu und verschwand dann. Übrig bleibt dir nur die kalte Kälte und die majestätischen Berge"
  },
  Event_20782_Name = {
    Text = "Vulkanphantom"
  },
  Event_20783_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_20783_Desc = {
    Text = "“Verstanden, wir werden grundlegende Ressourcen liefern, bitte überprüfen Sie den Empfang.“"
  },
  Event_20783_Name = {
    Text = "Unterstützungskommunikation"
  },
  Event_21398_ChoiceDesc1 = {
    Text = "[Heb das Foto auf] wähle 1 von 3 Befehlskarten, um Gebet zu erhalten: „(EnchantConfig.Arg1)“"
  },
  Event_21398_Desc = {
    Text = "Die Maschinen zerlegt, die Wahrheit enthüllt.\nDas lebhafte Leben verschwindet ins Nichts, was bleibt, ist die Erfüllung der Wahrheit"
  },
  Event_21398_Name = {
    Text = "Augenzeugenaussage"
  },
  Event_21399_ChoiceDesc1 = {
    Text = "[Heb das Foto auf] wähle 1 von 3 Befehlskarten, um Gebet zu erhalten: „(EnchantConfig.Arg1)“"
  },
  Event_21399_ChoiceDesc2 = {
    Text = "[Überprüfe den Film]Infiziere „(Skill.Arg1)“, tausche das erhaltene Gebet aus Option 1, kann noch einmal verwendet werden"
  },
  Event_21399_Desc = {
    Text = "Die Neugier trieb dich dazu, deinen Blick auf das Schattenbecken zu richten.\nDie Bilder tauchten in tiefrotem Elixier, und der Sünder, der ganz von schwarzem Schmutz bedeckt war, hatte ausgesprochen dein Gesicht"
  },
  Event_21399_Name = {
    Text = "Augenzeugenaussage"
  },
  Event_21400_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_21400_Desc = {
    Text = "Die Maschinen zerlegt, die Wahrheit enthüllt.\nDas lebhafte Leben verschwindet ins Nichts, was bleibt, ist die Erfüllung der Wahrheit"
  },
  Event_21400_Name = {
    Text = "Augenzeugenaussage"
  },
  Event_21811_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_21811_Desc = {
    Text = "„Fünfundzwanzig Jahre... ja, sie hat mich fünfundzwanzig Jahre lang schlafen lassen.“\nDas Mädchen antwortet dir düster und niedergeschlagen.\nNach nur einem Schlaf, sind die Diener, die sie seit ihrer Kindheit betreut haben, mit den Jahren zu vollwertigen Seefahrern geworden.\nNiemand versteht mehr ihr Leid, niemand kümmert sich mehr um ihren Schmerz, sodass sie allein in der Gemeinschaft ist.\nSie wünscht sich, dass der Tag vor ihrem Schlaf der „Moment der Sternenpositionierung“ war."
  },
  Event_21811_Name = {
    Text = "Eingesperrtes Leben"
  },
  Event_22058_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_22058_Desc = {
    Text = "“Nein, ich habe keinen Hunger.“\nDu hast höflich die herzliche Einladung zu diesem Bankett abgelehnt. \nDen Preis für das Entziehen von Seelen bist du niemals bereit zu zahlen."
  },
  Event_22058_Name = {
    Text = "Fleischfest"
  },
  Event_22059_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_22059_Desc = {
    Text = "Du beißt wahllos in den blutenden Scone, der Geruch von mit Pfeffer eingelegtem Herz und gebackenem Teig mischt sich, du riechst einen vertrauten Duft.\n“Kraft zu erlangen, erfordert einen Preis.“\nDu trinkst den letzten Tropfen Blut"
  },
  Event_22059_Name = {
    Text = "Fleischfest"
  },
  Event_22060_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_22060_Desc = {
    Text = "Du schluckst die Suppe und Fleischstücke und wischt dir den Mund mit dem Ärmel ab.\nDas Fleisch ist zart und die Suppe köstlich, aber wem es gehörte?\nNur ein kleiner Teil deiner verlorenen Besitztümer"
  },
  Event_22060_Name = {
    Text = "Fleischfest"
  },
  Event_22061_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_22061_Desc = {
    Text = "Du untersuchst sorgfältig die alten Riten, die auf der Windglocke eingraviert sind. \nSie sind in einem Ausmaß verzerrt, das ein gewöhnlicher Mensch nicht begreifen kann und scheinen nicht das Ziel zu haben, verstanden zu werden. \nNicht verstanden zu werden bedeutet, nicht gestört zu werden"
  },
  Event_22061_Name = {
    Text = "Rostige Windspiel"
  },
  Event_22062_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_22062_Desc = {
    Text = "“Nicht schlecht, du bist vorsichtig.“\nEine ferne Stimme kam aus dem Windspiel.\n“Vorsicht bringt dir eine kleine Belohnung, aber das war's auch schon.“"
  },
  Event_22062_Name = {
    Text = "Rostige Windspiel"
  },
  Event_22063_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_22063_Desc = {
    Text = "Du streichelst die alten Orisonen, die auf dem Windspiel eingraviert sind.\nSie sind in einem Maß verzerrt, das man sich nicht vorstellen kann und scheinen nicht verstanden werden zu wollen.\nNicht verstanden zu werden, bedeutet, nicht gestört zu werden"
  },
  Event_22063_Name = {
    Text = "Rostige Windspiel"
  },
  Event_22064_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_22064_Desc = {
    Text = "“Ah, wie schade... dann werde ich mein einsames Solo fortsetzen.“ Du weißt nicht, wann die Harfe und die Hände verschwanden, aber die Melodie bleibt für immer in deinem Herzen"
  },
  Event_22064_Name = {
    Text = "Geister an der Laute"
  },
  Event_22065_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_22065_Desc = {
    Text = "“Ah, es ist eine Ehre, einen solchen Freund zu haben!“ Die Hände wurden aufgeregt, du konntest nicht mithalten. Lange nach dem Ende des Spiels hallte die inspirierende Melodie noch in dir nach"
  },
  Event_22065_Name = {
    Text = "Geister an der Laute"
  },
  Event_22175_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_22175_Desc = {
    Text = "Das Ouija-Brett bewegte sich selbstbewusst, und dein Blick folgte ihm hin und her.\nDoch kaum hatte es zwei Buchstaben gezeigt, verwandelte es sich unter schrecklichem Geschrei in eine zähe schwarze Flüssigkeit"
  },
  Event_22175_Name = {
    Text = "Ouija-Brett"
  },
  Event_22176_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_22176_Desc = {
    Text = "“Mathematik! Mathematik!!“\nEine Frauenstimme knirscht mit den Zähnen, das Ouija-Brett gleitet schnell zwischen den Zahlen hin und her und erzeugt ein schrilles Holzgeräusch.\n“Nimm deine Mathematik und verschwinde aus meinem Blickfeld!“"
  },
  Event_22176_Name = {
    Text = "Ouija-Brett"
  },
  Event_22177_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_22177_Desc = {
    Text = "“Warte, warte!!“\n“Frag mich! Warum fragst du nicht!“"
  },
  Event_22177_Name = {
    Text = "Ouija-Brett"
  },
  Event_22178_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_22178_Desc = {
    Text = "Es hat noch nie so pulsiert wie jetzt, aber gleichzeitig wird das Loch in seinem Inneren aufgerissen"
  },
  Event_22178_Name = {
    Text = "Fluch der Gier"
  },
  Event_22179_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_22179_Desc = {
    Text = "Seele und Geist füllen deine Lungen, in der Stille steigst du weiter auf.\nDie Geräusche der Welt erklingen nacheinander und spielen die Symphonie des Lebens"
  },
  Event_22179_Name = {
    Text = "Wasser der Vergangenheit"
  },
  Event_22180_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_22180_Desc = {
    Text = "Alles geschieht wie gewohnt, die Zerstörung kommt wie erwartet, in den unverkohlten Überresten liegt etwas Wertvolles, das im Schatten glänzt"
  },
  Event_22180_Name = {
    Text = "Nadelende außerhalb"
  },
  Event_22181_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_22181_Desc = {
    Text = "Treffen, Abschied, Vorbeigehen"
  },
  Event_22181_Name = {
    Text = "Sternenmondton"
  },
  Event_22182_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_22182_Desc = {
    Text = "Das Herz beruhigt sich, aber vielleicht hat das „Gewissen“ ein wenig Trost gefunden"
  },
  Event_22182_Name = {
    Text = "Fluch der Gier"
  },
  Event_22183_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_22183_Desc = {
    Text = "Du schließt die Augen und genießt diesen seltenen Moment der Leere und Freiheit. Allmählich spürst du, wie die Welt aus der Stille schlüpft, das Leben in der Stille lautlos erblüht"
  },
  Event_22183_Name = {
    Text = "Wasser der Vergangenheit"
  },
  Event_22184_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_22184_Desc = {
    Text = "Du hältst den Zeiger auf, die Silberfläche blitzt auf und schneidet in deine weiche Handfläche, die Zerstörung ist noch nicht eingetroffen, aber dein Schatten wird von der dunklen Nacht verschlungen"
  },
  Event_22184_Name = {
    Text = "Nadelende außerhalb"
  },
  Event_22185_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_22185_Desc = {
    Text = "“Du kannst nicht entkommen, niemand kann dem inneren Bösen widerstehen“\nDas Böse zerrt an deinen Nerven, versucht dich in den Abgrund zu ziehen. Aber der Schmerz macht deinen Geist klarer als je zuvor.\nDas Böse kann dich nicht besitzen, du wirst immer du selbst sein"
  },
  Event_22185_Name = {
    Text = "unberechtigte Gedanken"
  },
  Event_22186_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_22186_Desc = {
    Text = "“Warum nicht？“\nUmarmt man die schrecklichen Gedanken, lösen sich alle Probleme, und das Paradoxon der „Ethik“ verschwindet"
  },
  Event_22186_Name = {
    Text = "unberechtigte Gedanken"
  },
  Event_22187_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_22187_Desc = {
    Text = "Ein silberner Lichtvorhang flackert vor deinen Augen, ein dumpfer Wind nimmt alle Geräusche mit"
  },
  Event_22187_Name = {
    Text = "unberechtigte Gedanken"
  },
  Event_22188_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_22188_Desc = {
    Text = "Wankelmütig, kalt, distanziert"
  },
  Event_22188_Name = {
    Text = "Sternenmondton"
  },
  Event_22189_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_22189_Desc = {
    Text = "Schwellung, Kontraktion, kurz vor dem Ausbruch"
  },
  Event_22189_Name = {
    Text = "Sternenmondton"
  },
  Event_22190_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_22190_Desc = {
    Text = "Obwohl es etwas ungestüm ist, warum nicht?\nBreche alle Barrieren und stürme zum Ziel.\nSelbst wenn du den See des Denkens in Aufruhr versetzt und wie Ikarus zur Sonne fliegst, hast du zumindest dein Ziel erreicht, oder?"
  },
  Event_22190_Name = {
    Text = "Denk-Labyrinth"
  },
  Event_22191_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_22191_Desc = {
    Text = [[
Dein Verstand ist ein Labyrinth und du bist Ariadne.
Niemand im Universum versteht das Labyrinth besser als du.
Niemand]]
  },
  Event_22191_Name = {
    Text = "Denk-Labyrinth"
  },
  Event_22192_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_22192_Desc = {
    Text = [[
Bei richtiger Stimmung wurde der dissonante Intervall etwas weicher.
Aber vielleicht kannst du noch mehr tun]]
  },
  Event_22192_Name = {Text = "Dissonanz"},
  Event_22193_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_22193_Desc = {
    Text = "Du bist Meister der Musik und auch ein gewöhnlicher Tölpel.\nDie Noten erfüllen unter deiner Kontrolle ihre Aufgaben, das fließende Leben ertönt endlich im Bereich"
  },
  Event_22193_Name = {Text = "Dissonanz"},
  Event_22194_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_22194_Desc = {
    Text = "Deine Stimme verschwindet in der Stille. Die Stille wird lauter und lauter, bis sie bricht und nur Trümmer hinterlässt"
  },
  Event_22194_Name = {
    Text = "Wasser der Vergangenheit"
  },
  Event_22195_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_22195_Desc = {
    Text = "Du wirst nicht leicht getäuscht und drehst dich entschlossen um und gehst"
  },
  Event_22195_Name = {
    Text = "Kriechender Riss"
  },
  Event_22293_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_22293_Desc = {
    Text = [[
In dem Moment, in dem ich den Stift hebe, brennt das Papier im Bereich, aschelt fallend in meine Hand,
als ich wieder zu mir komme, ist etwas mit dem Papier verschwunden]]
  },
  Event_22293_Name = {
    Text = "Einfache Konfession"
  },
  Event_22294_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_22294_Desc = {
    Text = "In dem Moment, in dem das Glaubensblatt in dem Bereich zerfällt, hörst du eine sanfte und schwache Fürsorge.\n „In dieser Situation an mich zu denken, ist die Ehre eines Lehrers.\n Aber es ist so lange her, dass ich das letzte Mal im Bereich war. Heute kann ich dir nur dies helfen...“"
  },
  Event_22294_Name = {
    Text = "Einfache Konfession"
  },
  Event_22295_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_22295_Desc = {
    Text = "In dem Moment, in dem das Glaubensblatt in dem Bereich zerfällt, hörst du einen dringenden Aufschrei.\n „Hüter, wenn du dich unwohl fühlst, lass es mich unbedingt wissen.\n Als Partner werde ich mein Bestes tun, um dir zu helfen.“"
  },
  Event_22295_Name = {
    Text = "Einfache Konfession"
  },
  Event_22296_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_22296_Desc = {
    Text = "In dem Moment, in dem das Glaubensblatt in dem Bereich zerfällt, hörst du ein kaltes Seufzen.\n „Es wäre schön, wenn du beim Mangel an Prüfungsleistungen so aktiv um Hilfe bitten könntest.“"
  },
  Event_22296_Name = {
    Text = "Einfache Konfession"
  },
  Event_22397_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_22397_Desc = {
    Text = "Dein Erscheinen lässt die Schatten verwirrt zurück, ein Sternenstrahl streift deine Schuhspitze, und die Menge löst sich plötzlich auf, nur der dichteste Schatten bleibt in deiner Hand"
  },
  Event_22397_Name = {
    Text = "Sternenmondbund"
  },
  Event_22398_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_22398_Desc = {
    Text = "Das laute Gemurmel verstummt abrupt, und die pechschwarzen Schatten wenden sich nacheinander dir zu und starren dich an. Von diesem gesichtslosen Antlitz scheinst du eine gewisse Ironie abzulesen..."
  },
  Event_22398_Name = {
    Text = "Sternenmondbund"
  },
  Event_22399_ChoiceDesc1 = {
    Text = "[Ruhig beobachten] Wähle 1 von 3 Befehlskarten aus, um ein Gebet zu erhalten: „(EnchantConfig.Arg1)\", infiziere „(Skill.Arg2)\""
  },
  Event_22399_ChoiceDesc2 = {
    Text = "[Fragen stellen] erhält 25 das schwarze Siegel"
  },
  Event_22399_Desc = {
    Text = "In der Verflechtung von Sternen und Mond sind Flüstern ununterbrochen zu hören. \n “Ist das die Person? @4 der Menschen...“ \n “In menschlicher Gestalt, letztendlich immer noch @3...“"
  },
  Event_22399_Name = {
    Text = "Sternenmondbund"
  },
  Event_22411_ChoiceDesc1 = {Text = "[Erledigt]"},
  Event_22411_Desc = {
    Text = "Billige, aber effektive Fallen!"
  },
  Event_22411_Name = {
    Text = "Falle herstellen"
  },
  Event_24254_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_24254_Desc = {
    Text = "Der Sturm des Wissens umgab Tulu, du tauschtet einen Blick und gingst gemeinsam in die Dunkelheit"
  },
  Event_24254_Name = {
    Text = "Aus dem Meer"
  },
  Event_24255_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_24255_Desc = {
    Text = "Der Sturm des Wissens umgab Tulu, und die lang anhaltende Trauer und Schuld breiteten sich im Raum aus"
  },
  Event_24255_Name = {
    Text = "Auge in Auge mit dem Abgrund"
  },
  Event_24256_ChoiceDesc1 = {
    Text = "[Tentakel halten]Tulus Hilfe annehmen"
  },
  Event_24256_Desc = {
    Text = "Sein Ansehen war wie ein großer Gegenstand, der ins Meer fiel, rüttelte die vor ihm liegende Region.\nDiese Kraft war archaisch, uralt und übertraf die Ewigkeiten.\nZum Glück wirst du nicht sein Feind sein, zumindest nicht im Moment"
  },
  Event_24256_Name = {
    Text = "Aus dem Meer"
  },
  Event_24257_ChoiceDesc1 = {
    Text = "[Tentakel halten]Mit Tulu reisen"
  },
  Event_24257_Desc = {
    Text = "Tulu atmete tief durch und sah aus der Ferne auf Miryam. \n Es schien, als würde er die Geschichte, alte Bekannte und sein eigenes Leben vermissen... \n Der komplexe Ausdruck auf seinem Gesicht hielt jedoch nur einen Augenblick an, dann wandte er den Blick von Miryams Gesicht ab. \n “Lass uns gehen, lass sie hinter uns.“"
  },
  Event_24257_Name = {
    Text = "Auge in Auge mit dem Abgrund"
  },
  Event_24277_ChoiceDesc1 = {
    Text = "[Schließe die Luke]"
  },
  Event_24277_Desc = {
    Text = "Ramona hielt den Schüler auf, der durch die Tür hereinstürmte. \n Der furchtlose und starke Schutzherr, der offensichtlich abgesehen von seinem völlig zerzausten Zustand nichts Ungewöhnliches aufwies, schien in ihren blauen Augen hinter der Brille verschwommen. \n Erst in dem Moment, als sie seine Hand ergriff, konnte Ramona bestätigen: Ihr habt euch wiedergefunden."
  },
  Event_24277_Name = {
    Text = "Freudiges Wiedersehen"
  },
  Event_24278_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_24278_Desc = {
    Text = "Ramona gab dir keine Chance zur Erklärung, sie zog dich in die düstere Kammer und schloss vorsichtig die Tür..."
  },
  Event_24278_Name = {
    Text = "Freudiges Wiedersehen"
  },
  Event_24540_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_24540_Desc = {
    Text = "“Sie ist dein starker Schild, dein scharfes Schwert.\nSie ist dein Partner, dein Begleiter, dein vertrauenswürdiger Freund—egal, wie sie sich verändert.“"
  },
  Event_24540_Name = {
    Text = "Eine fremde und doch vertraute Präsenz"
  },
  Event_24541_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_24541_Desc = {
    Text = "“Du... nein, das ist unmöglich, du in diesem Zyklus bist schon... und ich auch...“\nDie Stimme verschwindet mit der Gestalt, nur die Traurigkeit bleibt im Nebel"
  },
  Event_24541_Name = {
    Text = "vertraute, aber fremde Gestalt"
  },
  Event_24542_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_24542_Desc = {
    Text = "“Für die Welt, für die Menschheit, für alles, was uns wichtig ist.\nUnd vor allem — für dich.“"
  },
  Event_24542_Name = {
    Text = "Eine fremde und doch vertraute Präsenz"
  },
  Event_24543_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_24543_Desc = {
    Text = "Bevor du dich näherst, bemerkt er dich, seine Gestalt erstarrt, als wäre er schockiert oder tief traurig.\nBevor du etwas sagen kannst, verschwindet er mit dem Nebel"
  },
  Event_24543_Name = {
    Text = "vertraute, aber fremde Gestalt"
  },
  Event_24544_ChoiceDesc1 = {
    Text = "[Wer ist sie?]Ziehe zufällig 3 Befehlskarten, wähle 1 zur Kopie"
  },
  Event_24544_ChoiceDesc2 = {
    Text = "[Warum ist Sie so geworden?] Wähle 1 von 3 Befehlskarten aus, um ein Gebet zu erhalten: „(EnchantConfig.Arg1)\", infiziere „(Skill.Arg2)\""
  },
  Event_24544_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte 25 schwarze Siegel"
  },
  Event_24544_Desc = {
    Text = "Ein weiterer Nebel, eine weitere Gestalt. Diesmal siehst du sie klar und deutlich.\nEine Gestalt, die dir gleicht, in derselben Uniform, mit demselben Gesicht.\n„Du weißt, warum du hier bist,“ sagt die Person, „genauso wie du weißt, warum sie so geworden ist.“"
  },
  Event_24544_Name = {
    Text = "Eine fremde und doch vertraute Präsenz"
  },
  Event_24545_ChoiceDesc1 = {
    Text = "[Trost spenden] erhält Silberrelikt „(RelicConfig.Arg1)“, Infektion „(Skill.Arg2)“"
  },
  Event_24545_ChoiceDesc2 = {
    Text = "[Versuche näher zu kommen]Erhalte das Silberrelikt“(RelicConfig.Arg1)“，infiziere“(Skill.Arg2)“"
  },
  Event_24545_ChoiceDesc3 = {
    Text = "[Dreh dich um und verlasse]Erhalte 25 schwarze Siegel"
  },
  Event_24545_Desc = {
    Text = "Nebel hüllt deinen Weg ein.\nEine Gestalt erscheint im diffusen Licht, du kneifst die Augen zusammen, kannst aber ihr Gesicht nicht erkennen, nur bruchstückhafte Flüstern hören.\n„Warum... warum konnte ich nicht retten... ist das Schicksal wirklich unveränderlich...“"
  },
  Event_24545_Name = {
    Text = "vertraute, aber fremde Gestalt"
  },
  Event_35039_ChoiceDesc1 = {
    Text = "[Partner um Hilfe bitten] Erhalte eine Hochwertige Gravur (3 zur Auswahl, 1 wählen)"
  },
  Event_35039_ChoiceDesc2 = {
    Text = "[Filmset-Management durchführen]Erhalte goldenes Relikt“(RelicConfig.Arg1)“"
  },
  Event_35039_ChoiceDesc3 = {
    Text = "[Phänomenale Begeisterung anleiten]Schöpfung erhalten“(RelicConfig.Arg1)“"
  },
  Event_35039_Desc = {
    Text = "„In dem „Set-Guide von Meister Houdini“ steht klar, dass Casiah, also ich, als Produzentin und Regisseurin die Verantwortung und das Recht für den gesamten Film trägt. Daher, mutige Mitarbeiterin Casiah, wähle bitte deinen nächsten Aktionszeitplan!“\n„Aktionszeitplan? Warte mal, seit wann bin ich deine Mitarbeiterin?!“\n„Man muss die Gelegenheit nutzen, die Zeit kommt nicht zurück, zögere nicht länger!“"
  },
  Event_35039_Name = {
    Text = "Der Mythos des Produzenten"
  },
  Event_35103_ChoiceDesc1 = {
    Text = "[Verbinden]Arg2 Lebenspunkte heilen[ExDesc1][ExDesc2]"
  },
  Event_35103_ChoiceDesc2 = {
    Text = "[Meditation] wählt 1 Erwecker aus"
  },
  Event_35103_ChoiceDesc3 = {
    Text = "[verbanne]Entferne bis zu 3 Symptom-Karten, erhalte Arg2 schwarze Siegel"
  },
  Event_35103_Desc = {
    Text = "Du erkundest den Nebel, plötzlich leuchtet das Abzeichen auf deiner Brust schwach silbern. Wer ruft dich am anderen Ende des Kommunikators?"
  },
  Event_35103_Name = {
    Text = "Kontaktstelle"
  },
  Event_35103_Tips3 = {
    Text = "Derzeit besitzen Sie keine Symptom-Karten"
  },
  Event_35165_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_35165_Desc = {
    Text = "In der Zögerlichkeit hast du aktiv eine Kommunikationsanfrage an den mysteriösen Geldgeber gesendet. \n „Jetzt ist es zu spät, um zurückzuweichen. Ich bitte dich, Lord, sei großzügig und unterstütze mich...“ \n Am anderen Ende des Silberkern-Kommunikators ertönte ein besonders großzügiges Lachen, und schließlich stimmte die Person lachend deinem Anliegen zu. \n „Übrigens, bitte halte diese Angelegenheit unbedingt vor Ramona geheim.“"
  },
  Event_35165_Name = {
    Text = "Der Mythos des Produzenten"
  },
  Event_35236_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_35236_Desc = {
    Text = "Was macht die Schnittleitung? Du hast einen Stapel Dokumente herausgeholt, den Casiah dir heimlich in den Gnosis-Drucker gesteckt hat, und hast ihn sorgfältig durchgesehen. \nDann begann dein Kopf zu schmerzen. \nDie Verluste, die Lotan bei der Set-Gestaltung verursacht hat, die Snacks, die Aurita und Braun gegessen haben, die Erstattungsanträge für die magischen Kugeln, die Casiah gekauft hat... die Zahlungen liegen vor dir, und du musstest schmerzhaft auf dem Boden sitzen und rechnen. \nÜbrigens, was sind Casiahs magischen Kugeln?"
  },
  Event_35236_Name = {
    Text = "Der Mythos des Produzenten"
  },
  Event_35259_ChoiceDesc1 = {
    Text = "[Vertreibe die Illusion] Infiziere Symptom[ExDesc1][ExDesc2]."
  },
  Event_35259_ChoiceDesc2 = {
    Text = "[Verlassen]"
  },
  Event_35259_Desc = {
    Text = "Verschwommene Gesichter tauchen plötzlich auf, umgeben dich und stöhnen verzweifelt ohne Stimmbänder"
  },
  Event_35259_Name = {Text = "Illusion"},
  Event_35497_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_35497_Desc = {
    Text = "Hinter der phänomenalen Frenesie braucht man einen Antreiber, und wenn man von „Antreiber“ spricht, springt das Bild eines Mädchens mit grünen kurzen Haaren sofort in den Kopf. \n „Die erste Vermittlerin der Misaq Universität, Hanna Peaslee, steht Ihnen gerne zur Verfügung!“ \n „Wenn es sich um die erste Dienstanforderung des Schutzherrn handelt, genügt es, mit drei Curry-Menüs aus der Mensa zu bezahlen!“"
  },
  Event_35497_Name = {
    Text = "Der Mythos des Produzenten"
  },
  Event_35887_ChoiceDesc1 = {
    Text = "[Vorwärts]"
  },
  Event_35887_Desc = {
    Text = "Du enthüllst das Segel, doch es ist nichts darunter. Als du dich umdrehst, ist auch das Segel verschwunden.\nDie weiße Segel und das beinahe sichtbare Gesicht der Mädchen werden zu einer Botschaft - du bist auf deinem Weg nicht allein"
  },
  Event_35887_Name = {
    Text = "reines Segel"
  },
  Event_35888_ChoiceDesc1 = {
    Text = "[Segel setzen]"
  },
  Event_35888_Desc = {
    Text = "Hier weht kein Wind, doch es gibt ein makelloses weißes Segelboot, dessen Segel kraftvoll emporsteigt und auf der ruhigen, tiefblauen See steht. \n Du erblickst vage das Gesicht eines Mädchens; ihre Züge sind verschwommen, als ob sie durch einen Schleier oder eine fließende Wasseroberfläche betrachtet werden. Ihre Existenz scheint von allem um sie herum isoliert zu sein, und doch ist sie der Kern dieser Szene. \n Obwohl ihr Bild ständig in der Welle schwankt und mal klar, mal verschwommen erscheint, weißt du ohne Zweifel, wer sie ist."
  },
  Event_35888_Name = {
    Text = "reines Segel"
  },
  Event_35894_ChoiceDesc1 = {
    Text = "[Absturz]erhält 35 das schwarze Siegel, infiziert „(Skill.Arg2)“, weiter wählen"
  },
  Event_35894_ChoiceDesc2 = {
    Text = "[Weit weg gehen]"
  },
  Event_35894_Desc = {
    Text = "Die Stimme des Mädchens verbreitete sich in der Luft, verschwommen und fern wie eine Seifenblase"
  },
  Event_35894_Name = {Text = "Lebensrand"},
  Event_35895_ChoiceDesc1 = {
    Text = "[Immer wieder]erhält 30 das schwarze Siegel, infiziert „(Skill.Arg2)“, weiter wählen"
  },
  Event_35895_ChoiceDesc2 = {
    Text = "[Weit weg gehen]"
  },
  Event_35895_Desc = {
    Text = "Glieder sind schwer, der Nebel umschließt den schwachen Körper"
  },
  Event_35895_Name = {Text = "Lebensrand"},
  Event_35896_ChoiceDesc1 = {
    Text = "[Den Weg der Vorgänger lesen] Wähle 1 von 3 Befehlskarten aus, die das Gebet erhält: „(EnchantConfig.Arg1)\", infiziert „(Skill.Arg2)\""
  },
  Event_35896_ChoiceDesc2 = {
    Text = "[Eigene Wege schreiben]Erhalte ein Silberrelikt „(RelicConfig.Arg1)“, infiziere „(Skill.Arg2)“"
  },
  Event_35896_ChoiceDesc3 = {
    Text = "[Blick in die Dunkelheit]Erhalte 25 das schwarze Siegel"
  },
  Event_35896_Desc = {
    Text = "Wenn du in dem Bereich allein umherwanderst, wirst du dir sicherlich nicht so sicher über deinen Weg erscheinen wie jetzt.\nDie Fußstapfen im Bereich teilten sich in drei Wege, jeder Abdruck schrieb eine unsichtbare Zukunft"
  },
  Event_35896_Name = {Text = "Ausweg"},
  Event_35897_ChoiceDesc1 = {
    Text = "[Ihr helfen]"
  },
  Event_35897_ChoiceDesc2 = {
    Text = "[Sie ansehen]"
  },
  Event_35897_Desc = {
    Text = "Sie murmelte und drehte sich, bis sie vor dir stehen blieb.\nJemand hatte ihren Schlaf gestört, ihr Bewusstsein war an die Realität gebunden, aber ihre Seele blieb im verlorenen Reich"
  },
  Event_35897_Name = {
    Text = "Verlorenes Phantom"
  },
  Event_35898_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_35898_Desc = {
    Text = "In dieser undurchdringlichen Dunkelheit erstreckt sich eine Reihe unscharfer Fußspuren, wie die tiefen Spuren eines Nachtwanderers in einer unsichtbaren Wüste"
  },
  Event_35898_Name = {Text = "Ausweg"},
  Event_35899_ChoiceDesc1 = {
    Text = "[Gehen] Wähle 1 von 3 Befehlskarten aus, um ein Gebet zu erhalten: „(EnchantConfig.Arg1)\", infiziere „(Skill.Arg2)\""
  },
  Event_35899_Desc = {
    Text = "In deinen Augen spiegelt sich ein ferner Leuchtturm, der einsam am Rand der Dunkelheit steht und schwaches, aber festes Licht ausstrahlt, wie ein Führer im nächtlichen Meer, der umherirrende Seelen zur Ruhe am anderen Ufer ruft. \n Du kannst nicht anders, als ihm zu folgen, doch plötzlich ist der Boden unter deinen Füßen nicht mehr fest. \n Du trittst in ein Wasser, das im Schatten verborgen ist. Die Wasseroberfläche ist sanft wie Seide und verschlingt deine Schritte lautlos."
  },
  Event_35899_Name = {Text = "Blitz"},
  Event_35900_ChoiceDesc1 = {
    Text = "[Höre ihr zu]"
  },
  Event_35900_ChoiceDesc2 = {
    Text = "[Ignorier sie]"
  },
  Event_35900_Desc = {
    Text = "Du erkennst die Lichtquelle, es ist eine weibliche Gestalt.\nLicht strömt aus ihrem deformierten Kopf und bildet einen Weg ins Unbekannte.\n„Zurück nach... Li@2a...“"
  },
  Event_35900_Name = {
    Text = "Lange brennende Lichter"
  },
  Event_35901_ChoiceDesc1 = {
    Text = "[Nähe dich dem Leuchtturm]"
  },
  Event_35901_ChoiceDesc2 = {
    Text = "[Leuchtturm meiden]"
  },
  Event_35901_Desc = {
    Text = "An der Ecke, wo Realität und Traum aufeinandertreffen, entfaltet sich in dem flüchtigen Moment ein schreckliches Bild des Sturms vor dir. \n Es scheint, als würde eine riesige, unsichtbare Hand dich hochreißen, der Sturm brüllt wie ein wildes Tier, wirbelt Staub und Hoffnung auf, der Himmel ist düster und extrem bedrückend. \n Im Herzen des Sturms steht der Leuchtturm, der dort nicht sein sollte, er scheint ein Produkt der Fantasie zu sein, und doch wirkt er wie ein Relikt aus alten Legenden. Auf der Bühne des wütenden Sturms strahlt er einsam und tapfer ein schwaches Licht aus."
  },
  Event_35901_Name = {Text = "Sturmkern"},
  Event_35902_ChoiceDesc1 = {
    Text = "[Verlassen]Erhalte 50 schwarze Siegel"
  },
  Event_35902_Desc = {
    Text = "“Im Bereich, die Lichter brennen lange, mit bewusstlosen Phantasmen ...“\nTulu schloss die Augen, dachte nach und seufzte schließlich tief.\n„Der Torwächter von Lemuria... eine meiner Diener. Sie konnte letztendlich auch nicht dem Band der Besessenheit entkommen.““"
  },
  Event_35902_Name = {
    Text = "Das Sinken der Sonanir"
  },
  Event_35903_ChoiceDesc1 = {
    Text = "[Berühre das Silberlicht]Erhalte 25 schwarze Siegel"
  },
  Event_35903_ChoiceDesc2 = {
    Text = "[Gespräch mit dem Silberstrahl]Erhalte ein Silberrelikt „(RelicConfig.Arg1)“, infiziere „(Skill.Arg2)“"
  },
  Event_35903_Desc = {
    Text = "Ein perfekt passender Kommunikator wurde aufgebrochen, schwaches Licht strömt heraus – das ist wohl das erste Mal, dass der Silberkern mit der Außenwelt spricht"
  },
  Event_35903_Name = {
    Text = "Mithrilmonument"
  },
  Event_35904_ChoiceDesc1 = {
    Text = "[Verlassen]Erhalte Schöpfung“(RelicConfig.Arg1)“"
  },
  Event_35904_Desc = {
    Text = "“Die Frau mit dem leuchtenden Kopf?“ Elton zeigte sich überrascht, offensichtlich hatte er von den gelegentlichen Erscheinungen im Geheimgang des Frachters gehört, nur – \n “In der Nacht, als die Sonaniel sank... das war die Nacht, als ich Celeste erweckte, habe ich einen solchen Schatten im Sturm gesehen.“ \n “Ich habe mich definitiv nicht geirrt.“"
  },
  Event_35904_Name = {
    Text = "Das Sinken der Sonanir"
  },
  Event_35905_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_35905_Desc = {
    Text = "Vor dem Weg im Bereich in voller Gefahr, undurchdringlich.\n Deine Augen starren fest auf das unsichtbare Chaos, aber bevor du vom Chaos verschlungen wirst, hat dich die flüchtige Ramona gefangen genommen und in eine andere Richtung gezogen"
  },
  Event_35905_Name = {Text = "Ausweg"},
  Event_35906_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_35906_Desc = {
    Text = "Ist das die Frucht deiner geheimnisvollen Seele? Ist alles, was du jetzt erlebst, der Zusammenprall von Ich und Über-Ich? \n Je mehr du darüber nachdenkst, desto lauter und klarer wird das Geräusch in deinem Kopf. Dein Blick dringt in einen Nebel ein, und in dem Moment, in dem du gerade den Nebelmensch erblicken kannst, weist deine Seele dich zurück."
  },
  Event_35906_Name = {
    Text = "Verkehrtes Schicksal"
  },
  Event_35907_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_35907_Desc = {
    Text = "Es strömt in dir, wird zu furchtloser Kraft, die dich durch den Nebel und die Angst reißt"
  },
  Event_35907_Name = {
    Text = "Lichtverfolgung"
  },
  Event_35908_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_35908_Desc = {
    Text = "Mit der Konzentration des Bewusstseins und der inneren Ruhe beginnen die verworrenen Illusionen langsam zu schmelzen und ziehen schließlich wie eine zurückweichende Flut zurück.\nSchließlich verschwinden die Geräusche im Gehirn spurlos - aber wie viel wirst du vermissen? Das ist ungewiss"
  },
  Event_35908_Name = {
    Text = "Zukunftswarnung"
  },
  Event_35909_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_35909_Desc = {
    Text = "Die Seele verliert sich völlig im Tinnitus, du versuchst verzweifelt, dich zu befreien und den Schmerz zu verstehen, doch du schwebst nur am Rande des Bewusstseins"
  },
  Event_35909_Name = {Text = "Lebensrand"},
  Event_35910_ChoiceDesc1 = {
    Text = "[Verlassen]Erhalte eine Auswahl von 3 für 1 goldenes Relikt, infiziere“(Skill.Arg1)“"
  },
  Event_35910_Desc = {
    Text = "Du kannst jeden Lichtpunkt des Leuchtturms spüren, sie brennen und tanzen im Sturm, wie ein Ruf aus der Tiefe der Seele, der selbst in der heftigsten Angst nie aufhört, den Weg zu weisen"
  },
  Event_35910_Name = {Text = "Sturmkern"},
  Event_35911_ChoiceDesc1 = {
    Text = "[Verlassen]Erhalte eine Auswahl von 3 für 1 fortgeschrittenes Gebet"
  },
  Event_35911_Desc = {
    Text = "Ist es ein Symbol der Hoffnung oder ein Vorbote der Zerstörung?\nDu schaust es nicht mehr an, als ob seine Existenz nur ein sorgfältig inszenierter Traum wäre"
  },
  Event_35911_Name = {Text = "Sturmkern"},
  Event_35912_ChoiceDesc1 = {
    Text = "[Verworren]Erhalte 20 schwarze Siegel, infiziere „(Skill.Arg2)“"
  },
  Event_35912_ChoiceDesc2 = {
    Text = "[Weit weg gehen]"
  },
  Event_35912_Desc = {
    Text = "Dann legte sich ein seltsamer grauer Schleier über deine Augen. Kurz darauf merkst du, dass es dein halbtransparentes Augenlid ist"
  },
  Event_35912_Name = {Text = "Lebensrand"},
  Event_35913_ChoiceDesc1 = {
    Text = "[Verlassen]Zufällig 1 Erwecker erwecken, Infektion“(Skill.Arg1)“"
  },
  Event_35913_Desc = {
    Text = "Ein undefinierbares Gefühl der Resonanz erfüllt dein Herz.\nDoch Vernunft rät dir, sie zu ignorieren"
  },
  Event_35913_Name = {
    Text = "Lange brennende Lichter"
  },
  Event_35914_ChoiceDesc1 = {
    Text = "[Gehen] Wähle 1 von 3 Befehlskarten aus, um ein Gebet zu erhalten: „(EnchantConfig.Arg1)\", infiziere „(Skill.Arg2)\""
  },
  Event_35914_Desc = {
    Text = "Ihre Sprache war nie auf irgendeinem bekannten Monument eingraviert, doch sie verdichtete sich in der Luft zu tiefsten Buße und Rufen. Als käme sie von der anderen Seite der Zeit, die durch die Ablagerung der Jahre hindurchdrang, mit tiefem Heimweh zu einer fernen Heimat"
  },
  Event_35914_Name = {
    Text = "Lange brennende Lichter"
  },
  Event_35915_ChoiceDesc1 = {
    Text = "[Ihre Hand halten]zufällig 1 Silberrelikt aufwerten zu goldenem Relikt „(RelicConfig.Arg1)“"
  },
  Event_35915_ChoiceDesc2 = {
    Text = "[Besorgt sprechen] erhält Silberrelikt „(RelicConfig.Arg1)“, Infektion „(Skill.Arg2)“"
  },
  Event_35915_ChoiceDesc3 = {
    Text = "[Sie anstarren]Erhalte 25 schwarze Siegel"
  },
  Event_35915_Desc = {
    Text = "Murphy ist am Ende der Gruppe und geht Seite an Seite mit Celeste.\nDu konntest nicht anders, als häufig zurückzuschauen, doch Murphy schaute ständig auf ihre Schuhspitzen und verbarg ihren Ausdruck im Unbekannten."
  },
  Event_35915_Name = {
    Text = "Schmerzmanagement"
  },
  Event_35915_Tips1 = {
    Text = "Noch keine Silberrelikte"
  },
  Event_35916_ChoiceDesc1 = {
    Text = "[Kann mich nicht losreißen]erhalte 40 das schwarze Siegel, infiziere“(Skill.Arg2)“，setze fort die Auswahl"
  },
  Event_35916_ChoiceDesc2 = {
    Text = "[Umarme die Realität] erhält +25 das schwarze Siegel"
  },
  Event_35916_Desc = {
    Text = "@1@1 wird neu geboren, die Seele durchquert die Grenze zu @2, hat jedoch den Körper noch nicht vollständig umarmt. \nMurphys besorgte Worte entfernen sich immer weiter von deinem Bewusstsein, wie das Klagen der Krähen, das in deinen Ohren schwirrt, aber stets von der Barriere der Seele draußen gehalten wird."
  },
  Event_35916_Name = {Text = "Lebensrand"},
  Event_35917_ChoiceDesc1 = {
    Text = "[Verlassen]Wähle 1 Befehlskarte zum Kopieren, infiziere“(Skill.Arg1)“"
  },
  Event_35917_Desc = {
    Text = "Sie ist nur ein Geist, der in der Realität zurückgeblieben ist, ein unberührbares, aber unauslöschliches Relikt der Vergangenheit"
  },
  Event_35917_Name = {
    Text = "Verlorenes Phantom"
  },
  Event_35918_ChoiceDesc1 = {
    Text = "[Verlassen]Wähle eine von 3 Befehlskarten und erhalte ein Gebet:“(EnchantConfig.Arg1)“"
  },
  Event_35918_Desc = {
    Text = "In diesem Moment hörst du das feine Zerbrechen tief in deiner Seele. Wie der allmählich verblassende Rauch beginnt ihr Bild zu verschwommen und wird immer unrealistischer. \n Sie existiert nicht hier, es ist nur eine Projektion von Kapitän Eltons Erinnerungen. \n Doch das, was in deinem Herzen verweilt, ihr Verlust und ihre Verwirrung, ist nicht vorgetäuscht."
  },
  Event_35918_Name = {
    Text = "Verlorenes Phantom"
  },
  Event_35919_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_35919_Desc = {
    Text = "Im Moment der Berührung der Fingerspitzen überkam dich ein komplexes Gefühl – es war sowohl heiß als auch kalt.\nVergessene Seelen rufen nach ewiger Ruhe"
  },
  Event_35919_Name = {
    Text = "Mithrilmonument"
  },
  Event_35920_ChoiceDesc1 = {
    Text = "[Zündholz festhalten]erhöhe Arg1 Punkte maximale Gesundheit"
  },
  Event_35920_ChoiceDesc2 = {
    Text = "[Dem Inneren ins Gesicht sehen] 2 zufällige Befehlskarten erhalten ein Gebet: „(EnchantConfig.Arg1)\", infiziere 2 „(Skill.Arg2)\""
  },
  Event_35920_Desc = {
    Text = "In dieser gewaltigen Jagd verfolgt Goliath wie ein Raubtier in der Nacht, das jede Hoffnung verschlingen will. Doch diese gnadenlose Jagd hat dich nicht eingefroren, sondern das Feuer in deinem Inneren entfacht, das in deiner Brust immer heißer brennt"
  },
  Event_35920_Name = {
    Text = "Lichtverfolgung"
  },
  Event_35921_ChoiceDesc1 = {
    Text = "[Entschlüsseln]Erhalte zufällig 3 Befehlskarten aus dem Deck, wähle 1 Karte zum Kopieren"
  },
  Event_35921_ChoiceDesc2 = {
    Text = "[Es werden] Wähle 1 von 3 Befehlskarten aus, um ein Gebet zu erhalten: „(EnchantConfig.Arg1)\", infiziere „(Skill.Arg2)\""
  },
  Event_35921_ChoiceDesc3 = {
    Text = "[Ignoriere es]erhalte 25 das schwarze Siegel"
  },
  Event_35921_Desc = {
    Text = "Im Moment des ersten Schrittes zieht eine unsichtbare Erschütterung gewaltsam dein Bewusstsein, zwingt deine Augen, den Rand des Bereichs Chaos und Nichtigkeit zu betrachten"
  },
  Event_35921_Name = {
    Text = "Zukunftswarnung"
  },
  Event_35922_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_35922_Desc = {
    Text = "Es gibt bizarre Farben, die vor dir tanzen, es gibt Stimmen, die dir ins Ohr flüstern, oder flüchtige Szenen und verschwommene Gesichter, die miteinander verwoben sind, als würden sie eine unbekannte Geschichte erzählen. Diese Illusionen lassen dich fühlen, wie du allmählich von der Realität getrennt wirst und in einen Traum eintauchst, der sowohl vertraut als auch fremd ist."
  },
  Event_35922_Name = {
    Text = "Zukunftswarnung"
  },
  Event_35923_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_35923_Desc = {
    Text = "Das Zittern kam nicht von äußeren Geräuschen oder Berührungen, sondern von einer unbeschreiblichen Vorahnung tief in deinem Inneren. Es war wie ein Ruf aus der Zukunft, der in deinem Bewusstsein pulsierte"
  },
  Event_35923_Name = {
    Text = "Zukunftswarnung"
  },
  Event_35924_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_35924_Desc = {
    Text = "Ihre Hände wanderten unwillkürlich zu ihrer Brust, während sie versuchte, das erstickende Gefühl zu kontrollieren. \n Diese Angst ließ sie die Zähne zusammenbeißen und zwang sie, die Wellen der Schmerzen in ihrer Brust zu ignorieren. Jede kleine Verzerrung in Murphys Gesicht wurde von ihr schnell verborgen, mit einer schlechten Maske, um den Schmerz zu verbergen. \n — Bis du ihre Hand ergreifst, wird Überraschung zur Farbe in ihrem Gesicht."
  },
  Event_35924_Name = {
    Text = "Schmerzmanagement"
  },
  Event_35925_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_35925_Desc = {
    Text = "“Murphy? Geht es dir gut?“\n— Sie antwortet nicht.\nEtwas Unheimliches ergreift ihr Herz und macht ihr das Atmen schwer"
  },
  Event_35925_Name = {
    Text = "Schmerzmanagement"
  },
  Event_35926_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_35926_Desc = {
    Text = "Du zögerst nicht mehr und trittst in die dunkle Ungewissheit. Dein Weg zeichnet eine Linie, die sich zum schwachen Licht hin ausbreitet"
  },
  Event_35926_Name = {Text = "Ausweg"},
  Event_35927_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_35927_Desc = {
    Text = "Vor dir flackert ein Feuer.\nEs ist lebendig und umhüllt eine zitternde kalte Flamme, die die Disharmonien vertreibt.\nDu kommst zu dir und siehst Murphy, der dich fragend ansieht—\n“Geht es dir wirklich gut?“"
  },
  Event_35927_Name = {Text = "Lebensrand"},
  Event_35928_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_35928_Desc = {
    Text = "Du fühlst, wie dein Bewusstsein sich trennt, langsam aus deinem Körper gezogen wird.\nEs scheint, als ob deine Seele mit dem verbleibenden Bewusstsein des Silberkerns tanzt und dann in einen unsichtbaren Abgrund fällt...\nDort ist reine Leere"
  },
  Event_35928_Name = {
    Text = "Mithrilmonument"
  },
  Event_35929_ChoiceDesc1 = {
    Text = "[Verlassen]Erhalte 25 schwarze Siegel"
  },
  Event_35929_Desc = {
    Text = "Bevor du weiter nach der Quelle des Lichts forschen konntest, zitterte diese plötzlich und zerbrach in der Luft.\nDas Licht erzeugte Wellen im Bereich und breitete sich in alle Richtungen aus.\nDann blieb nichts zurück"
  },
  Event_35929_Name = {Text = "Blitz"},
  Event_35930_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_35930_Desc = {
    Text = "Wie könnte das du sein? \nWenn das du bist, warum hat Er dich nicht erlöst, als das Unglück kam? \nWenn das du bist, warum hat Er dir nicht geholfen, während du gelitten hast? \nAlso sind es alles Illusionen"
  },
  Event_35930_Name = {
    Text = "Verkehrtes Schicksal"
  },
  Event_35931_ChoiceDesc1 = {
    Text = "[Frage den Kapitän]"
  },
  Event_35931_ChoiceDesc2 = {
    Text = "[Frage Tulu]"
  },
  Event_35931_Desc = {
    Text = "Ein weiteres Mal siehst du die geheimnisvolle Gestalt in die Wand des Schiffs eintreten und spurlos verschwinden. Ihr fluoreszierendes langes Haar verwandelt sich an einem Punkt in mehrere Tentakel, die zu Boden hängen. \n Du bist dir absolut sicher, dass sie, selbst wenn sie kein Mitglied der Seefahrer ist, in irgendeiner Weise mit dem verlorenen Reich verbunden ist."
  },
  Event_35931_Name = {
    Text = "Das Sinken der Sonanir"
  },
  Event_35932_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_35932_Desc = {
    Text = "Du hast Angst, alles ist nur Adrenalin.\nDu fürchtest, dass deine Entscheidungen denen schaden, die die Dunkelheit mit dir teilen"
  },
  Event_35932_Name = {
    Text = "Lichtverfolgung"
  },
  Event_35933_ChoiceDesc1 = {
    Text = "[Es gibt kein Entkommen]erhalte 25 das schwarze Siegel, infiziere“(Skill.Arg2)“，setze fort die Auswahl"
  },
  Event_35933_ChoiceDesc2 = {
    Text = "[Weit weg gehen]"
  },
  Event_35933_Desc = {
    Text = "Jeder Nerv schreit nach @2"
  },
  Event_35933_Name = {Text = "Lebensrand"},
  Event_35934_ChoiceDesc1 = {
    Text = "[Verfolgen]"
  },
  Event_35934_ChoiceDesc2 = {
    Text = "[Ignorier es]"
  },
  Event_35934_Desc = {
    Text = "In der Ferne des Geheimgangs leuchtet ein schwaches und faszinierendes Licht auf. \n Es schimmert wie das Sonnenlicht, das sich auf der Wasseroberfläche bricht, tanzt wie die Sterne oder ist wie ein kleines Kerzenlicht... \n Als du näher kommen möchtest, verschwindet das Licht plötzlich. \n Es scheint dich zu verführen, wie die Motte, die von ihrem Instinkt geleitet wird."
  },
  Event_35934_Name = {Text = "Blitz"},
  Event_35935_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_35935_Desc = {
    Text = "Was bringt es, sich darüber den Kopf zu zerbrechen?\nDu bist ein Blatt, das in der Luft schwebt, und der Wind des Schicksals treibt dich nur voran"
  },
  Event_35935_Name = {
    Text = "Verkehrtes Schicksal"
  },
  Event_35936_ChoiceDesc1 = {
    Text = "[Selbstironie]Erhalte ein silbernes Relikt:“(RelicConfig.Arg1)“, Infektion“(Skill.Arg2)“"
  },
  Event_35936_ChoiceDesc2 = {
    Text = "[Frage nach dem Ende]Erhalte goldenes Relikt „(RelicConfig.Arg1)“, infiziere „(Skill.Arg2)“, „(Skill.Arg3)“"
  },
  Event_35936_ChoiceDesc3 = {
    Text = "[Nicht mehr denken]Erwirbt 25 das schwarze Siegel"
  },
  Event_35936_Desc = {
    Text = "Der Wind des Lebens bewegt deine Seele, wirbelt dich in den Strudel der Realität und zieht dich in das unbekannte Nebelmeer.\nDu fragst die Stimme in deinem Kopf: „Bin das ich?“"
  },
  Event_35936_Name = {
    Text = "Verkehrtes Schicksal"
  },
  Event_36146_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_36146_Desc = {
    Text = "Murphy bemerkte schließlich deinen Blick, vielleicht war er wirklich zu heiß.\nSie atmete tief durch, gab einen sanften „hm“ von sich. Schließlich folgte sie Celeste und blieb dicht hinter dir"
  },
  Event_36146_Name = {
    Text = "Schmerzmanagement"
  },
  Event_36722_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_36722_Desc = {
    Text = "Im Moment der Berührung der Fingerspitzen überkam dich ein komplexes Gefühl – es war sowohl heiß als auch kalt.\nVergessene Seelen rufen nach ewiger Ruhe"
  },
  Event_36722_Name = {
    Text = "Gnosismonument"
  },
  Event_36723_ChoiceDesc1 = {
    Text = "[Berühre es]Wache zufällig 1 Erwecker auf，infiziere“(Skill.Arg1)“"
  },
  Event_36723_ChoiceDesc2 = {
    Text = "[Drehen beitreten] erhält 3 aus 1 Orison"
  },
  Event_36723_Desc = {
    Text = "Im Moment des Schrittes öffnete sich eine stille Ritze in deinem Geist. Eine unbeschreibliche Tiefe wehte durch die Ritze und kräuselte dein Bewusstsein.\nDu spürst, wie ein silberner chaotischer Planet in deinem Inneren heimlich rotiert und wächst"
  },
  Event_36723_Name = {
    Text = "Gnosismonument"
  },
  Event_36724_ChoiceDesc1 = {
    Text = "[Folge ihnen]Erhalte das Silberrelikt“(RelicConfig.Arg1)“，infiziere“(Skill.Arg2)“"
  },
  Event_36724_ChoiceDesc2 = {
    Text = "[Streicheln sie] erhält goldenes Relikt „(RelicConfig.Arg1)“, Infektion „(Skill.Arg2)“, „(Skill.Arg3)“"
  },
  Event_36724_ChoiceDesc3 = {
    Text = "[Nicht stören]Erwirbt 25 das schwarze Siegel"
  },
  Event_36724_Desc = {
    Text = [[
Nach einer unerwarteten Kurve erscheint eine seltsame Szene vor deinen Augen.
Mehrere katzenartige Schatten huschen undeutlich an der kalten Schiffswand entlang.]]
  },
  Event_36724_Name = {
    Text = "Schiffskatze"
  },
  Event_36725_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_36725_Desc = {
    Text = "“Erinnerung“ antwortet nicht, sie kleben an der Wand und starren dich an, bis du um die nächste Ecke biegst"
  },
  Event_36725_Name = {
    Text = "Besitzer des Sonanir"
  },
  Event_36726_ChoiceDesc1 = {
    Text = "[Umweg machen]Entferne 1 Befehlskarte, erhalte Arg1 schwarzes Siegel"
  },
  Event_36726_ChoiceDesc2 = {
    Text = "[Warum gesunken]Kopiere 1 Befehlskarte, infiziere “(Skill.Arg1)“"
  },
  Event_36726_ChoiceDesc3 = {
    Text = "[Crewmitglied grüßen]wählt 1 von 3 Befehlskarten und erhält Orison: „(EnchantConfig.Arg1)“"
  },
  Event_36726_Desc = {
    Text = "Auf dem Weg zum Kraftwerk begegnetst du erneut einigen „Erinnerungen“, die im Bereich festgehalten sind.\nSie sind keine Geister, sondern nur Kapitän EltonS Sorge um die verstorbenen Mannschaftsmitglieder"
  },
  Event_36726_Name = {
    Text = "Besitzer des Sonanir"
  },
  Event_36727_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_36727_Desc = {
    Text = "“Erinnerung“ löste sich von der Wand ab, sein Gesicht verzerrte sich und ein klagender Schrei kam aus seiner Kehle. \n—— Leuchtturm. \n—— Ein isolierter Leuchtturm, der sie in den Sturm führte."
  },
  Event_36727_Name = {
    Text = "Besitzer des Sonanir"
  },
  Event_36728_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_36728_Desc = {
    Text = "Du hast gewählt, zu folgen, dem Verlauf der sanften und freien Seelen, auch wenn die Dunkelheit Fallen hinterlässt"
  },
  Event_36728_Name = {
    Text = "Schiffskatze"
  },
  Event_36729_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_36729_Desc = {
    Text = "Störe die Toten nicht, rühre nicht an die ruhenden Erinnerungen"
  },
  Event_36729_Name = {
    Text = "Besitzer des Sonanir"
  },
  Event_36730_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_36730_Desc = {
    Text = "Du fühlst, wie dein Bewusstsein sich trennt, langsam aus deinem Körper gezogen wird.\nEs scheint, als ob deine Seele mit dem Planeten tanzt und dann in einen unsichtbaren Abgrund fällt...\nDort ist reine Leere"
  },
  Event_36730_Name = {
    Text = "Gnosismonument"
  },
  Event_36731_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_36731_Desc = {
    Text = [[
Als sanfte Wesen sind sie ein Wunsch, den dieser Bereich nicht erlaubt, nur ein Phantasma.
Obwohl du dies verstehst, regt sich dennoch ein Hauch von warmen Wellen in deinem Herzen]]
  },
  Event_36731_Name = {
    Text = "Schiffskatze"
  },
  Event_36732_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_36732_Desc = {
    Text = "Ihre Gestalten sind verschwommen, wie ein Gemälde, das von der Zeit verwischt wurde. Die tiefschwarzen Flecken ähneln Wolken am Nachthimmel, ihre Augen leuchten wie ferne Sterne, geheimnisvoll und tief.\nDu kannst ihrer Verlockung nicht widerstehen und greifst in die Leere"
  },
  Event_36732_Name = {
    Text = "Schiffskatze"
  },
  Event_36733_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_36733_Desc = {
    Text = "Du weißt, dass du weitergehen musst, auch wenn du stolperst und fällst"
  },
  Event_36733_Name = {
    Text = "Körperlicher Schmerz"
  },
  Event_36734_ChoiceDesc1 = {
    Text = "[Versuche ihn zu rufen]Erhöhe Leben um Arg1"
  },
  Event_36734_ChoiceDesc2 = {
    Text = "[Verlassen]"
  },
  Event_36734_Desc = {
    Text = "Hier ist ein Ort voller verborgener Wünsche und unberührter Ängste, ein reiches Gemälde, das aus seinen Träumen und Erinnerungen gewebt ist"
  },
  Event_36734_Name = {
    Text = "Evolutionäre Verwandlung"
  },
  Event_36735_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_36735_Desc = {
    Text = "“Schutzherr, wenn du nicht mehr durchhalten kannst, bitte ertrage den Schmerz nicht alleine.“\nDu wirst dem Schmerz nicht entkommen, sie sind ein Teil des flüchtigen Lebens. \nDu wirst den Schatten der Nacht nicht meiden, denn du hast keine Angst, von der Dunkelheit verschlungen zu werden."
  },
  Event_36735_Name = {
    Text = "Körperlicher Schmerz"
  },
  Event_36736_ChoiceDesc1 = {
    Text = "[Rufe ihn weiter]Erhöhe Arg1 Leben, infiziere“(Skill.Arg2)“"
  },
  Event_36736_ChoiceDesc2 = {
    Text = "[Verlassen]"
  },
  Event_36736_Desc = {
    Text = "Naive Kritzeleien bilden diese Welt"
  },
  Event_36736_Name = {
    Text = "Evolutionäre Verwandlung"
  },
  Event_36737_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_36737_Desc = {
    Text = [[
Die Gebete der Seefahrer hallen wahnsinnig und erstickend in deinen Ohren.
Aber sie werden deinen Willen nicht beeinflussen, niemals]]
  },
  Event_36737_Name = {
    Text = "aus dem Meer"
  },
  Event_36738_ChoiceDesc1 = {
    Text = "[Heb das Foto auf] wähle 1 von 3 Befehlskarten, um Gebet zu erhalten: „(EnchantConfig.Arg1)“"
  },
  Event_36738_Desc = {
    Text = "Diese Blicke sind tief und klar, wie das Licht in der Tiefsee, hell und warm.\nSie sprechen nicht und zeigen sich nicht, aber du kannst ihre Anwesenheit spüren, wie eine sanfte Brise in einer Sommernacht"
  },
  Event_36738_Name = {
    Text = "Gutmütiger Späher"
  },
  Event_36739_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_36739_Desc = {
    Text = "Du zwingst dich, dich auf die aktuelle Krise zu konzentrieren und ignorierst den Schmerz"
  },
  Event_36739_Name = {
    Text = "Körperlicher Schmerz"
  },
  Event_36740_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_36740_Desc = {
    Text = "Das ist das Zeichen des Lebens, der Beweis des Daseins. Es erzählt Geschichten, doch unter dem Wüten des Sturms verliert es allmählich seine Stimme"
  },
  Event_36740_Name = {
    Text = "Auf Wiedersehen, Icarus"
  },
  Event_36741_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_36741_Desc = {
    Text = "Diese Blicke sind tief und klar, wie das Licht in der Tiefsee, hell und warm.\nSie sprechen nicht und zeigen sich nicht, aber du kannst ihre Anwesenheit spüren, wie eine sanfte Brise in einer Sommernacht"
  },
  Event_36741_Name = {
    Text = "Gutmütiger Späher"
  },
  Event_36742_ChoiceDesc1 = {
    Text = "[Letzter Ruf]Arg1 HP erhöhen, Infektion“(Skill.Arg2)“"
  },
  Event_36742_ChoiceDesc2 = {
    Text = "[Verlassen]"
  },
  Event_36742_Desc = {
    Text = "Risse des Schmerzes formen diese Welt"
  },
  Event_36742_Name = {
    Text = "Evolutionäre Verwandlung"
  },
  Event_36743_ChoiceDesc1 = {
    Text = "[Umarme den Schmerz] erhält Silberrelikt „(RelicConfig.Arg1)“, Infektion „(Skill.Arg2)“"
  },
  Event_36743_ChoiceDesc2 = {
    Text = "[Weigere dich gegen den Schmerz] erhält goldenes Relikt „(RelicConfig.Arg1)“, Infektion „(Skill.Arg2)“ und „(Skill.Arg3)“"
  },
  Event_36743_ChoiceDesc3 = {
    Text = "[Schmerz ignorieren]Erwirbt 25 das schwarze Siegel"
  },
  Event_36743_Desc = {
    Text = "Der Schmerz ist wie ein Hartgestein, tief verwurzelt im Gehirn. Die sich ausbreitende Qual ist wie eine Ranke, die jedes Nervengewebe umschlungen und dein Bewusstsein verzerrt"
  },
  Event_36743_Name = {
    Text = "Körperlicher Schmerz"
  },
  Event_36744_ChoiceDesc1 = {
    Text = "[Ihn fest rufen]Arg1 Leben erhöhen, Infektion“(Skill.Arg2)“"
  },
  Event_36744_ChoiceDesc2 = {
    Text = "[Verlassen]"
  },
  Event_36744_Desc = {
    Text = "Das Streben nach Anerkennung formte diese Welt"
  },
  Event_36744_Name = {
    Text = "Evolutionäre Verwandlung"
  },
  Event_36745_ChoiceDesc1 = {
    Text = "[Sie anstarren]Wähle 1 von 3 Befehlskarten und erhalte ein Gebet: „(EnchantConfig.Arg1)“"
  },
  Event_36745_ChoiceDesc2 = {
    Text = "[Um Hilfe bitten]infiziert „(Skill.Arg1)“, tauscht das erhaltene Orison aus, kann zweimal verwendet werden"
  },
  Event_36745_Desc = {
    Text = "In den fließenden Farben des Bereichs spürst du einen geheimnisvollen Blick, es sind unsichtbare Augen, die sich in den geheimnisvollen Falten dieses Bereichs verbergen. \n In dem Moment, als sie dich anblicken, steigt ein starkes Verlangen in dir auf."
  },
  Event_36745_Name = {
    Text = "Gutmütiger Späher"
  },
  Event_36746_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_36746_Desc = {
    Text = "Wenn du sie nicht verstehst, wirst du aus diesem chaotischen Gefängnis nicht entkommen können. \n Wenn die Sterne sich auf der Wasseroberfläche spiegeln, steigen die pulsierenden Wünsche und Bitten, diese Gebete, wie Blasen langsam zur Meeresoberfläche auf, werden jedoch unbemerkt von der Dunkelheit verschlungen."
  },
  Event_36746_Name = {
    Text = "aus dem Meer"
  },
  Event_36747_ChoiceDesc1 = {
    Text = "[Dringend rufen]Arg1 Lebenspunkte erhöhen, Infektion“(Skill.Arg2)“"
  },
  Event_36747_ChoiceDesc2 = {
    Text = "[Verlassen]"
  },
  Event_36747_Desc = {
    Text = "Hässliche Worte formen diese Welt"
  },
  Event_36747_Name = {
    Text = "Evolutionäre Verwandlung"
  },
  Event_36748_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_36748_Desc = {
    Text = "Du stehst vor ihm und siehst, wie seine Seele von seltsamen Erinnerungen verschlungen wird"
  },
  Event_36748_Name = {
    Text = "Evolutionäre Verwandlung"
  },
  Event_36749_ChoiceDesc1 = {
    Text = "[Das sind Tränen]Lösche 1 Karte"
  },
  Event_36749_ChoiceDesc2 = {
    Text = "[Das ist Blut]Erhalte“(RelicConfig.Arg1)“，Infektion“(Skill.Arg2)“"
  },
  Event_36749_Desc = {
    Text = "Einige Tropfen Flüssigkeit breiteten sich auf dem Deck aus, sickerten leise durch die Ritzen.\nDie Spuren waren sanft und entschlossen, jede Nässe trug eine endgültige Bedeutung, und im Brüllen des Meeres und dem Stöhnen des Schiffes entstand ein Bild von Leben und Tod, Ruhe und Lärm"
  },
  Event_36749_Name = {
    Text = "Auf Wiedersehen, Icarus"
  },
  Event_36750_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_36750_Desc = {
    Text = "Du starrst auf die sich langsam ausbreitenden Flecken und versuchst, ihre Natur zu erkennen, aber am Rand von Himmel und Erde verschwimmen die Unterschiede zwischen Regen und Blut.\nSind sie Regen? Tränen des Ozeans?\nDu weißt es nicht"
  },
  Event_36750_Name = {
    Text = "Auf Wiedersehen, Icarus"
  },
  Event_36751_ChoiceDesc1 = {
    Text = "[Weigere dich gegen Frequenzen] erhält 1 aus 3 Silberrelikte"
  },
  Event_36751_ChoiceDesc2 = {
    Text = "[Gemeinsam Frequenz finden] erhält Silberrelikt „(RelicConfig.Arg1)“, „(RelicConfig.Arg2)“, Infektion zweimal „(Skill.Arg3)“"
  },
  Event_36751_Desc = {
    Text = "Das Flüstern der Seefahrer und der Herzschlag des „Heiligen Kindes“ verschmelzen zu einer geheimen Symphonie. Jede Vibration löst ein Heulen im flüssigen Universum aus"
  },
  Event_36751_Name = {
    Text = "aus dem Meer"
  },
  Event_36752_ChoiceDesc1 = {
    Text = "[Heb das Foto auf] wähle 1 von 3 Befehlskarten, um Gebet zu erhalten: „(EnchantConfig.Arg1)“"
  },
  Event_36752_ChoiceDesc2 = {
    Text = "[Überprüfe den Film]Infiziere „(Skill.Arg1)“, tausche das erhaltene Gebet aus Option 1, kann noch einmal verwendet werden"
  },
  Event_36752_Desc = {
    Text = "Sie haben keine bösen Absichten, dieses Gefühl ist wie eine Intuition, die in deinem Blut und Knochen verwurzelt ist. \n Daher legst du deine Wachsamkeit ab und versuchst, diesen versteckten Wächtern um Hilfe zu bitten: Du teilst deine Verwirrung und Sehnsucht mit diesem vagen Wesen, als würdest du einem alten Freund deine innersten Gedanken anvertrauen, so wahrhaftig."
  },
  Event_36752_Name = {
    Text = "Gutmütiger Späher"
  },
  Event_36874_ChoiceDesc1 = {
    Text = "[Erzähle Interessantes über die Schule]Erhalte das Silberrelikt“(RelicConfig.Arg1)“"
  },
  Event_36874_ChoiceDesc2 = {
    Text = "[Nicht zur Schule gegangen]Erhalte 75 schwarze Siegel, infiziere „(Skill.Arg2)“"
  },
  Event_36874_Desc = {
    Text = "Als sie an einer Ruine vorbeikamen, leuchteten Auritas Augen plötzlich auf.\n“Großmutter sagte, das hier war früher eine Schule, aber weil es keine Schüler gab, ist es schon lange verwahrlost!“\n“Aurita ist nie zur Schule gegangen, und was ist mit den Freunden? Bist du jemals zur Schule gegangen?“"
  },
  Event_36874_Name = {
    Text = "Verlorene Freude"
  },
  Event_36875_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_36875_Desc = {
    Text = "Nachdem sie die negative Antwort von dir erhalten hatte, schüttelte Aurita betrübt den Kopf.\n„So gibt es in der äußeren Welt also auch keine Schüler... Warum wurde dann ursprünglich die Schule gegründet?“"
  },
  Event_36875_Name = {
    Text = "Verlorene Freude"
  },
  Event_36876_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_36876_Desc = {
    Text = "“Armenseele, kleine Maus, Wachsfigur... Juhu! Ein Abenteuer, ein Abenteuer!“\nAurita sagte das, während über ihrem Kopf ein unsichtbares Fragezeichen schwebte. \n“Aber Großmutter hat gesagt, die Schule ist ein Ort, der Aurita klüger machen wird, aber...“ \nBevor Aurita weiter nachdenken konnte, schobst du sie um die nächste Ecke."
  },
  Event_36876_Name = {
    Text = "Verlorene Freude"
  },
  Event_36877_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_36877_Desc = {
    Text = "“W-warum?“\nAurita war von dir erschrocken und wies dich mit ernstem Gesicht weiter an.\n“Das hier ist Auritas Zuhause, Aurita weiß, der Platz – ist genau da drinnen!“"
  },
  Event_36877_Name = {
    Text = "Unsichtbare Dunkelheit"
  },
  Event_36878_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_36878_Desc = {
    Text = "“Ich will diesen Weg nicht gehen. Kennt Aurita einen anderen Weg zum Platz?“\nAurita runzelte die Stirn, zog aber schließlich an deinem Umhang und wies in eine andere Richtung"
  },
  Event_36878_Name = {
    Text = "Unsichtbare Dunkelheit"
  },
  Event_36879_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_36879_Desc = {
    Text = "Dies ist ein Traum, es ist nur ein Traum.\nDu wiederholst es immer wieder, oder besser gesagt, beruhigst dich dabei selbst, während du Aurita anführst, um in die unsichtbare Dunkelheit zu dringen"
  },
  Event_36879_Name = {
    Text = "Unsichtbare Dunkelheit"
  },
  Event_36880_ChoiceDesc1 = {
    Text = "[Ihr gehorchen]wählt 1 von 3 Befehlskarten und erhält Orison: „(EnchantConfig.Arg1)“, infiziert „(Skill.Arg2)“"
  },
  Event_36880_ChoiceDesc2 = {
    Text = "[Gegen sie]wählt 1 Erwecker zum Erwachen, infiziert „(Skill.Arg1)“"
  },
  Event_36880_ChoiceDesc3 = {
    Text = "[Mit ihr beraten]erhält 25 das schwarze Siegel"
  },
  Event_36880_Desc = {
    Text = "Aurita zieht deinen Umhang und schreitet Schritt für Schritt in deinen Fußstapfen voran. \n “Hä... das ist falsch! Der Platz ist in die andere Richtung!“ \n Du drehst dich in die Richtung, die Aurita zeigt, aber die Gassen im Geheimgang sind offensichtlich von Dunkelheit erfüllt. A-Schleim und Mutanten winden sich und verflechten sich gegenseitig und ziehen die reale Welt mit in den Abgrund des Falls."
  },
  Event_36880_Name = {
    Text = "Unsichtbare Dunkelheit"
  },
  Event_37983_ChoiceDesc1 = {
    Text = "[Finanzmittel erhalten]Erhalte Arg1 schwarze Siegel"
  },
  Event_37983_ChoiceDesc2 = {
    Text = "[Finanzmittel erhalten]Erhalte Arg1 schwarze Siegel[ExDesc1]"
  },
  Event_37983_Desc = {
    Text = "“Kein Herrscher wird einen unbekannten Kerl einfach so dulden, geschweige denn einen Mönch.“\nDie Königin sitzt auf ihrem hohen Thron, in ihren Augen blitzt plötzlich eine Spur von Grausamkeit auf.\n“Beweise, dass du noch von Nutzen bist, sonst...“\nVon Nutzen? Du blickst aus dem Fenster auf die öden Felder, und ein Gedanke steigt plötzlich auf: Vielleicht könntest du dein Wissen in Wirtschaftswissenschaften nutzen, um Wanda bei der Verwaltung des Anwesens zu helfen?\nDu versuchst verzweifelt, in deinem kargen, glatten Gehirn zu kramen – denn in Misaq ist Wirtschaftswissenschaft nur ein unbedeutendes Wahlfach...\nDie Geduld ist erschöpft. Die Königin gähnt.\n“Enttäuschend. Freigeben –“\nIn dem Moment, als das Fallbeil herabsaust, erscheinen die Geister großer Vorfahren wie Adam Smith, Malthus, David Ricardo in deinem kleinen Kopf.\nArbeitsteilung! Besteuerung! Bevölkerung, verdammte Bevölkerung!\nVielleicht, wahrscheinlich ist dir etwas eingefallen."
  },
  Event_37983_Name = {
    Text = "Geheime Befehle"
  },
  Event_37984_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_37984_Desc = {
    Text = "Du machst widerwillig einen Vorschlag.\nDie Königin wirft einen kurzen Blick darauf und lächelt kalt:\n“Wenn es nicht funktioniert, weißt du, was passieren wird.“"
  },
  Event_37984_Name = {
    Text = "Geheime Befehle"
  },
  Event_37985_ChoiceDesc1 = {
    Text = "[Verordnung vorlegen]erhalte Silberrelikt „(RelicConfig.Arg1)“"
  },
  Event_37985_ChoiceDesc2 = {
    Text = "[Verordnung vorlegen]erhalte verfluchtes Relikt „(RelicConfig.Arg1)“"
  },
  Event_37985_ChoiceDesc3 = {
    Text = "[Verordnung vorlegen]erhalte goldenes Relikt „(RelicConfig.Arg1)“"
  },
  Event_37985_Desc = {
    Text = "“Du hast mein Geld genommen, also musst du für mich arbeiten.“\nDie Königin stützt ihren Kopf auf eine Hand und schaut dich gelangweilt an.\nOb sie es zugibt oder nicht, sie ist neugierig.\n“Also, erzähl mir deinen Plan, großer Reformer.“"
  },
  Event_37985_Name = {
    Text = "Geheime Befehle"
  },
  Event_38700_ChoiceDesc1 = {
    Text = "[Verbinden]Arg2 Lebenspunkte heilen[ExDesc1]"
  },
  Event_38700_ChoiceDesc2 = {
    Text = "[Meditation] wählt 1 Erwecker aus"
  },
  Event_38700_ChoiceDesc3 = {
    Text = "[verbanne]Entferne bis zu 3 Symptom-Karten, erhalte Arg2 schwarze Siegel"
  },
  Event_38700_Desc = {
    Text = "Du erkundest den Nebel, plötzlich leuchtet das Abzeichen auf deiner Brust schwach silbern. Wer ruft dich am anderen Ende des Kommunikators?"
  },
  Event_38700_Name = {
    Text = "Kontaktstelle"
  },
  Event_38700_Tips3 = {
    Text = "Derzeit besitzen Sie keine Symptom-Karten"
  },
  Event_38707_ChoiceDesc1 = {
    Text = "[Vertreibe die Illusion]Infiziere Symptom"
  },
  Event_38707_ChoiceDesc2 = {
    Text = "[Illusion absorbieren]verliert Arg1 Leben, erhält Arg2 das schwarze Siegel"
  },
  Event_38707_ChoiceDesc3 = {
    Text = "[Verlassen]"
  },
  Event_38707_Desc = {
    Text = "Verschwommene Gesichter tauchen plötzlich auf, umgeben dich und stöhnen verzweifelt ohne Stimmbänder"
  },
  Event_38707_Name = {Text = "Illusion"},
  Event_38715_ChoiceDesc1 = {
    Text = "[Verordnung vorlegen]erhalte Silberrelikt “(RelicConfig.Arg1)““(RelicConfig.Arg2)“"
  },
  Event_38715_ChoiceDesc2 = {
    Text = "[Verordnung vorlegen]erhalte verfluchtes Relikt „(RelicConfig.Arg1)“"
  },
  Event_38715_ChoiceDesc3 = {
    Text = "[Verordnung vorlegen]erhalte goldenes Relikt „(RelicConfig.Arg1)“"
  },
  Event_38715_Desc = {
    Text = "“Du hast mein Geld genommen, also musst du für mich arbeiten.“\nDie Königin stützt ihren Kopf auf eine Hand und schaut dich gelangweilt an.\nOb sie es zugibt oder nicht, sie ist neugierig.\n“Also, erzähl mir deinen Plan, großer Reformer.“"
  },
  Event_38715_Name = {
    Text = "Geheime Befehle"
  },
  Event_40452_ChoiceDesc1 = {
    Text = "[Nach der Identität fragen] Wähle 1 von 3 Befehlskarten aus, die das Gebet erhält: [(EnchantConfig.Arg1)]"
  },
  Event_40452_ChoiceDesc2 = {
    Text = "[Verlassen]Zufällig 3 Befehlskarten erhalten: Fortgeschrittenes Gebet:“(EnchantConfig.Arg1)“, Infektion“(Skill.Arg2)“"
  },
  Event_40452_Desc = {
    Text = "Drei Geister blockieren den Weg.\nSie sitzen am Spieltisch und starren auf die Würfel.\n„Gluck, gluck.“\nDie Würfel werden immer wieder geworfen.\nEin endloses Spiel"
  },
  Event_40452_Name = {
    Text = "Endloses Glücksspiel"
  },
  Event_40453_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_40453_Desc = {
    Text = "“Hallo, wir sind Wandas erster, zweiter und dritter Ehemann.“\n“Was, du fragst, wo der vierte Ehemann ist?“\nHm... ehrlich gesagt, John hatte wenig Humor, also hat ihn die Dame in einen blinden Diener verwandelt.“\n“Wir bedauern seinen Verlust. Natürlich nur ein wenig.“"
  },
  Event_40453_Name = {
    Text = "Endloses Glücksspiel"
  },
  Event_40454_ChoiceDesc1 = {
    Text = "[Handshake]Zufällig erweckt 1 Erwecker, infiziert „(Skill.Arg1)“"
  },
  Event_40454_ChoiceDesc2 = {
    Text = "[Verlassen]Erhalte eine Auswahl von 3 für 1 Gebet"
  },
  Event_40454_Desc = {
    Text = "Als ihr an einem Käfig vorbeikommt, streckt sich eine Hand heraus.\n„Verlass mich nicht, Rebecca...“\nDie Stimme ist alt und brüchig, wie ein alter Blasebalg"
  },
  Event_40454_Name = {Text = "Gefangener"},
  Event_40455_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_40455_Desc = {
    Text = "Eine klebrige Berührung kommt von deiner Handfläche - es ist D-Schleim. \nDer Besitzer der Stimme war schnell verschwunden und verbarg sich in dem dunklen Schatten in der Ecke"
  },
  Event_40455_Name = {Text = "Gefangener"},
  Event_40456_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_40456_Desc = {
    Text = "Du gehst gleichgültig weg und verpasst die dramatische Geschichte auf der Rückseite des Briefpapiers.\nAber was macht das schon?\nWeite Ozeane, Sonnenauf- und -untergänge, Wüstensand...\nDu wirst mehr erleben und mehr verpassen"
  },
  Event_40456_Name = {
    Text = "An meine verehrte Dame"
  },
  Event_40457_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_40457_Desc = {
    Text = [[
In gewisser Weise bist du nicht anders als dieser Gefangene.
Jetzt ist nicht die Zeit, ihn zu alarmieren.
Du ignorierst die Bitten des Gefangenen und gehst weg]]
  },
  Event_40457_Name = {Text = "Gefangener"},
  Event_40458_ChoiceDesc1 = {
    Text = "[Reiß den Brief ab]wähle 1 Relikt und verwandle es in ein verfluchtes Relikt“(RelicConfig.Arg1)“"
  },
  Event_40458_ChoiceDesc2 = {
    Text = "[Ignoriere den Brief]erhalte ein Silberrelikt“(RelicConfig.Arg1)“，infiziere“(Skill.Arg2)“"
  },
  Event_40458_ChoiceDesc3 = {
    Text = "[Antwort schreiben]erhält 25 das schwarze Siegel"
  },
  Event_40458_Desc = {
    Text = "Ⅰ.Brief  John Cambrian an Wanda (vor @2 Jahren der Überschwemmung)\n\nEhemänner haben das Recht, über ihre Frauen zu verfügen, zumindest war das im Kambrisch so.\nAber ich habe offensichtlich dein Maß an Wahnsinn unterschätzt. Jetzt sind meine Augen fast blind, und meine Gliedmaßen werden bald abgetrennt.\nDie Tochter des Teufels. Die Tochter des Teufels... nein, du bist der Teufel selbst.\nIch verfluche dich @1 verfluche dich @2 verfluche dich verfluche dich..."
  },
  Event_40458_Name = {
    Text = "An meine verehrte Dame"
  },
  Event_40459_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_40459_Desc = {
    Text = "Du hast den Fluch auf die einfachste Weise gelöst.\nNichts ist passiert. Das Papier fällt leblos zu Boden.\nDu zuckst mit den Schultern und gehst, aber ein ungutes Gefühl bleibt"
  },
  Event_40459_Name = {
    Text = "An meine verehrte Dame"
  },
  Event_40460_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_40460_Desc = {
    Text = "Du gehst ohne Ablenkung am Spieltisch vorbei.\nBevor du gehst, sprechen die Geister im Chor:\n“Grüße bitte unsere gemeinsame Ex-Frau, Frau Wanda, von uns.“"
  },
  Event_40460_Name = {
    Text = "Endloses Glücksspiel"
  },
  Event_40461_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_40461_Desc = {
    Text = "Am Ende des Briefes schreibst du ordentlich: \n„Der Fluch ist angekommen, alles Gute.“\nIm Moment, in dem du den letzten Strich machst, entzündet sich der Brief in wütenden blauen Flammen.\nDu erhältst Asche"
  },
  Event_40461_Name = {
    Text = "An meine verehrte Dame"
  },
  Event_44187_ChoiceDesc1 = {
    Text = "[Stelle dich der Dunkelheit][ExDesc1][ExDesc2]"
  },
  Event_44187_ChoiceDesc2 = {
    Text = "[Stelle dich der Dunkelheit][ExDesc1][ExDesc2]"
  },
  Event_44187_ChoiceDesc3 = {
    Text = "[Entkommen der Dunkelheit]Erhalte zufälliges goldenes Relikt"
  },
  Event_44187_Desc = {
    Text = "Die Seele vor dir ist düster und verunreinigt—Licht und Dunkelheit existieren gleichzeitig in ihr. Sie kämpfen um die Vorherrschaft, während die Seele in Verwirrung gerät. \n “Ich habe Mitleid mit ihnen, den armen Menschen, die alles verloren haben, aber ist die Welt nicht genau so? \n Wo jemand gewinnt, verliert ein anderer. \n Muss ich mein Glück aufgeben, um das Glück anderer zu sichern?“"
  },
  Event_44187_Name = {
    Text = "Innere Dunkelheit"
  },
  Event_44188_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_44188_Desc = {
    Text = "“Das ist meine Sünde, meine Last. Wie kann ich dich retten, meine widersprüchliche Seele?“"
  },
  Event_44188_Name = {
    Text = "Innere Dunkelheit"
  },
  Event_44299_ChoiceDesc1 = {
    Text = "[Zum Bischof beten]reinigt verfluchtes Relikt, wenn kein verfluchtes Relikt vorhanden, erhält zufälliges goldenes Relikt"
  },
  Event_44299_Desc = {
    Text = "“Ich habe betrogen, um das Leben zu bekommen, das ich wollte – Geld wurde zu Zahlen, Delikatessen wurden zu Alltagsgerichten, geschäftlich bin ich unnachgiebig, politisch bin ich hart. Aber warum, warum kann ich die Menschen nicht vergessen, denen ich alles genommen habe? Warum kann ich die Verzweiflung in ihren Gesichtern nicht vergessen? \n Alkohol bietet nur vorübergehende Flucht, meine Seele zerreißt sich selbst, der Schmerz droht mich zu ertränken. \n Was soll ich nur tun?“"
  },
  Event_44299_Name = {
    Text = "Schuld und Vergebung"
  },
  Event_44301_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_44301_Desc = {
    Text = "“Du gehst den Weg des Leidens, du bist vom Licht des Vaters abgekommen.\n“Kehre zurück, verlorenes Schaf, folge den Lehren des Vaters und finde den rechten Weg.“"
  },
  Event_44301_Name = {
    Text = "Schuld und Vergebung"
  },
  Event_44395_ChoiceDesc1 = {
    Text = "[Erbitte äußere Dinge]Der Bischof erträgt dein 1 Symptom, du erhältst Arg1 schwarze Siegel. Wenn es kein Symptom gibt, erhalte direkt schwarze Siegel"
  },
  Event_44395_ChoiceDesc2 = {
    Text = "[Erbitte Blut]Der Bischof erträgt deine 2 Symptome, du erhältst das Gebet „(EnchantConfig.Arg1)“"
  },
  Event_44395_ChoiceDesc3 = {
    Text = "[Mehr fordern]Bischof übernimmt mehr Symptome (mindestens 4)"
  },
  Event_44395_Desc = {
    Text = "Die illusorische Seele formt eine verschwommene Kontur, sie kniet vor dem Bischof und zeigt ihren zerbrochenen Körper und das verbliebene schwarze Innere. \n “Du gibst mir Führung, du gibst mir Vergebung, du gibst mir Erlösung, aber gnädiger Bischof, das ist bei weitem nicht genug. \n Ich bin arm und elend, von Krankheiten geplagt. Mein Leben hängt am seidenen Faden, und du bist meine einzige Erlösung. Hilf mir, Bischof, lass mich nicht länger leiden.“"
  },
  Event_44395_Name = {
    Text = "Bischofs “Segen“"
  },
  Event_44396_ChoiceDesc1 = {
    Text = "[Verbeugen und gehen]"
  },
  Event_44396_Desc = {
    Text = "Der Bischof zog den Ring ab und nahm die Brosche ab. Die blauen Edelsteine, die den All-Vater symbolisierten, wurden nacheinander in die Hände der Seele gelegt, der Bischof beugte sich hinunter und hielt die Hände der armen Seele. \n “Nimm mein Gold und Silber, nimm all meinen Besitz – solange du es brauchst. Die Lehren des All-Vaters genügen mir, um zu leben.“"
  },
  Event_44396_Name = {
    Text = "Bischofs “Segen“"
  },
  Event_44400_ChoiceDesc1 = {
    Text = "[Darin versinken]Infektion“(Skill.Arg1)“，zufälliges Erwachen eines Körpers"
  },
  Event_44400_ChoiceDesc2 = {Text = "[Aufgeben]"},
  Event_44400_Desc = {
    Text = "Die verlorene Seele will die Dunkelheit nicht aufgeben.\nDu weißt, was sie erwartet. Ein absurdes Leben wird beginnen, und du bist der einzige Zuschauer"
  },
  Event_44400_Name = {
    Text = "Innere Dunkelheit"
  },
  Event_44401_ChoiceDesc1 = {
    Text = "[Schnell und präzise]Erhalte Arg1 das schwarze Siegel"
  },
  Event_44401_ChoiceDesc2 = {
    Text = "[Ungehemmt rauben]Erhalte 3 wähle 1 Fortgeschrittenes Gebet, Infektion“(Skill.Arg1)“"
  },
  Event_44401_Desc = {
    Text = "Die schwarzen Spuren, die im Bereich gefunden werden, können angeboten werden, um die D-Marke zu opfern und um Projektionen stattfinden zu lassen. Sie verschwinden schnell zu schwarzem Schlamm, wenn du das aktuelle Gebiet verlässt"
  },
  Event_44401_Name = {
    Text = "Schwarzes Mal"
  },
  Event_44407_ChoiceDesc1 = {
    Text = "[Vertreibe die Illusion]Infiziere Symptom"
  },
  Event_44407_ChoiceDesc2 = {
    Text = "[Umarme das Trugbild] erhält 2 zufällige Symptome, erhält Arg1 das schwarze Siegel"
  },
  Event_44407_ChoiceDesc3 = {
    Text = "[Verlassen]"
  },
  Event_44407_Desc = {
    Text = "Verschwommene Gesichter tauchen plötzlich auf, umgeben dich und stöhnen verzweifelt ohne Stimmbänder"
  },
  Event_44407_Name = {Text = "Illusion"},
  Event_44445_ChoiceDesc1 = {
    Text = "[Verlassen]Suche Scheinwerfer"
  },
  Event_44445_ChoiceDesc2 = {
    Text = "[In den Nebel eindringen]Verliere Arg2 Leben"
  },
  Event_44445_ChoiceDesc3 = {
    Text = "[Äußere Dinge ablegen]Zahle 5 schwarze Siegel, erhalte 1 „Inspiration“"
  },
  Event_44445_Desc = {
    Text = "Vor uns liegt ein dichter schwarzer Nebel, ein unvorsichtiger Eintritt wird zu Katastrophen führen.\nVielleicht solltest du \"Die Scheinwerfer\" finden, um den Nebel zu vertreiben"
  },
  Event_44445_Name = {Text = "unbekannt"},
  Event_44469_ChoiceDesc1 = {
    Text = "[Erbitte Fleisch und Blut]Der Bischof erträgt deine 4 Symptome, du erhältst 3-wählen-1 goldenes Relikt+"
  },
  Event_44469_ChoiceDesc2 = {
    Text = "[Erbitte Segen]Der Bischof erträgt deine 6 Symptome, du erhältst 3-wählen-1 Chrono-Pendel"
  },
  Event_44469_ChoiceDesc3 = {
    Text = "[Zurückkehren]"
  },
  Event_44469_Desc = {
    Text = "Die illusorische Seele formt eine verschwommene Kontur, sie kniet vor dem Bischof und zeigt ihren zerbrochenen Körper und das, was von ihrem schwarzen Inneren übrig geblieben ist. \n “Du gibst mir Führung, gibst mir Vergebung, gibst mir Erlösung, aber gnädiger Bischof, das ist bei weitem nicht genug. \n Ich bin arm und elend, geplagt von Krankheit. Mein Leben hängt am seidenen Faden, und du bist meine einzige Erlösung. Hilf mir, Bischof, damit ich nicht mehr leiden muss.“"
  },
  Event_44469_Name = {
    Text = "Bischofs “Segen“"
  },
  Event_44474_ChoiceDesc1 = {
    Text = "[Suchen] den Segen des Bischofs erhalten"
  },
  Event_44474_ChoiceDesc2 = {
    Text = "[Suchen] den Segen des Bischofs erhalten"
  },
  Event_44474_ChoiceDesc3 = {
    Text = "[Verlassen]"
  },
  Event_44474_Desc = {
    Text = "“Das ist meine Sünde, meine Last. Wie kann ich dich retten, meine widersprüchliche Seele?“"
  },
  Event_44474_Name = {
    Text = "Innere Dunkelheit"
  },
  Event_44911_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_44911_Desc = {
    Text = "“Alles, alles... ja, ich will alles...!“\nDie Seele streckte die Hand aus, griff vergeblich in die Luft.\nSie gewann etwas, aber doch nichts"
  },
  Event_44911_Name = {
    Text = "Was hast du erhalten"
  },
  Event_44913_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_44913_Desc = {
    Text = "“Dann nur das Wichtigste, das Wichtigste...“\nDie Seele hockte sich hin, grub einen leuchtenden Wunsch aus dem Nichts und hielt ihn in den Händen"
  },
  Event_44913_Name = {
    Text = "Was hast du erhalten"
  },
  Event_44916_ChoiceDesc1 = {
    Text = "[Alles festhalten] Wähle 1 von 3 Befehlskarten aus, die das Gebet erhält: [(EnchantConfig.Arg1)]"
  },
  Event_44916_ChoiceDesc2 = {
    Text = "[Lehren loszulassen]erhalte 3 zufällige Befehlskarten und erhalte das Gotteszeichen: „(EnchantConfig.Arg1)“, Infektion „(Skill.Arg2)“"
  },
  Event_44916_Desc = {
    Text = "Die dunkle Seele ist in Schmerz gefangen.\nSie wandert umher, verwirrt von allen möglichen Entscheidungen und Konsequenzen.\n„Was soll ich wählen?“ flüstert sie, „Was soll ich tun?“\n„Wie kann ich alles haben?“"
  },
  Event_44916_Name = {
    Text = "Was hast du erhalten"
  },
  Event_44919_ChoiceDesc1 = {
    Text = "[Selbstreflexion] weckt zufällig 1 Erwecker und infiziert „(Skill.Arg1)“"
  },
  Event_44919_ChoiceDesc2 = {
    Text = "[Andere betrachten]erhalte 3 Auswahlen für das Gotteszeichen"
  },
  Event_44919_Desc = {
    Text = "Die schwebende Seele ist in einem Dilemma.\nSie bleibt stehen, zögert zwischen den Begierden.\n“Was soll ich wählen?“, flüstert sie, “Was soll ich tun?“\n“Was ist mein wahres Verlangen?“"
  },
  Event_44919_Name = {
    Text = "Was ist dein Wunsch"
  },
  Event_44920_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_44920_Desc = {
    Text = "“Du hast recht, ich muss nachsehen, ich muss nachsehen...“\nEs senkt den Kopf, greift in seine Brust und zieht ein illusorisches Herz heraus: eine Hälfte schwarz wie Tinte, die andere hell wie Sterne"
  },
  Event_44920_Name = {
    Text = "Was ist dein Wunsch"
  },
  Event_44921_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_44921_Desc = {
    Text = "“Ja, ja... Man sagt, andere können als Spiegel dienen... Ich muss schauen...“\nEs kommt näher und starrt dich mit seinem gesichtslosen Gesicht an.\n“Warum bist du nicht in Schwierigkeiten? So neidisch, so neidisch...“"
  },
  Event_44921_Name = {
    Text = "Was ist dein Wunsch"
  },
  Event_44998_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_44998_Desc = {
    Text = "“Sie sagen, das gegenwärtige Leiden ist vorübergehend, nach dem Tod werden wir im Arm des All-Vaters ewig Freude genießen. \n “Ich möchte nicht bis zum Tod warten.“ \n Der Schatten verschlingt gierig alles, die Seele wird trüb und verschmilzt fast mit der umgebenden Dunkelheit. \n Du willst etwas tun, bist aber hilflos."
  },
  Event_44998_Name = {
    Text = "Innere Dunkelheit"
  },
  Event_45000_ChoiceDesc1 = {
    Text = "[Verbeugen und gehen]"
  },
  Event_45000_Desc = {
    Text = "Der Bischof schnitt mit einer Klinge seine Handfläche auf, und das Blut, das auf die Tafel tropfte, verwandelte sich in heilendes blaues Licht, das das fehlende Blut der Seele auffüllte.\n„Nimm mein Blut, fülle dein Leben – solange du es brauchst. Das ist der Wille des Vaters.“"
  },
  Event_45000_Name = {
    Text = "Bischofs “Segen“"
  },
  Event_45001_ChoiceDesc1 = {
    Text = "[Verbeugen und gehen]"
  },
  Event_45001_Desc = {
    Text = "Der Bischof zog seine Seele aus der Tiefe seines Brustkorbs. Die sanften Lichtpunkte verschmolzen mit der Steinplatte und verwandelten sich in heilendes blaues Licht, das alle Risse in der Seele füllte.\n“Nimm es an, dies ist das Geschenk des All-Vaters, der Beweis seiner Liebe. Möge dein Körper gesund und deine Seele vollständig sein, und mögest du kein Leid mehr erfahren.“"
  },
  Event_45001_Name = {
    Text = "Bischofs “Segen“"
  },
  Event_45002_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_45002_Desc = {
    Text = "Du gehst auf die Gesichter zu, und als du die Augen wieder öffnest, ist alles dunkel. Nur das Lachen unbekannter Herkunft hallt um dich herum"
  },
  Event_45002_Name = {Text = "Illusion"},
  Event_45036_ChoiceDesc1 = {
    Text = "[Alle Schöpfungen löschen]"
  },
  Event_45036_Desc = {
    Text = "“Das ist meine Sünde, meine Last. Wie kann ich dich retten, meine widersprüchliche Seele?“"
  },
  Event_45036_Name = {
    Text = "Innere Dunkelheit"
  },
  Event_45196_ChoiceDesc1 = {
    Text = "[Verbeugen und gehen]"
  },
  Event_45196_Desc = {
    Text = "Der Läufer schnitt mit einer Klinge Fleisch und Knochen ab, das blasse Knochen und das blutrote Fleisch verschmolzen mit der Steinplatte und verwandelten sich in heilendes blaues Licht, das die gebrochenen Knochen der Seele wiederherstellte.\n“Nimm mein Fleisch und meine Knochen, fülle deinen fehlenden Körper – solange du es brauchst. Das ist der Wille des All-Vaters.“"
  },
  Event_45196_Name = {
    Text = "Bischofs “Segen“"
  },
  Event_46144_ChoiceDesc1 = {
    Text = "[Verlassen]Erhalte eine Auswahl von 3 für 1 Silberrelikt, infiziere“(Skill.Arg1)“"
  },
  Event_46144_Desc = {
    Text = "Die verschwommene Gestalt wird allmählich klarer, es ist nichts anderes als eine Fusionsschale, auch keine Katastrophe, sondern die gewöhnliche Clementine ohne Flügel. \n “Wie zufällig, bist du auch hier, um den Mondschein zu bewundern?“ sagt sie lächelnd, doch du fühlst dich schwindelig, “In der Nacht mit dichtem Nebel solltest du vorsichtig sein. \n Die kleinen Wesen hier sind nicht sehr brav.“"
  },
  Event_46144_Name = {
    Text = "Gestalt im Nebel"
  },
  Event_46145_ChoiceDesc1 = {
    Text = "[Verlassen]Erhalte eine Auswahl von 3 für 1 goldenes Relikt, infiziere“(Skill.Arg1)“"
  },
  Event_46145_Desc = {
    Text = "Du bleibst unbemerkt. Eine Dame stürzt plötzlich auf die Bühne. \nSie reist dem Jungen mit Wucht den Mund auf und sticht ihm den Stock tief hinein. \n„Sprich, sprich mit mir.“ \nAus dem Mund des Jungen fließt schwarzes Blut. Er murmelt weiter. \n„Ein Lied für Mama...“"
  },
  Event_46145_Name = {
    Text = "Abschlusszeremonie III"
  },
  Event_47309_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_47309_Desc = {
    Text = "An diesem Tag wird Gott die Perishit mit seinem starken, kraftvollen Schwert strafen, \nwegen des Mords, den sie „begangen“ haben. \nWas, du sagst, das sei nicht fair? \nNein, das ist das Schicksal des Jägers"
  },
  Event_47309_Name = {
    Text = "Seemannslied"
  },
  Event_47310_ChoiceDesc1 = {
    Text = "[Weiter hören]Erhalte ein verfluchtes Relikt:“(RelicConfig.Arg1)“, Infektion“(Skill.Arg2)“"
  },
  Event_47310_ChoiceDesc2 = {
    Text = "[Gehen] Eine zufällige Befehlskarte erhält das Gebet: [(EnchantConfig.Arg1)]"
  },
  Event_47310_Desc = {
    Text = "Gott sprach: Nennen wir ihn Philistine. \n Lass ihn die Pflicht des Tötens tragen, lass ihn den Fluch der Gier tragen. \n Lass seinen Weg leuchten, sodass er an die Tiefe wie an ein weißes Haar erinnert. \n Im weiten Ozean gibt es keinen majestätischeren Riesenhai als diesen. \n Lass ihn von allen Lebewesen gefürchtet und verehrt werden, \n bis der Moment des Urteils kommt."
  },
  Event_47310_Name = {
    Text = "Seemannslied"
  },
  Event_47311_ChoiceDesc1 = {
    Text = "[Verlassen]Infektion“(Skill.Arg1)“"
  },
  Event_47311_ChoiceDesc2 = {
    Text = "[Verlassen]Infektion“(Skill.Arg1)“"
  },
  Event_47311_ChoiceDesc3 = {
    Text = "[Verlassen]Infektion“(Skill.Arg1)“"
  },
  Event_47311_Desc = {
    Text = "Der Junge ist ein niederträchtiger Sklave. \n Sein Herr behandelt ihn wie einen Sohn, wird jedoch im Bett erstochen. \n “Ich liebe Sie, Vater. Ich will einfach nicht länger ein Sklave sein.“ \n Später steht der Junge vor dem Grab des “Vaters“ und erinnert sich an die Worte des Priesters: \n <Small: Verlasse nicht das Land, das dich geboren hat. \n Zu jener Zeit sind deine Hände mit Blut befleckt, und du stirbst ohne Würde. \n Wildhunde, Geier und Meeresfische verachten dich. > \n Der Junge namens mit Glen hat schließlich doch verlassen. \n Er wird seine berüchtigte Geschichte schreiben."
  },
  Event_47311_Name = {
    Text = "Junge im Fass"
  },
  Event_47312_ChoiceDesc1 = {
    Text = "[Seite nach vorne]erhalte das silberne Relikt“(RelicConfig.Arg1)“、wähle 1 Mal die Infektion von Symptomen"
  },
  Event_47312_ChoiceDesc2 = {
    Text = "[Seite nach hinten]wähle eine von 3 Befehlskarten, um ein Gebet zu erhalten:“(EnchantConfig.Arg1)“、infiziere“(Skill.Arg2)“"
  },
  Event_47312_ChoiceDesc3 = {
    Text = "[Abwerfen]Erhalte 25 das schwarze Siegel"
  },
  Event_47312_Desc = {
    Text = "Du findest ein Buch, das aus Papyrus gebunden ist: \n...\nDer Junge versteckt sich in einem Holzfass, während die kleinen Inseln der Philister vorbeischweben. \nEr ist schwach, niederträchtig und ehrgeizig. \nWährend der Ruhm des unsterblichen Riesen alle in Ehrfurcht versetzt, \nversteckt sich nur der Junge im Schatten und lässt das Licht nicht näher kommen. \nSpäter wird er von Goliath mit einer wichtigen Aufgabe betraut. \nWas die Gründe dafür betrifft—"
  },
  Event_47312_Name = {
    Text = "Junge im Fass"
  },
  Event_47313_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_47313_Desc = {
    Text = "Der Riese sagte weiter: \n“Ich habe ihn neben mir platziert, weil er sowohl melancholisch als auch komisch ist. \nUnd er kann mich niemals töten.“"
  },
  Event_47313_Name = {
    Text = "Junge im Fass"
  },
  Event_47314_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_47314_Desc = {
    Text = "Du hast den hinteren Teil nicht gehört, aber der Text erinnert dich an ein anderes Lied:\n„Dieser seltene Riesenhai, der in Sturm und Regen weilt,\nDer Ozean ist sein Zuhause,\nDa Macht die Wahrheit ist, ist er der Riese der Macht,\nDer König des grenzenlosen Ozeans.“"
  },
  Event_47314_Name = {
    Text = "Seemannslied"
  },
  Event_47315_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_47315_Desc = {
    Text = "Jetzt ist keine gute Zeit zum Lesen.\nDu wirfst das Buch hastig weg, ohne das Ende zu sehen:\n...\nEr versteckt sich nicht aus Neid im Schatten.\nSondern aus purer Angst.\nSobald er im Licht steht, wird seine erbärmliche Seele vollständig ausgelöscht.\nNicht einmal Asche wird übrig bleiben"
  },
  Event_47315_Name = {
    Text = "Junge im Fass"
  },
  Event_47463_ChoiceDesc1 = {
    Text = "[In Hypnose gehen]Bestimme einen Erwecker, um seine Geisterspaltung zu verursachen, verliere die anfänglichen vier Befehlskarten"
  },
  Event_47463_Desc = {
    Text = "Der Arzt hob den Kopf von den umfangreichen Büchern: \n“Du bist ein seltener Fall, deshalb werde ich dir nichts berechnen. \n Aber ich benötige eine andere Gegenleistung: eine Hypnose. \n Es handelt sich um eine neue Therapiemethode, die ein vollkommen offenes und nacktes Bewusstsein mit sich bringt. \n Was sagst du, möchtest du es versuchen?“"
  },
  Event_47463_Name = {Text = "Hypnokobra"},
  Event_47464_ChoiceDesc1 = {
    Text = "[Glänzende Erinnerung][ExDesc1][ExDesc2]"
  },
  Event_47464_ChoiceDesc2 = {
    Text = "[Fades Gedächtnis]Upgrade alle Ensemble-Gebete im Deck zu fortgeschrittenen Ensemble-Gebeten"
  },
  Event_47464_Desc = {
    Text = "Sie wanderte am Strand des Bewusstseins.\nDie Wellen lecken an ihren Füßen, bringen die verstreuten Erinnerungen ans Ufer.\nEinige leuchten, andere sind matt, und einige riechen nach der Regenzeit in Londinium.\nWelche Erinnerung wählst du aufzuheben? Sie wanderte am Strand des Bewusstseins"
  },
  Event_47464_Name = {
    Text = "“Körperfusion“"
  },
  Event_47465_ChoiceDesc1 = {
    Text = "[Ablehnen zu versuchen] 1 zufällige Befehlskarte erhält ein Gebet: [(EnchantConfig.Arg1)]"
  },
  Event_47465_ChoiceDesc2 = {
    Text = "[Lösungsmittel zerschlagen]Reinige Schuldschöpfung"
  },
  Event_47465_ChoiceDesc3 = {
    Text = "[Experiment akzeptieren]erhalte 1 Chrono-Pendel „(RelicConfig.Arg1)“"
  },
  Event_47465_Desc = {
    Text = "Der Arzt schüttelt das grüne Lösungsmittel und sagt begeistert zu ihr: \n “Nimm einen Schluck, dann kannst du in den wachen Traum eintreten. \n Es ist die Manifestation der kollektiven Unbewusstheit. \n Jetzt wirst du das Bewusstsein des Meeres mit unzähligen Lebensformen teilen, \n möchtest du es probieren?“"
  },
  Event_47465_Name = {
    Text = "“Klarer Traum“"
  },
  Event_47466_ChoiceDesc1 = {
    Text = "[Auf Geräusche reagieren]erhält 1 Befehlskarte des Geistes der Spaltung"
  },
  Event_47466_Desc = {
    Text = "Der Körper ist ein Käfig, der zersplitterte Persönlichkeiten einsperrt.\nDas Gefängnis „24“ ist jetzt überfüllt.\n„Nicht einschlafen, nicht ruhig bleiben.“\nIn der Dunkelheit flüstert eine Stimme leise"
  },
  Event_47466_Name = {
    Text = "“Selbsterkenntnis“"
  },
  Event_47848_ChoiceDesc1 = {
    Text = "[Schließe die Augen]Erhalte 3 aus 1 goldenes Relikt"
  },
  Event_47848_ChoiceDesc2 = {
    Text = "[Seitlich schauen] wählt 2 Erwecker und reduziert die Arithmetica ihrer Erweckungskarten um 1"
  },
  Event_47848_ChoiceDesc3 = {
    Text = "[Augen öffnen]Erhalte Silberrelikt“(RelicConfig.Arg1)“，“(RelicConfig.Arg2)“，“(RelicConfig.Arg3)“"
  },
  Event_47848_Desc = {
    Text = "Bevor sie in Hypnose ging, sagte der Arzt: \n“Öffne die Augen nicht ohne meine Erlaubnis.“\nAlso schloss sie fest die Augen, atmete ein... atmete aus... \nIm Halbschlaf schien sie ein “Zischen“ zu hören. \nDann badete sie in einem kalten Blick— \netwas beobachtete sie. \nSollte sie die Augen öffnen und heimlich einen Blick riskieren?"
  },
  Event_47848_Name = {Text = "Hypnokobra"},
  Event_47876_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_47876_Desc = {
    Text = "Sie bückte sich und hob die glänzenden Erinnerungen auf.\nEins, zwei... unzählige glückliche Erinnerungen kamen herbei,\nSie breitete die Arme aus und drehte sich um sie herum"
  },
  Event_47876_Name = {
    Text = "“Körperfusion“"
  },
  Event_47877_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_47877_Desc = {
    Text = "Sie bückte sich, um die trüben Erinnerungen aufzuheben.\nEins, zwei... unzählige kleine drängten herein,\nSie öffnete die Arme und umarmte sie alle."
  },
  Event_47877_Name = {
    Text = "“Körperfusion“"
  },
  Event_47878_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_47878_Desc = {
    Text = "Du weigerst dich, das Opfer dieser seltsamen Lösungsmittel zu werden.\nDer Doktor ist enttäuscht, drängt dich aber nicht.\n\"Ich verzeihe den Menschen ihre Feigheit und Kurzsichtigkeit.\""
  },
  Event_47878_Name = {
    Text = "“Klarer Traum“"
  },
  Event_47879_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_47879_Desc = {
    Text = "Platsch! Du zerschmetterst die Flasche.\nDie grüne Flüssigkeit ätzt schnell den Boden.\n“Gut, unüberlegte Handlung. Aber ich hoffe, es passiert nicht wieder.\nSonst werde ich traurig sein.“"
  },
  Event_47879_Name = {
    Text = "“Klarer Traum“"
  },
  Event_47880_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_47880_Desc = {
    Text = "Du trinkst einen Schluck.\nGluck, gluck... dein Gehirn und deine Kehle sprudeln vor Blasen.\nWie kleine, knisternde Feuerwerke.\n“Lob sei dir, mutiger Mensch. Du wirst die Unendlichkeit berühren.\nUnd ich werde die Unendlichkeit bezeugen.“"
  },
  Event_47880_Name = {
    Text = "“Klarer Traum“"
  },
  Event_47881_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_47881_Desc = {
    Text = "Sie öffnete die Augen und sagte:\n“Ja, das alles ist falsch.\nEs sollte Tränen geben, es sollte Widerstand geben.“\nIm Dunkeln ertönte ein Rascheln, und sie erhielt eine wohlwollende Antwort"
  },
  Event_47881_Name = {
    Text = "“Selbsterkenntnis“"
  },
  Event_47900_ChoiceDesc1 = {
    Text = "[Schlange sehen]Erhalte ein goldenes Relikt +“(RelicConfig.Arg1)“"
  },
  Event_47900_ChoiceDesc2 = {
    Text = "[Dich sehen]Erhalte Schuldschöpfung“(RelicConfig.Arg1)“"
  },
  Event_47900_Desc = {
    Text = "Klatsch.\nEin sanfter Finger schnippte sie zurück in die Realität.\nDer Doktor war irgendwann nähergekommen, seine kobaltblauen Augen waren aufgeregt zusammengekniffen.\n„Sag mir, was hast du gerade gesehen?“"
  },
  Event_47900_Name = {Text = "Hypnokobra"},
  Event_47901_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_47901_Desc = {
    Text = "Sie öffnete ihre Augen.\nIm schimmernden Licht sah sie eine große, weiße Schlange, die sich in der Dunkelheit wand und bewegte.\nUnd ihre Augen –\nReines, ungetrübtes Gold.\nOhne Schmerz oder Freude, ohne Bewertung,\nGenug, um eine Murmelmaus aus einem Albtraum im Hochsommer zu wecken"
  },
  Event_47901_Name = {Text = "Hypnokobra"},
  Event_47909_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_47909_Desc = {
    Text = "Sie öffnete leise ein Auge.\nVor ihr war ein verschwommenes weißes Licht, das sich langsam in der Dunkelheit bewegte.\nEin Hauch von Gold blitzte auf, als ob es sie vor einem Verstoß warnte.\nSie wagte es nicht, weiterzusehen"
  },
  Event_47909_Name = {Text = "Hypnokobra"},
  Event_47910_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_47910_Desc = {
    Text = "Sie befolgte die Anweisungen des Arztes und öffnete ihre Augen keinen Moment. \n Ein kalter Atem strich durch die Luft um sie herum und verweilte lange auf ihrem Gesicht. \n Sie wusste nicht, wie viel Zeit vergangen war, als alles wieder normal wurde. \n Als ob nichts geschehen wäre."
  },
  Event_47910_Name = {Text = "Hypnokobra"},
  Event_47911_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_47911_Desc = {
    Text = "“Ich sah... eine sehr schöne Schlange。“\nDer Arzt hielt für einen Moment inne, während er den Stift hielt.\n„Wie sieht die Schlange aus?“\n„Sehr schön! Sie ist schneeweiß und hat goldene Muster...“\nDer Arzt schwieg, und die Mundwinkel hoben sich kaum hörbar.\n„Danke.“"
  },
  Event_47911_Name = {Text = "Hypnokobra"},
  Event_47912_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_47912_Desc = {
    Text = "Sie sah direkt in die kobaltblauen Augen des Arztes. \n “Ich sah dich zu einer Schlange werden.“ \n “Oh. Warum bist du dir so sicher, dass das ich bin?“ \n Weil sie geheimnisvoll, still und komplex ist. \n Und... \n sie sieht sehr müde aus, als ob sie gerade aus einem jahrtausendelangen Winterschlaf erwacht wäre."
  },
  Event_47912_Name = {Text = "Hypnokobra"},
  Event_47992_ChoiceDesc1 = {
    Text = "[Verbinden]Arg2 Lebenspunkte heilen"
  },
  Event_47992_ChoiceDesc2 = {
    Text = "[Meditation] wählt 1 Erwecker aus"
  },
  Event_47992_ChoiceDesc3 = {
    Text = "[verbanne]Entferne bis zu 3 Symptom-Karten, erhalte Arg2 schwarze Siegel"
  },
  Event_47992_Desc = {
    Text = "Du erkundest den Nebel, plötzlich leuchtet das Abzeichen auf deiner Brust schwach silbern. Wer ruft dich am anderen Ende des Kommunikators?"
  },
  Event_47992_Name = {
    Text = "Kontaktstelle"
  },
  Event_47992_Tips3 = {
    Text = "Derzeit besitzen Sie keine Symptom-Karten"
  },
  Event_47993_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_47993_ChoiceDesc2 = {
    Text = "[Verlassen]Erhalte zufällig 1 Befehlskarten, erhalte Gebet:“(EnchantConfig.Arg1)“und kopiere 1 Originalversion dieser Karte"
  },
  Event_47993_Desc = {
    Text = "Du nimmst den Kontakt der Schule an, die vertraute Stimme beruhigt dich. Du sammelst dich und gehst weiter"
  },
  Event_47993_Name = {
    Text = "Kontaktstelle"
  },
  Event_48225_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_48225_Desc = {
    Text = "Die Katze leckt glücklich deine Hand.\n„Danke, sei nicht traurig um mich.\nHier sterben und werden Persönlichkeiten ständig neu geboren,\nIch werde sicher zurückkommen!\nMiau, miau, miau!“"
  },
  Event_48225_Name = {Text = "Letztwille"},
  Event_48226_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_48226_Desc = {
    Text = "Die Katze denkt, du verstehst sie nicht, und schmiegt sich an deine Hand.\n„Wenn du zustimmst, gebe ich dir meine versteckten Snacks.\nSie sind sicher in der Cambrey-Straße @2 aufbewahrt...“"
  },
  Event_48226_Name = {Text = "Letztwille"},
  Event_48227_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_48227_Desc = {
    Text = "Du entschuldigst dich aufrichtig bei George.\n„Hm, du hast wenigstens Manieren.\nGeorge wird den Fluch um 10% abschwächen,\nmaximal 15% – das ist Georges Grenze.“"
  },
  Event_48227_Name = {
    Text = "Georgs Geist"
  },
  Event_48228_ChoiceDesc1 = {
    Text = "[Stimme ihm zu]Erhalte ein goldenes Relikt:“(RelicConfig.Arg1)“, Infektion“(Skill.Arg2)“"
  },
  Event_48228_ChoiceDesc2 = {
    Text = "[Weigere dich] erhält 1 aus 3 goldene Relikte, Infektion „(Skill.Arg1)“"
  },
  Event_48228_ChoiceDesc3 = {
    Text = "[Schweigen] erhält Silberrelikt „(RelicConfig.Arg1)“"
  },
  Event_48228_Desc = {
    Text = "“Katze 24“ hat schwere Verletzungen erlitten, sie kämpft darum, dir zu sagen: \n“Weh weh, mein Ende naht, Miau. \nIch habe einen Freund, es ist ein Silberdorsch, Miau. \nWenn du ihn eines Tages siehst, sag ihm, dass ich verreist bin, Miau. \nIch werde sehr lange weg sein, Miau. \nIch werde ihm viele Pommes ohne gebratenen Fisch mitbringen, Miau. \nSag es ihm unbedingt!“"
  },
  Event_48228_Name = {Text = "Letztwille"},
  Event_48229_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_48229_Desc = {
    Text = "Die Katze ist etwas enttäuscht.\nAber sie war immer eine gehorsame Katze, die niemanden zwang.\nAm Ende schließt sie bedauernd die Augen"
  },
  Event_48229_Name = {Text = "Letztwille"},
  Event_48230_ChoiceDesc1 = {
    Text = "[Ihm entschuldigen]erhält Silberrelikt „(RelicConfig.Arg1)“, infiziert „(Skill.Arg2)“"
  },
  Event_48230_ChoiceDesc2 = {
    Text = "[Ihn verspotten]erhält Silberrelikt „(RelicConfig.Arg1)“, infiziert „(Skill.Arg2)“"
  },
  Event_48230_ChoiceDesc3 = {
    Text = "[Ignoriere es]erhalte 25 das schwarze Siegel"
  },
  Event_48230_Desc = {
    Text = "Ein Geist, Georgs Geist, schwebt über euch.\n“Georg starb ehrenlos.\nAber das macht nichts, Georg wird diese Demütigung nie vergessen.\nHüter, du bist erledigt, hahaha...“"
  },
  Event_48230_Name = {
    Text = "Georgs Geist"
  },
  Event_48231_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_48231_Desc = {
    Text = "“Hehe, du wagst es, George zu verspotten. \nKeine Sorge, beim Essen, Schlafen, Singen... \nGeorge wird immer um dich herumschweben, dich erinnern und quälen. \nDamit du deine Sünden nie vergisst. \nDu wirst niemals einen Geist fangen, lalala~“"
  },
  Event_48231_Name = {
    Text = "Georgs Geist"
  },
  Event_48232_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_48232_Desc = {
    Text = "Du gehst entschlossen voran und lässt Georges Fluch hinter dir.\nHinter dir hörst du ein Schluchzen, George beginnt zu weinen.\n„Buhu... So ein süßer Kerl wie ich, und dann von deinem Hintern—\nEkelhaft! Ekelhaft!\nGeorge würde lieber unter Pandias Peitsche sterben!“"
  },
  Event_48232_Name = {
    Text = "Georgs Geist"
  },
  Event_49055_ChoiceDesc1 = {
    Text = "[Rufen des Erweckers]zieht 100 Wahnsinn von allen Erweckern ab, entfernt 1 Symptomkarte"
  },
  Event_49055_ChoiceDesc2 = {
    Text = "[Kämpfen]Heile Arg1 Leben, infiziere 2 Karten “(Skill.Arg2)“"
  },
  Event_49055_ChoiceDesc3 = {
    Text = "[Silberschlüssel einsetzen]alle s-Energie leeren"
  },
  Event_49055_Desc = {
    Text = "Der schattenhafte Blutsee zeigt sich in dem Moment, in dem du ihn betrittst.\nDie tiefschwarzen Blutschleifen strecken unzählige Arme aus, krallen sich an deinen Knöcheln und ziehen unaufhörlich nach oben, um dich in den unberechenbaren Abgrund zu ziehen"
  },
  Event_49055_Name = {
    Text = "Blutige Pfütze"
  },
  Event_49097_ChoiceDesc1 = {
    Text = "[Vorwärts]"
  },
  Event_49097_Desc = {
    Text = "Dein Bauch tobt, aber nach ein paar Sekunden kehrt Ruhe ein. Du hörst ein weiteres Herz in dir schlagen"
  },
  Event_49097_Name = {
    Text = "Mutter der Geburt"
  },
  Event_49098_ChoiceDesc1 = {
    Text = "[In einem Zug austrinken] Wähle [ExDesc3] [ExDesc4] Befehlskarten aus, damit sie das Gebet erhalten: [(EnchantConfig.Arg1)] [ExDesc1] [ExDesc2]"
  },
  Event_49098_Desc = {
    Text = "Die abgedroschenen Tontöpfe starren dich aus den schmalen Spalten der niedrigen Felsen an. \n Wasserquellen sind die wertvollsten Ressourcen in der Wüste, Alkohol ist der Schlüssel zur Welt des Wahnsinns und der Illusion. \n In diesem kargen Land ist es für einen noch vernünftigen Menschen schwer, dieser Einladung zu widerstehen."
  },
  Event_49098_Name = {
    Text = "Mutter der Geburt"
  },
  Event_49312_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_49312_Desc = {
    Text = "Der Glanz des Silberschlüssels flackert; die Arme scheinen von einer gewissen Macht eingeschüchtert und ziehen sich ins Wasser zurück, um zu verschwinden"
  },
  Event_49312_Name = {
    Text = "Blutige Pfütze"
  },
  Event_49313_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_49313_Desc = {
    Text = "Du kämpfst verzweifelt, aber je mehr du dich wehrst, desto tiefer sinkst du. Fluchartige Murmeln hallen in deinem Kopf.\nAls du wieder zu dir kommst, ziehen sich die blutigen Tentakel zufrieden zurück. Du fühlst dich erfrischt, aber es scheint, als hättest du etwas verloren"
  },
  Event_49313_Name = {
    Text = "Blutige Pfütze"
  },
  Event_49314_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_49314_Desc = {
    Text = "Der antwortende Erwecker zögert nicht einen Moment und zieht dich aus dem blutigen Teich, deine handverbindende Verbindung wird zerrissen, trübes Wasser spritzt auf, und unzählige schwer zu erkennende Kreaturen winden sich im Wasser, als ob sie nach etwas verlangen und es verschlingen"
  },
  Event_49314_Name = {
    Text = "Blutige Pfütze"
  },
  Event_49867_ChoiceDesc1 = {
    Text = "Zufällige Erweckung +50 Wahnsinn"
  },
  Event_49867_Name = {Text = "Ereignis"},
  Event_49907_ChoiceDesc1 = {
    Text = "[Frage echt oder falsch]"
  },
  Event_49907_ChoiceDesc2 = {
    Text = "[Bitte um Streicheln]"
  },
  Event_49907_Desc = {
    Text = "“Du schaust immer neugierig auf mein Horn. Gibt es ein Problem?“\nThais kam plötzlich näher an deine Schulter, der honigfarbene Anhänger schwang sanft und streifte deine Wange."
  },
  Event_49907_Name = {
    Text = "Hornträger"
  },
  Event_49908_ChoiceDesc1 = {
    Text = "[Nach oben schauen]"
  },
  Event_49908_ChoiceDesc2 = {
    Text = "[Gehe zu Thais]"
  },
  Event_49908_Desc = {
    Text = "Staub verteilt sich in den Ruinen, und vor einem zerbrochenen Fenster taucht plötzlich Thais auf. Sie lehnt lässig auf dem staubigen Fensterbrett und zeigt geheimnisvoll auf den Balken darüber."
  },
  Event_49908_Name = {
    Text = "Schleichender"
  },
  Event_49909_ChoiceDesc1 = {
    Text = "[Verlassen]Wähle eine von 3 Befehlskarten und erhalte ein Gebet:“(EnchantConfig.Arg1)“"
  },
  Event_49909_Desc = {
    Text = "Du hebst den Kopf, die rostigen Kupferrohre verlaufen in alle Richtungen und sind wie ein riesiges Spinnennetz über deinem Kopf gespannt. Ein Schatten huscht vorbei, ist es eine nach Nahrung suchende Wildkatze oder ein Monster, das sich im Schatten versteckt? \n Als du dich wieder umdrehst, ist auch Thais verschwunden."
  },
  Event_49909_Name = {
    Text = "Schleichender"
  },
  Event_49910_ChoiceDesc1 = {
    Text = "[Sie beobachten]"
  },
  Event_49910_ChoiceDesc2 = {
    Text = "[Sie rufen]"
  },
  Event_49910_Desc = {
    Text = "Du siehst erneut das „Phantasma“. \nDieses Mal kennst du bereits ihren Namen. \nThais steht unter dem fernen Mutterbaum und betet ehrfurchtsvoll zu ihm. \nIhr Umriss verschwimmt mit dem Phantasma des Mutterbaums"
  },
  Event_49910_Name = {
    Text = "Wunscherfüller"
  },
  Event_49911_ChoiceDesc1 = {
    Text = "[Verlassen]Wähle eine von 3 Befehlskarten und erhalte ein Gebet:“(EnchantConfig.Arg1)“"
  },
  Event_49911_Desc = {
    Text = "Du siehst in die Ferne zu Thais, ihre Silhouette erscheint in diesem apokalyptischen Sturm wie ein heiliges, erhabenes Hochgebirge, selbst wenn der Sandsturm tobt, mindert es nicht ihre Autorität.\nIhr Schritt ist langsam und fest, ihre Haltung edel und unantastbar, was dich fasziniert"
  },
  Event_49911_Name = {
    Text = "Unsterblicher"
  },
  Event_49912_ChoiceDesc1 = {
    Text = "[Verlassen]Wähle 1 Befehlskarte zum Kopieren"
  },
  Event_49912_Desc = {
    Text = "“Was denkst du?“\nSie „psst“ und beugt sich näher, du spürst, wie die Spitze ihres Horns deine Wange streift, kühl und kitzelnd"
  },
  Event_49912_Name = {
    Text = "Hornträger"
  },
  Event_49913_ChoiceDesc1 = {
    Text = "[Gehen] Wähle 1 von 3 Befehlskarten aus, um ein Gebet zu erhalten: „(EnchantConfig.Arg1)\", infiziere „(Skill.Arg2)\""
  },
  Event_49913_Desc = {
    Text = "“Sag einfach, wenn du mich berühren willst, ich werde dich nicht abweisen.“\nSie lacht leise und zieht deine Hand, die Berührung ihrer Fingerspitzen ist warm und glatt, fast unwiderstehlich...“"
  },
  Event_49913_Name = {
    Text = "Hornträger"
  },
  Event_49914_ChoiceDesc1 = {
    Text = "[Verlassen]Wähle einen Erwecker, verringere seine Kosten für das Erwachen um 1, infiziere“(Skill.Arg1)“"
  },
  Event_49914_Desc = {
    Text = "Du kniest mit den anderen auf dem Boden.\n„Ich wusste es, ich wusste es, die Königin, die Königin beschützt uns immer!“\nFreudenschreie, lange Rufe und das Heulen des Windes hallen in deinem Kopf wider.\nEtwas Wichtiges blitzt auf, aber du kannst es nicht fassen"
  },
  Event_49914_Name = {
    Text = "Unsterblicher"
  },
  Event_49915_ChoiceDesc1 = {
    Text = "[Verlassen]Erhalte eine Auswahl von 3 für 1 Silberrelikt, infiziere“(Skill.Arg1)“"
  },
  Event_49915_Desc = {
    Text = "Du winkst ihr zu.\n„Was machst du da?“ Ramona schaut dich verwirrt an.\n„Dort...“\nBevor du den Satz beenden kannst, ist die Frau in der Ferne verschwunden.\nWar es eine Täuschung?"
  },
  Event_49915_Name = {
    Text = "Wasserbewerfer"
  },
  Event_49916_ChoiceDesc1 = {
    Text = "[Ihr antworten]"
  },
  Event_49916_ChoiceDesc2 = {Text = "[Zögern]"},
  Event_49916_Desc = {
    Text = "In der Ferne sieht man eine Frau am Flussufer Wasser schöpfen.\nAls sie deinen Blick bemerkt, winkt sie dir zu.\nDu bemerkst, dass ihre Drehung etwas seltsam wirkt"
  },
  Event_49916_Name = {
    Text = "Wasserbewerfer"
  },
  Event_49917_ChoiceDesc1 = {
    Text = "[Verlassen]Wähle eine von 3 Befehlskarten und erhalte ein Gebet“(EnchantConfig.Arg1)“"
  },
  Event_49917_Desc = {
    Text = "Während du zögerst, dreht sich die Frau um und verschwindet zwischen den Oasen. \nDu kannst deinen Augen kaum trauen... Hat sie Hufen wie ein Schaf?"
  },
  Event_49917_Name = {
    Text = "Wasserbewerfer"
  },
  Event_49918_ChoiceDesc1 = {
    Text = "[Verlassen]Wähle eine von 3 Befehlskarten und erhalte ein Gebet“(EnchantConfig.Arg1)“"
  },
  Event_49918_Desc = {
    Text = "„O Mutterbaum, erhöre das Gebet von @1. Ich werde in deiner Milch baden und wiedergeboren werden, dein Werkzeug werden, für dich durch die Wüsten wandeln und deine Wurzeln in jeden Winkel von Lemvah reichen lassen...\"\n\nDie abwechselnden unschuldigen Gebete hallen durch den Raum."
  },
  Event_49918_Name = {
    Text = "Wunscherfüller"
  },
  Event_49919_ChoiceDesc1 = {
    Text = "[Verlassen]Zufällig 1 Erwecker erwecken"
  },
  Event_49919_Desc = {
    Text = "Thais' vage und rätselhafte Blicke zogen deine Aufmerksamkeit auf sich, eine Art täuschende Kraft ließ dich unwillkürlich taumeln, als würdest du angezogen, konntest du nicht anders, als auf sie zuzugehen. \n “Eigentlich existieren unsichtbare Dinge weiterhin.“ \n Sie flüsterte sanft in dein Ohr, du hattest das Gefühl, etwas zu verstehen, doch es war, als wäre es von einem weißen Schleier umhüllt und nicht klar zu erkennen. \n Ist das eine Art Prophezeiung? Plötzlich war Thais schon verschwunden."
  },
  Event_49919_Name = {
    Text = "Schleichender"
  },
  Event_49920_ChoiceDesc1 = {
    Text = "[In die Ferne blicken]"
  },
  Event_49920_ChoiceDesc2 = {Text = "[Knien]"},
  Event_49920_Desc = {
    Text = "Die schwarzen Klauen des Schafes betreten den sandigen Boden.\nThais singt ein unbekanntes Gebet, während zahlreiche Aram sich in die Richtung knien, aus der sie kommt"
  },
  Event_49920_Name = {
    Text = "Unsterblicher"
  },
  Event_49921_ChoiceDesc1 = {
    Text = "[Verlassen]Erhalte eine Auswahl von 3 für 1 goldenes Relikt, infiziere“(Skill.Arg1)“"
  },
  Event_49921_Desc = {
    Text = "Der riesige Baum streckte tausende von kräftigen Ästen aus, die wie verschlungene Tentakel waren und Thais' Handgelenke und Knöchel fest umschlungen, ohne auf ihr Strampeln und Widerstand Rücksicht zu nehmen, rücksichtslos zog er ihren Oberkörper in den sich ausdehnenden Baumstamm...\n\nObwohl es nur ein fernes Phantom war, erreichte ihr Schmerz dennoch mit den Wellen des Wassers dein Inneres."
  },
  Event_49921_Name = {
    Text = "Wunscherfüller"
  },
  Event_49922_ChoiceDesc1 = {
    Text = "[Verlassen]Erhalte Schöpfung“(RelicConfig.Arg1)“"
  },
  Event_49922_Desc = {
    Text = "Die schlaffen Glieder fließen mit dem Baumsaft den Stamm hinunter, sie kämpfte mit aller Kraft, doch ihre Glieder waren wie schwankende, verzerrte Würmer und gehorchten nicht. \n “Die Knochen sind vollständig aufgelöst“, wurde Thais' Augenwinkel von Traurigkeit durchdrungen, “sie ist bereits ein Teil des Baumes.“ \n “Wir brauchen die Kraft der Umkehr... die Kraft, die die Zeit überschreitet.“"
  },
  Event_49922_Name = {
    Text = "Verrotteter Mensch"
  },
  Event_49923_ChoiceDesc1 = {
    Text = "[Verlassen]Wähle eine von 3 Befehlskarten und erhalte ein Gebet:“(EnchantConfig.Arg1)“"
  },
  Event_49923_Desc = {
    Text = "“Und dieser „verkehrte blinde Blick“ hat, warum auch immer, ein starkes, tiefes Gefühl der Anziehungskraft...“\n“Oh? Sprichst du von mir?“\n“Midanet lobt deine Fähigkeit, Geschichten zu erzählen.“\n\nAn diesem ruhigen Feuernacht hat sie dir einen Becher Wein nachgeschenkt"
  },
  Event_49923_Name = {
    Text = "Verrotteter Mensch"
  },
  Event_49924_ChoiceDesc1 = {
    Text = "[Baumknoten öffnen]"
  },
  Event_49924_ChoiceDesc2 = {Text = "[Erinnern]"},
  Event_49924_Desc = {
    Text = "Ein Wucherungsobjekt.\nEs pulsiert böse und geschwollen, und eine schwache, transparente blutrote Haut lässt ein verzerrtes und schmerzvolles Gesicht durchscheinen, als wollte es jederzeit schlüpfen.\n„Medinaite.“ Thais zeigt eine traurige Miene und ruft sanft den Namen dieses Gesichts"
  },
  Event_49924_Name = {
    Text = "Verrotteter Mensch"
  },
  Event_49939_ChoiceDesc1 = {
    Text = "[Vertraue Ryker]Alle Erwecker wiederherstellen Arg1 Aelius"
  },
  Event_49939_ChoiceDesc2 = {
    Text = "[Sorge um Ryker] wähle 2 erwachte Erwecker"
  },
  Event_49939_Desc = {
    Text = "“Vertraue auf mein Glück.“"
  },
  Event_49939_Name = {
    Text = "Glücksdetektiv"
  },
  Event_49940_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_49940_Desc = {
    Text = "Ryker kann nur drei Dinge gut: erkunden, zuhören, würfeln. \nMit anderen Worten, er ist nicht gut im Kampf. \nDeine innere Besorgnis lässt sich kaum zurückhalten, der Wahnsinn wächst"
  },
  Event_49940_Name = {
    Text = "Glücksdetektiv"
  },
  Event_49941_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_49941_Desc = {
    Text = "Glaube ist Magie, er wird alle Hindernisse überwinden"
  },
  Event_49941_Name = {
    Text = "Glücksdetektiv"
  },
  Event_49943_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_49943_Desc = {
    Text = "Du fühlst dich verlegen, aber schaust dennoch hoffnungsvoll zu der kranken Ramona.\n„Ich mach das.“\nSie wird rot und holt schnell ein neues Sammelgefäß aus ihrem unendlichen Handkoffer, um die Spinne zu fangen"
  },
  Event_49943_Name = {
    Text = "Giftspinnen"
  },
  Event_49944_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_49944_Desc = {
    Text = "Ryker schnippte mit den Fingern und streckte dann seinen pelzigen Zeigefinger auf die große Spinne, die ihr Vorderbein hochhielt. \n Diese bunt gemusterten Arten sind meistens sehr giftig. Du wolltest ihn gerade warnen, als die zuvor feindselige Spinne geschmeidig auf sein Fingergelenk hüpfte und sich zusammenrollte. \n Egal, jeder hat sein Schicksal."
  },
  Event_49944_Name = {
    Text = "Giftspinnen"
  },
  Event_49945_ChoiceDesc1 = {
    Text = "[Blick zu Ramona]Erhalte eine Auswahl von 3 für 1 Gebet"
  },
  Event_49945_ChoiceDesc2 = {
    Text = "[Blick zu Ryker]Wähle eine von 3 Befehlskarten und erhalte ein Gebet:“(EnchantConfig.Arg1)“，infiziere“(Skill.Arg2)“"
  },
  Event_49945_Desc = {
    Text = "Die vielen Facettenaugen schauen dich an. \n Der Besitzer der Facettenaugen macht einen Schritt zurück und fletscht drohend die Zähne. \n An den hoch erhobenen Beinen und den beiden Paaren von Beinen, die den Körper stützen, scheint es sich tatsächlich um ein seltenes Spinnentier zu handeln. \n Die Worte von Czort hallen dir noch im Ohr: „Zusätzliche Aufgabe, bitte sammle Proben der lokalen Arten und bewahre sie bis zur lokalen Erkundungsstation auf.“ \n Du schüttelst das Sammelgefäß in deinem Rucksack, das nach Wochen des Wanderns bereits von Insekten überquillt."
  },
  Event_49945_Name = {
    Text = "Giftspinnen"
  },
  Event_49946_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_49946_Desc = {
    Text = "“Unzeitgemäße Gier ist eine Krankheit.“"
  },
  Event_49946_Name = {
    Text = "Deine Antwort"
  },
  Event_49947_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_49947_Desc = {
    Text = "“Wörtliches Wiederholen wird dir keine Sympathie einbringen, Kind.“"
  },
  Event_49947_Name = {
    Text = "Deine Antwort"
  },
  Event_49948_ChoiceDesc1 = {
    Text = "[Goldener Schlüssel]Erhalte goldenes Relikt „(RelicConfig.Arg1)“, infiziere „(Skill.Arg2)“"
  },
  Event_49948_ChoiceDesc2 = {
    Text = "[Eiserner Schlüssel]Erhalte 3 aus 1 goldenes Relikt, infiziere „(Skill.Arg1)“"
  },
  Event_49948_ChoiceDesc3 = {
    Text = "[Silberschlüssel]Erhalte Silberrelikt „(RelicConfig.Arg1)“"
  },
  Event_49948_Desc = {
    Text = "Um Punkt Mittag haben die dampfenden Wasser des heiligen Flusses zwei leere Phantome gebildet.\nDie neblige Stimme des Phantoms fragt dich: Ist das dein goldener Schlüssel, silberner Schlüssel oder eisener Schlüssel, den du verloren hast?"
  },
  Event_49948_Name = {
    Text = "Deine Antwort"
  },
  Event_49949_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_49949_Desc = {
    Text = "“Ehrlichkeit führt oft zu sichereren Ergebnissen, aber du könntest auch etwas verpassen.“"
  },
  Event_49949_Name = {
    Text = "Deine Antwort"
  },
  Event_50013_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_50013_Desc = {
    Text = "Du versuchst, das Gesicht der Person genau zu erkennen, doch es verschwimmt und wird durch die Wasserwellen unklar. \n\nJe mehr du dich konzentrierst, desto schwerer wird dein Atem, und dein Gehirn wird von einem Gefühl der Hypoxie überwältigt, bis du schließlich Ramonas Stimme hörst, die deinen Namen ruft, und dich mühsam zurück in die Realität zieht. \nDie reflektierende Sonne auf der Wasseroberfläche ist äußerst blendend, aber unter der Oberfläche scheint etwas zu funkeln."
  },
  Event_50013_Name = {
    Text = "Todesphantom"
  },
  Event_50014_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_50014_Desc = {
    Text = "Das Phantasma zerfällt beim ersten Kontakt, deine Hände sind leer, nur ein plötzlicher starker Schmerz in deiner Schläfe bleibt.\nDie heiße Sonne, die sich in der Wasseroberfläche spiegelt, ist blendend, aber unter der Oberfläche scheint etwas zu funkeln"
  },
  Event_50014_Name = {
    Text = "Todesphantom"
  },
  Event_50015_ChoiceDesc1 = {
    Text = "[Mühevolle Identifikation] erhält Silberrelikt „(RelicConfig.Arg1)“, Infektion „(Skill.Arg2)“"
  },
  Event_50015_ChoiceDesc2 = {
    Text = "[Nach vorne greifen]Erhalte ein Silberrelikt „(RelicConfig.Arg1)“, infiziere „(Skill.Arg2)“"
  },
  Event_50015_ChoiceDesc3 = {
    Text = "[Augen reiben]erhalte 25 schwarze Siegel"
  },
  Event_50015_Desc = {
    Text = "Nubia stößt dich, ein Bein versinkt im heiligen Fluss.\nDu stabilisierst dich mühsam, doch im schwankenden Wasser siehst du ein unerwartetes Spiegelbild.\nEin junger Mann in Missaga-Schuluniform, sein Körper schlaff im Fluss treibend"
  },
  Event_50015_Name = {
    Text = "Todesphantom"
  },
  Event_50016_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_50016_Desc = {
    Text = "Panik zerfrisst deinen Verstand, der Schmerz macht das Bewusstsein vage. Du reißt verzweifelt, doch die Ranken ziehen sich immer fester zusammen, während ein stinkender Schleim in deine Nasenhöhle eindringt; jeder Atemzug ist von zähflüssiger Verzweiflung durchzogen. \n Ramona sticht mit dem Schwert zu, Nubien flieht mit einem abgetrennten Bein. Du reißt den letzten, an deiner Gesichtsseite haftenden Tentakel ab, der eine Schicht verschwommenen Fleisches trägt."
  },
  Event_50016_Name = {
    Text = "ins Gesicht wehen"
  },
  Event_50017_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_50017_Desc = {
    Text = "Silbernes Licht durchdringt den Körper Nubiens, das Gefühl von zerplatzendem Fleisch wird über den Silberschlüssel bis zu deinen Fingerspitzen und Handgelenken übertragen.\nNubias verzerrte Gliedmaßen heben sich gen Himmel und geben einen schrecklichen, klagenden Schrei von sich, während sie sich in eine zähflüssige, unbekannte Substanz verwandeln."
  },
  Event_50017_Name = {
    Text = "ins Gesicht wehen"
  },
  Event_50018_ChoiceDesc1 = {
    Text = "[Zerreißen]erhalte ein verfluchtes Relikt“(RelicConfig.Arg1)“，infiziere“(Skill.Arg2)“"
  },
  Event_50018_ChoiceDesc2 = {
    Text = "[Durchstechen] Eine zufällige Befehlskarte erhält das Gebet: [(EnchantConfig.Arg1)]"
  },
  Event_50018_Desc = {
    Text = "Nubias rankenartige Tentakel winden sich und stürzen sich auf dein Gesicht, dringen wild in Mund und Nase ein"
  },
  Event_50018_Name = {
    Text = "ins Gesicht wehen"
  },
  Event_50019_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_50019_Desc = {
    Text = "Auf der Wasseroberfläche waren nur glitzernde Wellen zu sehen.\nDu zogst dein nasses Bein heraus und schüttetest den feuchten Sand aus deinen Schuhen.\nDas Bild von eben blieb in deinem Kopf, unauslöschlich"
  },
  Event_50019_Name = {
    Text = "Todesphantom"
  },
  Event_50029_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_50029_Desc = {
    Text = "“Wird er zurückkommen? Oder wird er dich für immer in dieser endlosen Wüste zurücklassen?“\n“Wird er dich finden? Oder wird er wegen der wechselnden Winde und Dünen deine Position verlieren?“\n“Ist die Hoffnung, die du auf andere setzt, wirklich so verlässlich?“"
  },
  Event_50029_Name = {
    Text = "Verlorene Sandbank"
  },
  Event_50030_ChoiceDesc1 = {
    Text = "[Hilfe suchen]wecke zufällig 1 Erwecker, Infektion „(Skill.Arg1)“"
  },
  Event_50030_ChoiceDesc2 = {
    Text = "[Gemeinsam voranschreiten] wählt 1 aus 3 Befehlskarten und erhält Orison: „(EnchantConfig.Arg1)“"
  },
  Event_50030_Desc = {
    Text = "Eine alte und distanzierte Stimme vermischt sich mit dem Plätschern des Wassers und fragt dich. \n “Du bist in der endlosen Wüste verloren.“ \n “Vor dir liegen zwei Optionen. Dein Begleiter kann schneller gehen, lass ihn mit Essen und Wasser auf Rettungssuche gehen, während ihr an Ort und Stelle mit minimalem Verbrauch bleibt.“ \n “Oder ihr teilt alles und geht weiter.“"
  },
  Event_50030_Name = {
    Text = "Verlorene Sandbank"
  },
  Event_50031_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_50031_Desc = {
    Text = "“Ihr werdet vielleicht nicht weiterkommen, aber eure Seelen und Körper sind eng verbunden und geben einander Kraft.“\n“Das ist deine Wahl.“\nSagte er, und die sengende Sonne am Himmel schloss ihre Augen"
  },
  Event_50031_Name = {
    Text = "Verlorene Sandbank"
  },
  Event_50064_ChoiceDesc1 = {
    Text = "[Rote Schnur durchtrennen] entfernt 1 Befehlskarte und erhält Arg1 das schwarze Siegel"
  },
  Event_50064_ChoiceDesc2 = {
    Text = "[Widerstand]Kopiere 1 Befehlskarte, infiziere “(Skill.Arg1)“"
  },
  Event_50064_ChoiceDesc3 = {
    Text = "[Rufen Ramona]wählt 1 von 3 Befehlskarten und erhält Orison: „(EnchantConfig.Arg1)“"
  },
  Event_50064_Desc = {
    Text = "Casiah wirft das rote Satinband aus, das sich sofort um deinen Koffer wickelt"
  },
  Event_50064_Name = {
    Text = "Verwirbelte Seide"
  },
  Event_50065_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_50065_Desc = {
    Text = "Das intermittierende Klopfen hallt zwischen den Rohren über euch wider, wie ein einsamer Geist, der in diesem toten Raum tanzt.\nDiese Vorstellung ruft in dir eine uralte, kalte Angst hervor"
  },
  Event_50065_Name = {
    Text = "verwegene Tonleiter"
  },
  Event_50066_ChoiceDesc1 = {
    Text = "[Am Höhleneingang erkunden]erhalte das silberne Relikt „(RelicConfig.Arg1)“"
  },
  Event_50066_ChoiceDesc2 = {
    Text = "[In die Höhlen eindringen]Erhalte ein goldenes Relikt „(RelicConfig.Arg1)“, infiziere „(Skill.Arg2)“"
  },
  Event_50066_Desc = {
    Text = "“Hier gibt es eine Höhle.“\nThais macht dir eine Einladung. \n“Möchtest du hineingehen und nachsehen?“\nDie enge Höhle ist dunkel und tief, wie das riesige Maul eines Teufels, das sich in die endlose Dunkelheit erstreckt. Wer immer diesen trostlosen Ort betritt, kann das unheilvolle Gefühl, das tief im Rückenmark aufsteigt, nicht abschütteln. Es scheint, als würden in jeder Ecke dieser Höhle alte Wesen lauern, die sich nicht trauen, das Sonnenlicht zu betrachten, und auf das Kommen der Eindringlinge warten."
  },
  Event_50066_Name = {
    Text = "Dunkle Höhle"
  },
  Event_50067_ChoiceDesc1 = {
    Text = "[Einer nach dem anderen besiegen]Eines der Silberrelikte wird zufällig auf goldenes Relikt „(RelicConfig.Arg1)“ aufgewertet"
  },
  Event_50067_ChoiceDesc2 = {
    Text = "[Umzingelung zweier Personen] erhält Silberrelikt „(RelicConfig.Arg1)“, Infektion „(Skill.Arg2)“"
  },
  Event_50067_ChoiceDesc3 = {
    Text = "[Zuhören] erhält 25 das schwarze Siegel"
  },
  Event_50067_Desc = {
    Text = "Zwei Aram bewachen das Tor der Fabrik.\nEiner von ihnen schlendert untätig umher und spricht den anderen an.\n„Man sagt, dass die Herrin Juliette wieder die Gruppen zählt, die versuchen, die Sturmwand zu durchbrechen.“\n„Ich hoffe wirklich, ich werde nicht ausgewählt.“"
  },
  Event_50067_Name = {
    Text = "Mußiggänger Torwächter"
  },
  Event_50067_Tips1 = {
    Text = "Noch keine Silberrelikte"
  },
  Event_50068_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_50068_Desc = {
    Text = "Nicht schauen, nicht hören, nicht denken.\nVergiss die unpassende Melodie und geh direkt zur Stelle der Überreste des Mutterbaums"
  },
  Event_50068_Name = {
    Text = "verwegene Tonleiter"
  },
  Event_50069_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_50069_Desc = {
    Text = "Ramona sticht mit ihrem Schwert auf die mit rotem Schleihtuch wütende Casiah, die hastig ausweicht, und das rote Schleihtuch, das dich umschlungen hatte, löst sich sofort"
  },
  Event_50069_Name = {
    Text = "Verwirbelte Seide"
  },
  Event_50070_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_50070_Desc = {
    Text = "Ihr teilt euch auf, du und Ramona gehen links, Ryker geht rechts und umzingelt den Feind von beiden Seiten. \nDu hebst die Hand, und Ramona und Ryker schlagen gleichzeitig zu, die beiden Aram-Wächter fallen lautlos zu Boden"
  },
  Event_50070_Name = {
    Text = "Mußiggänger Torwächter"
  },
  Event_50071_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_50071_Desc = {
    Text = "Jetzt ist nicht die Zeit, in die Falle zu gehen. Schon am Eingang spürt ihr das böse Pulsieren der Felsen"
  },
  Event_50071_Name = {
    Text = "Dunkle Höhle"
  },
  Event_50072_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_50072_Desc = {
    Text = "Auf dein Zeichen hin schlug Ryker den schweigenden Aram-Wächter mit einem Würfel nieder und schlich sich dann leise an den anderen, der immer noch ununterbrochen redete. \n “Hey, Bruder, was machst du, wenn diese Juliette ein Betrüger ist?“ \n “Ich weiß auch nicht, was ich tun soll.“ \n Ryker grinste fröhlich, der Wächter zuckte zusammen und wollte gerade schreien, als Ryker ihm den Mund und die Nase zuhielt."
  },
  Event_50072_Name = {
    Text = "Mußiggänger Torwächter"
  },
  Event_50073_ChoiceDesc1 = {
    Text = "[Aufmerksam zuhören] Wähle 1 von 3 Befehlskarten aus, um ein Gebet zu erhalten: „(EnchantConfig.Arg1)\", infiziere „(Skill.Arg2)\""
  },
  Event_50073_ChoiceDesc2 = {
    Text = "[Ohren zuhalten]für jeden Erwecker mit einem Aelius-Wert von 50 oder mehr erhalte 15 schwarze Siegel"
  },
  Event_50073_ChoiceDesc3 = {
    Text = "[Überprüfen]Erhalte 3-wählen-1 Gebet"
  },
  Event_50073_Desc = {
    Text = "Als ihr die Etage mit den Überresten erreicht, ertönt in der leeren, verlassenen Fabrik plötzlich ein angenehmes Klingeln, das Kontrast zwischen den klaren Klängen des Klaviers und den rostigen Stahlruinen ist frappierend"
  },
  Event_50073_Name = {
    Text = "verwegene Tonleiter"
  },
  Event_50074_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_50074_Desc = {
    Text = "“Hey, Bruder, was würdest du tun, wenn diese Juliette eine Betrügerin wäre?“\n“Sprich keinen Unsinn, seit Juliette hier ist, läuft alles reibungslos. Wenn sie eine Betrügerin wäre, warum würde sie dann den Aranern so sehr helfen?“\nWährend sie plauderten, hatte Ryker heimlich die Position für den Hinterhalt ausgewählt, und zwei Würfel flogen mit einem Knall heraus und schickten die beiden zu Boden."
  },
  Event_50074_Name = {
    Text = "Mußiggänger Torwächter"
  },
  Event_50075_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_50075_Desc = {
    Text = "Du fasst den Mut zurückzublicken.\nDas große Auge des Vorhangs verzerrt sich plötzlich in ein bösartiges Grinsen, dein unerschütterlicher Widerstand beginnt zu wanken"
  },
  Event_50075_Name = {
    Text = "Magisches Auge"
  },
  Event_50076_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_50076_Desc = {
    Text = "Du reißt den Vorhang ohne Ablenkung auf.\nDas riesige Auge zerfällt in deinen Händen zu flachem, zerrissenem Stoff"
  },
  Event_50076_Name = {
    Text = "Magisches Auge"
  },
  Event_50077_ChoiceDesc1 = {
    Text = "[Blick zurückwerfen]erhalte das goldene Relikt „(RelicConfig.Arg1)“, Infektion „(Skill.Arg2)“"
  },
  Event_50077_ChoiceDesc2 = {
    Text = "[Zerreiß den Vorhang]wähle 1 von 3 Befehlskarten und erhalte ein Gebet:“(EnchantConfig.Arg1)“"
  },
  Event_50077_Desc = {
    Text = "Der Vorhang öffnete sich und enthüllte unzählige verdrehte Augen.\nDas riesige Wesen dahinter zeigte einen unersättlichen Hunger und regte sich"
  },
  Event_50077_Name = {
    Text = "Magisches Auge"
  },
  Event_50078_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_50078_Desc = {
    Text = "Es war ein Stück eines verlassenen, langen Bauteils, das durch eure Bewegung erschüttert wurde und wackelig gegen das Eisenrohr schlug."
  },
  Event_50078_Name = {
    Text = "verwegene Tonleiter"
  },
  Event_50079_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_50079_Desc = {
    Text = "Thais trat gelassen in die Höhle ein, während du ihr vorsichtig folgtest. \n “Vorsicht!“ Wurdest du plötzlich weggerissen und fielst in eine sanfte Umarmung. Vor euch stürzte ein pechschwarzes Ungeheuer mit unübertroffener Schnelligkeit aus der Höhle. \n “Schau hierher,“ begann Thais, während du noch erschüttert warst, ihre Augen leuchteten schwach im Dunkeln, “das könnte wohl ihr Schatz sein.“"
  },
  Event_50079_Name = {
    Text = "Dunkle Höhle"
  },
  Event_50080_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_50080_Desc = {
    Text = "Du ziehst verzweifelt am Griff des Koffers und kämpfst gegen die rote Seide.\nDoch die rote Seide ist unbändig stark, dein Koffer rutscht dir aus der Hand und der Inhalt fällt zu Boden"
  },
  Event_50080_Name = {
    Text = "Verwirbelte Seide"
  },
  Event_50081_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_50081_Desc = {
    Text = "Du hasst es, gefesselt zu sein.\nDu reißt das rote Tuch mit einem Ruck entzwei.\nDer Rest des Tuchs schlängelt sich wie eine rote Schlange davon"
  },
  Event_50081_Name = {
    Text = "Verwirbelte Seide"
  },
  Event_50276_ChoiceDesc1 = {
    Text = "[Opfere die Opfergabe]Erhalte ein verfluchtes Relikt „(RelicConfig.Arg1)“, infiziere „(Skill.Arg2)“"
  },
  Event_50276_ChoiceDesc2 = {
    Text = "[Das Seil lösen] Wähle 1 von 3 Befehlskarten aus, um das Gebet zu erhalten: [(EnchantConfig.Arg1)]"
  },
  Event_50276_ChoiceDesc3 = {
    Text = "[Weiter voran]Erhalte 50 schwarze Siegel"
  },
  Event_50276_Desc = {
    Text = "Drei Aram wurden an der Spitze eines Podiums gefesselt.\nAuf ihren Körpern erschienen die tiefdunklen, rindenartigen Muster, die du schon bei einem Säugling gesehen hast, während sie in Stadtgebet murmeln"
  },
  Event_50276_Name = {
    Text = "drei Opfergaben"
  },
  Event_50277_ChoiceDesc1 = {
    Text = "[Blick]Erhalte das silberne Relikt “(RelicConfig.Arg1)“, infiziere “(Skill.Arg2)“"
  },
  Event_50277_ChoiceDesc2 = {
    Text = "[Ignoriere] Erhalte 3 aus 1 Gebet"
  },
  Event_50277_Desc = {
    Text = "Die Aramer knieten in dem Sandsturm.\nDer Sturm peitschte gegen ihre Körper, der Sand verschlang ihre Andacht.\nInmitten des Staubwirbels scheinen unzählige riesige Augen die verzerrte Erde zu überblicken"
  },
  Event_50277_Name = {Text = "Sandriesen"},
  Event_50278_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_50278_Desc = {
    Text = "Die Bilder, die du nicht erinnern willst, tauchen wieder vor deinen Augen auf.\nWackelnde Tentakel, blutige Schnitte von Glasscherben...\nDu beginnst zu würgen"
  },
  Event_50278_Name = {
    Text = "Einsame Reise II"
  },
  Event_50279_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_50279_Desc = {
    Text = "Sie ist nicht hier, nicht in der gefährlichsten Hitze.\nDas beruhigt dich"
  },
  Event_50279_Name = {
    Text = "Einsame Reise I"
  },
  Event_50280_ChoiceDesc1 = {
    Text = "[Hinterhaltsangriff] Wähle 1 von 3 Befehlskarten aus, um ein Gebet zu erhalten: [(EnchantConfig.Arg1)]"
  },
  Event_50280_ChoiceDesc2 = {
    Text = "[ANG]erhalte zufällig 3 Befehlskarten und ein Gebet:“(EnchantConfig.Arg1)“，infiziere“(Skill.Arg2)“"
  },
  Event_50280_Desc = {
    Text = "Ein Nubier kämpft im heftigen Sandsturm.\nSeine Hufe graben sich tief in den Sand, um nicht in den Strudel gezogen zu werden"
  },
  Event_50280_Name = {
    Text = "Natürlicher Sandsturm"
  },
  Event_50281_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_50281_Desc = {
    Text = "Fest entschlossen stürmst du hinein und reißt das Seil mitten in den Ausrufen der Aram.\nEin Aram-Krieger kommt vorsichtig näher, du reißt ihm den Speer aus der Hand und richtest ihn auf die schwarze Menge"
  },
  Event_50281_Name = {
    Text = "drei Opfergaben"
  },
  Event_50282_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_50282_Desc = {
    Text = "Dein Verstand sagt dir, er wird nicht kommen.\nJa, wer würde einem Spieler vertrauen?\nDu bist allein. Du bist nur allein"
  },
  Event_50282_Name = {
    Text = "Einsame Reise III"
  },
  Event_50283_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_50283_Desc = {
    Text = "Wird das ungewöhnlich hohe Fieber mit der Wiederbelebung des Mutterbaums schlimmer?\nKann Ramona sich allein außerhalb der Sturmwand um sich selbst kümmern?\nJetzt ist nicht die Zeit, sich abzulenken, aber du kannst nicht aufhören, dir Sorgen um deinen Partner zu machen"
  },
  Event_50283_Name = {
    Text = "Einsame Reise I"
  },
  Event_50284_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_50284_Desc = {
    Text = "Du bist entschlossen, frontal anzugreifen, doch die Nubia scheint einen seltenen Halt gefunden zu haben und springt auf deinen Kopf. \n Du bist in dem doppelten Strudel aus Sandsturm und Nubia gefangen. \n “Blindes Wagemut ist kein Weg zum Sieg“, tönt Wilhelms kalte Stimme, die in deinen verstopften Ohren wie eine Botschaft des Engels klingt, “lerne, Gelegenheiten zu nutzen.“"
  },
  Event_50284_Name = {
    Text = "Natürlicher Sandsturm"
  },
  Event_50285_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_50285_Desc = {
    Text = "Jetzt ist nicht die Zeit, gemütlich Zeitung zu lesen"
  },
  Event_50285_Name = {
    Text = "Ihre Ermahnung"
  },
  Event_50286_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_50286_Desc = {
    Text = "Du denkst nicht nach, du erinnerst dich nicht.\nDu willst nicht nachdenken, du willst dich nicht erinnern.\nDie Legende von Missaga wird enden, aber der Weg von Missaga wird nicht aufhören.\nDu musst weitergehen. Du musst weitergehen"
  },
  Event_50286_Name = {
    Text = "Einsame Reise II"
  },
  Event_50287_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_50287_Desc = {
    Text = "“Lieber Schutzherr: \n Ich hoffe, es geht dir gut. \n Es tut mir leid, dass ich während dieser Reise nach Lemvah nicht gut auf meinen Körper geachtet habe und nicht immer an deiner Seite sein kann. \n Aber in entscheidenden Momenten, vertraue bitte auf deinen einzigen Helfer. \n Wenn du mich brauchst, bin ich immer für dich da.“ \n Aus Zeitgründen kannst du nicht weiter lesen. \n Aber die vertraute Schrift gibt dir ein Gefühl der Ruhe und Stabilität."
  },
  Event_50287_Name = {
    Text = "Ihre Ermahnung"
  },
  Event_50288_ChoiceDesc1 = {
    Text = "[Er wird wiederkommen]Erhalte ein Silberrelikt „(RelicConfig.Arg1)“"
  },
  Event_50288_ChoiceDesc2 = {
    Text = "[Er kommt nicht wieder]Erhalte ein goldenes Relikt „(RelicConfig.Arg1)“, infiziere „(Skill.Arg2)“"
  },
  Event_50288_Desc = {
    Text = "Der letzte, der geht, ist Ryker.\nUm Casiah aufzuhalten, hat er sich entschieden, im Zelt zu bleiben.\nEr hatte dir einst versprochen, am Ende das Ritual zu brechen und den Mutterbaum zu verbrennen, und er würde auf jeden Fall dabei sein.\nAber jetzt ist er immer noch nicht an deiner Seite.\nNur du bist allein zurückgeblieben."
  },
  Event_50288_Name = {
    Text = "Einsame Reise III"
  },
  Event_50289_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_50289_Desc = {
    Text = "Gluck gluck, drei runde Schrecken rollen durch die Zeremonie.\nDu fühlst dich nicht mehr wie du selbst, der fanatische Ritus reißt dich in eine unaussprechliche Leere"
  },
  Event_50289_Name = {
    Text = "drei Opfergaben"
  },
  Event_50290_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_50290_Desc = {
    Text = [[
Der Glaube der Arlaner ist so stark, dass sie bereit sind, sich immer wieder vom Sand begraben zu lassen.
Aber wenn du aufblickst, gibt es in dem Sturm keine Sonne]]
  },
  Event_50290_Name = {Text = "Sandriesen"},
  Event_50291_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_50291_Desc = {
    Text = "Möge die Wüste ihre Frömmigkeit erwidern"
  },
  Event_50291_Name = {Text = "Sandriesen"},
  Event_50292_ChoiceDesc1 = {
    Text = "[Entfliehe der Erinnerung]Verbessere zufällig die Gebetsqualität 1 Karte"
  },
  Event_50292_ChoiceDesc2 = {
    Text = "[Erinnerungen einfangen] Wähle 1 von 3 Befehlskarten aus, um das Gebet zu erhalten: „(EnchantConfig.Arg1)\", infiziere „(Skill.Arg2)\""
  },
  Event_50292_Desc = {
    Text = "Der zweite, der ging, war William"
  },
  Event_50292_Name = {
    Text = "Einsame Reise II"
  },
  Event_50293_ChoiceDesc1 = {
    Text = "[Beruhigt]erhalte 25 das schwarze Siegel"
  },
  Event_50293_ChoiceDesc2 = {
    Text = "[Sorge] erhält Silberrelikt „(RelicConfig.Arg1)“, Infektion „(Skill.Arg2)“"
  },
  Event_50293_Desc = {
    Text = "Du erinnerst dich plötzlich an den Tag, an dem du deine Reise begonnen hast. \n Ramona erinnert dich daran, deinen Rucksack zu packen, Wilhelm hat ein Handbuch für die Aufzeichnungen auf dem Weg vorbereitet, und Ryker hat heimlich eine Flasche Whiskey in deinen Rucksack gesteckt. \n Jetzt sind sie alle schon weg. \n\n Die Erste, die ging, war Ramona, Tawils Macht und die Kraft der Sturmwand standen im Widerspruch zueinander, und sie wurde von dem hohen Fieber auf dem Weg überwältigt."
  },
  Event_50293_Name = {
    Text = "Einsame Reise I"
  },
  Event_50294_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_50294_Desc = {
    Text = "Du überfällst den Fuß des Nubiers, er steht instabil, mehrere rankenartige Tentakel wirbeln hastig und chaotisch in der Luft, bis sie schließlich in den Sandsturm gezogen werden."
  },
  Event_50294_Name = {
    Text = "Natürlicher Sandsturm"
  },
  Event_50295_ChoiceDesc1 = {
    Text = "[Lesen]Lösche 1 Karte"
  },
  Event_50295_ChoiceDesc2 = {
    Text = "[Einpacken]Erhalten“(RelicConfig.Arg1)“，Infektion“(Skill.Arg2)“"
  },
  Event_50295_Desc = {
    Text = "Klak Klak.\nUnter dem unirdischen Altar der Ekstase, das schwere Trommeln trieb sich durch den Sandsturm. Inmitten der endlosen Gesänge hörtest du das leise Ticken einer Schreibmaschine – ein Ruf von Missaga, der deine unruhige Seele beruhigte"
  },
  Event_50295_Name = {
    Text = "Ihre Ermahnung"
  },
  Event_50296_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_50296_Desc = {
    Text = "Ryker hat überirdisches Glück. \nEr hat dir versprochen, dass er alles tun wird, was er gesagt hat. \nAuf jeden Fall"
  },
  Event_50296_Name = {
    Text = "Einsame Reise III"
  },
  Event_50297_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_50297_Desc = {
    Text = "Nicht deine Angelegenheit.\nWas du jetzt am meisten benötigst, ist, schnell die Überreste des Mutterbaums zu erreichen und zu zerstören"
  },
  Event_50297_Name = {
    Text = "drei Opfergaben"
  },
  Event_52373_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_52373_Desc = {
    Text = "Du hast überlebt. Du siehst unzählige aufgeschichtete Erdhügel und verbrannte Leiber.\nEs scheint, als hättest du auch etwas verbrannt, doch das spielt bereits keine Rolle mehr.\nDu hörst, die Glocken des Gottes Reiches haben bereits geschlagen"
  },
  Event_52373_Name = {
    Text = "Pestinvasion"
  },
  Event_52374_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_52374_Desc = {
    Text = "Du hast überlebt. Du siehst unzählige aufgestapelte Erdhügel und verbrannte Körper.\nDu kämpfst darum, die Dinge zu schützen, die dir wichtig sind, und hast dafür einen schmerzhaften Preis gezahlt. Doch das spielt schon keine Rolle mehr.\nDu hörst die Glocken des Gottes Reiches läuten"
  },
  Event_52374_Name = {
    Text = "Pestinvasion"
  },
  Event_52375_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_52375_Desc = {
    Text = "Der Zorn des Riesen ebbte vorübergehend. Die Wolken verziehen sich, der Regen hört auf, der Wind legt sich. Der Ozean ist wie eine ewige Mutter, die mit sanften Gezeiten den Rücken von Lemuria sanft streichelt. Nur die verwüsteten Leichname und Ruinen bleiben auf Lemuria zurück. \n Du kämpfst darum, die Dinge zu schützen, die dir wichtig sind, und hast dafür einen schmerzhaften Preis gezahlt. Doch das spielt schon keine Rolle mehr. \n Im Ozean spähst du nach den Umrissen des Göttlichen Reiches."
  },
  Event_52375_Name = {
    Text = "Das Brüllen des Ozeans"
  },
  Event_52376_ChoiceDesc1 = {
    Text = "[Opfer zusätzlicher Opfer]Lösche 1 Befehlskarte, füge 3 verschiedene „Gottes Reich Phantasma“ je 1 Karte dem Deck hinzu"
  },
  Event_52376_Desc = {
    Text = "Vor dem zusammengefallenen Thron von Lemuria stehend, opferst du dein letztes Altar.\nDer endlose Abgrund breitet sich vor dir aus. Du kniest nieder, lächelst und weinst.\n„Sieh, Vater, Deborah. Sieh, mein höchster König - das Gottes Reich ist vor mir erschienen!“"
  },
  Event_52376_Name = {
    Text = "Begrüße, Göttliches Reich"
  },
  Event_52377_ChoiceDesc2 = {
    Text = "[Werte das Kostbare] verliert Arg1 Leben, erhält 1 zufällige Symptom-Karte"
  },
  Event_52377_Desc = {
    Text = "Die Erde. Die stille Erde, die ruhige Erde. Die Erde, die die Menschheit trägt, die ewige und unvergängliche Erde. Doch die Erde zittert. Sie reißt eine bodenlose Spalte auf, alles, was sie trägt, ist wacklig. \n Du setzt all deine Hoffnungen auf die Erde, wenn die Erde zu beben beginnt, wohin wirst du dann gehen? \n Opferritual, die Bürger von Lemuria rufen dich. Opfere alles, damit das göttliche Reich ohne Katastrophen erscheint."
  },
  Event_52377_Name = {
    Text = "Tremor der Erde"
  },
  Event_52378_ChoiceDesc2 = {
    Text = "[Werte das Kostbare] verliert Arg1 Leben, erhält 1 zufällige Symptom-Karte"
  },
  Event_52378_Desc = {
    Text = "Ozean. Der Ozean ist die Mutter, die Lemuria gebar, ist dein Leben, dein Glauben. Und in diesem Moment erhebt sich der Ozean wie der wütende Riese aus den Legenden. Er schreit und ruft, verwandelt das sanfte Meerwasser in harte Felsen und scharfe Stacheln, die er gegen alles vor sich schleudert. Er blickt kalt auf das zitternde Lemuria zu seinen Füßen, auf die Lemurier, die wie Insekten umherfliehen. Er wird Lemuria zerstören, das hat nichts mit Lemuria zu tun. \n Opferritual, die Bürger von Lemuria rufen dich. Opfere alles, damit das ohne Unheil Gottes Reich erscheint."
  },
  Event_52378_Name = {
    Text = "Das Brüllen des Ozeans"
  },
  Event_52379_ChoiceDesc2 = {
    Text = "[Werte das Kostbare] verliert Arg1 Leben, erhält 1 zufällige Symptom-Karte"
  },
  Event_52379_Desc = {
    Text = "Die Pest. Die Pest ist überall. Die Pest ist der schamloseste Diener; wenn der Zorn der Götter über Erde und Ozean vorüber ist, spricht sie im Namen der Götter das Urteil über die unaussprechlichen Tode. Beerdige die Leichen der Angehörigen, verbrenne die Leichen der Angehörigen, bete, dass die Verstorbenen, die starben, um dich zu schützen, sich von dir entfernen. Leben und Menschlichkeit sind vor der Pest machtlos. \nOpferritual, die Bürger von Lemuria rufen dich. Opfere alles, damit das gottlose Reich erscheint."
  },
  Event_52379_Name = {
    Text = "Pestinvasion"
  },
  Event_52380_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_52380_Desc = {
    Text = "Die heftigen Erschütterungen legten sich. Die Straßen sind mit blutroten Flecken bedeckt, unzählige Menschen sind unter den eingestürzten Häusern begraben. \n Du kämpfst darum, die Dinge zu schützen, die dir wichtig sind, und hast dafür einen schmerzhaften Preis gezahlt. Doch das spielt schon keine Rolle mehr. \n Das Einzige, was zählt, ist, dass du dem Göttlichen Reich einen Schritt näher gekommen bist."
  },
  Event_52380_Name = {
    Text = "Tremor der Erde"
  },
  Event_52381_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_52381_Desc = {
    Text = "Vor dem zusammengefallenen Thron von Lemuria stehend, rezitierst du das letzte Gebet.\nDer endlose Abgrund breitet sich vor dir aus. Du kniest nieder, lächelst und weinst.\n„Sieh, Vater, Deborah. Sieh, mein höchster König - das Gottes Reich ist vor mir erschienen!“"
  },
  Event_52381_Name = {
    Text = "Begrüße, Göttliches Reich"
  },
  Event_52382_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_52382_Desc = {
    Text = "Die heftigen Erschütterungen legten sich. Die Straßen sind mit blutroten Flecken bedeckt, unzählige Menschen sind unter den eingestürzten Häusern begraben. \nEtwas von dir scheint ebenfalls unter den Trümmern begraben zu sein, doch das spielt bereits keine Rolle mehr. \nDas Einzige, was zählt, ist, dass du dem Göttlichen Reich einen Schritt näher gekommen bist."
  },
  Event_52382_Name = {
    Text = "Tremor der Erde"
  },
  Event_52383_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_52383_Desc = {
    Text = "Der Zorn des Riesen ließ vorübergehend nach. Die Wolken verschwanden, der Regen hörte auf, der Wind legte sich. Der Ozean war wie eine ewige Mutter und streichelte sanft den Rücken von Lemuria mit sanften Gezeiten. Nur die verwüsteten Leichen und Ruinen blieben auf Lemuria zurück. \n Etwas von dir scheint im Ozean begraben zu sein, aber das spielt keine Rolle mehr. \n Im Ozean spähten die Umrisse des Göttlichen Reiches hervor."
  },
  Event_52383_Name = {
    Text = "Das Brüllen des Ozeans"
  },
  Event_52384_ChoiceDesc1 = {
    Text = "[Ehrfurchtsvolles Gebet]Verwandelt jede gewöhnliche Symptom-Karte im Deck in ein“Gottes Reich Phantasma“und erhält zusätzlich 2“Gottes Reich Phantasma“"
  },
  Event_52384_ChoiceDesc2 = {
    Text = "[Ehrfurchtsvolles Gebet]Verwandelt jede gewöhnliche Symptom-Karte im Deck in ein“Gottes Reich Phantasma“und erhält zusätzlich 2“Gottes Reich Phantasma“"
  },
  Event_52384_Desc = {
    Text = "Die Erde zittert nicht mehr, der Ozean dröhnt nicht mehr, die Seuchen greifen nicht mehr an. Das Verderben hat Lemuria zerstört und nur dich zurückgelassen. Du blickst auf und schaust dich um, alles ist verwüstet. Du siehst auf deine leeren Hände. \n Aber was macht das schon, ehrenwerter Hauptopfer? Trete auf die Trümmer und Leichen von Lemuria und krieche weiter vorwärts. \n Du bist nur noch einen Schritt entfernt vom Göttlichen Reich."
  },
  Event_52384_Name = {
    Text = "Begrüße, Göttliches Reich"
  },
  Event_53140_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_53140_Desc = {
    Text = "Du nimmst den Kontakt der Schule an, die vertraute Stimme beruhigt dich. Du sammelst dich und gehst weiter"
  },
  Event_53140_Name = {
    Text = "Kontaktstelle"
  },
  Event_53141_ChoiceDesc1 = {
    Text = "[Verbinden]Arg2 Lebenspunkte heilen"
  },
  Event_53141_ChoiceDesc2 = {
    Text = "[Meditation] wählt 1 Erwecker aus"
  },
  Event_53141_ChoiceDesc3 = {
    Text = "[verbanne]Entferne bis zu 3 Symptom-Karten, erhalte Arg2 schwarze Siegel"
  },
  Event_53141_ChoiceDesc4 = {
    Text = "[In den Wahnsinn stürzen]wecke zufällig 2 Erwecker und erhalte 1 zufälliges Symptom"
  },
  Event_53141_ChoiceDesc5 = {
    Text = "[Zögern]Andere"
  },
  Event_53141_Desc = {
    Text = "Du erkundest den Nebel, plötzlich leuchtet das Abzeichen auf deiner Brust schwach silbern. Wer ruft dich am anderen Ende des Kommunikators?"
  },
  Event_53141_Name = {
    Text = "Kontaktstelle"
  },
  Event_53141_Tips3 = {
    Text = "Derzeit besitzen Sie keine Symptom-Karten"
  },
  Event_53142_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_53142_Desc = {
    Text = "Du nimmst den Kontakt der Schule an, die vertraute Stimme beruhigt dich. Du sammelst dich und gehst weiter"
  },
  Event_53142_Name = {
    Text = "Kontaktstelle"
  },
  Event_53143_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_53143_Desc = {
    Text = "Du nimmst den Kontakt der Schule an, die vertraute Stimme beruhigt dich. Du sammelst dich und gehst weiter"
  },
  Event_53143_Name = {
    Text = "Kontaktstelle"
  },
  Event_53147_ChoiceDesc1 = {
    Text = "[verbanne]Entferne bis zu 3 Symptom-Karten, erhalte Arg2 schwarze Siegel"
  },
  Event_53147_ChoiceDesc2 = {
    Text = "[In den Wahnsinn stürzen]wecke zufällig 2 Erwecker und erhalte 1 zufälliges Symptom"
  },
  Event_53147_Desc = {
    Text = "Du erkundest den Nebel, plötzlich leuchtet das Abzeichen auf deiner Brust schwach silbern. Wer ruft dich am anderen Ende des Kommunikators?"
  },
  Event_53147_Name = {
    Text = "Kontaktstelle"
  },
  Event_53147_Tips1 = {
    Text = "Derzeit besitzen Sie keine Symptom-Karten"
  },
  Event_53148_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_53148_Desc = {
    Text = "Du stellst die Verbindung her. Am anderen Ende des Kommunikationsgeräts ertönt eine verrückte und berauschende Stimme.\n„Erinnere dich. Das ist das Geschenk des Gottes Reichs an dich.“"
  },
  Event_53148_Name = {
    Text = "Kontaktstelle"
  },
  Event_55782_ChoiceDesc1 = {
    Text = "[Dornen schneiden]Nächster Kampf: Feind HP +30%, Schaden +15%, erhalte Arg1 Bild“(Skill.Arg2)“"
  },
  Event_55782_ChoiceDesc2 = {
    Text = "[Dornen schneiden]Nächster Kampf: Feind HP +30%, Schaden +15%, erhalte Arg1 Bild“(Skill.Arg2)“"
  },
  Event_55782_ChoiceDesc3 = {
    Text = "[Dornen entfernen]Infektion“(Skill.Arg3)“，Arg1 Kartenbild“(Skill.Arg2)“ins Deck legen"
  },
  Event_55782_ChoiceDesc4 = {
    Text = "[Dornen entfernen]Infektion“(Skill.Arg3)“，Arg1 Kartenbild“(Skill.Arg2)“ins Deck legen"
  },
  Event_55782_ChoiceDesc5 = {
    Text = "[Verlasse die Dornen]„Horlas Feder und Tinte“ erhalten Arg1 Schichten„Feder & Tinte“"
  },
  Event_55782_Desc = {
    Text = "Etwas berührt dein Herz. Du bleibst stehen und schaust in die Ecke des Gartens. Unter den Dornen bewegt sich ein Lichtpunkt, versucht sich zu befreien.\nWas ist das? Ein Schmetterling? Ein Vogel? Du näherst dich ihm"
  },
  Event_55782_Name = {
    Text = "Muzus Segen"
  },
  Event_55782_Tips1 = {
    Text = "Im nächsten Kampf sind die Feinde verstärkt, keine erneute Auswahl möglich"
  },
  Event_55783_ChoiceDesc1 = {
    Text = "[Kreative Opfergabe] wählt 3 „Imagination“ Karten und lässt Horla „Opfergabe“ für dich schaffen"
  },
  Event_55783_ChoiceDesc2 = {
    Text = "[Verlassen]"
  },
  Event_55783_Desc = {
    Text = "Du stehst vor einem schönen Gewächshaus und schaust durch das Fenster hinein, aber du kannst nichts sehen. \n Ein Windstoß hebt die Blütenblätter und fallenden Blätter im Gewächshaus, sie wirbeln durch die Luft und sammeln sich. Zwischen den Blumen und Blättern siehst du die Gestalt eines Mädchens. \n „Ah! Ein Besucher im Blumen- und Garten!“ Das Mädchen schaut dich überrascht und nervös an. „Entschuldigung, Kolette ist ausgegangen... Ich weiß nicht so genau, wie viel diese Blumen kosten...“ \n Das Mädchen hält plötzlich inne und betrachtet dich neugierig. „Ah, dieser Gast, ich spüre die Bilder der Poesie in dir... Vielleicht können wir zusammen ein Gedicht schreiben?“"
  },
  Event_55783_Name = {
    Text = "Frühlingsgeschenk"
  },
  Event_55783_Tips1 = {
    Text = "“'Visionen' weniger als 3, nicht kombinierbar.“"
  },
  Event_55799_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_55799_Desc = {
    Text = "Die lebendig gewordenen Dornen sind unruhig, aber diese Kosten sind gering – du hörst den Ruf der Muse an diesem Lichtpunkt"
  },
  Event_55799_Name = {
    Text = "Muzus Segen"
  },
  Event_55819_ChoiceDesc1 = {
    Text = "[Erinnere dich an den Körper]Überspringe den Kampf und gewinne sofort, aber verliere Arg1 Lebenspunkte"
  },
  Event_55819_ChoiceDesc2 = {
    Text = "[Verlassen]Kampf beginnen"
  },
  Event_55819_Desc = {
    Text = "Angesichts des vertrauten Feindes weißt du bereits, wie der nächste Kampf verlaufen wird"
  },
  Event_55819_Name = {
    Text = "Muskelgedächtnis"
  },
  Event_55997_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_55997_Desc = {
    Text = "Aus den gesammelten Bildern hast du einige ausgewählt und sie dem Mädchen in die Hand gegeben. \n „So schöne Bilder! Dieser Gast, bitte warte... Hier. Das ist das Gedicht, das der Frühling für dich mitgebracht hat!“ \n Ein Gedicht erscheint in deiner Hand, wie eine Blume, die speziell für dich aufgeblüht ist. \n Du willst dem Mädchen danken. Doch als du den Kopf hebst, ist die Gestalt des Mädchens bereits verschwunden. In dem einsamen Blumenhaus bleiben nur die verwelkten Blumen und Blätter zurück. \n — das ist die Asche, die nach dem Erlöschen des Frühlings übrig bleibt."
  },
  Event_55997_Name = {
    Text = "Frühlingsgeschenk"
  },
  Event_55999_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_55999_Desc = {
    Text = "Dichte Dornen lassen dich zurückweichen. Du verlässt den Lichtpunkt, aber der kurze Blick darauf füllt dein Herz mit neuer Inspiration – du hörst den Ruf der Muse"
  },
  Event_55999_Name = {
    Text = "Muzus Segen"
  },
  Event_56000_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_56000_Desc = {
    Text = "Du schiebst die Dornen beiseite und verletzt dich dabei, aber das ist es wert – du hörst den Ruf der Muse"
  },
  Event_56000_Name = {
    Text = "Muzus Segen"
  },
  Event_56024_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_56024_Desc = {
    Text = "Nicht genug... Du näherst dich weiter dem Lichtpunkt. Die Dornen sind wütend und zeigen dir ihre scharfen Spitzen. Aber es ist alles wert.\nDer Lichtpunkt entfaltet sich aus deiner Handfläche, und in dem strahlenden Lichthimmel spürst du deutlich den Segen der Musen"
  },
  Event_56024_Name = {
    Text = "Muzus Segen"
  },
  Event_56025_ChoiceDesc1 = {
    Text = "[Nähe dich dem Lichtpunkt]Im nächsten Kampf haben Feinde 30% mehr Leben und 15% mehr Schaden, wähle 1 \"Bild\" zur Verbesserung"
  },
  Event_56025_ChoiceDesc2 = {
    Text = "[Verlassen]"
  },
  Event_56025_Desc = {
    Text = "Du schneidest die Dornen mit deinem Werkzeug ab, sie scheinen unruhig zu sein, aber das ist es wert – du hörst den Ruf der Muse"
  },
  Event_56025_Name = {
    Text = "Muzus Segen"
  },
  Event_56146_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_56146_Desc = {
    Text = "Nicht genug... Du näherst dich weiter dem Lichtpunkt. Scharfe Dornen durchbohren deine Hände und lassen dein Blut fließen. Aber es ist alles wert.\nDer Lichtpunkt entfaltet sich aus deiner Handfläche, und in dem strahlenden Lichthimmel spürst du deutlich den Segen der Musen"
  },
  Event_56146_Name = {
    Text = "Muzus Segen"
  },
  Event_56147_ChoiceDesc1 = {
    Text = "[Kreatives Verlangen] alle Erwecker verlieren allen Aelius, wählt 3 „Imagination“ Karten und lässt Horla „Opfergabe“ für dich schaffen"
  },
  Event_56147_ChoiceDesc2 = {
    Text = "[Verlassen]"
  },
  Event_56147_Desc = {
    Text = "Du nimmst den Kontakt der Schule an, die vertraute Stimme beruhigt dich. Du sammelst dich und gehst weiter"
  },
  Event_56147_Name = {
    Text = "Kontaktstelle"
  },
  Event_56147_Tips1 = {
    Text = "“'Visionen' weniger als 3, nicht kombinierbar.“"
  },
  Event_56148_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_56148_Desc = {
    Text = "Das Silber auf dem Wappen ließ dein Herz höher schlagen. Du folgtest deinem Instinkt und warfst etwas in die Dornen. Das Licht darunter begann zu leuchten – in diesem Licht fandest du neue Inspiration"
  },
  Event_56148_Name = {
    Text = "Kontaktstelle"
  },
  Event_56149_ChoiceDesc1 = {
    Text = "[Nähe dich dem Lichtpunkt]Reduziere die maximale Lebenspunkte um 10%, wähle ein \"Bild\" zur Verbesserung"
  },
  Event_56149_ChoiceDesc2 = {
    Text = "[Verlassen]"
  },
  Event_56149_Desc = {
    Text = "Du schiebst die Dornen beiseite und verletzt dich dabei, aber das ist es wert – du hörst den Ruf der Muse"
  },
  Event_56149_Name = {
    Text = "Muzus Segen"
  },
  Event_56149_Tips1 = {
    Text = "Keine aufrüstbare „Vision“"
  },
  Event_56150_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_56150_Desc = {
    Text = "Das Silber auf dem Wappen ließ dein Herz höher schlagen. Du fühltest einen starken Drang, die Verse in deinem Kopf aufzuschreiben"
  },
  Event_56150_Name = {
    Text = "Kontaktstelle"
  },
  Event_56151_ChoiceDesc1 = {
    Text = "[Neue Inspiration]Wähle 1 Bild zu entfernen, 1 Bild zufällig aufwerten"
  },
  Event_56151_ChoiceDesc2 = {
    Text = "[Verlassen]"
  },
  Event_56151_Desc = {
    Text = "Du nimmst den Kontakt der Schule an, die vertraute Stimme beruhigt dich. Du sammelst dich und gehst weiter"
  },
  Event_56151_Name = {
    Text = "Kontaktstelle"
  },
  Event_56151_Tips1 = {
    Text = "Keine „Imago“-Karten"
  },
  Event_57738_ChoiceDesc1 = {
    Text = "[Durchbrechen]Alle Erwachten erhalten 30 Wahnsinn, aber 2 Karten“(Skill.Arg1)“werden ins Deck gemischt"
  },
  Event_57738_ChoiceDesc2 = {
    Text = "[Entwaffnen]Im nächsten Kampf erhöht sich das Leben des Feindes um 60%, der Schaden um 30%"
  },
  Event_57738_ChoiceDesc3 = {
    Text = "[Hinterhalt]Erschöpfe alle Erwecker Wahnsinn, erhalte 30 das schwarze Siegel und entferne Wächterbedrohung"
  },
  Event_57738_Desc = {
    Text = "Du spähst aus dem Sichtfeld um die Ecke. Die Agenten des Ausschusses beobachten in eine andere Richtung und haben euch nicht bemerkt. \nBilder aus deinem Training blitzen in deinem Kopf auf, und für diesen Feind, der euch den Weg versperrt, findest du schnell eine passende Lösung"
  },
  Event_57738_Name = {
    Text = "Agent der Prüfungskommission"
  },
  Event_57738_Tips3 = {
    Text = "Keine Wahnsinn bei allen Erwachten"
  },
  Event_57739_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_57739_Desc = {
    Text = "Du beobachtest aufmerksam. Die Agenten des Ausschusses stehen euch im Weg und überwachen aufmerksam diesen Bereich vor dir. \nAngesichts der überwältigenden Anzahl feindlicher Kräfte kannst du nicht mit ihnen konkurrieren. \nVorwärts oder rückwärts?"
  },
  Event_57739_Name = {Text = "Haftstelle"},
  Event_57776_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_57776_ChoiceDesc2 = {
    Text = "[Täuschung]Nach Erkundung des Gebiets, teleportiere zum Haftpunkt, erhalte 2 zufällige „Symptome“"
  },
  Event_57776_ChoiceDesc3 = {
    Text = "[Eindringen]Nach Erkundung des Gebiets, teleportiere zum Haftpunkt, verliere Arg1 Leben"
  },
  Event_57776_Desc = {
    Text = "Du beobachtest aufmerksam. Die Agenten des Ausschusses stehen euch im Weg und überwachen aufmerksam diesen Bereich vor dir. \nAngesichts der überwältigenden Anzahl feindlicher Kräfte kannst du nicht mit ihnen konkurrieren. \nVorwärts oder rückwärts?"
  },
  Event_57776_Name = {
    Text = "Überwachungspunkt"
  },
  Event_57776_Tips3 = {
    Text = "Lebenspunkte niedrig"
  },
  Event_59193_ChoiceDesc1 = {
    Text = "[Alistairs Segen]Füge ein \"Dämmerlicht\" dem Deck hinzu"
  },
  Event_59193_Desc = {
    Text = "Dieses Einschreibungszertifikat lag immer am Boden deines Koffers. Du streichst über den fein verzierten Rahmen, der wie mit Sternenlicht überzogen scheint, und riechst den leichten Duft von Tinte. Das Wappen von Missaga zieht deine sehnsüchtigen Augen an – wie damals, wie heute"
  },
  Event_59193_Name = {
    Text = "Einschulung"
  },
  Event_59527_ChoiceDesc1 = {
    Text = "Wähle eine Karte, um das \"Lex Nous\" Orison zu verstehen. \"Lex Nous\": Beim Spielen ziehe 2 Karten; ihre arithmetischen Kosten werden auf die tatsächlichen Kosten der Orison-Karte reduziert, gültig nur einmal pro Kampf."
  },
  Event_59527_Desc = {
    Text = "Das Symbol des Wissens ist auf deinem Dokument eingeprägt.\nTawils Gedanken fließen in deinen Verstand. In all diesen unendlichen Möglichkeiten gehst du den einzig richtigen Weg"
  },
  Event_59527_Name = {
    Text = "Einschulung"
  },
  Event_59528_ChoiceDesc1 = {
    Text = "Wähle eine Karte, um das \"Lex Volis\" Orison zu verstehen. \"Lex Volis\": Beim Spielen wirf alle Karten ab, außer denen dieses Erweckers, erhalte 5 zufällige Nicht-Erwecker-Karten, gültig nur einmal pro Kampf."
  },
  Event_59528_Desc = {
    Text = "Das Symbol der Freude ist auf deinem Dokument eingeprägt.\nDurch das Zeichen beobachtet N dich. Er erwartet, dass du ihm ein Ergebnis bringst, das niemals ausgesprochen wurde"
  },
  Event_59528_Name = {
    Text = "Einschulung"
  },
  Event_59529_ChoiceDesc1 = {
    Text = "Wähle eine Karte, um das \"Lex Genis\" Orison zu verstehen. \"Lex Genis\": Beim Spielen, erhalte 3 zusätzliche Originalkopien mit \"Behalten\" und \"Verbraucht\", gültig nur einmal pro Kampf."
  },
  Event_59529_Desc = {
    Text = "Das Symbol der Fortpflanzung ist auf deinem Dokument eingeprägt.\nThais setzt seine Hoffnungen auf dich, er wird mit dir in allen Welten koexistieren"
  },
  Event_59529_Name = {
    Text = "Einschulung"
  },
  Event_59566_ChoiceDesc1 = {
    Text = "[Bluttränen abwischen] Wähle 1 von 3 Befehlskarten aus, um ein Gebet zu erhalten: [(EnchantConfig.Arg1)]"
  },
  Event_59566_ChoiceDesc2 = {
    Text = "[Augen offen halten]erhalte 3 zufällige Befehlskarten und erhalte das Gotteszeichen: „(EnchantConfig.Arg1)“, Infektion „(Skill.Arg2)“"
  },
  Event_59566_Desc = {
    Text = "Unzählige deiner Wünsche verschmelzen zu einem. Ihr hattet einst denselben Ursprung, jetzt teilt ihr denselben Körper.\nUnzählige Augen öffnen sich, um dem riesigen Auge zu begegnen.\nUnzählige Augen zerbrechen, weinen trockene, schmerzhafte Tränen"
  },
  Event_59566_Name = {
    Text = "Meine Fusion"
  },
  Event_59567_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_59567_Desc = {
    Text = "Du versuchst, mit der verrückten Stimme zu argumentieren und die nihilistische Idee zu widersprechen.\n„Alles wird dem Tod entgegengehen, ist das Leben selbst bedeutungslos?“\nDu streitest leidenschaftlich, doch das Lachen schwindet nicht, es scheint deinen Unverstand zu verspotten"
  },
  Event_59567_Name = {
    Text = "Lamm zur Schlachtung"
  },
  Event_59568_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_59568_Desc = {
    Text = "Du starrst auf die Tür und möchtest den Schmerz der Unwissenheit nicht länger ertragen. \n Du willst die Szene hinter der Tür sehen. \n Die illusorische Tür schwankt hypnotisch, und du siehst die flüchtigen Schatten unzähliger Welten vorbeiziehen. \n Es bleibt dir keine Zeit, um klar zu sehen, unendliche Informationen überfluten deinen Geist, dein Gehirn ist voller chaotischer Geräusche."
  },
  Event_59568_Name = {
    Text = "Tür hinter"
  },
  Event_59569_ChoiceDesc1 = {
    Text = "[Entschlossener Befehl]wecke zufällig 1 Erwecker, Infektion „(Skill.Arg1)“"
  },
  Event_59569_ChoiceDesc2 = {
    Text = "[Gemeinsam verhandeln] wählt 1 aus 3 Befehlskarten und erhält Orison: „(EnchantConfig.Arg1)“"
  },
  Event_59569_Desc = {
    Text = "Alles geschieht so plötzlich, du spürst einen nebligen Dunst um dich, du versuchst, umherzuschauen, aber du kannst nichts klar erkennen.\nDie Erwecker warten auf deine Befehle.\nJetzt bist du isoliert und hilflos, kannst nur auf deine eigenen Kräfte verlassen"
  },
  Event_59569_Name = {
    Text = "Unwissender Blick"
  },
  Event_59570_ChoiceDesc1 = {
    Text = "[Mit Opfer]Erhalte ein verfluchtes Relikt „(RelicConfig.Arg1)“, infiziere „(Skill.Arg2)“"
  },
  Event_59570_ChoiceDesc2 = {
    Text = "[Mit Mut] Wähle 1 von 3 Befehlskarten aus, um das Gebet zu erhalten: [(EnchantConfig.Arg1)]"
  },
  Event_59570_ChoiceDesc3 = {
    Text = "[Direkter Blick]Erhalte 50 das schwarze Siegel"
  },
  Event_59570_Desc = {
    Text = "Unzählige von dir stehen in unzähligen Welten, Schulter an Schulter, Hand in Hand, wie Geschwister.\nJetzt steht ihr gemeinsam im Schatten, hebt eure Köpfe und weicht keinen Schritt zurück.\nWas tun?\nWie besiegt man das ultimative Selbst?"
  },
  Event_59570_Name = {
    Text = "Meine Selbstantwort"
  },
  Event_59571_ChoiceDesc1 = {
    Text = "[Antwort suchen]erhalte Arg1 das schwarze Siegel, Infektion „(Skill.Arg2)“, weiter wählen"
  },
  Event_59571_ChoiceDesc2 = {
    Text = "[Gib auf]erhalte 25 das schwarze Siegel, verlasse"
  },
  Event_59571_Desc = {
    Text = "Durch die Illusion der Tür blitzen unzählige Erlebnisse deines Lebens in deinem Kopf auf. \n Einige starben, einige wurden verrückt, einige hielten durch, einige fielen. \n Unzählige Wege, unzählige Entscheidungen blitzen vor dir auf, als hättest du in einem Augenblick ein langes, endloses Leben gelebt. \n Jetzt arbeiten unzählige Köpfe, unzählige Münder gleichzeitig. \n Du versuchst, durch Raum und Zeit mit unzähligen Versionen deiner selbst zu sprechen und aus den endlosen Erinnerungen Antworten zu finden."
  },
  Event_59571_Name = {
    Text = "Meine Selbstfrage"
  },
  Event_59572_ChoiceDesc1 = {
    Text = "[Macht tauschen]Zufällige Befehlskarte erhalten und das Orison: „(EnchantConfig.Arg1)“"
  },
  Event_59572_ChoiceDesc2 = {
    Text = "[Glück tauschen]Erhöhe Arg1 Punkte maximale Gesundheit, infiziere „(Skill.Arg2)“"
  },
  Event_59572_Desc = {
    Text = "Jede Wahl hat ihren Preis.\nLeben, Geist, Emotionen, Erinnerungen...\nWas möchtest du mit dem Schicksal tauschen und was wählst du, um es auf die Waage zu legen?"
  },
  Event_59572_Name = {
    Text = "Schicksalsentscheidung"
  },
  Event_59573_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_59573_Desc = {
    Text = "Wie kann ein Mensch ohne Herz leben? \n Du suchst panisch um dich herum, dein Atem wird zunehmend schneller, die Angst vor dem Tod umhüllt dein Gehirn. \n „Ich kann nicht mehr atmen... mein Herzschlag wird aufhören...“ \n Moment mal, du scheinst keinen Herzschlag mehr zu brauchen. \n Du hast plötzlich eine Erkenntnis und beginnst glücklich zu lachen."
  },
  Event_59573_Name = {
    Text = "Brusthöhle"
  },
  Event_59574_ChoiceDesc1 = {
    Text = "[Direkter Blick]Erhalte goldenes Relikt“(RelicConfig.Arg1)“，Infektion“(Skill.Arg2)“"
  },
  Event_59574_ChoiceDesc2 = {
    Text = "[Vermeiden]Zufälliges Erwachen von 2 Erwachten, Infektion zweimal“(Skill.Arg1)“"
  },
  Event_59574_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte 50 schwarze Siegel"
  },
  Event_59574_Desc = {
    Text = "Du fühlst, dass etwas im Nichts dich beobachtet.\nEgal wohin du gehst, dieser Blick folgt dir.\nDu fühlst dich wie eine gejagte Beute, dein Rücken beginnt vor Schmerz zu stechen"
  },
  Event_59574_Name = {Text = "Sein Blick"},
  Event_59575_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_59575_Desc = {
    Text = "Du bleibst unbeeindruckt von der wilden Musik und behältst deinen eigenen Rhythmus bei.\nDie ANGe und Verlockungen des Gegners haben keine Wirkung auf dich, und auf dem Klavier werden gleichzeitig zwei Melodien gespielt. Wer bis zum Ende durchhält, wird alle Noten beherrschen"
  },
  Event_59575_Name = {
    Text = "Apokalypse Party Song"
  },
  Event_59576_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_59576_Desc = {
    Text = "Du sammelst all deinen Mut, egal was kommt, du wirst mit deinen Gefährten weitermachen"
  },
  Event_59576_Name = {
    Text = "Zukunft festgehalten"
  },
  Event_59577_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_59577_Desc = {
    Text = "„Wo bist du jetzt?“ \n „Was haben die Lehrer vor?“ \n „Was soll ich als Nächstes tun?“ \n Du fragst hastig nach, willst dich wie gewohnt auf dieses zuverlässige Wesen verlassen. \n Der Kommunikator reagierte wie ein Stocken und blieb stumm, während du das Gerät schüttelst, verwandeln sich die Buchstaben auf dem Antwortschreiben in eine Gruppe von Schmetterlingen, die mit einem Flattern in dein Gesicht schlagen. \n Du reibst dir die Augen und stellst fest, dass alles nur eine Illusion war. \n Auf dem Briefpapier der Antwort steht kein Wort."
  },
  Event_59577_Name = {
    Text = "Verwirrender Echo"
  },
  Event_59578_ChoiceDesc1 = {
    Text = "[Suchend in Panik]steigere Arg1 Punkte maximale Gesundheit"
  },
  Event_59578_ChoiceDesc2 = {
    Text = "[Auffüllen versuchen] Wähle 1 von 3 Befehlskarten aus, um ein Gebet zu erhalten: „(EnchantConfig.Arg1)\", infiziere „(Skill.Arg2)\""
  },
  Event_59578_Desc = {
    Text = "Du fühlst eine Leere und Leichtigkeit in deiner Brust. Du schaust nach unten und siehst, dass deine Brust sich in ein Schlüsselloch verwandelt hat.\nDein Herz ist verschwunden"
  },
  Event_59578_Name = {
    Text = "Brusthöhle"
  },
  Event_59579_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_59579_Desc = {
    Text = "Du fragst laut nach seinem Ziel, doch erhältst nur ein unverändertes Lächeln zurück.\n\nEr hat die Welt längst verlassen, jemand ohne Bindungen muss sich um nichts kümmern.\nDu kannst nur vergeblich Widerstand leisten"
  },
  Event_59579_Name = {
    Text = "Verrückter Herr"
  },
  Event_59580_ChoiceDesc1 = {
    Text = "[Rhythm stören] Erhalte das Silberrelikt“(RelicConfig.Arg1)“、infiziere“(Skill.Arg2)“"
  },
  Event_59580_ChoiceDesc2 = {
    Text = "[Behalte dich selbst] Erhalte 3 aus 1 Gebet"
  },
  Event_59580_Desc = {
    Text = "Es ist, als würdest du mit einem Wahnsinnigen spielen, der dich an die Tasten fesselt und in seine verrückte Melodie zieht.\nDu spielst mühsam in ihrem Rhythmus, stolpernd.\nDu kämpfst schwer mit ihr, versuchst, die Melodie zu kontrollieren"
  },
  Event_59580_Name = {
    Text = "Apokalypse Party Song"
  },
  Event_59581_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_59581_Desc = {
    Text = "Du wünschst dir unvergleichliche Macht, die in der Lage ist, alle Fesseln und Hindernisse zu zerbrechen.\nDoch menschliche Kraft ist begrenzt, gegen Gottheiten in einem winzigen Körper anzutreten, wird letztendlich wie ein Streichholz sein, das das eigene Leben verbrennt"
  },
  Event_59581_Name = {
    Text = "Schicksalsentscheidung"
  },
  Event_59582_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_59582_Desc = {
    Text = "„Weg... weg...“\nDas Gefühl der Leere ist unangenehm, du nimmst die Taschenuhr, den Apfel und die Schuluniformjacke, um die Leere in deiner Brust zu füllen.\nDein Brustkorb fühlt sich wieder voll an, aber du hast das Gefühl, zu satt zu sein.\nEs ist okay, nichts ist perfekt."
  },
  Event_59582_Name = {
    Text = "Brusthöhle"
  },
  Event_59583_ChoiceDesc1 = {
    Text = "[Überzeuge]Erhalte 25 schwarze Siegel"
  },
  Event_59583_ChoiceDesc2 = {
    Text = "[Frage]Erhalte das Silberrelikt“(RelicConfig.Arg1)“，infiziere“(Skill.Arg2)“"
  },
  Event_59583_Desc = {
    Text = "N's Schuhe bleiben vor dir stehen, ein verzerrtes Grinsen auf seinem dunklen Gesicht.\nEr kleidet sich stets tadellos, doch hinter dieser höflichen Fassade verbirgt sich pure Wahnsinn.\nEr hat keine Freunde und kaum Feinde.\nDenn sie alle verschwinden auf die theatralischste Art und Weise.\nLeider bist du nun seine nächste Hauptrolle.\nVorbereiten deiner Eröffnungszeile. Wie wirst du dieses anspruchsvollste Publikum zufriedenstellen?"
  },
  Event_59583_Name = {
    Text = "Verrückter Herr"
  },
  Event_59584_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_59584_Desc = {
    Text = "Die Erwecker wissen nicht mehr als du, aber sie sind bereits deine loyalsten Partner, Kameraden und Rückhalt. \n Du besprichst Strategien mit den Erweckten. Obwohl ihr innerlich immer noch unsicher seid, habt ihr den Mut, neu zu starten."
  },
  Event_59584_Name = {
    Text = "Unwissender Blick"
  },
  Event_59585_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_59585_Desc = {
    Text = "Als ob du dir selbst Mut machst, antwortest du laut und entschlossen.\nDeine Stimme hallt zwischen unzähligen Blasen wider, als ob viele von dir gleichzeitig schwören.\nDu bist bereit, allem zu begegnen"
  },
  Event_59585_Name = {
    Text = "Seine Anklage"
  },
  Event_59586_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_59586_Desc = {
    Text = "Du bewegst dich nicht, sondern starrst nur auf die Schrift auf dem Antwortbrief. \n Unter deinem Blick verschwommen und verzerrten sich die Worte allmählich und verwandelten sich schließlich in eine Schar von Schmetterlingen, die lautlos auf dein Gesicht flogen. \n Du schwenkst deine Hände, um die Schmetterlinge zu vertreiben, und als du dich umdrehst, ist das Blatt des Antwortbriefs bereits leer. \n Tatsächlich sind allzu schöne Träume immer illusorisch."
  },
  Event_59586_Name = {
    Text = "Verwirrender Echo"
  },
  Event_59587_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_59587_Desc = {
    Text = "Du verachtest diese niederträchtigen Fäden. \n Du ziehst sie mit aller Kraft, einige Fäden reißen, doch unzählige Fäden wickeln sich erneut um dich. \n Du kämpfst mit all deiner Kraft gegen sie an."
  },
  Event_59587_Name = {
    Text = "Manipulierte Hände"
  },
  Event_59588_ChoiceDesc1 = {
    Text = "[Die Schattengestalt niederstrecken] Wähle 1 von 3 Befehlskarten aus, die das Gebet erhält: „(EnchantConfig.Arg1)\", infiziert „(Skill.Arg2)\""
  },
  Event_59588_ChoiceDesc2 = {
    Text = "[Den Embryo zermalmen] Wähle 1 von 3 Befehlskarten aus, die das Gebet erhält: „(EnchantConfig.Arg1)\", infiziert „(Skill.Arg2)\""
  },
  Event_59588_ChoiceDesc3 = {
    Text = "[Schließe die Augen]Erhalte 25 das schwarze Siegel"
  },
  Event_59588_Desc = {
    Text = "Benommen siehst du die Menschen, die du einst bei Aram getroffen hast, sich dir nähern. \n Sie lachen und laden dich ein, zu trinken, zu tanzen und köstliches Essen zu probieren. \n Dann schält sich ihr Fleisch Schicht für Schicht ab, und das, was zu Boden fällt, kriecht und wächst zu neuen Embryonen. \n Sie strecken dir die Hände entgegen und laden dich ein, an der Feier von Fleisch und Neugeboren teilzunehmen."
  },
  Event_59588_Name = {
    Text = "Schatten der Vergangenheit"
  },
  Event_59589_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_59589_Desc = {
    Text = "Bevor du die Hand ausstreckst, erinnerst du dich, dass du nie eine solche Katze hattest.\nDu und die Katze starren sich durch die Luft an, die Katze blinzelt dir zu.\nDie Katze kümmert sich nicht um deine Kälte, sie liebt dich immer noch"
  },
  Event_59589_Name = {
    Text = "Katzenverlockung"
  },
  Event_59590_ChoiceDesc1 = {
    Text = "[Einfassung]Wähle ein Relikt, um zu einem verfluchten Relikt „(RelicConfig.Arg1)“ zu werden"
  },
  Event_59590_ChoiceDesc2 = {
    Text = "[Herunter schlucken]erhält Silberrelikt „(RelicConfig.Arg1)“, infiziert „(Skill.Arg2)“"
  },
  Event_59590_ChoiceDesc3 = {
    Text = "[Packe es ein]erhalte 25 das schwarze Siegel"
  },
  Event_59590_Desc = {
    Text = "Die Kraft der drei großen Plasmide in deinem Körper verschmilzt, während du mühsam versuchst, diese gewaltige Kraft zu bändigen. \n Der geistige Raum dehnt sich ständig aus, eine Galaxie entsteht und breitet sich aus. \n Angesichts der unaufhörlichen Feinde betest du aufrichtig zu diesem Sternenhimmel und wünschst dir die Hilfe dieser Kraft. \n Ein Stern fällt aus der Galaxie in deine Handfläche und strahlt verführerisches Licht aus."
  },
  Event_59590_Name = {
    Text = "Wunschstern"
  },
  Event_59591_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_59591_Desc = {
    Text = [[
Du antwortest mit Schweigen, ihr habt nicht kommuniziert, die Stille ist die Antwort auf alles.
Du bist bereit, allem zu begegnen.]]
  },
  Event_59591_Name = {
    Text = "Seine Anklage"
  },
  Event_59592_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_59592_Desc = {
    Text = "Ist die Katze ein Betrüger?\nDu beginnst, an den wasserblauen Augen zu zweifeln, das Lachen hallt in deinen Ohren wider.\n„Betrüger, Betrüger, du wurdest betrogen!“\nEine Welle der Besorgnis überkommt dich"
  },
  Event_59592_Name = {
    Text = "Geheimes Flüstern"
  },
  Event_59593_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_59593_Desc = {
    Text = "Ihr seid wie ein Zuschauer, der still die fremden Emotionen betrachtet. \nIhr zügelt all eure Sehnsüchte und spürt, wie eure Seele allmählich kalt wird.\nDas ist dein Schicksal, das ist dein unvermeidlicher Weg"
  },
  Event_59593_Name = {
    Text = "Emotionskristall"
  },
  Event_59594_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_59594_Desc = {
    Text = "Das lächelnde Gesicht bleibt unberührt, du kannst ihn weder mit rationaler noch mit emotionaler Kommunikation erreichen. \n Alles, was der Mensch begehrt, ist ihm gleichgültig. \n Können deine Worte die Vorstellungskraft der Menschen überschreiten?"
  },
  Event_59594_Name = {
    Text = "Verrückter Herr"
  },
  Event_59595_ChoiceDesc1 = {
    Text = "[Antworte]erhalte das goldene Relikt“(RelicConfig.Arg1)“、infiziere“(Skill.Arg2)“"
  },
  Event_59595_ChoiceDesc2 = {
    Text = "[Schweigen]Zufälliges Erwachen von 2 Körpern, zweimal Infektion“(Skill.Arg1)“"
  },
  Event_59595_Desc = {
    Text = "Unzählige Blasen sehen aus wie unzählige runde Augen, sie schauen dich schweigend an, als ob sie lautlos fragen würden.\nBist du bereit?\nBereit, alles aufzugeben?\nBereit, alles zu tragen?"
  },
  Event_59595_Name = {
    Text = "Seine Anklage"
  },
  Event_59596_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_59596_Desc = {
    Text = "Im Moment des ANGs des Gegners, konterst du sofort.\nDu hast weise erkannt, wer sie wirklich sind, eine Gruppe von Bestien mit entblößten Reißzähnen.\nDu hast glücklicherweise gewonnen.\nJetzt fliehe, lass dich nicht von ihnen erwischen"
  },
  Event_59596_Name = {
    Text = "In die Tiefe sinken"
  },
  Event_59597_ChoiceDesc1 = {
    Text = "[Antwort suchen]erhalte Arg1 das schwarze Siegel, Infektion „(Skill.Arg2)“, weiter wählen"
  },
  Event_59597_ChoiceDesc2 = {
    Text = "[Aufgeben]Verlassen"
  },
  Event_59597_Desc = {
    Text = "Was sollst du tun?\nDu siehst auf unzählige Versionen von dir selbst, unzählige Gesichter, die dich anstarren, ihre Münder bewegen sich.\nWie ein Strohhalm der Hoffnung suchst und lauschst du, in der Hoffnung, die endgültige Antwort zu finden"
  },
  Event_59597_Name = {
    Text = "Meine Selbstfrage"
  },
  Event_59598_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_59598_Desc = {
    Text = [[
Der Zeitpunkt ist noch nicht gekommen, du musst geduldig warten.
Du schluckst deinen Groll und Hass hinunter und wartest auf den entscheidenden Moment]]
  },
  Event_59598_Name = {
    Text = "Manipulierte Hände"
  },
  Event_59599_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_59599_Desc = {
    Text = "Du spürst eine Art von mysteriöser Anziehung und möchtest die Quelle dieses Blicks erkennen. \n Du starrst besessen ins Nichts und hast das Gefühl, etwas gesehen zu haben. \n Der Blick wird für einen Moment von schneeflockenartiger Unschärfe verdeckt, und die Welt in deinen Augen scheint an einem Ort anders geworden zu sein. \n Du reibst dir die Augen und bemerkst, dass aus deinen Augenwinkeln zwei Ströme Bluttränen fließen."
  },
  Event_59599_Name = {Text = "Sein Blick"},
  Event_59600_ChoiceDesc1 = {
    Text = "[Angestrengt erinnern] Wähle 1 von 3 Befehlskarten aus, die das Gebet erhält: „(EnchantConfig.Arg1)\", infiziert „(Skill.Arg2)\""
  },
  Event_59600_ChoiceDesc2 = {
    Text = "[Die Trauer auskosten] Wähle 1 von 3 Befehlskarten aus, die das Gebet erhält: „(EnchantConfig.Arg1)\", infiziert „(Skill.Arg2)\""
  },
  Event_59600_ChoiceDesc3 = {
    Text = "[schweige hinnehmend]Erhalte 25 schwarze Siegel"
  },
  Event_59600_Desc = {
    Text = "Es ist, als hättest du die präziseste Gehirnoperation durchlebt; du spürst deutlich, wie kostbare Erinnerungen aus deinem Geist entgleiten, dein Gehirn wird verschwommen, als würde es schmelzen. \n Du zitterst schmerzhaft und drückst die Hand, die du zu stoppen versuchst. \n Kristallklare Tränen fließen aus deinen Augenwinkeln, aber warum fließen sie? \n Es scheint, als könntest du dich nicht daran erinnern. \n Du fühlst dich seltsam traurig."
  },
  Event_59600_Name = {
    Text = "Gedächtnisdissoziation"
  },
  Event_59601_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_59601_Desc = {
    Text = "Deine Freundschaft mit der Katze ist unbestreitbar. Du winkst und gehst weiter, ohne zurückzublicken.\n„Dummkopf! Dummkopf!“\nDie Stimme in deinem Ohr ist wütend"
  },
  Event_59601_Name = {
    Text = "Geheimes Flüstern"
  },
  Event_59602_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_59602_Desc = {
    Text = "Du hast beschlossen, egal welche Kosten es hat, du wirst bis zur letzten Sekunde für die Hoffnung aller kämpfen"
  },
  Event_59602_Name = {
    Text = "Zukunft festgehalten"
  },
  Event_59603_ChoiceDesc1 = {
    Text = "[Zurückhalten] erhält Silberrelikt „(RelicConfig.Arg1)“"
  },
  Event_59603_ChoiceDesc2 = {
    Text = "[Starren]Erhalte ein goldenes Relikt „(RelicConfig.Arg1)“, infiziere „(Skill.Arg2)“"
  },
  Event_59603_Desc = {
    Text = "Hinter dem Tor, das Tawil bewacht, liegt eine endlose Welt und endlose Wahrheiten.  \nDu weißt nicht, was sie hinter der Tür gesehen hat, aber du weißt, dass sie alles weiß.  \nJetzt steht diese Tür vor dir offen und die gesamte Wahrheit lädt hinter dem Tor geräuschlos ein"
  },
  Event_59603_Name = {
    Text = "Tür hinter"
  },
  Event_59604_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_59604_Desc = {
    Text = "Man sollte dem unbekannten Wesen mit Respekt begegnen, es zu meiden ist die vorsichtige Wahl. \n Du senkst den Kopf, umklammerst den silbernen Schlüssel an deiner Brust und fühlst dich ein wenig getröstet. \n Zumindest hast du noch Kraft, noch die Erwecker. \n Du versuchst, die Blicke zu ignorieren und dich auf den Weg vor dir zu konzentrieren. \n Aber sind diese Blicke wirklich verschwunden? Das weißt du ganz genau."
  },
  Event_59604_Name = {Text = "Sein Blick"},
  Event_59605_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_59605_Desc = {
    Text = "Wenn alle Mittel, um gegen die Götter anzukämpfen, wie Ameisen sind, die einen Baum erschüttern, dann ist der einzige Mut, den du aufrechterhalten kannst, nicht aufzugeben.\nWenn die endlose Zerstörung vom Himmel herabdrängt, wirst du diejenige sein, die ganz vorne steht"
  },
  Event_59605_Name = {
    Text = "Meine Selbstantwort"
  },
  Event_59606_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_59606_Desc = {
    Text = "Du berührst verwirrt die unaufhörlich fließenden Tränen und schmeckst den unbekannten Schmerz sorgfältig nach. \n Es scheint, als hättest du viele sehr kostbare Dinge selbst weggeworfen, doch du kannst dich nicht mehr daran erinnern, was es war. \n Wie bedauerlich. \n Du wischst die Tränen kraftlos ab und zeigst in den Tränen ein bitteres Lächeln."
  },
  Event_59606_Name = {
    Text = "Gedächtnisdissoziation"
  },
  Event_59607_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_59607_Desc = {
    Text = "Du ignorierst ihre Stimmen.\nEs ist dir egal, ob die Katze ein Betrüger ist, du vertraust nur deiner eigenen Kraft.\nDie Stimmen in deinem Ohr seufzen"
  },
  Event_59607_Name = {
    Text = "Geheimes Flüstern"
  },
  Event_59608_ChoiceDesc1 = {
    Text = "[Antwort suchen]erhalte Arg1 das schwarze Siegel, Infektion „(Skill.Arg2)“, weiter wählen"
  },
  Event_59608_ChoiceDesc2 = {
    Text = "[Aufgeben]Verlassen"
  },
  Event_59608_Desc = {
    Text = "Jemand lacht wahnsinnig.\nEr glaubt, alles ist vergeblich, besser aufgeben.\nDu runzelst die Stirn, er lächelt plötzlich und sagt, es wäre besser, alle zu töten, als sie leiden zu lassen.\nDu vertreibst die Stimme und bleibst standhaft"
  },
  Event_59608_Name = {
    Text = "Meine Selbstfrage"
  },
  Event_59609_ChoiceDesc1 = {
    Text = "[Fragen]Lösche 2 Karten"
  },
  Event_59609_ChoiceDesc2 = {
    Text = "[Durchstoßen]erhalte das verfluchte Relikt“(RelicConfig.Arg1)“、infiziere“(Skill.Arg2)“"
  },
  Event_59609_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte Arg1 schwarze Siegel"
  },
  Event_59609_Desc = {
    Text = "In der langen Wartezeit hast du erneut den Kommunikator geöffnet, vielleicht hat dein Vermissen und Beten gewirkt, du siehst, wie auf dem Antwortblatt ihre vertraute und liebevolle Antwort kontinuierlich erscheint. \n Sie ist jetzt sehr sicher, die Lehrer haben bereits Vorkehrungen getroffen, die Abläufe in Misaq laufen reibungslos... \n Du siehst die gute Nachricht, die wie Schneeflocken heranfliegt, und kannst nicht anders, als dich im Herzen zu rühren."
  },
  Event_59609_Name = {
    Text = "Verwirrender Echo"
  },
  Event_59610_ChoiceDesc1 = {
    Text = "[Sterne einfangen]ein Silberrelikt zu goldenem Relikt „(RelicConfig.Arg1)“ aufwerten"
  },
  Event_59610_ChoiceDesc2 = {
    Text = "[Sterne zerdrücken]erhalte goldenes Relikt „(RelicConfig.Arg1)“, infektiere „(Skill.Arg2)“ sowie „(Skill.Arg3)“"
  },
  Event_59610_ChoiceDesc3 = {
    Text = "[Stumm Zusehen]Erhalte 25 schwarze Siegel"
  },
  Event_59610_Desc = {
    Text = "Deine Emotionen werden zusammen mit den Erinnerungen abgerissen, und du spürst, dass du zu einer gewaltigen Existenz wirst, als wäre das Monster in sein uraltes, warmes Nest zurückgekehrt. \n Unzählige Freuden und Leiden konzentrieren sich und verwandeln sich in funkelnde Sterne, die in deiner geistigen Dimension einen leuchtenden Regen fallen lassen. \n Die Spuren deines Daseins verwandeln sich in Sternschnuppen und verschwinden. \n Du beobachtest schweigend und hebst einen Stern vor dir auf, aus dem dein fröhliches Lachen ertönt. \n So lachst auch du, süß wie Honig."
  },
  Event_59610_Name = {
    Text = "Emotionskristall"
  },
  Event_59611_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_59611_Desc = {
    Text = "Du weißt, dass dies nur Schatten der Vergangenheit sind, und mit ausdrucklosem Gesicht schlachtest du die Menschen, die einst mit dir gesprochen haben. \n Ihr Lachen und ihre Tränen zerbrechen in deinen Händen, du darfst nicht einen Moment innehalten. \n Wenn dies die notwendige Prüfung ist, wirst du der grausamste Henker sein."
  },
  Event_59611_Name = {
    Text = "Schatten der Vergangenheit"
  },
  Event_59612_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_59612_Desc = {
    Text = "Sein weiches Fell und seine klaren Augen lassen dich natürlich Vertrauen spüren.\nDu näherst dich der Katze, und die Katze nähert sich dir.\nIhr sprecht nicht, aber ihr Schwanz steht hoch"
  },
  Event_59612_Name = {
    Text = "Katzenverlockung"
  },
  Event_59613_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_59613_Desc = {
    Text = "Du unterdrückst deine Neugier, du weißt, dass diese Tür nicht geöffnet werden sollte.\nZu viel Wahrheit ist manchmal ein Fluch.\nDu hältst den silbernen Schlüssel an deiner Brust fest und beschließt, diese Tür für immer zu verschließen"
  },
  Event_59613_Name = {
    Text = "Tür hinter"
  },
  Event_59614_ChoiceDesc1 = {
    Text = "[Mut] zufällig erhöht die Effekte von 2 Karten"
  },
  Event_59614_ChoiceDesc2 = {
    Text = "[Entschlossenheit] wählt 1 aus 3 Befehlskarten und erhält Orison: „(EnchantConfig.Arg1)“"
  },
  Event_59614_Desc = {
    Text = "Tawils Worte hallen in deinem Kopf wider.\nVon unzähligen Enden gibt es nur einen richtigen Weg.\nIm Dämmerzustand siehst du viele Schattenwelten vor dir, die wie Filmfragmente vorbeihuschen, wartend auf den Moment, in dem der Knopf gedrückt wird, um sie festzuhalten.\nWas für ein Ende wird die Welt nach dieser Sekunde erleben?"
  },
  Event_59614_Name = {
    Text = "Zukunft festgehalten"
  },
  Event_59615_ChoiceDesc1 = {
    Text = "[Ignoriere den Zweifel]erhalte 50 das schwarze Siegel"
  },
  Event_59615_ChoiceDesc2 = {
    Text = "[Willkür]Erhalte 75 das schwarze Siegel, Infektion“(Skill.Arg2)“"
  },
  Event_59615_Desc = {
    Text = "Mit Ns Spott beginnst du, an allen zu zweifeln. \nWer ist sein Avatar, wer dein wahrer Freund? \nSein Schatten verändert sich ständig, als ob er viele Gesichter hätte, die dich anlächeln"
  },
  Event_59615_Name = {
    Text = "Die hundert Gesichter des Schattens"
  },
  Event_59616_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_59616_Desc = {
    Text = "Wenn jeder verraten könnte, dann verlasse dich auf niemanden.\nIn der Dunkelheit kannst du nur eine Wahrheit erkennen.\nZumindest hast du dich selbst – dein treuestes Selbst, dem du vertrauen kannst"
  },
  Event_59616_Name = {
    Text = "Die hundert Gesichter des Schattens"
  },
  Event_59617_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_59617_Desc = {
    Text = "Du drückst kräftig zu, und der schimmernde Kristall zerbricht zu Staub an deinen Fingerspitzen. \n Gierig atmest du die Emotionen aus der Vergangenheit ein. \n In einem Augenblick strömt intensive Freude in dein Gehirn, während die Illusion langsam verschwindet. \n Deine Mundwinkel heben sich daraufhin hoch, um dann langsam wieder zu sinken. \n Dein Gesicht wird allmählich ruhig und reglos."
  },
  Event_59617_Name = {
    Text = "Emotionskristall"
  },
  Event_59618_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_59618_Desc = {
    Text = "Du weißt, dass alles seinen Preis hat. Wenn der Preis für die Rettung Opfer ist, dann trägst du ihn allein.\nDu bist bereit, alles zu geben"
  },
  Event_59618_Name = {
    Text = "Meine Selbstantwort"
  },
  Event_59619_ChoiceDesc1 = {
    Text = "[Antwort suchen]erhalte Arg1 das schwarze Siegel, Infektion „(Skill.Arg2)“, weiter wählen"
  },
  Event_59619_ChoiceDesc2 = {
    Text = "[Aufgeben]Verlassen"
  },
  Event_59619_Desc = {
    Text = "Jemand schreit.\nDu willst fliehen, er sagt, Widerstand ist zwecklos.\nNur endlose Flucht kann das Ende hinauszögern.\nDu bist unsicher"
  },
  Event_59619_Name = {
    Text = "Meine Selbstfrage"
  },
  Event_59620_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_59620_Desc = {
    Text = "Du kennst die schreckliche Fortpflanzungsrate dieser Embryonen, das Neugeborene ist hier der Fluch der Heuschrecken. \n Du zerdrückst sie, bevor diese Neugeborenen zu jammern beginnen. \n Die aus Fleisch bestehenden Menschen sehen dich mit Groll an und fragen dich, warum du das heilige Leben verfluchst. \n Du antwortest mit endlosem Töten."
  },
  Event_59620_Name = {
    Text = "Schatten der Vergangenheit"
  },
  Event_59621_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_59621_Desc = {
    Text = "In diesem Moment hoffst du, der Glücklichste zu sein und das beste Ende zu erreichen.\nDoch Glück hat oft einen hohen Preis, und wenn du es erreichst, vergiss nicht, was du verloren hast"
  },
  Event_59621_Name = {
    Text = "Schicksalsentscheidung"
  },
  Event_59622_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_59622_Desc = {
    Text = "Es ist, als würdest du um das Lenkrad eines Autos kämpfen, deine Hände fliegen umher, während du versuchst, den Rhythmus des Stücks zu kontrollieren.\nIn diesem mühsamen Kampf drückst du plötzlich heftig eine Reihe von Tasten.\nDas chaotische Spiel wird von dir gestört, du verzogst die Lippen zu einem Lächeln und gerätst in einen Kampf zwischen Wahnsinn und noch mehr Wahnsinn."
  },
  Event_59622_Name = {
    Text = "Apokalypse Party Song"
  },
  Event_59623_ChoiceDesc1 = {
    Text = "[Nähe]Erhalte 25 das schwarze Siegel"
  },
  Event_59623_ChoiceDesc2 = {
    Text = "[Starren]50% Möglichkeit, 50 schwarze Siegel zu erhalten, 50% Möglichkeit, nichts zu erhalten"
  },
  Event_59623_Desc = {
    Text = "Eine Katze begleitet dich, ihr Fell ist glatt und sauber, ihre Vorderpfoten sind schneeweiß.\nDie Katze bleibt immer an deiner Seite, Schritt für Schritt, wie dein treuester Diener.\nAlle deine Zweifel und Ängste, dein Schmerz und deine Unruhe werden beruhigt"
  },
  Event_59623_Name = {
    Text = "Katzenverlockung"
  },
  Event_59624_ChoiceDesc1 = {
    Text = "[Verneinung] infiziere“(Skill.Arg1)“、erhalte die Fluchkreatur“(RelicConfig.Arg2)“"
  },
  Event_59624_ChoiceDesc2 = {
    Text = "[Widerspruch] Infiziere zweimal mit “(Skill.Arg1)“, erhalte ein Silberrelikt “(RelicConfig.Arg2)“ und “(RelicConfig.Arg3)“"
  },
  Event_59624_ChoiceDesc3 = {
    Text = "[Schweigen] erhält Silberne Schöpfung “(RelicConfig.Arg1)“"
  },
  Event_59624_Desc = {
    Text = "Du bist in eine Art von Nichtigkeitsträumerei gefangen. \n Du siehst unzählige Menschen, die unter dem Schatten des Weltuntergangs schweigen, klein wie Staub. \n Sie sind starr, grau und haben die Hoffnung verloren. \n Du hörst das scharfe Lachen von jemandem. \n „Sieh her, das ist das Ergebnis eures Festhaltens.“ \n „Die Welt hat niemals ein Ende, alles hat keine Bedeutung.“"
  },
  Event_59624_Name = {
    Text = "Lamm zur Schlachtung"
  },
  Event_59625_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_59625_Desc = {
    Text = "Nein, das ist falsch, das ist nicht real.\nDu lehnst die verrückte Stimme ständig ab, doch der graue Schatten bleibt ungerührt, als ob er das nihilistische Ende bestätigt.\nDas Lachen wird immer lauter, verspottet deine Ohnmacht"
  },
  Event_59625_Name = {
    Text = "Lamm zur Schlachtung"
  },
  Event_59626_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_59626_Desc = {
    Text = "Du fühlst ein großes Bedauern und eine tiefe Traurigkeit, und instinktiv versuchst du verzweifelt, in den Bruchstücken deiner Erinnerungen nach den Schatten der Vergangenheit zu suchen. \n Diese verschwommenen Reflexionen ziehen schnell nach hinten, du versuchst verzweifelt, sie zu greifen, doch du kannst nur sehen, wie diese Bilder zwischen deinen Fingern entgleiten. \n Du erkennst, dass du bald nichts mehr haben wirst."
  },
  Event_59626_Name = {
    Text = "Gedächtnisdissoziation"
  },
  Event_59627_ChoiceDesc1 = {
    Text = "[Nähe]Erhalte 25 das schwarze Siegel"
  },
  Event_59627_ChoiceDesc2 = {
    Text = "[Starren]50% Möglichkeit, 50 schwarze Siegel zu erhalten, 50% Möglichkeit, nichts zu erhalten"
  },
  Event_59627_Desc = {
    Text = "Eine Katze begleitet dich, ihr Fell ist glatt und sauber, ihre Vorderpfoten sind schneeweiß.\nDie Katze bleibt immer an deiner Seite, Schritt für Schritt, wie dein treuester Diener.\nAlle deine Zweifel und Ängste, dein Schmerz und deine Unruhe werden beruhigt"
  },
  Event_59627_Name = {
    Text = "Katzenverlockung"
  },
  Event_59628_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_59628_Desc = {
    Text = "Du triffst hier auf dein endgültiges Ich. Der Kampf um die Zerstörung der Welt ist eigentlich nur ein Blickduell.\nWenn Er dich ansieht, musst du Ihn fest anstarren, bis einer von euch beiden den Blick abwendet"
  },
  Event_59628_Name = {
    Text = "Meine Selbstantwort"
  },
  Event_59629_ChoiceDesc1 = {
    Text = "[Atmen]erhält Silberrelikt „(RelicConfig.Arg1)“, infiziert „(Skill.Arg2)“"
  },
  Event_59629_ChoiceDesc2 = {
    Text = "[Gegenschlag]erhält goldenes Relikt „(RelicConfig.Arg1)“, infiziert „(Skill.Arg2)“, „(Skill.Arg3)“"
  },
  Event_59629_ChoiceDesc3 = {
    Text = "[Kämpfe] erhält +25 das schwarze Siegel"
  },
  Event_59629_Desc = {
    Text = "Ein intensives Geräusch von Schritten ertönt, eine Gruppe von Agenten des Ausschusses blockiert deinen Weg.\n„Bitte kooperiere mit unserer Untersuchung.“\nDie gefühlskalte Stimme birgt Bosheit.\nPlumps, die ruhige Wasseroberfläche wird gestört, sie werfen dich in den tiefen Teich"
  },
  Event_59629_Name = {
    Text = "In die Tiefe sinken"
  },
  Event_59630_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_59630_Desc = {
    Text = "Du strampelst verzweifelt.\nVorwärts, nur ein bisschen weiter.\nEgal was es kostet, du musst alles beschützen.\nDu streckst deine Hand aus, Fäden schneiden in dein Fleisch, du merkst es nicht"
  },
  Event_59630_Name = {
    Text = "Manipulierte Hände"
  },
  Event_59631_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_59631_Desc = {
    Text = "Du schüttelst heftig den Kopf, um die chaotischen Erinnerungen loszuwerden.\nBald verschwinden die lauten Geräusche, und dein Bewusstsein kehrt zurück.\nDu kannst aus der Vergangenheit keinen Nutzen ziehen, nur durch Konzentration auf die Gegenwart findest du Hoffnung"
  },
  Event_59631_Name = {
    Text = "Meine Selbstfrage"
  },
  Event_59632_ChoiceDesc1 = {
    Text = "[Verlassen]Erhalte 50 schwarze Siegel"
  },
  Event_59632_Desc = {
    Text = "Bevor du die Hand ausstreckst, erinnerst du dich, dass du nie eine solche Katze hattest.\nDu und die Katze starren sich durch die Luft an, die Katze blinzelt dir zu.\nDie Katze kümmert sich nicht um deine Kälte, sie liebt dich immer noch"
  },
  Event_59632_Name = {
    Text = "Katzenverlockung"
  },
  Event_59633_ChoiceDesc1 = {
    Text = "[Antwort suchen]erhalte Arg1 das schwarze Siegel, Infektion „(Skill.Arg2)“"
  },
  Event_59633_ChoiceDesc2 = {
    Text = "[Aufgeben]Verlassen"
  },
  Event_59633_Desc = {
    Text = "Jemand weint.\nDu willst deine Liebsten umarmen.\nNicht bei ihnen zu sein, als alles endete, ist dein größtes Bedauern.\nDein Herz schmerzt, du fühlst den Kummer"
  },
  Event_59633_Name = {
    Text = "Meine Selbstfrage"
  },
  Event_59634_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_59634_Desc = {
    Text = "Du ignorierst die spöttischen Stimmen der grauen Gestalten.\nWie kann man die zerfallende Welt retten?\nDu denkst unaufhörlich darüber nach"
  },
  Event_59634_Name = {
    Text = "Lamm zur Schlachtung"
  },
  Event_59635_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_59635_Desc = {
    Text = "Die Luft in den Alveolen verschwindet allmählich, du versuchst unter Wasser zu atmen.\nWie dumm, aber du hast es geschafft.\nDeine Alveolen füllen sich wieder, du kannst frei atmen.\nAber was atmest du da ein?"
  },
  Event_59635_Name = {
    Text = "In die Tiefe sinken"
  },
  Event_59636_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_59636_Desc = {
    Text = "Du sinkst in die zähe Flüssigkeit.\nEgal wie sehr du dich anstrengst, du sinkst immer tiefer.\nDu kannst diesem Sumpf nicht alleine entkommen"
  },
  Event_59636_Name = {
    Text = "In die Tiefe sinken"
  },
  Event_59637_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_59637_Desc = {
    Text = "Du zwingst dich, diese Zweifel zu vergessen.\nDu weißt, dass Zweifel jetzt nutzlos sind, du musst einfach glauben.\nBevor die versiegelte Box geöffnet wird, kannst du die Wahrheit darin nicht wissen.\nManchmal ist es einfacher, als unwissender Narr Frieden zu finden"
  },
  Event_59637_Name = {
    Text = "Die hundert Gesichter des Schattens"
  },
  Event_59638_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_59638_Desc = {
    Text = "Alle Blicke richten sich auf dich, du musst als Anführer für alle auftreten und darfst keine Schwäche zeigen.\n„Geht zur schwarzen Pfütze, alles wird gut.“\nRuhig gibst du den Befehl und versprichst etwas, an das du selbst vermutlich nicht glaubst"
  },
  Event_59638_Name = {
    Text = "Unwissender Blick"
  },
  Event_59639_ChoiceDesc1 = {
    Text = "[Zweifel]infiziere“(Skill.Arg1)“、erhalte das verfluchte Relikt“(RelicConfig.Arg2)“"
  },
  Event_59639_ChoiceDesc2 = {
    Text = "[Verächtlich]Infiziert zweimal mit „(Skill.Arg1)“, erwirbt ein Silberrelikt „(RelicConfig.Arg2)“ und „(RelicConfig.Arg3)“"
  },
  Event_59639_ChoiceDesc3 = {
    Text = "[Ignoriere]erhalte ein Silberrelikt“(RelicConfig.Arg1)“"
  },
  Event_59639_Desc = {
    Text = "Drei unsichere Gestalten sind vor dir, murmeln leise.\nDu näherst dein Ohr, um zu hören, Worte und Atem werden klarer.\n„Vertraue der Katze nicht, sie ist ein Betrüger.“\nDu drehst dich scharf um, aber niemand ist da"
  },
  Event_59639_Name = {
    Text = "Geheimes Flüstern"
  },
  Event_59640_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_59640_Desc = {
    Text = "Die Sterne sehen so köstlich aus, dass du ihre Kraft begehrst und sie verschlingst.\nGulp.\nDu fühlst dich geistig erfrischt, ein Licht blitzt in deinem Augenwinkel.\nDu schaust hinunter und siehst, dass die Sterne in deinem Magen leuchten"
  },
  Event_59640_Name = {
    Text = "Wunschstern"
  },
  Event_59641_ChoiceDesc1 = {
    Text = "[Vorwärts kämpfen]entferne 1 Befehlskarte, erhalte Arg1 schwarzes Siegel"
  },
  Event_59641_ChoiceDesc2 = {
    Text = "[Faden durchtrennen]1 Befehlskarte kopieren, Infektion“(Skill.Arg1)“"
  },
  Event_59641_ChoiceDesc3 = {
    Text = "[halte inne]Wählen Sie 1 Karte aus 3 Befehlskarten und erhalten Sie das Gebet:“(EnchantConfig.Arg1)“"
  },
  Event_59641_Desc = {
    Text = "Den ganzen Weg wirst du vorwärts gedrängt, alle deine Entscheidungen werden von unsichtbaren Fäden kontrolliert. \n Du kämpfst darum, deine Hände zu bewegen, um alles, was dir wichtig ist, zu greifen. \n Das Schicksal der Welt hängt an deinen Fingerspitzen. \n Unzählige Fäden winden sich um dich und fesseln deinen ganzen Körper."
  },
  Event_59641_Name = {
    Text = "Manipulierte Hände"
  },
  Event_59642_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_59642_Desc = {
    Text = "Du wischst die blutigen Tränen aus deinen Augen, aber unzählige neue strömen nach. \nRot überflutet dein Sichtfeld, als ob es ein blutiges Opfer ankündigt. \nDu wischst weiter, zitterst vor Schmerz, aber ohne Angst"
  },
  Event_59642_Name = {
    Text = "Meine Fusion"
  },
  Event_59643_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_59643_Desc = {
    Text = "Du streichelst diesen magischen Edelstein und setzt ihn in den Silberschlüssel ein.\nDas Licht der Sterne erhellt dich.\nDu bist benommen."
  },
  Event_59643_Name = {
    Text = "Wunschstern"
  },
  Event_59644_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_59644_Desc = {
    Text = "Du ignorierst alles, hältst die Augen offen, und dein innerer Wille wird zu einem starrköpfigen Schrei.\nSelbst wenn du zerbrichst, wirst du keinen Schritt zurückweichen"
  },
  Event_59644_Name = {
    Text = "Meine Fusion"
  },
  Event_59645_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_59645_Desc = {
    Text = "Jemand schweigt.\nDu siehst das verzweifelte Gesicht und weißt, sie haben es nicht geschafft.\nDu bist derjenige, der am weitesten gekommen ist, nur deine Antwort zählt"
  },
  Event_59645_Name = {
    Text = "Meine Selbstfrage"
  },
  Event_59646_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_59646_Desc = {
    Text = "Du streckst die Hand aus und greifst unaufhörlich nach unzähligen Sternschnuppen, während der schimmernde Kristall über deine Fingerspitzen gleitet. \n Freude, Traurigkeit, Wut, Angst... \n Gierig ergreifst du jeden Hauch von Emotion, nur um zuzusehen, wie sie aus deiner Hand entglitten. \n Strahlendes Licht erhellt dein Gesicht, und deine Augen werden allmählich schwarz und tief."
  },
  Event_59646_Name = {
    Text = "Emotionskristall"
  },
  Event_59657_ChoiceDesc1 = {
    Text = "[Rufen]erhält Silberrelikt „(RelicConfig.Arg1)“"
  },
  Event_59657_ChoiceDesc2 = {
    Text = "[Berühre]Erhalte das goldene Relikt“(RelicConfig.Arg1)“，infiziere“(Skill.Arg2)“"
  },
  Event_59657_Desc = {
    Text = "Du siehst, wie die Puppe zusammenbricht.\nSie war die rationalste und treueste Assistentin, die alle Informationen sorgfältig aufbewahrte.\nJetzt scheint sie sich an nichts mehr zu erinnern.\nDu siehst Tränen in ihren Augen"
  },
  Event_59657_Name = {
    Text = "Puppentränen"
  },
  Event_59658_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_59658_Desc = {
    Text = "Du gibst nicht auf und versuchst, ihren Energie-Kern zu erreichen.\nSolange es mechanisch ist, wird es bestimmt wieder starten.\nLeider hat die gefühlskalte Puppe dir keine naive Chance gegeben.\nDeine Nachsicht brachte dir kein Erbarmen von der Puppe ein, du musstest mit voller Kraft kämpfen"
  },
  Event_59658_Name = {
    Text = "Puppentränen"
  },
  Event_59659_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_59659_Desc = {
    Text = "Du willst deine ehemaligen Kameraden nicht zerstören.\nDu rufst verzweifelt ihren Namen und gibst alle Befehle, aber es nützt nichts.\nDie Puppe hat euch verraten und ist zu kaltem, leblosen Material zurückgekehrt"
  },
  Event_59659_Name = {
    Text = "Puppentränen"
  },
  Event_60944_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_60944_Desc = {
    Text = "Dir bleibt nicht viel Zeit, du hast den direktesten Weg gewählt und die Blockade durchbrochen. Die Erwachten sind motiviert und aufgeregt.\nDie wachsameren Feinde sind kein Problem"
  },
  Event_60944_Name = {
    Text = "Agent der Prüfungskommission"
  },
  Event_60945_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_60945_Desc = {
    Text = "Bevor der Agent reagieren konnte, seid ihr hinter ihn gekommen und habt ihm die Waffe abgenommen. Bevor die Verstärkung eintraf, seid ihr erfolgreich entkommen.\nLeider hat sich die Nachricht verbreitet, und die nächsten Feinde werden besser vorbereitet sein. Seid bereit"
  },
  Event_60945_Name = {
    Text = "Agent der Prüfungskommission"
  },
  Event_60946_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_60946_Desc = {
    Text = "Der Agent wird von einem Pfiff angezogen und nähert sich eurem Versteck. Im richtigen Moment greifen die Erwachten an.\nEin perfekter Hinterhalt, die Gefahr ist gebannt"
  },
  Event_60946_Name = {
    Text = "Agent der Prüfungskommission"
  },
  Event_60947_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_60947_Desc = {
    Text = "Angesichts der vielen Feinde kannst du ihnen nicht standhalten. Du trittst absichtlich in ihr Sichtfeld und leistest keinen Widerstand.\nDu weißt, dass ihr bald in Gewahrsam genommen werdet, was Teil des Plans ist.\nVon dort werdet ihr fliehen und einen neuen Weg suchen"
  },
  Event_60947_Name = {
    Text = "Überwachungspunkt"
  },
  Event_60948_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_60948_Desc = {
    Text = "Angesichts der vielen Feinde kannst du ihnen nicht standhalten. Nach einem kurzen Kampf gebt ihr den Widerstand auf.\nDu weißt, dass ihr bald in Gewahrsam genommen werdet, was Teil des Plans ist.\nVon dort werdet ihr fliehen und einen neuen Weg suchen"
  },
  Event_60948_Name = {
    Text = "Überwachungspunkt"
  },
  Event_60949_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_60949_Desc = {
    Text = "Angesichts der vielen Feinde kannst du ihnen nicht standhalten.\nDu entscheidest dich, vorübergehend zu gehen und einen neuen Weg zu suchen"
  },
  Event_60949_Name = {
    Text = "Überwachungspunkt"
  },
  Event_61058_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_61058_Desc = {
    Text = "Du betrachtest deine Hände, deinen ganzen Körper, voller Hoffnung und Entschlossenheit.\nWenn das alles Schicksal ist, bist du bereit, allem zu begegnen.\nSollten im letzten Moment wirklich Tore zum Himmel oder zur Hölle stehen, wirst du sie für die Welt öffnen"
  },
  Event_61058_Name = {Text = "spähen"},
  Event_61059_ChoiceDesc1 = {
    Text = "[Bereit für den Kampf] wählt 1 aus 3 Befehlskarten und erhält Orison: „(EnchantConfig.Arg1)“"
  },
  Event_61059_ChoiceDesc2 = {
    Text = "[Weiter beobachten]Infektion“(Skill.Arg1)“, erneutes Gebet, höchstens 1 Mal"
  },
  Event_61059_Desc = {
    Text = "Du eilst nicht in den Kampf, versuchst ruhig die Situation zu klären. Der plötzlich auftauchende Dirigent ist weder Freund noch Feind, du weißt nicht, was er vorhat. Du entscheidest dich, dich vorzubereiten und seine Herausforderung anzunehmen, um dann zu beobachten, was er will"
  },
  Event_61059_Name = {
    Text = "Teufelsdirigent"
  },
  Event_61060_ChoiceDesc1 = {
    Text = "[Lauscher]Erhalte 3 wähle 1 Fortgeschrittenes Gebet"
  },
  Event_61060_ChoiceDesc2 = {
    Text = "[Rufen]erhält goldenes Relikt „(RelicConfig.Arg1)“, infiziert „(Skill.Arg2)“"
  },
  Event_61060_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte 50 schwarze Siegel"
  },
  Event_61060_Desc = {
    Text = "Seit dem Unfall hast du keine Nachrichten mehr von deinem Partner erhalten. \n Unzählige Kontaktversuche wurden gestartet, doch sie verhallten wie ein Stein, der ins Meer geworfen wird. \n In dem Moment, als du schon die Hoffnung aufgegeben hattest, ertönte plötzlich ein Geräusch aus dem Kommunikationsgerät. \n Du öffnest den Koffer und hältst den Telefonhörer ans Ohr. \n „Hüter des Geheimnisses...“ \n In einem Dämmerzustand hörst du die Stimme, die du so sehr vermisst hast, wie ein ferner Widerhall, der durch Schichten von Leere dringt."
  },
  Event_61060_Name = {
    Text = "Sehnsuchtsvolle Echos"
  },
  Event_61061_ChoiceDesc1 = {
    Text = "[Dunkelheit akzeptieren]erhalte Silberrelikt „(RelicConfig.Arg1)“, infektiere „(Skill.Arg2)“"
  },
  Event_61061_ChoiceDesc2 = {
    Text = "[Versuchen zu schwimmen]erhalte das silberne Relikt „(RelicConfig.Arg1)“, Infektion „(Skill.Arg2)“"
  },
  Event_61061_ChoiceDesc3 = {
    Text = "[Rufen des Geistes]erhält 25 das schwarze Siegel"
  },
  Event_61061_Desc = {
    Text = "Du rennst nach vorne, und der Boden verwandelt sich plötzlich in ein unpassierbares Meer.\nDu sinkst in den Boden.\nWie Geister auf einem Friedhof tauchen unzählige klebrige Schatten auf und dringen gierig in deinen Mund und deine Nase ein"
  },
  Event_61061_Name = {
    Text = "in den Boden eindringen"
  },
  Event_61062_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_61062_Desc = {
    Text = "Du weitest die Augen und versuchst, alle Hinweise zu finden. \n Hundert Augen drehen sich gleichzeitig, du siehst die Pfoten des menschenähnlichen Hundes vor dir rennen, du siehst die Spur des Dirigentenstabes von Hameln hinter dir schwingen. \n Du beobachtest gierig alles. \n Plötzlich siehst du, wie eine vertraute Augenlinse zu Boden rollt. \n Es scheint dein eigenes Auge zu sein."
  },
  Event_61062_Name = {
    Text = "Wissensgier"
  },
  Event_61063_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_61063_Desc = {
    Text = "Nein, du kannst nicht so viele Dinge sehen.\nDu hast nur... nur ein paar Augen, oder?\nDu schließt schnell deine Augen und tastest dein Gesicht ab.\nEins, zwei...\nAls du wieder öffnest, wird deine Sicht wieder eng und unwissend.\nDu hast nur zwei Augen, schade, schade."
  },
  Event_61063_Name = {
    Text = "Wissensgier"
  },
  Event_61064_ChoiceDesc1 = {
    Text = "[Suchen]erhalte verfluchtes Relikt „(RelicConfig.Arg1)“, infektiere „(Skill.Arg2)“"
  },
  Event_61064_ChoiceDesc2 = {
    Text = "[Augen schließen] Eine zufällige Befehlskarte erhält das Gebet: [(EnchantConfig.Arg1)]"
  },
  Event_61064_Desc = {
    Text = "Immer mehr Fäden sind chaotisch zu einem Knäuel verwoben, du bist besorgt, verwirrt und wütend, du hasst es, dass du nichts weißt. \n Der enorme Druck lässt deinen Geist wie einen dünnen Faden gespannt sein. \n Mit einem Knall fühlst du, wie sich deine Kopfhaut plötzlich entspannt, und du kannst plötzlich die gesamte Umgebung sehen, die schattenhaften Gestalten, die im Nichts schwanken. \n Mehr, du musst mehr sehen..."
  },
  Event_61064_Name = {
    Text = "Wissensgier"
  },
  Event_61065_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_61065_Desc = {
    Text = "Du schwimmst im Boden und stellst dir vor, du seist der geschmeidigste Fisch. \n Wenn du ein Fisch werden willst, musst du deine menschlichen Beine aufgeben. \n Das ist der Preis des Handels. \n Bald fühlst du eine nie dagewesene Leichtigkeit, du bist das freieste Wesen im Erdreich. \n Du schwimmst zurück an die Oberfläche, hast jedoch vergessen, wie man läuft."
  },
  Event_61065_Name = {
    Text = "in den Boden eindringen"
  },
  Event_61066_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_61066_Desc = {
    Text = "Der vertraute Kontakt des Silberschlüssels berührt deine Fingerspitzen, das ist der Kern aller Lichter. \n Dies ist die Essenz deines Lebens, die Inkarnation deines Schicksals. \n Vergangene Erfahrungen blitzen vor deinen Augen auf. \n Deine Entscheidungen sind fest mit den Entscheidungen dieser Welt verbunden. \n Dein Schicksal ist eng mit vielen Menschen verbunden."
  },
  Event_61066_Name = {Text = "spähen"},
  Event_61067_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_61067_Desc = {
    Text = "Du fühlst dich von vielen vertrauten Wesen umgeben.\nDu rufst nach den Geistern, die vielleicht gar nicht existieren.\nEin Wunder geschieht, du kehrst zurück an die Oberfläche.\nUnzählige Grabsteine bleiben stumm"
  },
  Event_61067_Name = {
    Text = "in den Boden eindringen"
  },
  Event_61068_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_61068_Desc = {
    Text = "Du hast keine Zeit für Gefühle, du willst nur alles retten.\nWenn du ein Stern wirst, dann lass dich als Sternschnuppe fallen.\nSolange du den Nachthimmel erleuchtest, ist es egal, ob du verglühst"
  },
  Event_61068_Name = {Text = "spähen"},
  Event_61069_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_61069_Desc = {
    Text = "Du drückst deine Ohren fester zusammen und nimmst alle zerbrochenen Geräusche in deinen Kopf auf. \n„Ich...“ \n„Du musst...“ \nDu kannst nur bruchstückhafte Sätze hören, kannst keine Bedeutung erkennen. \nAber du wagst es nicht, etwas zu sagen, aus Angst, kein Wort zu verpassen. \nDoch das Schicksal hat dir nicht mehr Mitleid geschenkt. \nSogar das letzte bisschen Klang verschwand so, und die Umgebung kehrte zur Stille zurück."
  },
  Event_61069_Name = {
    Text = "Sehnsuchtsvolle Echos"
  },
  Event_61070_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_61070_Desc = {
    Text = "Du denkst nicht weiter nach, befiehlst den Erwachten, sich aufzustellen, um seine Herausforderung anzunehmen"
  },
  Event_61070_Name = {
    Text = "Teufelsdirigent"
  },
  Event_61071_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_61071_Desc = {
    Text = "Du rufst ständig ihren Namen und versuchst, auch nur ein Fünkchen Gefühl zu vermitteln. \n Du weißt nicht, ob sie es gehört hat, während du versuchst, die gedämpfte Stimme im Mikrofon zu erkennen. \n Es scheint ihre Antwort zu sein, oder vielleicht sind es unzählige Fragmente der Vergangenheit, die sich wiederholen. \n Sie spielen die Trauer und Freude sowie die Begegnungen ab, die ihr gemeinsam erlebt habt."
  },
  Event_61071_Name = {
    Text = "Sehnsuchtsvolle Echos"
  },
  Event_61072_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_61072_Desc = {
    Text = "Vielleicht ist diese Dunkelheit die wahre Welt, was ist daran schlecht, sie zu betreten? \n Du hast die Dunkelheit vollständig akzeptiert, und die Dunkelheit weist dich ebenfalls nicht mehr zurück, du kannst frei atmen. \n Im nächsten Moment bist du wieder an der Oberfläche, vielleicht ist etwas für immer im Untergrund geblieben, aber das spielt keine Rolle mehr."
  },
  Event_61072_Name = {
    Text = "in den Boden eindringen"
  },
  Event_61073_ChoiceDesc1 = {
    Text = "[Starren auf das Licht]Wähle 1 von 3 Befehlskarten und erhalte ein Gebet: „(EnchantConfig.Arg1)“, infiziere „(Skill.Arg2)“"
  },
  Event_61073_ChoiceDesc2 = {
    Text = "[Berühre die Brust]Wähle 1 Erwecker, um ihn aufzuwachen，infiziere“(Skill.Arg1)“"
  },
  Event_61073_ChoiceDesc3 = {
    Text = "[Weiter rennen]Erhalte 25 schwarze Siegel"
  },
  Event_61073_Desc = {
    Text = "Du bist verwirrt und kannst nur verzweifelt laufen, ohne viel nachzudenken.\nPlötzlich fühlst du eine Leere in deiner Brust.\nAls du nach unten siehst, erscheint an der Stelle deines Herzens ein schimmerndes Licht in Form eines Schlüssels.\nDieses Licht wird immer heller und breitet sich allmählich über deinen ganzen Körper aus.\nDu siehst dich selbst zu einem Stern werden.\nPlötzlich wird dir klar, vielleicht ist das deine Bestimmung, die du schon immer hattest."
  },
  Event_61073_Name = {Text = "spähen"},
  Event_61074_ChoiceDesc1 = {
    Text = "[Bereit für den Kampf] wählt 1 aus 3 Befehlskarten und erhält Orison: „(EnchantConfig.Arg1)“"
  },
  Event_61074_ChoiceDesc2 = {
    Text = "[Genau beobachten]Infiziere „(Skill.Arg1)“, erneuere das Orison, bis zu 2 Mal"
  },
  Event_61074_Desc = {
    Text = "“Hey... warte! Was ist hier los...“\n“Übung.“\n Der Mann schaut dich ausdruckslos an. \n“Die Verbindung der Erwecker durch Musik aufrechtzuerhalten, ist ein neuer Versuch. Nur wenn das Niveau des Orchesters sichergestellt ist, kann die Aufführung perfekt sein.“\n Sein erhobener Taktstock schwingt klar nach unten und beschreibt in der Luft ein elegantes Auftaktzeichen. \n“Spiele, Schutzherr. Lass mich sehen, was du kannst.“"
  },
  Event_61074_Name = {
    Text = "Teufelsdirigent"
  },
  Event_61075_ChoiceDesc1 = {
    Text = "[Bereit für den Kampf] wählt 1 aus 3 Befehlskarten und erhält Orison: „(EnchantConfig.Arg1)“"
  },
  Event_61075_Desc = {
    Text = "Unabhängig von seinen Zielen hat er dich wenigstens aus dem Übergriff des Ausschusses gerettet. Wenn er dir schaden wollte, hätte er dich nicht helfen müssen. Du beruhigst dich und machst dich bereit für das Letzte"
  },
  Event_61075_Name = {
    Text = "Teufelsdirigent"
  },
  Event_65400_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_65400_Desc = {
    Text = "Der Kontakt übermittelte das Versprechen externer Rettung. Als die Rettungsteams versuchten, in die Berge zu gelangen, keimte neue Hoffnung auf"
  },
  Event_65400_Name = {
    Text = "Kontaktstelle"
  },
  Event_65401_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_65401_Desc = {
    Text = "Keiner der Mitglieder des Forschungsteams hat den Schneeberg überlebt. Angesichts der Katastrophe wählst du immer nur dich selbst. Das Leben gewöhnlicher Menschen ist dir nichts wert, du hast deine Menschlichkeit aufgegeben und bist sicher ans Ziel gekommen.\nDie Retter schauen dich mit gemischten Gefühlen an, du bleibst ungerührt und gehst in den Schneesturm zurück. Vielleicht werden in der Mitternacht, wenn du träumst, die Seelen derjenigen, die wegen deiner Gleichgültigkeit gestorben sind, um dein Bett herumstehen und dich schweigend anstarren."
  },
  Event_65401_Name = {
    Text = "Sicherer Extraktionspunkt"
  },
  Event_65402_ChoiceDesc1 = {
    Text = "[Evakuierung]Entferne Schöpfung „Expeditionsteam“, erhalte je nach Teamgröße verschiedene „Rettungsmedaillen“"
  },
  Event_65402_Desc = {
    Text = "Du hast das Forscherteam sicher zum Evakuierungspunkt gebracht, das Rettungsteam übernimmt alles, die Geretteten sinken erschöpft zu Boden.\nDu weißt jedoch, dass die eigentliche Gefahr noch lange nicht vorbei ist, das riesige Biest lauert weiter in den Bergen, hungrig und wartend"
  },
  Event_65402_Name = {
    Text = "Sicherer Extraktionspunkt"
  },
  Event_65403_ChoiceDesc1 = {
    Text = "[Versorgungsumtausch]Erhalte 25 schwarze Siegel, und für jeden Mitglied der Expedition zusätzlich 1 schwarzes Siegel（Arg1）"
  },
  Event_65403_ChoiceDesc2 = {
    Text = "[Verpflichtung retten]wähle 1 Gebet. Ergänze 2 Mitglieder des Forschungsteams"
  },
  Event_65403_ChoiceDesc3 = {
    Text = "[Effizienz zuerst]10 Forscher verlieren, wähle eine Gold+ Schöpfung"
  },
  Event_65403_Desc = {
    Text = "Ihr kämpft euch durch den Schneesturm, folgt dem flackernden Licht der Notfallstation.\n    ○ Endlich, nach unzähligen Gebeten, seht ihr das hoffnungsvolle Häuschen"
  },
  Event_65403_Name = {
    Text = "Kontaktstelle"
  },
  Event_65403_Tips3 = {
    Text = "Zu wenige Mitglieder im Forschungsteam"
  },
  Event_65404_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_65404_Desc = {
    Text = "Ihr habt vom Kontaktmann das Passwort für das Lager des Kontaktbüros erfahren und dort alle Vorräte für zwei Tage gefunden, gratuliert euch, dass ihr zumindest nicht im Schneeberg verhungern werdet"
  },
  Event_65404_Name = {
    Text = "Kontaktstelle"
  },
  Event_65415_ChoiceDesc1 = {
    Text = "[Bestätigen]"
  },
  Event_65415_Desc = {
    Text = "Der Schneeberg hat in einem Moment seine Mahlzeit beendet, zwei Personen sind für immer in den tiefen, unergründlichen Eisspalten verschwunden, während ihr davon nichts wisst."
  },
  Event_65415_Name = {Text = "Illusion"},
  Event_65416_ChoiceDesc1 = {
    Text = "[Verlassen]Suche Scheinwerfer"
  },
  Event_65416_ChoiceDesc2 = {
    Text = "[In den Schnee eindringen]Verliere 2 Expeditionsteilnehmer"
  },
  Event_65416_Desc = {
    Text = "Plötzlich erhob sich ein Sturm auf dem Schneeberg, das Heulen des Windes in deinen Ohren klang wie der Aufschrei eines Ungeheuers, der weiße, neblige Schnee blendete euch für einen Moment, als ob etwas in dem endlosen weißen Nebel umherging. \n Ihr seid gezwungen, stehen zu bleiben und versucht, eure Beine tief im Schnee zu verankern, um zu verhindern, dass ihr den Hang hinunterrollt."
  },
  Event_65416_Name = {Text = "unbekannt"},
  Event_65417_ChoiceDesc1 = {
    Text = "[Lautlos verdampfen]2 Forscher verlieren"
  },
  Event_65417_ChoiceDesc2 = {
    Text = "[Verlassen]"
  },
  Event_65417_Desc = {
    Text = "Aus dem Bauch des Schneebergs ertönt ein dröhnendes Gebrüll, wie das unzufriedene Brüllen eines hungrigen Biestes, die Erde bebt, und die unter dem Schnee verborgene Eisdecke reißt leise auf, als hätte der Schneeberg seinen Mund geöffnet. \n Als das Beben der Erde schließlich aufhört und die Menschen verwirrt umherblicken, drehst du dich um, um die Gruppe zu überprüfen."
  },
  Event_65417_Name = {Text = "Illusion"},
  Event_65468_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_65468_Desc = {
    Text = "Um die Handlungsfähigkeit der Gruppe zu gewährleisten, hast du die schwerfälligen Personen zurückgelassen und sie in diesem isolierten Häuschen zurückgelassen. Das könnte die Überlebensrate der verbleibenden Personen erhöhen, aber siehst du nicht die unzufriedenen und grollenden Blicke? Hat das dein Inneres überhaupt nicht berührt?"
  },
  Event_65468_Name = {
    Text = "Kontaktstelle"
  },
  Event_65483_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_65483_Desc = {
    Text = "Du rettest einige Menschen, aber viele bleiben für immer im Schneeberg, egal was, du hast immerhin dein Bestes gegeben.\nDie Retter geben an, dass dein Beitrag gewürdigt werden wird, du winkst und gehst in den Sturm zurück"
  },
  Event_65483_Name = {
    Text = "Sicherer Extraktionspunkt"
  },
  Event_65484_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_65484_Desc = {
    Text = "Du hast keine Zeit für anderes, um aus dem Schneeberg zu entkommen, wählst du die effizienteste Methode; in den Augen der letzten Überlebenden bist du möglicherweise ein Dämon.\nDie Retter geben an, dass dein Beitrag gewürdigt werden wird, du winkst und gehst in den Sturm zurück"
  },
  Event_65484_Name = {
    Text = "Sicherer Extraktionspunkt"
  },
  Event_65485_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_65485_Desc = {
    Text = "Unter deinem unermüdlichen Schutz blieb das gesamte Forschungsteam unversehrt. Dich zu treffen, war ihr größtes Glück inmitten des Unglücks; du bist ihr wahrhaftiger Retter. \n Du hast ein Wunder in der Katastrophe geschaffen, die Legenden über den Helden des Schneebergs werden vielleicht bald weit verbreitet sein. Die Rettungskräfte betonen, dass dein herausragender Beitrag bald gewürdigt wird, du lächelst, winkst und gehst in den Schneesturm zurück."
  },
  Event_65485_Name = {
    Text = "Sicherer Extraktionspunkt"
  },
  Event_65486_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_65486_Desc = {
    Text = "Du kümmerst dich wirklich um das Leben der Menschen, die meisten wurden von dir gerettet. Sie weinen vor Dankbarkeit.\nRettungskräfte loben deine herausragende Leistung, du winkst lächelnd und gehst in den Schneesturm"
  },
  Event_65486_Name = {
    Text = "Sicherer Extraktionspunkt"
  },
  Event_65487_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_65487_Desc = {
    Text = "Du hast gegen das unbeständige Unglück gekämpft und Menschen dem Tod entrissen. Dank deiner Bemühungen hat sich das tragische Ende leicht verschoben.\nDie Rettungskräfte betonen deine wertvollen Beiträge, die bald gewürdigt werden. Du lächelst, winkst und gehst in den Schneesturm zurück"
  },
  Event_65487_Name = {
    Text = "Sicherer Extraktionspunkt"
  },
  Event_6817_ChoiceDesc1 = {
    Text = "[Genug ist genug]Erhalte 3 aus 1 Gebet"
  },
  Event_6817_ChoiceDesc2 = {
    Text = "[Weiterlesen] Eine zufällige Befehlskarte erhält das Gebet: „(EnchantConfig.Arg1)\", infiziert „(Skill.Arg2)\""
  },
  Event_6817_Desc = {
    Text = "Ganz oben im Holzregal steht ein Buch mit einem goldgelben Einband. Aus der Perspektive des Bodens ist der Titel des Buches nicht zu sehen. \n Irgendwie verspürst du das Verlangen, es zu lesen... Dieses Verlangen wächst in einem Augenblick zu einer unkontrollierbaren Kraft, und ohne Rücksicht auf die Möglichkeit, andere zu stören, steigst du die Holzleiter neben dem Regal hinauf, nimmst das Buch herunter und beginnst ungeduldig zu lesen... \n Vage Eindrücke steigen in deinem Gedankenmeer auf, und du versinkst im Ozean der Illusion..."
  },
  Event_6817_Name = {
    Text = "gelbe Schriftrolle"
  },
  Event_6818_ChoiceDesc1 = {
    Text = "[Zuhören] Wähle 1 von 3 Befehlskarten aus, um ein Gebet zu erhalten: „(EnchantConfig.Arg1)\", infiziere „(Skill.Arg2)\""
  },
  Event_6818_ChoiceDesc2 = {
    Text = "[Ensemble]für jede aufwachte Energie mit 50 oder mehr erhält 15 das schwarze Siegel"
  },
  Event_6818_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte eine Auswahl von 3 für 1 Gebet"
  },
  Event_6818_Desc = {
    Text = "Die Musik erreicht plötzlich deine Ohren. Grüne Finger tanzen über die Tasten, elegante Klänge fließen wie ein Bach.\n„Lieber Freund, möchtest du mit mir spielen?“\nDie Hand spricht nicht, sie fragt dich durch die Musik"
  },
  Event_6818_Name = {
    Text = "Geister an der Laute"
  },
  Event_6819_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6819_Desc = {
    Text = "Ramona wandte sich der Quelle des Geräuschs zu, aber sie sah nur einen allmählich verschwommenden Phantasma, der wie ein Grammophon wirkte, das in die Wand verschmolzen war"
  },
  Event_6819_Name = {
    Text = "Fremde Ohren"
  },
  Event_6820_ChoiceDesc1 = {
    Text = "[Reinige die Schreibmaschine]Lösche 1 Befehlskarte und erhalte 25 schwarze Siegel"
  },
  Event_6820_ChoiceDesc2 = {
    Text = "[Versuche zu lesen]Kopiere 1 Karte aus dem Deck, infiziere “(Skill.Arg1)“"
  },
  Event_6820_Desc = {
    Text = "Die Schreibmaschine im Koffer spuckte plötzlich dicke Tinte aus, die durch das Rütteln des Zuges in lineare Ströme spritzte"
  },
  Event_6820_Name = {
    Text = "Das Flüstern der Schreibmaschine"
  },
  Event_6821_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6821_Desc = {
    Text = "In dem Augenblick, als die Faust das Phantasma zerschlug, stürmten Erinnerungen in dein Gehirn und schlugen heftig auf deine Seele ein, wodurch drückende Schmerzen entstanden"
  },
  Event_6821_Name = {
    Text = "Fata Morgana"
  },
  Event_6822_ChoiceDesc1 = {
    Text = "[Briefpapier wegwerfen]1 Karte löschen"
  },
  Event_6822_ChoiceDesc2 = {
    Text = "[Sicher aufbewahren]Erhalte “(RelicConfig.Arg1)“，infiziere “(Skill.Arg2)“"
  },
  Event_6822_Desc = {
    Text = "Ziehe einige Blätter aus der Schreibmaschine, der Tintenfleck verströmt einen starken Geruch. Du überfliegst den Inhalt und runzelst unwillkürlich die Stirn.\nDer Großteil des Briefes ist unleserlich, und das, was übrig bleibt, ist kaum lesbar"
  },
  Event_6822_Name = {
    Text = "gekritzelter Brief"
  },
  Event_6823_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6823_Desc = {
    Text = "Du versuchst, die verschwommenen Schriftzeichen auf dem Papier zu erkennen. Sie verzerren sich ständig und zeigen dann einen völlig anderen Inhalt. \n“@2 Ich denke, du solltest die Nachricht in der Zeitung gesehen haben. \n Ja, dein Vater hat dich aus der Erbfolge gestrichen... wir möchten auch nicht @2 \n der Teufel, der Teufel... \n Bitte höre sofort auf, den Herrn Herbert zu treffen, sonst werde ich deine finanzielle Unterstützung einstellen...“"
  },
  Event_6823_Name = {
    Text = "Wie im Brief gelesen"
  },
  Event_6824_ChoiceDesc1 = {
    Text = "[Silberschlüssel halten]wähle 1 von 3 Befehlskarten und erhalte Gebet: „(EnchantConfig.Arg1)“, infektiere „(Skill.Arg2)“"
  },
  Event_6824_ChoiceDesc2 = {
    Text = "[Schließe die Augen]Wähle 1 Erwecker und infiziere „(Skill.Arg1)“"
  },
  Event_6824_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte 25 schwarze Siegel"
  },
  Event_6824_Desc = {
    Text = "Du wirst von einem riesigen Absurdität zerrissen, deine Glieder kriechen verzerrt über den Boden, als würdest du von @2 aus einer Dimension jenseits der deinen manipuliert. \n“Nein... nein...“\n Dein Verstand bricht Stück für Stück zusammen, verwirrte, grinsende Lachen und Schreie verweben sich, wie ein riesiges Netz, das dein Bewusstsein fesselt, und auf deinen Lippen schwappt nur ein unverständliches Jammern."
  },
  Event_6824_Name = {
    Text = "Blick des Auges"
  },
  Event_6825_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6825_Desc = {
    Text = "Überlass es dem Hüter des Geheimnisses, wer weiß, welches Wesen erweckt wird"
  },
  Event_6825_Name = {
    Text = "Einsamer Silberkern"
  },
  Event_6826_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6826_Desc = {
    Text = "Eine traurige Melodie fließt in dein Ohr, Kummer und Schmerz erfüllen deinen Geist und deine Seele. Als du es bemerkst, sind die Augen eines Menschen bereits feucht"
  },
  Event_6826_Name = {
    Text = "Unbekannter Ton"
  },
  Event_6827_ChoiceDesc1 = {
    Text = "[Linke Tür aufstoßen]erhalte Silberrelikt „(RelicConfig.Arg1)“"
  },
  Event_6827_ChoiceDesc2 = {
    Text = "[Rechte Tür aufstoßen]erhalte goldenes Relikt „(RelicConfig.Arg1)“, infektiere „(Skill.Arg2)“"
  },
  Event_6827_Desc = {
    Text = "Tür. Tür. Unzählige Türen. \n Die Anzahl der Türen scheint deutlich größer zu sein als während eurer Patrouille mit Ramona. \n Ihr haltet im Flur an und bereitet euch darauf vor, die nächste Tür zu öffnen. \n Hinter der linken Tür herrscht stille, sie wartet zurückhaltend auf euren Besuch. \n Hinter der rechten Tür sind undeutliche Gespräche zu hören."
  },
  Event_6827_Name = {
    Text = "unendliches Tor"
  },
  Event_6828_ChoiceDesc1 = {
    Text = "[Lauscher] erhält Silberrelikt „(RelicConfig.Arg1)“, Infektion „(Skill.Arg2)“"
  },
  Event_6828_ChoiceDesc2 = {
    Text = "[Ohren zuhalten]erhalte 3 Auswahlen für das Gotteszeichen"
  },
  Event_6828_Desc = {
    Text = "Du kannst nur das chaotische Klopfen der Tasten hören, das wie ein Sturm über dich hereinbricht, wie der Einschlag eines Meteoriten auf den Boden, wodurch das gesamte Klavier erbebt. \n Die hämmernden Klöppel quietschen und die hüpfenden Pedale geben einen schmerzlichen Schrei von sich. \n In der täuschenden Musik wird die vertraute Melodie mitgerissen und streift über dein Trommelfell."
  },
  Event_6828_Name = {
    Text = "Verbotene Klangfarbe"
  },
  Event_6829_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6829_Desc = {
    Text = "“Ermittler William hat Ihnen eine Notversorgung bereitgestellt. Bitte klopfen Sie dreimal auf die Brosche zur Bestätigung nach Erhalt.“"
  },
  Event_6829_Name = {
    Text = "Unterstützungskommunikation"
  },
  Event_6830_ChoiceDesc1 = {
    Text = "[Linke Tür aufstoßen]erhalte 3 wähle 1 Gebet"
  },
  Event_6830_ChoiceDesc2 = {
    Text = "[Linke Tür aufstoßen]wähle 1 von 3 Befehlskarten und erhalte Gebet: „(EnchantConfig.Arg1)“, infektiere „(Skill.Arg2)“"
  },
  Event_6830_Desc = {
    Text = "Tür. Tür. Unzählige Türen. \n Die Anzahl der Türen scheint deutlich größer zu sein als während deiner und Ramonas Inspektion. \n Ihr bleibt im Flur stehen und bereitet euch darauf vor, die nächste Tür zu öffnen. \n Hinter der linken Tür herrscht stille, sie wartet schüchtern und zurückhaltend auf euren Besuch. \n Hinter der rechten Tür ist ein undeutliches Gespräch zu hören."
  },
  Event_6830_Name = {
    Text = "Endlose Türen"
  },
  Event_6831_ChoiceDesc1 = {
    Text = "[Lesen des Briefes]Entferne eine Befehlskarte, erhalte Arg1 das schwarze Siegel"
  },
  Event_6831_ChoiceDesc2 = {
    Text = "[Schließe die Kiste]"
  },
  Event_6831_Desc = {
    Text = "Der Koffer zitterte unaufhörlich, als ob ein Leben darin das Ei zerriss und kurz vor dem Schlüpfen stand.\nDu öffnest den Koffer unkontrolliert, und die Briefe fliegen wie Schmetterlinge heraus"
  },
  Event_6831_Name = {
    Text = "Ungebetener Brief"
  },
  Event_6832_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6832_Desc = {
    Text = "Das schrille Klingeln machte dich nervös, du nahmst den Hörer und legtest ihn auf den Tisch. Das Klingeln verstummte abrupt, nur ein Echo blieb in deinem Kopf"
  },
  Event_6832_Name = {
    Text = "Zug anrufen"
  },
  Event_6833_ChoiceDesc1 = {
    Text = "[Heb das Foto auf] wähle 1 von 3 Befehlskarten, um Gebet zu erhalten: „(EnchantConfig.Arg1)“"
  },
  Event_6833_ChoiceDesc2 = {
    Text = "[Überprüfe den Film]Infiziere „(Skill.Arg1)“, tausche das erhaltene Gebet aus Option 1, kann zweimal verwendet werden"
  },
  Event_6833_Desc = {
    Text = "In der Ecke des Ateliers stand eine alte Kamera, einige Filmrollen und verstreute Fotos. Sie dokumentieren treu die Arbeit und Ästhetik des Wachsfigurenbastlers"
  },
  Event_6833_Name = {
    Text = "wie es ist, aufzeichnen"
  },
  Event_6834_ChoiceDesc1 = {
    Text = "[Weiter befragen]Erhöhe Arg1 Punkte maximale Gesundheit"
  },
  Event_6834_ChoiceDesc2 = {
    Text = "[Schatten ergreifen] Wähle 1 von 3 Befehlskarten aus, um ein Gebet zu erhalten: „(EnchantConfig.Arg1)\", infiziere „(Skill.Arg2)\""
  },
  Event_6834_Desc = {
    Text = "Der Schatten rezitiert im goldenen Staub:\n„Diejenigen, die die Wahrheit kennen...\nMit dem Schlüssel als Macht, werden sie die Menschheit führen.“\nDas ist ein altes Sprichwort.\nDein Instinkt sagt dir, dass es nah an der Wahrheit ist, die du suchst.\nUnd dein Instinkt ist immer richtig"
  },
  Event_6834_Name = {
    Text = "Silberschlüssler"
  },
  Event_6835_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6835_Desc = {
    Text = "Du zeigst offen deine Zustimmung zu den wirren Worten und wärst fast dem Wahnsinn verfallen"
  },
  Event_6835_Name = {Text = "Wasserfest"},
  Event_6836_ChoiceDesc1 = {
    Text = "[Rufen der Krähe]erhält 30 das schwarze Siegel, infiziert „(Skill.Arg2)“, weiter wählen"
  },
  Event_6836_ChoiceDesc2 = {
    Text = "[Weit weg gehen]"
  },
  Event_6836_Desc = {
    Text = [[
Du gehst nicht, und sie gehen auch nicht.
Seltsame Seile verbinden eure Geister, sie scheinen dir etwas sagen zu wollen]]
  },
  Event_6836_Name = {
    Text = "Aussätzige Krähe"
  },
  Event_6837_ChoiceDesc1 = {
    Text = "[Gib den Widerstand auf]entferne 1 Befehlskarte, erhalte Arg1 das schwarze Siegel"
  },
  Event_6837_ChoiceDesc2 = {
    Text = "[Hände zurückziehen]"
  },
  Event_6837_Desc = {
    Text = "Eine, zwei, drei... \nAuf Gesicht und Fingern, Schmetterlinge wie Feuerwerk am Himmel, leuchten wie Edelsteine im Dunkeln.\nDiese Schreibmaschine hat keinen praktischen Nutzen, aber sie ist ein Meister der Schönheit"
  },
  Event_6837_Name = {
    Text = "Inspirationsschub"
  },
  Event_6838_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6838_Desc = {
    Text = "Wichtigeres liegt vor dir, du schließt die Kiste und beschließt, es zu ignorieren, während die Schreibmaschine allmählich verstummt"
  },
  Event_6838_Name = {
    Text = "Ungebetene Warnung"
  },
  Event_6839_ChoiceDesc1 = {
    Text = "[Mond hören]Infektion“(Skill.Arg1)“"
  },
  Event_6839_ChoiceDesc2 = {
    Text = "[Zwergstern hören]Infektion“(Skill.Arg1)“"
  },
  Event_6839_ChoiceDesc3 = {
    Text = "[Lauscher der Meteoriten]Verliere 25 schwarze Siegel"
  },
  Event_6839_Desc = {
    Text = "Heiß, hell, endlos"
  },
  Event_6839_Name = {
    Text = "Sternenmondton"
  },
  Event_6840_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6840_Desc = {
    Text = "Im Zentrum des Lichts ist ein erstarrter Silberkern, aber dein Verstand sagt dir, dass er nicht leuchtet.\nDein Blick folgt dem Lichtstrahl und stößt auf die Falle der Dunkelheit und des Unbekannten"
  },
  Event_6840_Name = {Text = "Nachtglanz"},
  Event_6841_ChoiceDesc1 = {
    Text = "[Verlassen]Wähle eine von 3 Befehlskarten und erhalte ein Gebet:“(EnchantConfig.Arg1)“"
  },
  Event_6841_Desc = {
    Text = [[
Norden, Nordausgang!
Wie Ramona entschieden hat, gibt es im Norden einen Ausweg]]
  },
  Event_6841_Name = {
    Text = "Nach Norden weiter"
  },
  Event_6842_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6842_Desc = {
    Text = "Oh... Makelloses Silber, ein Scherz deiner Seele.\nWas ist deine nächste Wahl?"
  },
  Event_6842_Name = {
    Text = "Die Show kann beginnen"
  },
  Event_6843_ChoiceDesc1 = {
    Text = "[Gehen] Wähle 1 von 3 Befehlskarten aus, um ein Gebet zu erhalten: „(EnchantConfig.Arg1)\", infiziere „(Skill.Arg2)\""
  },
  Event_6843_Desc = {
    Text = "Du schüttelst den Kopf, um die Stimmen zu vertreiben.\nEin kaum hörbares Seufzen bringt dir etwas Hilfe"
  },
  Event_6843_Name = {
    Text = "Nach Norden weiter"
  },
  Event_6844_ChoiceDesc1 = {
    Text = "[In den Korridor vordringen]Infektion“(Skill.Arg1)“，weitergehen?"
  },
  Event_6844_ChoiceDesc2 = {
    Text = "[Gegensätzlich]Erhalte 25 schwarze Siegel"
  },
  Event_6844_Desc = {
    Text = "Das Mondlicht verblasst, verschlungen vom Korridor, nur eine unheilvolle Tür bleibt in Sicht."
  },
  Event_6844_Name = {
    Text = "Stille Galerie"
  },
  Event_6845_ChoiceDesc1 = {
    Text = "[In die Korridore eindringen]Zufällige 1 Befehlskarte erhalte ein Gebet: „(EnchantConfig.Arg1)“, soll ich weitergehen?"
  },
  Event_6845_ChoiceDesc2 = {
    Text = "[Gegensätzlich]Erhalte 25 schwarze Siegel"
  },
  Event_6845_Desc = {
    Text = "Unbekanntes sollte nicht vertieft werden"
  },
  Event_6845_Name = {
    Text = "Stille Galerie"
  },
  Event_6846_ChoiceDesc1 = {
    Text = "[In den Korridor vordringen]Infektion“(Skill.Arg1)“，weitergehen?"
  },
  Event_6846_ChoiceDesc2 = {
    Text = "[Gegensätzlich]Erhalte 25 schwarze Siegel"
  },
  Event_6846_Desc = {
    Text = "Die Tür auf der linken Seite lachte unheimlich, sie zitterte leicht und schüttelte ein wenig Bosheit ab"
  },
  Event_6846_Name = {
    Text = "Stille Galerie"
  },
  Event_6847_ChoiceDesc1 = {
    Text = "[In die Korridore eindringen]Erhalte ein silbernes Relikt „(RelicConfig.Arg1)“, soll ich weitergehen?"
  },
  Event_6847_ChoiceDesc2 = {
    Text = "[Gegensätzlich]Erhalte 25 schwarze Siegel"
  },
  Event_6847_Desc = {
    Text = "Die Tür auf der rechten Seite stand offen, Blut zog eine Spur auf dem Boden"
  },
  Event_6847_Name = {
    Text = "Stille Galerie"
  },
  Event_6848_ChoiceDesc1 = {
    Text = "[Nichts mehr da, du gehst zurück]"
  },
  Event_6848_Desc = {
    Text = "Wer sagt, man muss immer mit dem Kopf durch die Wand? Ein Schritt zurück, und vielleicht öffnet sich der Himmel"
  },
  Event_6848_Name = {
    Text = "Stille Galerie"
  },
  Event_6849_ChoiceDesc1 = {
    Text = "[Wachsfigur restaurieren] wählt eine Karte und reduziert ihre Arithmetica um 1"
  },
  Event_6849_Desc = {
    Text = "Die Reparatur der Wachsfigur wird fortgesetzt. \n Du bist kein professioneller Wachsfigurenmacher und hast auch keine systematische ästhetische Ausbildung erhalten. \n Doch du beginnst dennoch geschickt mit dem Abformen, Modellieren und Färben... \n Als ob du von Geburt an mit einem Schnitzmesser in der Hand leben solltest. \n Als ob sie von Geburt an unvollständig sein sollte, nur um auf deine Bearbeitung zu warten."
  },
  Event_6849_Name = {
    Text = "Unfertige Wachsfigur"
  },
  Event_6850_ChoiceDesc1 = {
    Text = "[Wachsfigur restaurieren] wählt eine Karte und reduziert ihre Arithmetica um 1"
  },
  Event_6850_Desc = {
    Text = "Galatea, Galatea...\nDu folgst der Stimme und findest die unvollendete Wachsfigur wieder.\nSie sieht perfekt aus, fast beunruhigend.\n„Hässlichkeit ist ein Riss in der Perfektion.“\nIm letzten Moment entscheidest du dich, etwas zu tun"
  },
  Event_6850_Name = {
    Text = "Unfertige Wachsfigur"
  },
  Event_6851_ChoiceDesc1 = {
    Text = "[Trugbild annehmen] Eine zufällige Befehlskarte erhält das Gebet: „(EnchantConfig.Arg1)\", infiziert „(Skill.Arg2)\""
  },
  Event_6851_ChoiceDesc2 = {
    Text = "[Illusion verleugnen]wählt 1 von 3 Befehlskarten und erhält Orison: „(EnchantConfig.Arg1)“"
  },
  Event_6851_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte 25 schwarze Siegel"
  },
  Event_6851_Desc = {
    Text = "Unter der schweren, dunklen Eisenbrücke, am stillen Ufer mit Schilfrohr, fliegt plötzlich ein leuchtender Schmetterling heraus. \n Der Schmetterling landet sanft in deiner Handfläche, das schreckliche Geschrei verstummt und wird ersetzt durch das Dröhnen der Züge, die über die rostigen Stahlträger fahren, das Knistern der brennenden Kohle und das metallische Reiben der sich drehenden Achsen..."
  },
  Event_6851_Name = {
    Text = "Eisenbahnillusion"
  },
  Event_6852_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6852_Desc = {
    Text = "Ja, Flucht, du wirst von einem Wesen verfolgt, und dein Überlebensinstinkt lässt dich rennen, bis es keinen Ausweg mehr gibt. Nein, es sollte keinen Ausweg geben... nicht für den Höllenhund, oder?"
  },
  Event_6852_Name = {Text = "Laufen"},
  Event_6853_ChoiceDesc1 = {
    Text = "[Das ist nicht wahr]Erhalte Silberrelikt „(RelicConfig.Arg1)“"
  },
  Event_6853_ChoiceDesc2 = {
    Text = "[Fallen ... fallen ...]Erwirbt ein Goldrelikt „(RelicConfig.Arg1)“, infiziert „(Skill.Arg2)“"
  },
  Event_6853_Desc = {
    Text = "Der Spiegel auf dem Boden hat einen kunstvollen Rahmen, in dem sich immer wieder Rahmen befinden...\nAlice springt hinab und fällt endlos im Kaninchenbau, sieht Spiegel und gefangene Geister, nur sich selbst nicht"
  },
  Event_6853_Name = {
    Text = "Spiegel im Spiegel"
  },
  Event_6854_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6854_Desc = {
    Text = [[
Du blickst durch die fensterlosen Schneeverwehungen auf den Schneeberg hinab, viele schwarze Ameisen jagen eine andere schwarze Ameise...
Deine Gedanken stocken]]
  },
  Event_6854_Name = {
    Text = "Vulkanische Erinnerung"
  },
  Event_6855_ChoiceDesc1 = {
    Text = "[Vorwärts greifen]Erwirbt 25 das schwarze Siegel"
  },
  Event_6855_ChoiceDesc2 = {
    Text = "[Freundliche Antwort]50% Chance, 50 das schwarze Siegel zu erhalten, 50% Chance, nichts zu erhalten"
  },
  Event_6855_Desc = {
    Text = "Eine Katze, die aus dem Nichts erscheint, sitzt zwischen D-Schleim, ihr verschwommener Körper zeigt, dass sie ein Bewohner der Geisterdimension sein sollte.\nDieses unkenntliche Abbild betrachtet Lotan mit klugen Augen, es hebt seine reinweißen Vorderpfoten und winkt ihr zu"
  },
  Event_6855_Name = {
    Text = "Wandernde Bewohner"
  },
  Event_6856_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6856_Desc = {
    Text = "Ein fröhliches Gruppenbild.\nDie Wachsfiguren sind festlich gekleidet, sitzen ordentlich auf Stühlen und tragen das gleiche übertriebene Lächeln.\nSie sind so harmonisch wie in jeder Irrenanstalt.\n\nSigniert: Holozän 305, @2 Rogers"
  },
  Event_6856_Name = {
    Text = "Porträtgalerie"
  },
  Event_6857_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6857_Desc = {
    Text = "Du hast vorsichtig das Fragment abgenommen und genau untersucht. Es bewegte sich nicht mehr. \n„Tollpatschig, beweg dich nicht“, sagte Puppe und klopfte dir leicht auf den Hinterkopf. „Für eine Weile kann ich dir nicht helfen, ein weiteres Stück zu machen.“"
  },
  Event_6857_Name = {
    Text = "Unruhige Brosche"
  },
  Event_6858_ChoiceDesc1 = {
    Text = "[Schlüssel benutzen]"
  },
  Event_6858_ChoiceDesc2 = {
    Text = "[Verlassen]"
  },
  Event_6858_Desc = {
    Text = "Eine Tür blockiert deinen Weg. Du hast alles versucht, sie bleibt unbeweglich"
  },
  Event_6858_Name = {
    Text = "Rostige Tür"
  },
  Event_6858_Tips1 = {
    Text = "Benötigt den „verrosteten Schlüssel“"
  },
  Event_6859_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6859_Desc = {
    Text = "Du schämst dich für deine Unbarmherzigkeit. \n Ein qualifizierter Schutzherr muss gewissenhaft sein, du solltest nicht leichtfertig zu dem Urteil kommen, dass sie keine “hochwertigen Waren“ sind. \n Also beschließt du, sie genau zu beobachten. Fünf Minuten vergehen, zehn Minuten vergehen... \n Gut, jetzt kannst du ein Urteil fällen – \n es sind tatsächlich Schrottwaren."
  },
  Event_6859_Name = {
    Text = "Gebundene Seele"
  },
  Event_6860_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6860_Desc = {
    Text = "Du und deine Gefährten legen die Waffen nieder.\nDas ist keine große Gnade, sondern du weißt, dass ihre wackeligen Körper nicht lange durchhalten können.\nDein Urteil erweist sich als richtig"
  },
  Event_6860_Name = {Text = "Übung"},
  Event_6861_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6861_Desc = {
    Text = "“Komm und jage mich!“\n“Komm schon, du Idiot!“\n“Wenn du es kannst, fang uns!“\nDie Kinderstimmen sind triumphierend.\n“Verdammte! Bleibt stehen!“\nDie Erwachsenenstimmen keuchen"
  },
  Event_6861_Name = {
    Text = "Unsere Erinnerungen"
  },
  Event_6862_ChoiceDesc1 = {
    Text = "[Betreten]Durch den Nebel gehen, um die andere Seite zu erreichen"
  },
  Event_6862_ChoiceDesc2 = {
    Text = "[Verlassen]"
  },
  Event_6862_Desc = {
    Text = "Das ist die Person, die du suchst. Du hast die Aufgabe erfüllt"
  },
  Event_6862_Name = {
    Text = "Einzelspur-Schleichweg 26"
  },
  Event_6863_ChoiceDesc1 = {
    Text = "[Verlassen]Erhalte Silberrelikt“(RelicConfig.Arg1)“"
  },
  Event_6863_Desc = {
    Text = "Ah! Nur ein bisschen mehr! Warte, warum haben drei Würfel zehn Punkte ergeben?!\nDie Würfel liegen brav vor dir, sehen unschuldig aus"
  },
  Event_6863_Name = {
    Text = "Endloses Glücksspiel"
  },
  Event_6864_ChoiceDesc1 = {
    Text = "[Verlassen]Erhalte goldenes Relikt“(RelicConfig.Arg1)“"
  },
  Event_6864_Desc = {
    Text = [[
Verdammt! Es ist nicht sechs, aber es ist immer noch ein Gewinn.
Also, wie viele Punkte sind es?]]
  },
  Event_6864_Name = {
    Text = "Endloses Glücksspiel"
  },
  Event_6865_ChoiceDesc1 = {
    Text = "[Verlassen]Erhalte 50 schwarze Siegel"
  },
  Event_6865_Desc = {
    Text = [[
Obwohl ich es nicht erraten habe, kann ich es akzeptieren.
Was haben sie geworfen?]]
  },
  Event_6865_Name = {
    Text = "Endloses Glücksspiel"
  },
  Event_6866_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6866_Desc = {
    Text = "Du suchst in den Gipsstücken und setzt sie Stück für Stück zusammen, ihr Körper nimmt langsam Form an"
  },
  Event_6866_Name = {
    Text = "Zusammengesetzter Körper"
  },
  Event_6867_ChoiceDesc1 = {
    Text = "[Schlüssel aufheben]"
  },
  Event_6867_Desc = {
    Text = "Ein rostiger Schlüsselbund. Kann zum Öffnen von Schlössern verwendet werden"
  },
  Event_6867_Name = {
    Text = "Rostiger Schlüssel"
  },
  Event_6868_ChoiceDesc1 = {
    Text = "[Vorderseite]50% Chance, ein goldenes Relikt „(RelicConfig.Arg2)“ zu erhalten, 50% Chance zu infizieren „(Skill.Arg3)“"
  },
  Event_6868_ChoiceDesc2 = {
    Text = "[Gegenseite]50% Wahrscheinlichkeit, 75 das schwarze Siegel zu erhalten, 50% Wahrscheinlichkeit, „(Skill.Arg3)“ zu infizieren"
  },
  Event_6868_ChoiceDesc3 = {
    Text = "[Lass den anderen zuerst wählen]50% Chance, verfluchtes Relikt zu erhalten“(RelicConfig.Arg2)“，50% Chance, infiziert zu werden“(Skill.Arg3)“"
  },
  Event_6868_Desc = {
    Text = "Nur eine Wette, du wirst nicht verlieren.\nEine gravierte Münze wird hochgeworfen und fällt schnell, von deiner Hand erwärmt"
  },
  Event_6868_Name = {
    Text = "Berühmter Glücksspieler"
  },
  Event_6869_ChoiceDesc1 = {
    Text = "[Verlassen]Erhalte 25 schwarze Siegel"
  },
  Event_6869_Desc = {
    Text = "“Diejenigen, die sich dem Schicksal anvertrauen, werden auch vom Schicksal gestürzt.“\nDu entscheidest dich zu gehen"
  },
  Event_6869_Name = {
    Text = "Berühmter Glücksspieler"
  },
  Event_6870_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6870_Desc = {
    Text = "“Hüter.“\nRamona's Stimme weckt dich, aber das Gefühl des Fallens verschwindet nicht"
  },
  Event_6870_Name = {
    Text = "Spiegel im Spiegel"
  },
  Event_6871_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6871_Desc = {
    Text = "Es wird gesagt, dass das Nachtlied ein aus der Liebe entstandenes Lied ist.\nEs wird an Sommernächten, draußen vor den Fenstern der Liebenden, von ein paar Freunden als zärtliches Stück gespielt.\nUngezwungen und oberflächlich, entspricht es nicht Rogers Ästhetik, aber es ist dennoch zu seinem Repertoire geworden.\nWahrscheinlich weiß nur er selbst den Grund dafür."
  },
  Event_6871_Name = {
    Text = "schlechter Geschmack"
  },
  Event_6872_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6872_Desc = {
    Text = "Du weigerst dich, von ihrem Gemurmel verführt zu werden. \n Du sagst: “Lügen über Lügen! Ihr seid in der pechschwarzen Ewigkeit gefangen, wie könnt ihr das Universum durchqueren?“ \n Die Augen lachen. Unzählige Lacher vereinen sich zu einem gewaltigen Schall, und dein Herz zittert. \n Die Augen sagen: “Indem wir andere Augen rauben. Jedes Auge ist ein Universum. Wenn du tausend Augen besitzt, wirst du eine wahre Reise durch Raum und Zeit antreten.“"
  },
  Event_6872_Name = {Text = "Auge"},
  Event_6873_ChoiceDesc1 = {
    Text = "[abholen]Erhalte 3 wählbare goldene Relikte"
  },
  Event_6873_Desc = {
    Text = "Oh ja, das abscheuliche Spiegelbild bist du selbst.\nDie aufsteigende Bosheit tanzt mit dem schwarzen Schlamm zu deinen Füßen. Wenn es dir nichts ausmacht, will es auf deine Schulter klettern"
  },
  Event_6873_Name = {
    Text = "Spiegel darunter"
  },
  Event_6874_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6874_Desc = {
    Text = "Nach kurzer Zeit ließ die Bindung plötzlich nach, sodass du ins Straucheln gerietest.\nDu blicktest zurück auf die ruhige Fäden——„Berühre niemals den Sand“, dieser Satz könnte auch im Bereich gelten"
  },
  Event_6874_Name = {Text = "versunken"},
  Event_6875_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6875_Desc = {
    Text = "Das Feuer des Wissens brannte alle Fesseln nieder—\nzumindest dachtest du das"
  },
  Event_6875_Name = {Text = "versunken"},
  Event_6876_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6876_Desc = {
    Text = "Mit aller Kraft aus den Fesseln befreien, die Fäden schneiden die Kleidung und hinterlassen feine Blutspuren auf der Haut.\nObwohl das Spinnennetz etwas als Durchgangsgebühr hinterlassen hat, fühlst du dich erleichtert—du bist frei"
  },
  Event_6876_Name = {Text = "versunken"},
  Event_6877_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6877_Desc = {
    Text = "Die von Erosionswucherungen erzeugten Briefe werden meist gelöscht.\nDu konntest keine wertvollen Informationen aus dem Briefpapier gewinnen und hast es zerrissen und verstreut"
  },
  Event_6877_Name = {
    Text = "Schmetterlingseinteilung"
  },
  Event_6878_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6878_Desc = {
    Text = "Auch wenn die Schrift absichtlich gelöscht wurde, kannst du den Wert des Briefes immer noch klar erkennen"
  },
  Event_6878_Name = {
    Text = "Schmetterlingseinteilung"
  },
  Event_6879_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6879_Desc = {
    Text = "Vorsicht ist besser.\nRamona beugte sich, kehrte in den Flur zurück und schlich in den nächsten Raum"
  },
  Event_6879_Name = {
    Text = "Fensterspiegelung"
  },
  Event_6880_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6880_Desc = {
    Text = "Du stößt einen verzweifelten Schrei aus.\nDie Krähen scheinen von deinem Schrei verwirrt zu sein und verschwinden schnell, hinterlassen schwarze Spuren"
  },
  Event_6880_Name = {
    Text = "Sanges der Raben"
  },
  Event_6881_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6881_Desc = {
    Text = "Du rollst dich zusammen und versuchst, dich zu einem schwarzen Punkt zu machen.\nSo werden sie dich nicht bemerken, oder?\nNach einer Weile öffnest du die Augen.\nDu siehst Licht"
  },
  Event_6881_Name = {
    Text = "Sanges der Raben"
  },
  Event_6882_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6882_Desc = {
    Text = "Der Schatten floss durch die Finger und hinterließ goldene Staubpartikel"
  },
  Event_6882_Name = {
    Text = "Silberschlüssler"
  },
  Event_6883_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6883_Desc = {
    Text = [[
Du reibst dir wild die Haare, Fantasien und Wahnsinn explodieren in deinem Kopf, ein Klumpen schwarzer Schleim verbirgt sich tief darin.
Was wird es dir bringen, wenn du es aufschneidest?]]
  },
  Event_6883_Name = {
    Text = "Stirnrunzeln"
  },
  Event_6884_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6884_Desc = {
    Text = "Bunte Ölflecken füllen allmählich dein Sichtfeld, deine Emotionen geraten in ein chaotisches Fest"
  },
  Event_6884_Name = {
    Text = "Stirnrunzeln"
  },
  Event_6885_ChoiceDesc1 = {
    Text = "[Einstecken]"
  },
  Event_6885_Desc = {
    Text = "Eine quecksilberähnliche silberne Substanz, extrahiert aus ätzendem Schleim, enthält starke geistige Energie, hauptsächlich verwendet, um in Ritualen mehr Erwachte zu verbinden"
  },
  Event_6885_Name = {Text = "Silberkern"},
  Event_6886_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6886_Desc = {
    Text = "Fröhliches Lachen strömt aus der Schachtel, und nach dem Verschwinden des warmen Glühens siehst du eine Karte mit drei Strichmännchen: du, die silberhaarige Ramona und der blondhaarige Ogier. Daneben steht eine Zeile.\n„Danke euch!“"
  },
  Event_6886_Name = {
    Text = "Geschenk der Güte"
  },
  Event_6887_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6887_Desc = {
    Text = "Dein Körper entkam den Schmetterlingen, aber sie haben ihr Ziel nicht verloren, sie drangen in deinen Koffer ein und saugten gierig die Tinte aus der Schreibmaschine"
  },
  Event_6887_Name = {Text = "Wahnwelle"},
  Event_6888_ChoiceDesc1 = {
    Text = "[Fehler aufzeigen] Wähle 1 Befehlskarte aus, um ein Gebet zu erhalten: „(EnchantConfig.Arg1)\", infiziere „(Skill.Arg2)\""
  },
  Event_6888_ChoiceDesc2 = {
    Text = "[Nach dem Spiel hören]für jede aufgewachte Energie mit 50 oder mehr erhält 15 das schwarze Siegel"
  },
  Event_6888_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte eine Auswahl von 3 für 1 Gebet"
  },
  Event_6888_Desc = {
    Text = "Die Wachsfigur des Jungen saß am Klavier und spielte eine Übung.\nSein Lehrer – ebenfalls aus Wachs – stand daneben und gab Anweisungen.\n133, 355, 244...\nFalsch, jeder Ton war falsch"
  },
  Event_6888_Name = {
    Text = "Piano-Unterricht"
  },
  Event_6889_ChoiceDesc1 = {
    Text = "[Gib den Widerstand auf]entferne 1 Befehlskarte, erhalte Arg1 das schwarze Siegel"
  },
  Event_6889_ChoiceDesc2 = {
    Text = "[Hände zurückziehen]"
  },
  Event_6889_Desc = {
    Text = "Du kannst dem inneren Drang nicht widerstehen. \n Deine Finger wandern und spielen wie Kinder, die sich im Wald verirrt haben, über die Tastatur... \n Allmählich fliegen Schmetterlinge aus der Schreibmaschine. \n Eins, zwei, drei... \n Auf deinem Gesicht und deinen Fingern leuchten Schmetterlinge wie Feuerwerk am Himmel, strahlend wie Edelsteine im Dunkeln. \n Diese Schreibmaschine hat keinen praktischen Nutzen, aber sie ist ein Meister der Schönheit."
  },
  Event_6889_Name = {
    Text = "Inspirationsschub"
  },
  Event_6890_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6890_Desc = {
    Text = "Du hältst das Papier unter das dunkelrote Licht, aus Angst, ein Detail zu übersehen. \n Es handelt sich um einen Gesundheitsbericht, und die getestete Person ist Mason. \n “Gewicht 40 kg, Sauerstoffsättigung normal, Synchronisationsrate 30 %, Resonanzwert...“ \n Du möchtest weiter lesen, doch die Schrift verschwindet allmählich. \n So sauber, als wäre nichts geschehen."
  },
  Event_6890_Name = {
    Text = "Schreibmaschine"
  },
  Event_6891_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6891_Desc = {
    Text = "Ja, du fliehst nicht, du verfolgst ein klares Ziel—die „Höllenhunde“, die durch die engen, nassen Schneegassen stürmen. Du wirst das nicht vergessen, so wie du das Gesicht der Person nicht vergessen wirst, die dich an diesem Tag in Tunguska aus den Trümmern gezogen hat. ...Wer war das?"
  },
  Event_6891_Name = {Text = "Laufen"},
  Event_6892_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6892_Desc = {
    Text = "In diesem isolierten Raum kannst du nur auf dich selbst zählen"
  },
  Event_6892_Name = {
    Text = "Alptraumwandler"
  },
  Event_6893_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6893_Desc = {
    Text = "Krise und Risiko gehen Hand in Hand. Beim Berühren des Eisenschlosses brannte die ätzende Flüssigkeit in deiner Handfläche. Hoffentlich ist das, was hinter der Tür ist, es wert"
  },
  Event_6893_Name = {
    Text = "Hinter der Eisentür"
  },
  Event_6894_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6894_Desc = {
    Text = [[
Du bist in einer unbekannten Welt unterwegs, aber dein schwankender Geist ist nicht bis zum Wahnsinn verwahrlost.
Das Unheimliche des Unbekannten war dir schon immer bewusst]]
  },
  Event_6894_Name = {
    Text = "Alptraumwandler"
  },
  Event_6895_ChoiceDesc1 = {
    Text = "[Laut schreien]erhalte das silberne Relikt „(RelicConfig.Arg1)“, Infektion „(Skill.Arg2)“"
  },
  Event_6895_ChoiceDesc2 = {
    Text = "[Fühle die Stille]erhalte das goldene Relikt“(RelicConfig.Arg1)“、infiziere“(Skill.Arg2)“、“(Skill.Arg3)“"
  },
  Event_6895_ChoiceDesc3 = {
    Text = "[An die Oberfläche kommen]Erhalte 25 schwarze Siegel"
  },
  Event_6895_Desc = {
    Text = "Du hörst die Stille.\nEine verstärkte Stille, die wie das Rauschen der Wellen den Raum füllt.\n\nDu hebst den Kopf, wie ein kleiner Punkt, der in den Sternenhimmel schaut"
  },
  Event_6895_Name = {
    Text = "Wasser der Vergangenheit"
  },
  Event_6896_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6896_Desc = {
    Text = "Du spitzst die Ohren und suchst nach der Quelle des Geräusches, versuchst den Unruhestifter ausfindig zu machen. \n Doch so als wolle man dich absichtlich verspotten, stößt du immer wieder auf eine Wand des Geistes, als hättest du die Person in die Enge gedrängt, nur um erneut an den Ausgangspunkt zurückzukehren. \n Entmutigt trittst du gegen die Ziegelmauer, doch ein Stein fällt von der Wand und offenbart ein geheimnisvolles, schimmerndes Loch."
  },
  Event_6896_Name = {
    Text = "Versteckte Spur"
  },
  Event_6897_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6897_Desc = {
    Text = "Es muss ein Abspielproblem sein, es muss so sein.\nDu spulst die Nadel zurück, erträgst die schreckliche Musik, aber das vertraute Klopfen bleibt aus.\nHinter dir schleicht ein kleiner Schatten davon"
  },
  Event_6897_Name = {
    Text = "Versteckte Spur"
  },
  Event_6898_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6898_Desc = {
    Text = "Niemand ist in deiner Nähe, das Geheimnis des Klopfens muss im Mechanismus des Phonographen verborgen sein. \n Aus Vertrauen in dein eigenes Urteil hast du den alten Phonographen auseinandergebaut. \n Außer den verfaulten Metallteilen und einer dicken Staubschicht hast du nichts gefunden. \n Nur ein leises Kichern schwebt im Nebel, so leicht, als ob du in einem Traum bist."
  },
  Event_6898_Name = {
    Text = "Versteckte Spur"
  },
  Event_6899_ChoiceDesc1 = {
    Text = "[Narrensubstanz]Arg1 Lebenspunkte heilen"
  },
  Event_6899_ChoiceDesc2 = {
    Text = "[Herz des Wahnsinnigen]Zufällig 1 Befehlskarte erhalten, erhalte Orison:“(EnchantConfig.Arg1)“"
  },
  Event_6899_ChoiceDesc3 = {
    Text = "[Weigere dich zu essen] erhält +25 das schwarze Siegel"
  },
  Event_6899_Desc = {
    Text = "“Das weiße Fleisch des Narren ist so köstlich wie eine kochende Fischsuppe, während das Herz des Wahnsinnigen zu einem heißen, blutigen Scone gebraten wurde.“\nDer Schatten grinst hämisch und reicht dir ein Gericht mit unklaren Zutaten.\nDu atmest tief ein, das durchdringende Aroma dringt rücksichtslos in deine Nase, deine würdelosen Speicheldrüsen ergeben sich zuerst, während dein Magen und Darm traurig krampfen und ein sehnsüchtiges Grummeln von sich geben."
  },
  Event_6899_Name = {
    Text = "Fleischfest"
  },
  Event_6900_ChoiceDesc1 = {
    Text = "[Berühre die Windglocke]Infiziere“(Skill.Arg1)“，zufällig eine Befehlskarte erhält ein Gebet:“(EnchantConfig.Arg2)“"
  },
  Event_6900_ChoiceDesc2 = {
    Text = "[Beobachte die Windglocke]Infiziere“(Skill.Arg1)“，zufällig eine Befehlskarte erhält ein Gebet:“(EnchantConfig.Arg2)“"
  },
  Event_6900_ChoiceDesc3 = {
    Text = "[Nichts tun]Zufällige Befehlskarte erhalten und das Orison: „(EnchantConfig.Arg1)“"
  },
  Event_6900_Desc = {
    Text = [[
Ding Ding, Ding Ding......
Das ist eine verrostete Windglocke, deren unbeholfene Melodie aus den Ritzen hervorkriecht]]
  },
  Event_6900_Name = {
    Text = "Rostige Windspiel"
  },
  Event_6901_ChoiceDesc1 = {
    Text = "[Abwarten]Versuche zu überleben"
  },
  Event_6901_ChoiceDesc2 = {
    Text = "[Waffe schwingen]Fluchtversuch"
  },
  Event_6901_ChoiceDesc3 = {
    Text = "[Eine Hand halten]erhalte 25 schwarze Siegel"
  },
  Event_6901_Desc = {
    Text = "Der Boden unter deinen Füßen verwandelt sich plötzlich in einen schwarzen Sumpf, aus dem unzählige Hände hervorsprießen. \n Sie haben verschiedene Hautfarben, Materialien und Texturen, Pfauenblau, schuppig, mit Augen, als wären sie durch unzählige Dimensionen und Räume gekommen, und versuchen, das nächste Unglück zu ihrem großen Familienkreis zu ziehen. \n Du entscheidest dich—"
  },
  Event_6901_Name = {
    Text = "dunkles Sumpfgebiet"
  },
  Event_6902_ChoiceDesc1 = {
    Text = "[Festhalten]Wähle 1 von 3 zufälligen Befehlskarten aus dem Deck zur Kopie"
  },
  Event_6902_ChoiceDesc2 = {
    Text = "[Einmal schütteln] Wähle 1 von 3 Befehlskarten aus, um ein Gebet zu erhalten: „(EnchantConfig.Arg1)\", infiziere „(Skill.Arg2)\""
  },
  Event_6902_ChoiceDesc3 = {
    Text = "[Nichts tun]Erhalte 25 das schwarze Siegel"
  },
  Event_6902_Desc = {
    Text = [[
Ding Ding, Ding Ding......
Das ist eine verrostete Windglocke, deren unbeholfene Melodie aus den Ritzen hervorkriecht]]
  },
  Event_6902_Name = {Text = "Windglocke"},
  Event_6903_ChoiceDesc1 = {
    Text = "[Widerlegen]erhält Silberrelikt „(RelicConfig.Arg1)“, wählt 1 Symptom zur Infektion"
  },
  Event_6903_ChoiceDesc2 = {
    Text = "[folge ihnen]Wählen Sie 1 Karte aus 3 Befehlskarten und erhalten Sie das Gebet:“(EnchantConfig.Arg1)“，Infektion“(Skill.Arg2)“"
  },
  Event_6903_ChoiceDesc3 = {
    Text = "[Neue Perspektive einbringen]erhalte 25 schwarze Siegel"
  },
  Event_6903_Desc = {
    Text = "“Bitte haltet Abstand zu uns.“\nEine Gruppe von Ratten umzingelt dich, und hält mindestens fünf Fuß Abstand. \n“Wir bemühen uns um Fortpflanzung, wir gedeihen, wir sind nie wählerisch – und so bringen wir den Menschen Krankheiten, Angst und Leid.“\n“Wir sollten nicht zu nahe bei den Menschen sein, das ist nicht der Ort, an dem du sein solltest.“\nUm die Ratten zu entspannen, entscheidest du dich zu –"
  },
  Event_6903_Name = {Text = "Pest"},
  Event_6904_ChoiceDesc1 = {
    Text = "[Weiter fallen]Infiziere“(Skill.Arg1)“, weiter fallen?"
  },
  Event_6904_ChoiceDesc2 = {
    Text = "[Zieh dich zurück] erhält +25 das schwarze Siegel"
  },
  Event_6904_Desc = {
    Text = "„Du\" lädt dich tiefer ein.\nIn den Tiefen der Spirale senden dir die „Du\" aus Vergangenheit und Zukunft „Geschenke\" aus verschiedenen Dimensionen."
  },
  Event_6904_Name = {
    Text = "Spiralabgrund"
  },
  Event_6905_ChoiceDesc1 = {
    Text = "[Drücke den Raben]erhalte 40 das schwarze Siegel, infiziere“(Skill.Arg2)“，setze fort die Auswahl"
  },
  Event_6905_ChoiceDesc2 = {
    Text = "[Lass es sein]erhalte 25 das schwarze Siegel, verlasse"
  },
  Event_6905_Desc = {
    Text = "Eine einsame Krähe zupft sich heiser eine nach der anderen ihre schwarzen Federn aus.\nSie zittert vor Schmerz, schreit laut, kann aber nicht aufhören.\n„Krah—Krah—“\nBlaue Tränen, vermischt mit schwarzem Schleim, fließen aus ihren Augen, nur du siehst es"
  },
  Event_6905_Name = {
    Text = "Träne der geschmolzenen Lava"
  },
  Event_6906_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6906_Desc = {
    Text = "Rot, leidenschaftlich, lebhaft, prächtig, ich kenne zufällig eine solche Schönheit, die ihr bald treffen werdet.\nWas ist deine nächste Wahl?"
  },
  Event_6906_Name = {
    Text = "Die Show kann beginnen"
  },
  Event_6907_ChoiceDesc1 = {
    Text = "[Lauter Jubel]"
  },
  Event_6907_ChoiceDesc2 = {
    Text = "[Schläfrig]"
  },
  Event_6907_Desc = {
    Text = "Du hattest einen langen Traum.\nIm Traum saßt du im Publikum und sahst einem Jungen beim Singen auf der Bühne zu.\n“Alter Charlie hatte eine Katze, die er sehr liebte\nAls sie verschwand, suchte er überall nach ihr“\n......\nEine hohle, trockene Stimme wiederholte mechanisch, endlos"
  },
  Event_6907_Name = {
    Text = "Abschlusszeremonie IV"
  },
  Event_6908_ChoiceDesc1 = {
    Text = "[Obere Zweige lösen]"
  },
  Event_6908_ChoiceDesc2 = {
    Text = "[Untere Zweige lösen]"
  },
  Event_6908_Desc = {
    Text = "Die verbleibenden Gnosis aus dem Bereich verweben sich und bilden ein instabiles Kraftfeld.\nVielleicht kannst du die verknäuelte Seele lösen, um dir den Weg nach vorne zu ebnen"
  },
  Event_6908_Name = {
    Text = "Verflochtener Pfad"
  },
  Event_6909_ChoiceDesc1 = {
    Text = "[Verlassen]Wähle zwei Erwecker"
  },
  Event_6909_Desc = {
    Text = "Du stehst auf und rennst sofort zur Tür. \n “Du hast das Tuch angehoben... \n Geheimnis, du hast ein Geheimnis entdeckt...“ \n Die Geräuschwelle vereint sich zu einem lärmenden Ozean, der Boden vibriert heftig in schrecklicher Resonanz. \n Du wagst nicht, dich umzudrehen, und fliehst mit der schnellsten Geschwindigkeit vom Ort des Geschehens."
  },
  Event_6909_Name = {
    Text = "Abschlusszeremonie V"
  },
  Event_6910_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6910_Desc = {
    Text = "Du leistest keinen Widerstand, aber du wirst dich auch nicht verlieren"
  },
  Event_6910_Name = {
    Text = "Schädelwunde"
  },
  Event_6911_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6911_Desc = {
    Text = "Du widerstehst nicht mehr, lässt die Unreinheit deinen Körper und Geist verschlingen, und nach dem langen Schlaf fällt das Silberlicht in deine gefalteten Hände"
  },
  Event_6911_Name = {
    Text = "Schädelwunde"
  },
  Event_6912_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6912_Desc = {
    Text = "Je mehr du kämpfst, desto tiefer sinkt der Schmutz in deinem Kopf, und in den tiefsten Schichten des von Sünde verstopften Gehirns liegt ein unerklärliches Geschenk verborgen"
  },
  Event_6912_Name = {
    Text = "Schädelwunde"
  },
  Event_6913_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6913_Desc = {
    Text = "Mit dem Zerbrechen des Netzes blitzt etwas in deinem Kopf auf, vielleicht das Lächeln einiger Kinder"
  },
  Event_6913_Name = {
    Text = "verirrtes Netzwerk"
  },
  Event_6914_ChoiceDesc1 = {
    Text = "[Verlassen]Erhalte 25 schwarze Siegel"
  },
  Event_6914_Desc = {
    Text = "Die Katze nickt zufrieden und verschwindet als Schatten, hinterlässt schwarze runde Objekte"
  },
  Event_6914_Name = {
    Text = "Wandernde Bewohner"
  },
  Event_6915_ChoiceDesc1 = {
    Text = "[Lesen des Briefes]Entferne eine Befehlskarte, erhalte Arg1 das schwarze Siegel"
  },
  Event_6915_ChoiceDesc2 = {
    Text = "[Schließe die Kiste]"
  },
  Event_6915_Desc = {
    Text = "Fliegende Briefe bedeckten den Himmel, wie stumme Mahnungen"
  },
  Event_6915_Name = {
    Text = "Ungebetener Brief"
  },
  Event_6916_ChoiceDesc1 = {
    Text = "[Betreten]Durch den Nebel gehen, um die andere Seite zu erreichen"
  },
  Event_6916_ChoiceDesc2 = {
    Text = "[Verlassen]"
  },
  Event_6916_Desc = {
    Text = "Auf der Straße vor dir tauchte ein versteckter Tunnel auf, in dem sich schwarzer Nebel ausbreitete, ohne zu wissen, wohin er führte"
  },
  Event_6916_Name = {Text = "Tunnel"},
  Event_6917_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6917_Desc = {
    Text = "Du beschließt, ihr Leiden zu beenden, greifst nach ihrem weichen Körper, drückst zu, noch fester...\nSie kämpft verzweifelt in deiner Handfläche, bis sie schließlich in einer warmen Flüssigkeit explodiert"
  },
  Event_6917_Name = {
    Text = "Träne der geschmolzenen Lava"
  },
  Event_6918_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6918_Desc = {
    Text = "Keine Sorge, das sind nur zerbrochene Erinnerungen aus einer anderen Dimension. Du hast einen Schatten. Aber ist die Person im Schatten wirklich noch du?"
  },
  Event_6918_Name = {
    Text = "Erinnerungsfragment: Bier"
  },
  Event_6919_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6919_Desc = {
    Text = "Du hast den spitzen Schnabel der Krähe, der versuchte, an seinen Federn zu knabbern, mit aller Kraft zurückgebogen, doch sie wand sich unaufhörlich, so stark, dass deine Knochen knacken. \n Dein Gesicht wird rot, und du setzt all deine Kraft ein, um den Körper der Krähe zu bändigen und ihr verrücktes Selbstverletzen zu stoppen. \n Gerade als du aufatmest, dreht sich der bereits halb kahle Hals der Krähe ruckartig nach hinten, ihr Körper wird schlaff und verwandelt sich in deiner Hand in einen Haufen schwarzen Schleims."
  },
  Event_6919_Name = {
    Text = "Träne der geschmolzenen Lava"
  },
  Event_6920_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6920_Desc = {
    Text = "Du ignorierst kalt die verzweifelten Glocken.\nSelbst wenn du in der nächsten Sekunde in die Urzeit zurückgebombt wirst, selbst wenn du und deine große Mission zusammen begraben werden.\nEin Anruf, den man nicht annehmen sollte, darf man nicht annehmen.\nDu kennst diese einfache Wahrheit"
  },
  Event_6920_Name = {
    Text = "Bitte rangehen"
  },
  Event_6921_ChoiceDesc1 = {
    Text = "[Nach unten sehen]Erhalte 25 das schwarze Siegel"
  },
  Event_6921_ChoiceDesc2 = {
    Text = "[Ich werde es finden]erhalte das silberne Relikt“(RelicConfig.Arg1)“、infiziere“(Skill.Arg2)“"
  },
  Event_6921_Desc = {
    Text = "Du verfolgst den Schatten und trittst plötzlich in flaches Wasser. Die farblose Flüssigkeit dringt in deine Schuhe und bringt Kälte.\nEine Stimme im Wasser sagt: „Du wirst es nicht finden wollen.“"
  },
  Event_6921_Name = {
    Text = "Du wirst nicht wollen zu finden"
  },
  Event_6922_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6922_Desc = {
    Text = "Sichere Wahl"
  },
  Event_6922_Name = {
    Text = "hinter dem Strohballen"
  },
  Event_6923_ChoiceDesc1 = {
    Text = "[vertreibe die Krähen]Erhalte Arg1 schwarze Siegel, Infektion“(Skill.Arg2)“，weiter wählen"
  },
  Event_6923_ChoiceDesc2 = {
    Text = "[Ignoriere]erhalte 25 das schwarze Siegel, verlasse"
  },
  Event_6923_Desc = {
    Text = "Wie kann es in einem Raum des Sanatoriums einen Raben geben? \n Aber du hörst tatsächlich das höhnische Lachen des Raben, im Schatten gibt es eine Macht, die noch nicht auf die Bühne getreten ist, die dich aus den leeren Vogelaugen beobachtet. Diese pechschwarzen Wesen verdrehen ihre Hälse und stehen an der Deckenlampe am Ende der Gasse, während sie dich mit böswilligen Blicken anstarren. Die schattenhaften Köpfe scheinen denselben in A-Schleim getauchten Körper zu teilen."
  },
  Event_6923_Name = {
    Text = "Laternenschwarzer Rabe"
  },
  Event_6924_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6924_Desc = {
    Text = "Fürchte dich nicht vor dem Schmutz, du gewinnst mehr, als du verlierst"
  },
  Event_6924_Name = {
    Text = "hinter dem Strohballen"
  },
  Event_6925_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6925_Desc = {
    Text = "Der Sturm des Wissens umgab Tulu, du tauschtet einen Blick und gingst gemeinsam in die Dunkelheit"
  },
  Event_6925_Name = {
    Text = "Die Verheißung des Agenten"
  },
  Event_6926_ChoiceDesc1 = {
    Text = "[Betreten]Durch den Nebel gehen, um die andere Seite zu erreichen"
  },
  Event_6926_ChoiceDesc2 = {
    Text = "[Verlassen]"
  },
  Event_6926_Desc = {
    Text = "Du fällst in die Dunkelheit.\nAm Ende deines Blickfelds ist nur ein Lichtstrahl, der durch einen schlüssellochgroßen Spalt dringt.\nDer silberne Schlüssel leuchtet schwach und weist dir den Weg in den Geheimgang"
  },
  Event_6926_Name = {
    Text = "Einzelspur-Schleichweg"
  },
  Event_6927_ChoiceDesc1 = {
    Text = "[Infiziere“(Skill.Arg1)“、erhalte das Relikt:“(RelicConfig.Arg2)“]"
  },
  Event_6927_ChoiceDesc2 = {
    Text = "[Wähle eine Karte aus drei Befehlskarten und erhalte das Gebet:“(EnchantConfig.Arg1)“]"
  },
  Event_6927_Desc = {
    Text = "Ereignis 203 (in Entwicklung), nicht das Endergebnis"
  },
  Event_6927_Name = {
    Text = "Ereignis 203 (in Entwicklung)"
  },
  Event_6928_ChoiceDesc1 = {
    Text = "[Flicken]1 Befehlskarte löschen, Schöpfung erhalten:“(RelicConfig.Arg1)“"
  },
  Event_6928_ChoiceDesc2 = {
    Text = "[Streicheln] lösche 1 Schlag-/VERTskarte, erhält Gebet: „(EnchantConfig.Arg1)“"
  },
  Event_6928_ChoiceDesc3 = {
    Text = "[Verachtung]erhält 25 das schwarze Siegel"
  },
  Event_6928_Desc = {
    Text = "“Magst du meinen verstümmelten Körper? Wenn ja, könntest du mir helfen, meinen Körper wieder zusammenzusetzen?“\nDie Lippen der halbierten Gipsstatue bewegten sich, und eine schwache Stimme, wie ein sanfter Schleier, drang aus ihren eigentlich harten und kalten Lippen"
  },
  Event_6928_Name = {
    Text = "Zusammengesetzter Körper"
  },
  Event_6929_ChoiceDesc1 = {
    Text = "[Umschlag abwerfen]Wähle eine von 3 Befehlskarten und erhalte das Orison: „(EnchantConfig.Arg1)“"
  },
  Event_6929_ChoiceDesc2 = {
    Text = "[In die Tasche stecken]Infektion“(Skill.Arg1)“，Schöpfung erhalten：“(RelicConfig.Arg2)“"
  },
  Event_6929_Desc = {
    Text = "Dies ist ein Hilferuf, der Schreiber bemüht sich, ruhig zu bleiben, doch die schiefen Schriftzüge enthüllen seine tief verborgene Angst. \n “Das alles übersteigt vollkommen meine Erwartungen, wenn jetzt jemand sagt, ich sei verflucht, schwöre ich, dass ich es ohne Zweifel glauben würde.“ \n “Jemand sagt, ich sei verrückt, und er hat nur zur Hälfte recht, ich wackele am Rand des Wahnsinns.“ \n “Aber ich habe es wirklich gesehen! Es mutiert und zerfällt, das schwarz glänzende, klebrige Zeug versucht, meinen ganzen Körper zu erklimmen!“ \n “Ich bin geflohen! Ich bin schnell geflohen, aber der Blick hat sich nie von mir abgewandt, ich habe das Gefühl, es wird mich finden! Der abscheuliche schwarze Schlamm wird wieder in meinen Schädel fließen, egal wer diesen Brief erhält, ich flehe dich an, rette mich—“"
  },
  Event_6929_Name = {
    Text = "Ein Hilferuf"
  },
  Event_6930_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6930_Desc = {
    Text = "“Beruhige dich,“ Ramona klopft dir auf den Kopf, „nur Fragmente der Vergangenheit. Ich weiß nicht, wer sie in diesem Dimensionstunnel zurückgelassen hat.“\nTatsächlich, es riecht nach Nostalgie"
  },
  Event_6930_Name = {
    Text = "Notfallkommunikation"
  },
  Event_6931_ChoiceDesc1 = {
    Text = "[Zufällig 1 Befehlskarte erhält das Gebet:“(EnchantConfig.Arg1)“]"
  },
  Event_6931_ChoiceDesc2 = {
    Text = "[Zufällig 1 Befehlskarte erhält das Gebet:“(EnchantConfig.Arg1)“]"
  },
  Event_6931_ChoiceDesc3 = {
    Text = "[Zufällig 1 Befehlskarte erhält das Gebet:“(EnchantConfig.Arg1)“]"
  },
  Event_6931_Desc = {
    Text = "Ereignis 205 (in Entwicklung), nicht das Endergebnis"
  },
  Event_6931_Name = {
    Text = "Ereignis 205 (in Entwicklung)"
  },
  Event_6932_ChoiceDesc1 = {
    Text = "[Erhalte Artefakt:“(RelicConfig.Arg1)“"
  },
  Event_6932_ChoiceDesc2 = {
    Text = "[Erhalte Artefakt:“(RelicConfig.Arg1)“"
  },
  Event_6932_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte 50 schwarze Siegel"
  },
  Event_6932_Desc = {
    Text = "Ereignis 204 (in Entwicklung), nicht das Endergebnis"
  },
  Event_6932_Name = {
    Text = "Ereignis 204 (in Entwicklung)"
  },
  Event_6933_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6933_Desc = {
    Text = "Der einsame Mond hängt hoch am Himmel, und du kannst seine Gebete hören, eine seltsame Melodie, die wie das Flüstern des Unreinen klingt. \n Das Gebet verstummt, und du bist im Begriff zu gehen. Doch hinter dir erscheint ein weißer Schatten. \n “Die, die das Schicksal und die Verfluchung der Gebete ausspionieren, werden sowohl Gnade als auch Preis rechtzeitig erhalten.“"
  },
  Event_6933_Name = {
    Text = "Silbermondfragment"
  },
  Event_6934_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6934_Desc = {
    Text = "Ein knackendes Geräusch hinter dir, du zögerst kurz und gehst dann weg"
  },
  Event_6934_Name = {
    Text = "Silbermondfragment"
  },
  Event_6935_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6935_Desc = {
    Text = "Eine Handvoll Mondlicht, die in der Handfläche gehalten wird, wird auf den Grabstein gestreut. \n Jemand wurde unter dem schweren Schlamm begraben, die Zuschauer behaupten, diese Person sei einem natürlichen Verfall begegnet und werde im Erdreich ruhen. \n Doch der begrabene Schlamm beginnt zu schwellen, und aus den Schreien kriecht ein schlaffer Mond hervor."
  },
  Event_6935_Name = {
    Text = "Silbermondfragment"
  },
  Event_6936_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6936_Desc = {
    Text = "Aber es sind nur Lebewesen, die ums Überleben kämpfen und ein Stück Treibholz suchen, um sich auszuruhen...\nDu seufzt und lässt den schwarzen Saft vom Schmetterlingsschwanz fließen"
  },
  Event_6936_Name = {
    Text = "Etwas, das nicht existieren sollte"
  },
  Event_6937_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6937_Desc = {
    Text = "Es ist eine angekündigte Falle, und du kennst ihre Gefahr genau.\nIm Vergleich zu Schmuck bist du selbst der wertvollere Edelstein"
  },
  Event_6937_Name = {
    Text = "Verwirrende Teufelklauen"
  },
  Event_6938_ChoiceDesc1 = {
    Text = "[Silberschlüssel einstecken]"
  },
  Event_6938_Desc = {
    Text = "Im gesättigten D-Schleim scheint eine gewisse Substanz verborgen zu sein... Beobachte sie mit dem Silberschlüssel und verwandle sie in deine eigene Macht"
  },
  Event_6938_Name = {
    Text = "Ausgangspunkt"
  },
  Event_6939_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6939_Desc = {
    Text = "Du stimmst der Bitte zu, stößt jedoch auf ein kleines Problem.\n“Wie sieht die Wachspuppe aus?“\n“Das ist mein Abbild, natürlich sieht sie genauso aus wie ich.“\n“Aber...“\n“Dein Gesicht ist längst völlig verrottet. Wusstest du das nicht?“"
  },
  Event_6939_Name = {
    Text = "Mein Oberkörper"
  },
  Event_6940_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6940_Desc = {
    Text = "Du hältst die Hand deines Begleiters fest, Ramona wirft dir einen verwirrten Blick zu, aber sie duldet schließlich deine Unhöflichkeit"
  },
  Event_6940_Name = {Text = "Traumgebet"},
  Event_6941_ChoiceDesc1 = {
    Text = "[Frag es, wer es ist] Wähle eine von 3 Befehlskarten und erhalte das Gebet: “(EnchantConfig.Arg1)“, infiziere “(Skill.Arg2)“"
  },
  Event_6941_ChoiceDesc2 = {
    Text = "[Mit ihm Blickkontakt aufnehmen] Wähle 1 Erwecker zum Erwachen, infiziere “(Skill.Arg1)“"
  },
  Event_6941_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte 25 schwarze Siegel"
  },
  Event_6941_Desc = {
    Text = "Das starke Gefühl, beobachtet zu werden, bringt dich zum Stehen. \n “Wer ist da?“ fragst du und blickst in den Nebel, “Jenkin, bist du das?“ \n Der Nebel ist dicht, aus der Tiefe des Hofes dringt das Schreien einer Fusionsschale. Du findest nichts und musst umkehren, doch dabei stößt du fast mit einem in der Luft schwebenden Auge zusammen."
  },
  Event_6941_Name = {
    Text = "Blinder Blick"
  },
  Event_6942_ChoiceDesc1 = {
    Text = "[Nicht berühren]Zufällig 1 Befehlskarte erhält das Gebet: „(EnchantConfig.Arg1)“"
  },
  Event_6942_ChoiceDesc2 = {
    Text = "[Berühre die Münze]Erhöhe Arg1 Punkte maximale Gesundheit，infiziere“(Skill.Arg2)“"
  },
  Event_6942_Desc = {
    Text = "Du findest eine alte Münze im schwarzen Schlamm.\nEinerseits von Adern durchzogen, andererseits ein fein graviertes Relief eines puren weißen Gesichts - eine Herzogin mit einem reinen Lächeln, die deine blassen Augen fixiert"
  },
  Event_6942_Name = {
    Text = "Doppelte Antike Münze"
  },
  Event_6943_ChoiceDesc1 = {
    Text = "[Dreh dich um]Erhalte 25 schwarze Siegel"
  },
  Event_6943_ChoiceDesc2 = {
    Text = "[Weiter gehen]Erhalte ein silbernes Relikt:“(RelicConfig.Arg1)“, Infektion“(Skill.Arg2)“"
  },
  Event_6943_Desc = {
    Text = "Da ist es wieder, das seltsame Geräusch von Schritten. \n Es folgt dir dicht auf den Fersen, von dem Studio zum Büro des Kurators und dann von dort in den Keller. \n Du weißt, dass es sich um einen vorsichtigen Typ handelt. \n Er achtet sorgsam darauf, den Abstand zwischen euch aufrechtzuerhalten, sodass er nicht zu groß, aber auch nicht unangenehm ist. \n Trotzdem fühlst du dich tief betroffen."
  },
  Event_6943_Name = {Text = "Schritte"},
  Event_6944_ChoiceDesc1 = {
    Text = "[Beobachte es]Erhalte 25 schwarze Siegel"
  },
  Event_6944_ChoiceDesc2 = {
    Text = "[Streicheln sie] 50% Chance auf +50 das schwarze Siegel, 50% Chance nichts"
  },
  Event_6944_Desc = {
    Text = "Plötzlich springt eine schwarze Katze aus der Gasse und schmiegt sich ungewöhnlich vertraut um eure Beine. Ihre leuchtend grünen, senkrechten Pupillen blitzen mit einem unheimlichen Licht, als wollte sie sagen: “Hör auf zu verfolgen, spiel ein wenig mit mir.“ \n “Du hast sie bereits gesehen, sie ist direkt neben dir, die von Wahnsinn verschmutzten, fanatischen Schatten... Schau nicht direkt auf ihre Konturen.“"
  },
  Event_6944_Name = {Text = "Nachtelf"},
  Event_6945_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6945_Desc = {
    Text = "Die erweckten Körper warten auf deine Befehle, du hast keine Zeit für andere Dinge"
  },
  Event_6945_Name = {Text = "von Winkel"},
  Event_6946_ChoiceDesc1 = {
    Text = "[Überprüfe den Film]Infiziere „(Skill.Arg1)“, erhalte ein goldenes Relikt „(RelicConfig.Arg2)“"
  },
  Event_6946_ChoiceDesc2 = {
    Text = "[Überprüfe die Kamera]Erhalte 50 schwarze Siegel"
  },
  Event_6946_Desc = {
    Text = "Wie ein Stück Innereien herausgerissen, wird der Film im Bauch der Kamera zerfetzt und hier achtlos weggeworfen, ohne dass sich jemand darum kümmert. \n Ein blendendes Weiß blitzt auf, die Kamera, die an der Straßenecke zurückgelassen wurde, steht schief, der Verschluss wird grundlos betätigt. \n “Knack—“ \n Dein verwirrtes, erstauntes Gesicht wird treu auf dem Film in der Kamera festgehalten."
  },
  Event_6946_Name = {
    Text = "Rekord unschuldig"
  },
  Event_6947_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6947_Desc = {
    Text = "Es ist nur das Geräusch des Windes, der die Eisenketten schüttelt, nichts, worüber man sich Sorgen machen müsste"
  },
  Event_6947_Name = {
    Text = "Hinter der Eisentür"
  },
  Event_6948_ChoiceDesc1 = {
    Text = "[Wählen]Infektion“(Skill.Arg1)“"
  },
  Event_6948_ChoiceDesc2 = {
    Text = "[Wählen]Infektion“(Skill.Arg1)“"
  },
  Event_6948_ChoiceDesc3 = {
    Text = "[Wählen]Infektion“(Skill.Arg1)“"
  },
  Event_6948_Desc = {
    Text = "“Ich“ bin einzigartig, aus unzähligen Universen, unvergleichlich"
  },
  Event_6948_Name = {
    Text = "Seelenresonanz"
  },
  Event_6949_ChoiceDesc1 = {
    Text = "[abholen]Wählen Sie 1 Silberrelikt"
  },
  Event_6949_Desc = {
    Text = "Das könnte vielleicht das“Ich“sein.\nDas “Ich“, das durch den Schatten der Zeit reist, die Dimensionsbarriere überquert und durch einen Riss mit mir blickt."
  },
  Event_6949_Name = {
    Text = "Seelenresonanz"
  },
  Event_6950_ChoiceDesc1 = {
    Text = "[Weise auf das Problem hin] wähle 1 von 3 Befehlskarten, um Gebet zu erhalten: „(EnchantConfig.Arg1)“"
  },
  Event_6950_ChoiceDesc2 = {
    Text = "[Fragen schlucken]infiziert „(Skill.Arg1)“, druckt neu, kann 1 weitere Mal durchgeführt werden"
  },
  Event_6950_Desc = {
    Text = "Für diese Mädchen ist es auch ein unausgesprochenes Geheimnis.\nDu hast deine Fragen geschluckt, sie aber legt ihre Hand auf ihre Brust und erzählt sanft von einem langen Traum von fünfundzwanzig Jahren, vom Gefühl ihrer Isolation nach dem Erwachen"
  },
  Event_6950_Name = {
    Text = "Eingesperrtes Leben"
  },
  Event_6951_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6951_Desc = {
    Text = "Du wirfst Papier und Holzspäne ins Feuer. Die Flammen verschlingen sie gierig und geben ein zufriedenes „Rülpsen“ von sich. Bereit, die Welt zu zerstören, geben sie dir davor noch ein Segenswort"
  },
  Event_6951_Name = {
    Text = "dämmriges Feuer"
  },
  Event_6952_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6952_Desc = {
    Text = "Du trittst erbarmungslos die letzten Funken des Hasses aus, und der umgebende Groll und die Unzufriedenheit scheinen nachzulassen"
  },
  Event_6952_Name = {
    Text = "dämmriges Feuer"
  },
  Event_6953_ChoiceDesc1 = {
    Text = "[vertreibe die Krähen]Erhalte Arg1 schwarze Siegel, Infektion“(Skill.Arg2)“"
  },
  Event_6953_ChoiceDesc2 = {
    Text = "[Ignorieren]Verlassen"
  },
  Event_6953_Desc = {
    Text = "Du willst die Krähe fangen, aber sie fliegt nur von einer Seite des Zimmers zur anderen und gibt seltsame Geräusche von sich. Wo sie vorbeifliegt, hinterlässt sie schwarze, klebrige Spuren"
  },
  Event_6953_Name = {
    Text = "Laternenschwarzer Rabe"
  },
  Event_6954_ChoiceDesc1 = {
    Text = "[Verlassen]Erhalte Schöpfung“(RelicConfig.Arg1)“，Infektion“(Skill.Arg2)“"
  },
  Event_6954_Desc = {
    Text = "“Du hast ein gutes Gespür für das Wesentliche,“ lächelt der Mann, “das ist das köstlichste Futter der Welt, das es wert ist, von jedem Taotie sorgfältig zubereitet und genossen zu werden.“\n“Es tut mir leid, dass ich dir diesmal nicht die Gelegenheit geben kann, es zu probieren. Als Entschädigung habe ich auch einige andere köstliche Delikatessen dabei, die ich dir schenken möchte.“\n Nachdem er das gesagt hat, wirft der Mann ein Stück zart-rotes, weiches Fleisch weg. Das weiche Fleisch fällt auf die Brücke und die klebrigen Tentakel winden sich verzerrt. Als du wieder aufblickst, ist die Gestalt des Mannes bereits hinter dem verworrenen Stahlgerüst verschwunden, ohne eine Spur zu hinterlassen."
  },
  Event_6954_Name = {
    Text = "Seltsamer Begleiter VI"
  },
  Event_6955_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6955_Desc = {
    Text = "Schicht für Schicht, das ist deine Spezialität.\nDer Glanz der Inspiration macht das Gehirn besonders klar, du kannst die gegenwärtige Realität sehen -\nEgal, wer die Marionette im Hintergrund manövriert, entkomme und halte durch"
  },
  Event_6955_Name = {
    Text = "Inspirationsschub"
  },
  Event_6956_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6956_Desc = {
    Text = "Der Schmetterling zerbrach in deiner Handfläche, wie eine Glasdecke, die plötzlich zerschmettert wurde, die Bruchstücke fielen zur Erde, fielen, fielen—"
  },
  Event_6956_Name = {
    Text = "Eisenbahnillusion"
  },
  Event_6957_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6957_Desc = {
    Text = "Als Ramona sich nicht nähern wollte, schüttelte die Katze den Kopf und verschwand als Schatten"
  },
  Event_6957_Name = {
    Text = "Wandernde Bewohner"
  },
  Event_6958_ChoiceDesc1 = {
    Text = "[Gib ein Versprechen]Erhalte das Silberrelikt“(RelicConfig.Arg1)“，infiziere“(Skill.Arg2)“"
  },
  Event_6958_ChoiceDesc2 = {
    Text = "[Weigere dich] erhält Silberrelikt „(RelicConfig.Arg1)“, Infektion „(Skill.Arg2)“"
  },
  Event_6958_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte 25 schwarze Siegel"
  },
  Event_6958_Desc = {
    Text = "“Das war wirklich eine unvergessliche Erinnerung. \nMein Kopf und meine Glieder wurden gewaltsam in den Gips gedrückt. \nErstickung und die nahe Todesillusion umhüllten mich tief und zogen mich gewaltsam hoch, warfen mich an den dunklen Strand. \nIch sah es an und fühlte, dass ein Teil von mir ebenfalls mitgenommen wurde. \nDie verlorene andere Hälfte meiner Seele wohnt seitdem in dieser kleinen, ursprünglichen Wachsfigur. \nAlso... kannst du mir helfen, meinen Oberkörper zu finden?“"
  },
  Event_6958_Name = {
    Text = "Mein Oberkörper"
  },
  Event_6959_ChoiceDesc1 = {
    Text = "[Verlassen]Erhalte eine Auswahl von 3 für 1 fortgeschrittenes Gebet"
  },
  Event_6959_Desc = {
    Text = "Du bist der Zuschauer der Erinnerungen und kannst nur zusehen, wie das Mädchen in das dunkle Meer stürzt.\nDas Wasser hebt ihren Rock, doch sie sinkt, ähnlich einer ungeöffneten Blüte"
  },
  Event_6959_Name = {
    Text = "Sunkene See"
  },
  Event_6960_ChoiceDesc1 = {
    Text = "[Silberschlüssel einstecken]"
  },
  Event_6960_Desc = {
    Text = "Im gesättigten D-Schleim scheint eine gewisse Substanz verborgen zu sein... Beobachte sie mit dem Silberschlüssel und verwandle sie in deine eigene Macht"
  },
  Event_6960_Name = {
    Text = "Ausgangspunkt"
  },
  Event_6961_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6961_Desc = {
    Text = "Ignoriere die Verlockungen des Feindes, es könnte eine Falle sein"
  },
  Event_6961_Name = {Text = "Fluchrabe"},
  Event_6962_ChoiceDesc1 = {Text = "[Hilf ihm]"},
  Event_6962_ChoiceDesc2 = {
    Text = "[Kühle Beobachtung]"
  },
  Event_6962_Desc = {
    Text = "Der Junge stand auf der Bühne, das grelle Licht fiel auf sein Gesicht.\n“Für...“\nDer Junge errötete. Er öffnete den Mund, konnte aber keinen Laut von sich geben.\nSein schwarzes, gähnendes Maul wurde immer größer und größer"
  },
  Event_6962_Name = {
    Text = "Abschlusszeremonie III"
  },
  Event_6963_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6963_Desc = {
    Text = "“Verdammtes, verdammtes!“Wie von dir berührt, zeigt die schwarze Katze plötzlich ihr böses Gesicht und beißt nach deinem Arm. Zum Glück hast du rechtzeitig ausgewichen, sodass sie nur einen Teil deines Kleidungsstücks zerbissen hat. Die schwarze Katze springt um die Ecke und verschwindet im Abwasserkanal der Gasse."
  },
  Event_6963_Name = {Text = "Nachtelf"},
  Event_6964_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6964_Desc = {
    Text = "Von den brodelnden Gedanken in deinem Kopf getrieben, öffnest du die Tür und betrittst einen Weg ohne Wiederkehr.\nDas grelle weiße Licht draußen – ist es Erlösung oder Zerstörung?"
  },
  Event_6964_Name = {
    Text = "Jenseits der verschlossenen Türen"
  },
  Event_6965_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6965_Desc = {
    Text = "Du gehst mutig vor und untersuchst, die Schleimschicht auf dem Tisch reißt plötzlich auf und zeigt, was darunter liegt"
  },
  Event_6965_Name = {
    Text = "Jenseits der verschlossenen Türen"
  },
  Event_6966_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6966_Desc = {
    Text = "Schlucke deinen Speichel, unterdrücke deine Fragen und konzentriere dich auf den Feind.\nLass die Schmetterlinge in deinem Körper verweilen, auch wenn ihre Flügelschläge deine Organe zerreißen"
  },
  Event_6966_Name = {
    Text = "Schmetterlingseffekt"
  },
  Event_6967_ChoiceDesc1 = {
    Text = "[Verlassen]Erhalte 50 schwarze Siegel"
  },
  Event_6967_Desc = {
    Text = "Die Katze nickt zufrieden und verschwindet als Schatten, hinterlässt schwarze runde Objekte"
  },
  Event_6967_Name = {
    Text = "Wandernde Bewohner"
  },
  Event_6968_ChoiceDesc1 = {
    Text = "[Silberschlüssel einstecken]"
  },
  Event_6968_Desc = {
    Text = "Im gesättigten D-Schleim scheint eine gewisse Substanz verborgen zu sein... Beobachte sie mit dem Silberschlüssel und verwandle sie in deine eigene Macht"
  },
  Event_6968_Name = {
    Text = "Ausgangspunkt"
  },
  Event_6969_ChoiceDesc1 = {
    Text = "[Verlassen]Erhalte 1 zufälliges goldenes Relikt, infiziere“(Skill.Arg1)“"
  },
  Event_6969_Desc = {
    Text = "Als du noch zögerst, springt Kumm auf den Erdhaufen und gräbt schnell etwas mit seinen Vorderpfoten aus, das er dir vor die Füße schiebt"
  },
  Event_6969_Name = {
    Text = "Vergrabenes Objekt"
  },
  Event_6970_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6970_Desc = {
    Text = "Oben auf dem Papier steht „Mérimée“, es gab nie einen Mason.\nZu viel Misstrauen ist kein gutes Zeichen, Hüter"
  },
  Event_6970_Name = {
    Text = "Schreibmaschine"
  },
  Event_6971_ChoiceDesc1 = {
    Text = "[Verlassen]Erhalte eine Auswahl von 3 für 1 goldenes Relikt, infiziere“(Skill.Arg1)“"
  },
  Event_6971_Desc = {
    Text = "Im Erdhaufen liegen die unzähligen Verbrechen der Bildhauer verborgen"
  },
  Event_6971_Name = {
    Text = "Vergrabenes Objekt"
  },
  Event_6972_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6972_Desc = {
    Text = "Vögel haben ihre eigenen Regeln, sie handeln nicht nach deinem Willen, und du hast kein Recht, die Gesetze der Natur zu stören"
  },
  Event_6972_Name = {
    Text = "Aussätzige Krähe"
  },
  Event_6973_ChoiceDesc1 = {
    Text = "[Verlassen]Erhalte eine Auswahl von 3 für 1 goldenes Relikt, infiziere“(Skill.Arg1)“"
  },
  Event_6973_Desc = {
    Text = "Warum, warum ist es gesunken?\nAn diesem Tag gab es kein Gewitter, keinen Sturm. Der Nachthimmel war klar, ohne Sterne, der Vollmond hing tief über dem Meer, wie eine kalte Sonne"
  },
  Event_6973_Name = {
    Text = "Sunkene See"
  },
  Event_6974_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6974_Desc = {
    Text = "“Zugführer! Wir wurden Opfer eines Terroranschlags! ... Zisch...“\n Es scheint ein Anruf des Fahrers zu sein, du hattest vor, einfach aufzulegen. \n “Wiederholen: Hier ist das Außenteam Misaq, Gruppe 4. Wir sind auf dem Weg, um Geiseln im Nordlinien-Nachtzug zu eskortieren, als wir auf ... Aah!“\n Der Ton am Telefon wurde zu einem heiseren Flüstern, durchsetzt mit schaurigen, durchdringenden Schreien. \n “Das Sakrament ist vollzogen. Verirrtes Lamm, möge dieses heilige Bad deine Seele reinigen...“"
  },
  Event_6974_Name = {
    Text = "Zug anrufen"
  },
  Event_6975_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6975_Desc = {
    Text = "Das Sammeln von Silberkernen ist auch eine Aufgabe der Hüter.\nDie Seelen, die im reinen Kristall treiben, werden in neuer Gestalt in die Welt zurückkehren"
  },
  Event_6975_Name = {
    Text = "Gebundene Seele"
  },
  Event_6976_ChoiceDesc1 = {
    Text = "[Weiter fallen]Zufällig 1 Befehlskarte, um ein Gebet zu erhalten:“(EnchantConfig.Arg1)“, weiter fallen?"
  },
  Event_6976_ChoiceDesc2 = {
    Text = "[Zieh dich zurück] erhält +25 das schwarze Siegel"
  },
  Event_6976_Desc = {
    Text = "„Du\" lädt dich tiefer ein.\nIn den Tiefen der Spirale senden dir die „Du\" aus Vergangenheit und Zukunft „Geschenke\" aus verschiedenen Dimensionen."
  },
  Event_6976_Name = {
    Text = "Spiralabgrund"
  },
  Event_6977_ChoiceDesc1 = {
    Text = "[Beuge dich und schaue]infiziere“(Skill.Arg1)“、erhalte das goldene Relikt“(RelicConfig.Arg2)“"
  },
  Event_6977_ChoiceDesc2 = {
    Text = "[Gib die Überprüfung auf]erhalte 50 das schwarze Siegel"
  },
  Event_6977_Desc = {
    Text = "Unter dem Operationstisch schien eine Filmrolle zu stecken"
  },
  Event_6977_Name = {
    Text = "Erinnerungsschein"
  },
  Event_6978_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6978_Desc = {
    Text = "Störungen ablehnen, konzentriere dich auf das Hier und Jetzt.\nDu hast wichtigere Dinge zu tun"
  },
  Event_6978_Name = {
    Text = "Mein Oberkörper"
  },
  Event_6979_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6979_Desc = {
    Text = "Verlorene heilige Artefakte, unbezahlbare Erbstücke, Wunschmaschinen...\nVielleicht sind nur Schätze so verlockend"
  },
  Event_6979_Name = {
    Text = "Mysteriöse Eingabemethode"
  },
  Event_6980_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6980_Desc = {
    Text = "“Du bist Lilys 'Mutter', aber du behandelst sie nur als Werkzeug für Forschung und Kampf,“ antwortest du, “Ein kleines Kind mag seiner Mutter gehorchen, aber du solltest nicht Lilys 'Mutter' sein.“"
  },
  Event_6980_Name = {Text = "Ihre Wahl"},
  Event_69813_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_69813_Desc = {
    Text = "Der Glanz des Silberschlüssels flackert; die Arme scheinen von einer gewissen Macht eingeschüchtert und ziehen sich ins Wasser zurück, um zu verschwinden"
  },
  Event_69813_Name = {
    Text = "Blutige Pfütze"
  },
  Event_69814_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_69814_Desc = {
    Text = "Du sinkst immer tiefer, während das Flüstern des obersten Willens in deinem Kopf chaotisch erklingt. Du schließt die Augen und rufst deine inneren Mächte hervor. \n Plötzlich verschwinden alle Geräusche und die ungewöhnlichen Berührungen, und du stehst hinter der Tür, die blutigen Tentakel um dich herum sind spurlos verschwunden, als hätten sie niemals existiert. \n Du fühlst dich erfrischt. Du verstehst, welchen Preis du bezahlt hast, aber das ist unbedeutend - du wirst in einer stärkeren Form dem höchsten Wesen gegenüberstehen."
  },
  Event_69814_Name = {
    Text = "Blutige Pfütze"
  },
  Event_69815_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_69815_Desc = {
    Text = "Der aus Erinnerungen gestaltete Erwecker zögert nicht einen Moment und zieht dich aus der blutigen Pfütze, deine handverbindende Verbindung wird zerrissen, trübes Wasser spritzt auf, und unzählige schwer zu erkennende Kreaturen winden sich im Wasser, der ursprüngliche Schöpfer und Zerstörer, der nach dem Verschlingen verlangt."
  },
  Event_69815_Name = {
    Text = "Blutige Pfütze"
  },
  Event_69816_ChoiceDesc1 = {
    Text = "[Rufen des Erweckers]zieht 100 Wahnsinn von allen Erweckern ab, entfernt 1 Symptomkarte"
  },
  Event_69816_ChoiceDesc2 = {
    Text = "[Blutbecken aufnehmen]Erhöhe Arg1 maximale Gesundheit, infiziere 2 Karten „(Skill.Arg2)“"
  },
  Event_69816_ChoiceDesc3 = {
    Text = "[Silberschlüssel einsetzen]alle s-Energie leeren"
  },
  Event_69816_Desc = {
    Text = "Die Autorität des Lebens erscheint in der Form des Todes im ursprünglichen Auge. In dem Moment, in dem du diesen schattenhaften Ort betrittst, zeigt sich der stinkende Blutsee sofort in seiner wahren Gestalt. \nDie tiefschwarzen Blutschleifen strecken unzählige Arme aus, krallen sich an deinen Knöcheln und ziehen unaufhörlich nach oben, um dich in den unberechenbaren Abgrund zu ziehen."
  },
  Event_69816_Name = {
    Text = "Blutige Pfütze"
  },
  Event_6981_ChoiceDesc1 = {
    Text = "[Schlüssel aufheben]"
  },
  Event_6981_Desc = {
    Text = "Ein rostiger Schlüsselbund. Kann zum Öffnen von Schlössern verwendet werden"
  },
  Event_6981_Name = {
    Text = "Rostiger Schlüssel"
  },
  Event_6982_ChoiceDesc1 = {
    Text = "[Verlassen]Wähle 1 Befehlskarte zum Kopieren, infiziere“(Skill.Arg1)“"
  },
  Event_6982_Desc = {
    Text = "Unter dem Lied und der Anleitung von Celeste blickst du in die tiefe, lichtlose Schiffsmitte - liegt eure Lebensenergie in dieser grenzenlosen Dunkelheit?"
  },
  Event_6982_Name = {
    Text = "Schiffslied"
  },
  Event_6983_ChoiceDesc1 = {
    Text = "[Gemeinsam gehen]Erwirbt ein Silberrelikt „(RelicConfig.Arg1)“"
  },
  Event_6983_ChoiceDesc2 = {
    Text = "[Weigere dich zu gehen] erhält +75 das schwarze Siegel, Infektion „(Skill.Arg2)“"
  },
  Event_6983_Desc = {
    Text = "Ist es eine Halluzination? Du siehst Krähen am Himmel kreisen und ein bekanntes Lied singen:\n“Dann lass uns zusammen gehen, du und ich\nWenn die Nacht gerade hereinbricht\nWie ein sterbender Trunkenbold, der auf der Straße liegt“"
  },
  Event_6983_Name = {
    Text = "Rabenstimme"
  },
  Event_6984_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6984_Desc = {
    Text = "Die Rückverfolgungskraft kann für kurze Zeit keinen Verbindungspunkt für dich finden, doch du hast zumindest vorübergehende Trost gefunden"
  },
  Event_6984_Name = {
    Text = "Abnormale Verbindung"
  },
  Event_6985_ChoiceDesc1 = {
    Text = "[In die Spirale fallen]In die Tiefe der Spirale blicken"
  },
  Event_6985_ChoiceDesc2 = {
    Text = "[Zieh dich zurück] erhält +25 das schwarze Siegel"
  },
  Event_6985_Desc = {
    Text = "Draußen am Fenster war das Meer nicht mehr zu sehen.\nDas Glas spiegelte dein blasses Gesicht wider, und in deinen Schülern spiegelte „du“ auch in das Fenster.\nDie Realität und der Bereich überlappen, verflechten sich und verdrehen sich schließlich zu einer mehrdimensionalen Spirale"
  },
  Event_6985_Name = {
    Text = "Spiralabgrund"
  },
  Event_6986_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6986_Desc = {
    Text = "Du nimmst den Kontakt der Schule an, die vertraute Stimme beruhigt dich. Du sammelst dich und gehst weiter"
  },
  Event_6986_Name = {
    Text = "Kontaktstelle"
  },
  Event_6987_ChoiceDesc1 = {
    Text = "[Zustimmen]"
  },
  Event_6987_ChoiceDesc2 = {Text = "[Ablehnen]"},
  Event_6987_ChoiceDesc3 = {
    Text = "[Keine Meinung]"
  },
  Event_6987_Desc = {
    Text = "“Lange nicht gesehen, Freunde.“ Ihr habt euch aus dem Kampf mit den Laternenträgern befreit und erhaltet einen kurzen Moment zum Durchatmen, als ihr plötzlich den langhaarigen Mann wieder am Straßenrand seht, der euch lächelnd begrüßt, als wäre der Kampf gerade nie passiert. \n“Im Vergleich zu unserem letzten Treffen ist der Geruch von Kerberos an dir viel intensiver geworden. In dieser Zeit bist du sicher weit gereist, oder?“\n"
  },
  Event_6987_Name = {
    Text = "Seltsamer Begleiter V"
  },
  Event_6988_ChoiceDesc1 = {
    Text = "[Ihn nach dem Weg fragen] Wähle 1 von 3 Befehlskarten aus, die das Gebet erhält: „(EnchantConfig.Arg1)\", infiziert „(Skill.Arg2)\""
  },
  Event_6988_ChoiceDesc2 = {
    Text = "[Es verlassen] Wähle 1 von 3 Befehlskarten aus, die das Gebet erhält: „(EnchantConfig.Arg1)\", infiziert „(Skill.Arg2)\""
  },
  Event_6988_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte 25 schwarze Siegel"
  },
  Event_6988_Desc = {
    Text = "Der Schatten steht unter der schmalen Straßenlaterne. \n “Darf ich bitte ein Feuer leihen, mein Herr?“ \n Du hast nicht die Gewohnheit, @2 zu benutzen, aber du hast nichts dagegen, ein wenig “Magie“ einzusetzen. \n Mit deiner Hilfe wird der entzündete @2 in den bodenlosen schwarzen Wirbel hineingestoßen. \n Nach einer Weile siehst du weißen Rauch aufsteigen. \n “Ah—“ \n Der Schatten gibt ein erfreutes Seufzen von sich."
  },
  Event_6988_Name = {
    Text = "Die Silhouette unter der Straßenlaterne"
  },
  Event_6989_ChoiceDesc1 = {
    Text = "[Bestätigen]"
  },
  Event_6989_Desc = {
    Text = "Auf dem Schachbrett ist das Gesehene nicht die Wahrheit.\n\nWas dich aufhält, sind vielleicht nicht die Wände, sondern deine erschöpfte Neugier."
  },
  Event_6989_Name = {
    Text = "Phantomraum"
  },
  Event_6990_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6990_Desc = {
    Text = "“Es tut so weh, so weh... Schwester Sasha...“\nDu schaust zu Sarah, die nervös die beiden Kinder beschützt, als hätte sie nichts gehört.\nDie Stimme verblasste allmählich"
  },
  Event_6990_Name = {
    Text = "“Sasa-Schwester“"
  },
  Event_6991_ChoiceDesc1 = {
    Text = "[Verlassen]Erhalte 25 schwarze Siegel"
  },
  Event_6991_Desc = {
    Text = "Du stehst auf und applaudierst dem Jungen. \nEr scheint deinen Zuspruch zu spüren und streckt stolz seine kleine Brust. \nSchwarzes Blut strömt aus seinem Mund, aber es kann den Gesang nicht mehr stoppen"
  },
  Event_6991_Name = {
    Text = "Abschlusszeremonie IV"
  },
  Event_6992_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6992_Desc = {
    Text = "Ein Teil der Trauer verdampft, aber die Tränen fließen unaufhörlich in die mystische Vergangenheit."
  },
  Event_6992_Name = {
    Text = "Tränen des Seelenstrandes"
  },
  Event_6993_ChoiceDesc1 = {
    Text = "[Sängerin am Hals packen]infiziere „(Skill.Arg1)“, erhalte verfluchtes Relikt „(RelicConfig.Arg2)“"
  },
  Event_6993_ChoiceDesc2 = {
    Text = "[Hindernis für die Tänzerfüße]Infektion zweimal“(Skill.Arg1)“, erhalte ein silbernes Relikt:“(RelicConfig.Arg2)“und“(RelicConfig.Arg3)“"
  },
  Event_6993_ChoiceDesc3 = {
    Text = "[Umweg verlassen]Erhalte ein silbernes Relikt:“(RelicConfig.Arg1)“"
  },
  Event_6993_Desc = {
    Text = "Drei klebrige Gestalten versperren dir den Weg. \n Eine Gestalt singt ein Lied, die Stimme heiser, die Texte seltsam, du hältst dir die Ohren zu und umgehst sie. \n Eine Gestalt tanzt, die Bewegungen steif, die Schritte unsicher, du schließt die Augen und weicht ihr aus. \n Eine Gestalt rezitiert Gedichte, der Rhythmus zerbrochen, die Sätze unverständlich, du kannst es nicht mehr ertragen, also—"
  },
  Event_6993_Name = {
    Text = "Schurke auf dem schmalen Pfad"
  },
  Event_6994_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_6994_Desc = {
    Text = "Ein Teil der Wut kochte, aber die Tränen flossen unaufhörlich in die unbekannte Vergangenheit"
  },
  Event_6994_Name = {
    Text = "Tränen des Seelenstrandes"
  },
  Event_6995_ChoiceDesc1 = {
    Text = "[Ignorieren]Infektion“(Skill.Arg1)“"
  },
  Event_6995_ChoiceDesc2 = {
    Text = "[Dreh dich um und verlasse]Wache zufällig 1 Erwecker auf"
  },
  Event_6995_Desc = {
    Text = "Das grausame Schicksal kriecht unter den Füßen des Wanderers, der Weg ist so glatt wie ein klarer Spiegel, und hinter dir ertönt ein leises Zerbrechen. \n Wer hat das Schicksal unter deinen Füßen zertrampelt? Ist es Illusion, ist es eine Falle, oder einfach nur Gemurmel, ist es eine Lüge... \n Vor deinen Augen entsteht ein langsam kriechender Riss. \n <Italic:Als ob es für das Erwachen der Gnosis untergehen würde.>"
  },
  Event_6995_Name = {
    Text = "Kriechender Riss"
  },
  Event_6996_ChoiceDesc1 = {
    Text = "[Durchführen der Prüfung]Infiziere „(Skill.Arg1)“, gewinne 1 goldenes Relikt bei Sieg, erhalte 50 das schwarze Siegel bei Niederlage"
  },
  Event_6996_ChoiceDesc2 = {
    Text = "[Verlassen]Erhalte 50 schwarze Siegel"
  },
  Event_6996_Desc = {
    Text = "Du hast einige Geheimnisse in der spiegelnden schwarzen Flüssigkeit unter dir gesehen.\nIhr verschwommenes Spiegelbild ist von schwarzem Rauch umgeben, es kommt dir bekannt vor, aber du kannst es nicht identifizieren"
  },
  Event_6996_Name = {
    Text = "Spiegel darunter"
  },
  Event_6997_ChoiceDesc1 = {
    Text = "[Miau nachahmen]50% Chance, 125 das schwarze Siegel zu erhalten, 50% Chance, Infektion „(Skill.Arg2)“"
  },
  Event_6997_ChoiceDesc2 = {
    Text = "[Füttere mit Nahrung] 75% Chance auf 100 das schwarze Siegel, 25% Chance Infektion „(Skill.Arg2)“"
  },
  Event_6997_ChoiceDesc3 = {
    Text = "[Schnapp dir und lauf] erhält +50 das schwarze Siegel"
  },
  Event_6997_Desc = {
    Text = "Du bist in das Revier der schwarzen Katze geraten. \n Unzählige Augen öffnen sich plötzlich in der Dunkelheit, voller Neugier, Misstrauen, Wachsamkeit... nur ohne Freundlichkeit. \n Smaragdgrün, Bernsteinfarben, Pfauenblau... \n Du fühlst dich, als wärst du in einem leuchtenden Meer aus Edelsteinen. \n Um zu entkommen, du——"
  },
  Event_6997_Name = {
    Text = "Katzenstadt"
  },
  Event_6998_ChoiceDesc1 = {
    Text = "[Über Narzisse] erhält zufällig 2 Befehlskarten mit jeweils Orison: „(EnchantConfig.Arg1)“, „(EnchantConfig.Arg2)“"
  },
  Event_6998_ChoiceDesc2 = {
    Text = "[Über den Höllenhund] erhält verfluchtes Relikt „(RelicConfig.Arg1)“"
  },
  Event_6998_ChoiceDesc3 = {
    Text = "[Über Lily]Infiziere “(Skill.Arg1)“"
  },
  Event_6998_Desc = {
    Text = "“Hier ist Dafdels Hinweiszeit.“"
  },
  Event_6998_Name = {
    Text = "Hinweiszeit"
  },
  Event_6999_ChoiceDesc1 = {
    Text = "[Lass den Zeiger sein]erhalte ein goldenes Relikt“(RelicConfig.Arg1)“，infiziere“(Skill.Arg2)“"
  },
  Event_6999_ChoiceDesc2 = {
    Text = "[Drücke den Zeiger]erhalte ein goldenes Relikt“(RelicConfig.Arg1)“，infiziere“(Skill.Arg2)“"
  },
  Event_6999_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte 50 schwarze Siegel"
  },
  Event_6999_Desc = {
    Text = "Knack, Knack, Knack—\nDas Schicksalsrad drehte sich langsam, das kalte Klicken eines Mechanismus schob sich gnadenlos in die Richtung, die du am meisten fürchtest"
  },
  Event_6999_Name = {
    Text = "Nadelende außerhalb"
  },
  Event_7000_ChoiceDesc1 = {
    Text = "[Nicht hören]Zufällig 3 Befehlskarten aus dem Deck ziehen, wähle 1 Karte zur Löschung und erhalte 75 schwarze Siegel"
  },
  Event_7000_ChoiceDesc2 = {
    Text = "[Vorsichtig überprüfen]Erhalte zufällig 3 Befehlskarten aus dem Deck, wähle eine Karte aus, kopiere sie und füge sie ins Deck ein, erhalte 25 schwarze Siegel"
  },
  Event_7000_ChoiceDesc3 = {
    Text = "[Dreh dich um und verlasse]Erhalte 50 schwarze Siegel"
  },
  Event_7000_Desc = {
    Text = "Das grausame Schicksal kriecht unter den Füßen des Wanderers, der Weg ist so glatt wie ein klarer Spiegel, und hinter dir ertönt ein leises Zerbrechen. \n Wer hat das Schicksal unter deinen Füßen zertrampelt? Ist es Illusion, ist es eine Falle, oder einfach nur Gemurmel, ist es eine Lüge... \n Vor deinen Augen entsteht ein langsam kriechender Riss."
  },
  Event_7000_Name = {
    Text = "Kriechender Riss"
  },
  Event_7001_ChoiceDesc1 = {
    Text = "[Rufen der Krähe]erhält 25 das schwarze Siegel, infiziert „(Skill.Arg2)“, weiter wählen"
  },
  Event_7001_ChoiceDesc2 = {
    Text = "[Weit weg gehen]"
  },
  Event_7001_Desc = {
    Text = "Die Klaue durchdringt den Umhang und gräbt sich tief in die Schulter"
  },
  Event_7001_Name = {
    Text = "Aussätzige Krähe"
  },
  Event_7002_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7002_Desc = {
    Text = "Manchmal kommt die Angst nicht von einem Wesen.\nWo der „Höllenhund“ vorbeigeht, bleiben rote Tropfen zurück, die dein Spiegelbild zeigen"
  },
  Event_7002_Name = {
    Text = "unsichtbares Spiegelbild"
  },
  Event_7003_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7003_Desc = {
    Text = "Begleitet von einem schwachen Strom hörst du das Flüstern einer Frau. \n Sie weint und erzählt unaufhörlich von ihren Erlebnissen. \n Eine Stunde vergeht, ein Tag vergeht... bis du längst vergessen hast, warum sie traurig ist. \n Schließlich legt sie fröhlich auf und verspricht dir ein großes Geschenk. \n Du nimmst das Geschenk an. Wie auch immer, Geschenke sind immer erfreulich."
  },
  Event_7003_Name = {
    Text = "Bitte rangehen"
  },
  Event_7004_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7004_Desc = {
    Text = "Du kniest mit einem Knie auf dem Boden und senkst den Kopf, während deine Partner dich ungläubig ansehen, und legst die rechte Hand zur Faust geballt auf deine Stirn. \n Sehr gut, so kannst du dein Gesicht perfekt verbergen."
  },
  Event_7004_Name = {
    Text = "Täuschend echt"
  },
  Event_7005_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7005_Desc = {
    Text = "“Du hast mir den Schleier angelegt.“\nDie Wachsfigur lächelt dich ruhig an. \n“Ich werde dir die Wahrheit schenken, als Belohnung für deine harte Arbeit.“\nIhr Bauch fließt ständig mit schwarzem Schleim, der dich fest umhüllt. \nDie Welt ist pechschwarz, aber unglaublich warm. \nDu kuschelst dich zusammen und gähnst, zum @1. Mal trittst du in den Traum ein..."
  },
  Event_7005_Name = {
    Text = "Unfertige Wachsfigur"
  },
  Event_7006_ChoiceDesc1 = {
    Text = "[Bestätigen]"
  },
  Event_7006_Desc = {
    Text = "Du hast im Nebel nichts gefunden"
  },
  Event_7006_Name = {Text = "Chaosnebel"},
  Event_7007_ChoiceDesc1 = {
    Text = "[Anruf entgegennehmen]erhalte 3 wähle 1 fortgeschrittenes Gebet"
  },
  Event_7007_ChoiceDesc2 = {
    Text = "[Ignoriere den Klang]Erhalte ein goldenes Relikt „(RelicConfig.Arg1)“, infiziere „(Skill.Arg2)“"
  },
  Event_7007_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte 50 schwarze Siegel"
  },
  Event_7007_Desc = {
    Text = "“Klingeling...“\nEin schrilles Telefonklingeln ertönt aus der Ecke, laut und hektisch, immer lauter, fast so, als würde es explodieren und die Welt zerstören, wenn du nicht rangehst"
  },
  Event_7007_Name = {
    Text = "Bitte rangehen"
  },
  Event_7008_ChoiceDesc1 = {
    Text = "[nähe Phantasma]Erhalte 3 wählbare Silberrelikte"
  },
  Event_7008_ChoiceDesc2 = {
    Text = "[Zerstreuendes Phantasma] erhält Silberrelikt „(RelicConfig.Arg1)“ „(RelicConfig.Arg2)“, Infektion zweimal „(Skill.Arg3)“"
  },
  Event_7008_Desc = {
    Text = "Ist es die Fata Morgana im Geheimgang? Oder eine weitere Erinnerung, die nicht loszulassen ist? \n Du reibst dir die Augen, während die Illusion in der Ferne näher kommt - es ist ein lebhafter Markt, das Wachsfigurenmuseum, das in der Auflösung verschwunden ist, die Nervenheilanstalt in einem schneebedeckten Städtchen, oder Akute, dessen Landschaft bereits verschwommen ist?"
  },
  Event_7008_Name = {
    Text = "Fata Morgana"
  },
  Event_7009_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7009_Desc = {
    Text = "Es ist, als ob du mit kochendem Wasser verbrüht wurdest, reflexartig hältst du dir die Ohren zu und schließt die bösen Klänge aus."
  },
  Event_7009_Name = {
    Text = "Verbotene Klangfarbe"
  },
  Event_7010_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7010_Desc = {
    Text = "Helle Dur-Töne vertrieben die Anspannung und Angst. Du warst voller Leidenschaft, in voller Blüte, voller Freude und hast Ramona weit hinter dir gelassen – „Geheimnishüter?! Geh nicht so schnell!“"
  },
  Event_7010_Name = {
    Text = "Unbekannter Ton"
  },
  Event_7011_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7011_Desc = {
    Text = "“Halt an!!! Selbst kriechende, ätzende Monster kennen ihre Gliedmaßen besser als du!“\nLass die Zuschauer in Ruhe...\nDu betest im Stillen"
  },
  Event_7011_Name = {
    Text = "Schurke auf dem schmalen Pfad"
  },
  Event_7012_ChoiceDesc1 = {
    Text = "[Sich zurückziehen]"
  },
  Event_7012_Desc = {
    Text = "Das ist nur ein Bereich.\nWas du schützen und wovor du fliehen willst, ist eine einzigartige Realität"
  },
  Event_7012_Name = {
    Text = "Spiralabgrund"
  },
  Event_7013_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7013_Desc = {
    Text = "“Du bist der Hassenswerteste.“\nDu reißt das Manuskript in Stücke und wirfst es in den Wind, es zerfällt in fliegende Flocken.\nDer Dichter schaut nach oben, während die Zeichen im Wind wirbeln, sein Mundwinkel zeichnet sich mit einem besessenen Bogen ab.\n„So schön...“"
  },
  Event_7013_Name = {
    Text = "Schurke auf dem schmalen Pfad"
  },
  Event_7014_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7014_Desc = {
    Text = "Du hast das Plakat komplett abgerissen und festgestellt, dass auf der Rückseite hastig die Ausgaben des Wachsfigurenkabinetts festgehalten sind. \n Der Besitzer der Schrift hat offensichtlich keine Geduld oder Begabung für Mathematik, diese Rechnungen lassen sich einfach nicht ausgleichen. \n Du hast kurz einen Blick darauf geworfen, die größte Ausgabe scheint die “Pflege und Reinigung der Wachsfiguren“ zu sein. \n Die Personalkosten sind hingegen armselig gering, die letzte Ausgabe sind 12 Pferdehaarbürsten, deren Preis ungefähr 20 Lavka beträgt. \n Außerdem gibt es eine spezielle Ausgabe – “ihr Futter“. \n Wer sind “sie“?"
  },
  Event_7014_Name = {
    Text = "Lachen in der Dunkelheit"
  },
  Event_7015_ChoiceDesc1 = {
    Text = "[Verlassen]Erhalte Silberrelikt“(RelicConfig.Arg1)“，infiziere“(Skill.Arg2)“"
  },
  Event_7015_Desc = {
    Text = "“Schlau... und die richtige Antwort.“\nDie Stimme klang interessiert, ein silbernes Objekt wurde aus dem Wasser geworfen.\n“Denke daran, alles hat seinen Preis.“"
  },
  Event_7015_Name = {
    Text = "Stimmen aus dem Jenseits"
  },
  Event_7016_ChoiceDesc1 = {
    Text = "[Fange den zweiten Schmetterling] lösche 1 Befehlskarte, erhalte Arg1 das schwarze Siegel"
  },
  Event_7016_ChoiceDesc2 = {
    Text = "[Nicht mehr verweilen]"
  },
  Event_7016_Desc = {
    Text = "Sind sie Bewohner der Geisterdimension? Oder Leben, die aus der Selbstauflösung geboren wurden?\nMit diesem Zweifel gehst du in einen Sturm von Schmetterlingen"
  },
  Event_7016_Name = {
    Text = "Geistessturm"
  },
  Event_7017_ChoiceDesc1 = {
    Text = "[Beobachte den dritten Schmetterling]Entferne eine Befehlskarte und erhalte Arg1 schwarze Siegel"
  },
  Event_7017_ChoiceDesc2 = {
    Text = "[Nicht mehr verweilen]"
  },
  Event_7017_Desc = {
    Text = "Schmerz in den Fingern, du lässt plötzlich los"
  },
  Event_7017_Name = {
    Text = "Geistessturm"
  },
  Event_7018_ChoiceDesc1 = {
    Text = "[Verlassen]Erhalte 25 schwarze Siegel, infiziere“(Skill.Arg1)“"
  },
  Event_7018_Desc = {
    Text = "“Habt ihr Menschen keine anderen Antworten mehr?“\nDer Besitzer der Stimme knurrte ungeduldig, und der ganze Raum bebte.\n“Gierig und unwissend... das ist der Grund, warum ich euch verachte.“"
  },
  Event_7018_Name = {
    Text = "Stimmen aus dem Jenseits"
  },
  Event_7019_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7019_Desc = {
    Text = "“Keine Sorge, ich habe dem gierigen Gast nur eine kleine Strafe gegeben. Was soll ich sagen, ich mag kein Bier~“"
  },
  Event_7019_Name = {
    Text = "Erinnerungsfragment: Bier"
  },
  Event_7020_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7020_Desc = {
    Text = "“Hör auf zu singen—“\nDu warnst den unmusikalischen Sänger, deine Ohren nicht weiter zu quälen"
  },
  Event_7020_Name = {
    Text = "Schurke auf dem schmalen Pfad"
  },
  Event_7021_ChoiceDesc1 = {
    Text = "[Verlassen]Wähle zwei Erwecker"
  },
  Event_7021_Desc = {
    Text = "Du drehst dich um und verlässt den langen Flur. \nDie endlosen Korridore rauben dir fast die Geduld, bis du eine kleine, verfallene Bühne entdeckst.\nDu blinzelst, und die Bühne ist verschwunden"
  },
  Event_7021_Name = {
    Text = "Abschlusszeremonie II"
  },
  Event_7022_ChoiceDesc1 = {
    Text = "[Glas aufheben]Spezialkarte erhalten"
  },
  Event_7022_Desc = {
    Text = "Ein Glas klarer, goldenfarbener Flüssigkeit, das wie die goldenen Wellen des spätherbstlichen Weizens schimmert und einen süßen, honigartigen Duft verströmt. Was sind die Zutaten? Wer hat es hier platziert? Warum kümmert sich niemand darum?\nBevor diese Fragen beantwortet werden, schleicht ein geheimnisvoller Gedanke in deinen Kopf: Du musst es sofort, jetzt sofort trinken.\nIn diesem Moment verwandelst du dich plötzlich in eine von Flammen verzauberte Motte, in ein Insekt, das von einer Kannenpflanze gefangen wird, und greifst unkontrolliert nach dem Glas süßen Weins —"
  },
  Event_7022_Name = {Text = "Honigwein"},
  Event_7023_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7023_Desc = {
    Text = "Du versuchst, die Tür zu untersuchen, aber sie verschwindet bei der Berührung, und in der Ferne hörst du ein Geräusch, als würde etwas geöffnet"
  },
  Event_7023_Name = {
    Text = "Seltsame Tür"
  },
  Event_7024_ChoiceDesc1 = {
    Text = "[Keine Aktion]"
  },
  Event_7024_ChoiceDesc2 = {
    Text = "[Handabdruck wegwischen]"
  },
  Event_7024_Desc = {
    Text = "Franz' Büro ist kalt und ordentlich, was die Sorgfalt des Besitzers widerspiegelt. \n In der Ecke der Box entdeckst du einen 5 Zoll großen Staubabdruck. \n Die Form des Handabdrucks ist seltsam – der äußere Rand ähnelt dem Pfotenabdruck eines Biestes, während in der Mitte der Handabdruck eines kleinen menschlichen Mädchens eingearbeitet ist. Es scheint, als wäre zuerst der Handabdruck des Menschen hinterlassen worden, dann hätte die riesige Pfote des Biestes darüber gelegt. \n Du kannst dir natürlich ein herzergreifendes Bild vorstellen, in dem ein gezähmtes, gehorsames Biest seine Krallen sanft auf den Handrücken des Mädchens legt, um Trost zu spenden. \n Aber du kennst die Wahrheit – es ist der Abdruck eines Monsters, das durch grausame Experimente fusioniert wurde."
  },
  Event_7024_Name = {
    Text = "Riesentierfährte"
  },
  Event_7025_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7025_Desc = {
    Text = "Die wandernden Versuchskörper haben dich erschöpft, eine kurze Pause fühlt sich an wie Regen in der Wüste"
  },
  Event_7025_Name = {
    Text = "unendliches Tor"
  },
  Event_7026_ChoiceDesc1 = {
    Text = "[Herr]Erhalte ein verfluchtes Relikt „(RelicConfig.Arg1)“, infiziere „(Skill.Arg2)“"
  },
  Event_7026_ChoiceDesc2 = {
    Text = "[Es fortnehmen] Wähle 1 von 3 Befehlskarten aus, um das Gebet zu erhalten: [(EnchantConfig.Arg1)]"
  },
  Event_7026_ChoiceDesc3 = {
    Text = "[Öffne es] erhält +50 das schwarze Siegel"
  },
  Event_7026_Desc = {
    Text = "Du gehst voran und trittst gegen etwas.\nEs ist ein Kompass, die Glasschicht ist zerbrochen, die restlichen Teile sind mit D-Schleim beschmutzt, du drehst ihn vorsichtig um und siehst vage das Wappen der Mythag Universität auf der Rückseite"
  },
  Event_7026_Name = {Text = "Ihre Wahl"},
  Event_7027_ChoiceDesc1 = {
    Text = "[Lesen des Briefes]Entferne eine Befehlskarte, erhalte Arg1 das schwarze Siegel"
  },
  Event_7027_ChoiceDesc2 = {
    Text = "[Schließe die Kiste]"
  },
  Event_7027_Desc = {
    Text = "Ein Brief, ein Brief, noch ein Brief.\nDie Seiten sind mit deiner Vergangenheit und deiner Zukunft beschrieben. Von seltsamer Verlockung getrieben, zerreißt und verschlingst du die Seiten.\n“Hey? Was machst du da? Luft trinken?“\nMurphy tritt dich aus der Halluzination, und vor dir ist nichts"
  },
  Event_7027_Name = {
    Text = "Ungebetener Brief"
  },
  Event_7028_ChoiceDesc1 = {
    Text = "[Verlassen]Erhalte eine Auswahl von 3 für 1 Gebet"
  },
  Event_7028_Desc = {
    Text = "Als die Silhouette deine Stimme hört, bleibt sie stehen; Clementines Stimme dringt kaum durch den dichten Nebel.\n„Oh – du bist es \", sagt sie, undeutlich und verschwommen, wie Mondlicht, das sich im Wasser auflöst. „Keine Sorge, dir wird es gut gehen\"– ein schöner Gedanke, aber schwer zu glauben.\n„Wenn du hier fertig bist, werden wir uns wiedersehen.\""
  },
  Event_7028_Name = {
    Text = "Gestalt im Nebel"
  },
  Event_7029_ChoiceDesc1 = {
    Text = "[Empfänger: Akademisches Büro]erhalte ein Silberrelikt“(RelicConfig.Arg1)“"
  },
  Event_7029_ChoiceDesc2 = {
    Text = "[Empfänger: Partner]erhalte ein Silberrelikt“(RelicConfig.Arg1)“"
  },
  Event_7029_Desc = {
    Text = "Beim Schreiben des Empfängers stieg Rauch aus dem Briefpapier auf. Eine unsichtbare Hand griff durch den Raum und riss das Papier aus deiner Hand—\nMit einem Geräusch wie Kauen wurde dein Körper plötzlich schwer.\nAber das Artefakt in deiner Hand zeigt, dass diese Reise nicht umsonst war"
  },
  Event_7029_Name = {
    Text = "Einfache Konfession"
  },
  Event_7030_ChoiceDesc1 = {
    Text = "[Silberschlüssel einstecken]"
  },
  Event_7030_Desc = {
    Text = "Im gesättigten D-Schleim scheint eine gewisse Substanz verborgen zu sein... Beobachte sie mit dem Silberschlüssel und verwandle sie in deine eigene Macht"
  },
  Event_7030_Name = {
    Text = "Ausgangspunkt"
  },
  Event_7031_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7031_Desc = {
    Text = "Warte, bis sie aus dem Schatten treten"
  },
  Event_7031_Name = {
    Text = "Laternenschwarzer Rabe"
  },
  Event_7032_ChoiceDesc1 = {
    Text = "[Rufen der Krähe]erhält 35 das schwarze Siegel, infiziert „(Skill.Arg2)“, weiter wählen"
  },
  Event_7032_ChoiceDesc2 = {
    Text = "[Weit weg gehen]"
  },
  Event_7032_Desc = {
    Text = "Schwarze Vögel werden gerufen, ihre Körper schwellen an und sie spucken etwas in deine Hand.\nSie kehren zum Mast zurück und starren dich an, ihre Augen brennen"
  },
  Event_7032_Name = {
    Text = "Aussätzige Krähe"
  },
  Event_7033_ChoiceDesc1 = {
    Text = "[Höhle betreten]"
  },
  Event_7033_ChoiceDesc2 = {
    Text = "[Verlassen]"
  },
  Event_7033_Desc = {
    Text = "“Hust, hust...“\nSo vertraut... ich erinnere mich! \nMenschen machen solche Geräusche, wenn sie krank oder sterbend sind! \nSchnell, schau nach!"
  },
  Event_7033_Name = {
    Text = "Tiefe der Höhle"
  },
  Event_7034_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7034_Desc = {
    Text = "Du hast alles über Silberkerne gelernt, einschließlich wie man ihre Qualität bestimmt. \n Offensichtlich erfüllen diese Silberkerne nicht die grundlegenden Anforderungen an die Raffination. \n Du musstest sie aufgeben, sowie die zerbrochenen Seelen, die möglicherweise darin gefangen sind. \n Das Lernen, loszulassen, ist ebenfalls eine Pflichtlektion für den Hüter."
  },
  Event_7034_Name = {
    Text = "Gebundene Seele"
  },
  Event_7035_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7035_Desc = {
    Text = "Das ist ein einseitiger Durchgang, durch den du nicht zurück zum Eingang gelangen kannst"
  },
  Event_7035_Name = {Text = "Durchgang"},
  Event_7036_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7036_Desc = {
    Text = "Je früher es endet, desto besser. Missagas Ermittler fürchten keine Gefahr"
  },
  Event_7036_Name = {
    Text = "unendliches Tor"
  },
  Event_7037_ChoiceDesc1 = {
    Text = "[Bitte, mach Platz, ich habe es eilig]"
  },
  Event_7037_ChoiceDesc2 = {
    Text = "[Erzählen Sie mehr]"
  },
  Event_7037_Desc = {
    Text = "“Entschuldigung, dürft ihr kurz anhalten? Ich sehe, dass ihr ernst schaut und in Eile seid, vielleicht seid ihr in Schwierigkeiten geraten. \n Aber das Leben sollte nicht aufgrund der aktuellen Probleme den Gesamtblick und einen kühlen Kopf aufgeben. \n Zum Beispiel habe ich in den letzten Tagen ernsthaft darüber nachgedacht, dass es in der Legende von Kerberos viele Punkte gibt, die nicht mit der gegenwärtigen Situation übereinstimmen.“"
  },
  Event_7037_Name = {
    Text = "Seltsamer Begleiter II"
  },
  Event_7038_ChoiceDesc1 = {
    Text = "[Geschenk annehmen]"
  },
  Event_7038_ChoiceDesc2 = {
    Text = "[Höflich ablehnen]"
  },
  Event_7038_Desc = {
    Text = "Der Junge sitzt auf der Fensterbank und schaut dich an. Er hat lange auf dich gewartet. \n “Die Aufführung war ein Erfolg, d-danke.“ \n “Ich werde jetzt gehen... Das ist ein Geschenk für dich.“ \n Der Junge hält dir seine Hand entgegen. \n Du siehst eine wunderschön verpackte Schachtel, aus der Blut fließt und die Hände des Jungen rot färbt."
  },
  Event_7038_Name = {
    Text = "Abschlusszeremonie VI"
  },
  Event_7039_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7039_Desc = {
    Text = "Hoffentlich hast du immer dieses Selbstvertrauen"
  },
  Event_7039_Name = {
    Text = "unsichtbares Spiegelbild"
  },
  Event_7040_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7040_Desc = {
    Text = "Du hast dieses kleine, weiche Ohr angenommen. \n Es ist in zähem Wachs eingewickelt und liegt ruhig in deiner Handfläche. \n In deinem Inneren steigt ein starkes Gefühl der Verantwortung auf. \n Zunächst darf man die Bar nicht einfach betreten, die Musik dort ist zu schmutzig. \n Außerdem darf man das Wellington Garden Theatre nicht besuchen, das Orchester dort ist schon völlig veraltet. \n Dann... \n Du und deine Begleiter akzeptiert gut die Tatsache, ein weiteres kleines Haustier zu haben."
  },
  Event_7040_Name = {Text = "Lausch"},
  Event_7041_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7041_Desc = {
    Text = "“Professor Alistair ist der Grundpfeiler von Misaq; ohne ihn wird das gesamte System von Misaq zum Stillstand kommen.“\n Du erinnerst dich vage an eine dieser einschläfernden Vorlesungen, in der Czort mit einem verkniffenen Gesicht an die Tafel klopfte und diesen Satz sagte.\n Wenn dieser Grundpfeiler in Scherben zerbricht, wie wirst du dann dastehen? Eine große Angst umhüllte dich. \n “Wohin willst du gehen?“ Der Ruf von Ramona holte dich zurück in die Realität. \n Ist das Vergangenheit oder Zukunft, ist es real oder Vorstellung, oder ist es ein Traum aus einer anderen Dimension? Du weißt es auch nicht mehr. \n In deiner Hand erschien ein “Geschenk“."
  },
  Event_7041_Name = {
    Text = "Chaosgeheul"
  },
  Event_7042_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7042_Desc = {
    Text = "“Dieser Rollstuhl ist meine zweiten Beine, ich werde ihn wohl nie loswerden,“Professor Alistair lächelt bitter,“leider macht er mich viel kleiner.“\n\nAlso kann das nicht der echte Professor Alistair sein"
  },
  Event_7042_Name = {
    Text = "Chaosgeheul"
  },
  Event_7043_ChoiceDesc1 = {
    Text = "[Wer spricht da?] Wähle 1 von 3 Befehlskarten aus, die das Gebet erhält: „(EnchantConfig.Arg1)\", infiziert „(Skill.Arg2)\""
  },
  Event_7043_ChoiceDesc2 = {
    Text = "[Was für ein Whiskey, lass mich auch kosten] Wähle 1 von 3 Befehlskarten aus, die das Gebet erhält: „(EnchantConfig.Arg1)\", infiziert „(Skill.Arg2)\""
  },
  Event_7043_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte 25 schwarze Siegel"
  },
  Event_7043_Desc = {
    Text = "“Willst du wirklich nicht einen Schluck probieren? Das ist schließlich feiner Whiskey. Wäre der Wirt nicht so großzügig gewesen und hätte mir eine ganze Flasche geschenkt, hätte ich dir nicht einmal einen Tropfen gegeben.“\n“Also hast du diesen dürren Typen, dessen Haut wie Gummi gespannt ist und der nur Bloody Marys trinkt, für ihn verscheucht. Das ist die gesamte Belohnung, die dir der Wirt gegeben hat. Für diese Untersuchung hast du einen Monat Zeit aufgewendet, dreißig Haushalte besucht, elf Mal einen Korb bekommen und siebzehn Revolverkugeln verbraucht. Eine Flasche Whiskey, und du hast nicht einmal dein Geld zurückbekommen.“\n“Gut, gut, mach dir nicht so viele Gedanken. Schließlich haben wir jetzt diese Flasche Whiskey, oder?“"
  },
  Event_7043_Name = {
    Text = "Erinnerungsfragment: Whisky"
  },
  Event_7044_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7044_Desc = {
    Text = "Du hältst den Tentakel des Erwachten fest, er schaut dich an, düsteres Licht in seinen Augen.\nEr sagt nichts, aber du verstehst seine versteckte Botschaft: - \"Anmaßung.\""
  },
  Event_7044_Name = {
    Text = "Schmetterlingseffekt"
  },
  Event_7045_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7045_Desc = {
    Text = "Der Telegraf ist völlig zerstört. Du kannst dir die Verzweiflung des Besitzers während des Sturms vorstellen... denn du fühlst sie jetzt auch"
  },
  Event_7045_Name = {
    Text = "Vorherige Hinterlassenschaften"
  },
  Event_7046_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7046_Desc = {
    Text = "Name: Leigh\nAlter: 20\nKomplikationen: Blutdurst mit schwerer Hysterie\nWucherungen: tiefroter Tentakel @2 Mundwerkzeuge\nVerpflanzung: nahe Verwandtschaftsorgane @3\nÜbergab Grund: Es gibt keinen besonderen Grund. Ich mag sie nicht.\n(Der nachfolgende Inhalt wurde durchgestrichen)"
  },
  Event_7046_Name = {
    Text = "Organregistrierung"
  },
  Event_7047_ChoiceDesc1 = {
    Text = "[Wähle „Segen annehmen“]Verliere alle das schwarze Siegel. Erhalte 1 goldenes Relikt"
  },
  Event_7047_Desc = {
    Text = "Ein Klumpen schwarzen Schlamms erscheint vor dir und reicht zitternd ein Dokument. \n “Ich kann jetzt nicht persönlich erscheinen... aber Sie können sich unsere maßgeschneiderten Dienstleistungen ansehen...“ \n Eine weibliche Stimme schwebt aus dem Brustkorb des Schlamms, etwas panisch, als würde sie vor etwas fliehen. \n “Feensegens tritt je nach Mitgliedsstufe in Kraft, garantiert für Jung und Alt.“ \n “Unterschreiben, schnell unterschreiben!“"
  },
  Event_7047_Name = {Text = "Feensegens"},
  Event_7048_ChoiceDesc1 = {
    Text = "[Lauscher] erhält Silberrelikt „(RelicConfig.Arg1)“, Infektion „(Skill.Arg2)“"
  },
  Event_7048_ChoiceDesc2 = {
    Text = "[Vorwärts untersuchen]Alle Erwachten heilen 50 Wahnsinn, Infektion „(Skill.Arg1)“"
  },
  Event_7048_ChoiceDesc3 = {
    Text = "[Direkt gehen]Erhalte 3 Auswahl 1 Orison"
  },
  Event_7048_Desc = {
    Text = "“Weißt du?“Als Ramona nach der mysteriösen Person suchte, ertönte plötzlich eine Stimme, als ob jemand leise tuschelte, “Weißt du von dieser Sache? Von dieser großen Sache?“"
  },
  Event_7048_Name = {
    Text = "Fremde Ohren"
  },
  Event_7049_ChoiceDesc1 = {
    Text = "[Fokus]Entferne bis zu 2 Symptom-Karten"
  },
  Event_7049_ChoiceDesc2 = {
    Text = "[Meditation] wählt 1 Erwecker aus"
  },
  Event_7049_ChoiceDesc3 = {
    Text = "[Verbinden]Arg2 Lebenspunkte heilen"
  },
  Event_7049_Desc = {
    Text = "Du erkundest den Nebel, plötzlich leuchtet das Abzeichen auf deiner Brust schwach silbern. Wer ruft dich am anderen Ende des Kommunikators?"
  },
  Event_7049_Name = {
    Text = "Kontaktstelle"
  },
  Event_7050_ChoiceDesc1 = {
    Text = "[Vorsichtig reagieren]Erhöhe Arg1 Punkte maximale Gesundheit"
  },
  Event_7050_ChoiceDesc2 = {
    Text = "[Entgegentreten] Wähle 1 von 3 Befehlskarten aus, um das Gebet zu erhalten: „(EnchantConfig.Arg1)\", infiziere „(Skill.Arg2)\""
  },
  Event_7050_Desc = {
    Text = "Der durch den Bereich geworfene Schatten streckt seine Hand zu dir aus, schemenhaft.\n Du erinnerst dich, dass einst ein Mythag-Ermittler dieses Schiff bestiegen hat, wäre es er?\n Oder ist das nur eine weitere bedauernswerte Erinnerung, die vom Bereich gefangen gehalten wird?"
  },
  Event_7050_Name = {
    Text = "Silberschlüssler"
  },
  Event_7051_ChoiceDesc1 = {
    Text = "[Verlassen]Erhalte goldenes Relikt“(RelicConfig.Arg1)“，infiziere“(Skill.Arg2)“"
  },
  Event_7051_Desc = {
    Text = "“Sieh mal, wegen meiner Bemerkung hast du die dringlichste Situation ignoriert, das ist nicht gut.\nWenn du weiter zögerst, wird eure Beute entkommen.\nAls Entschuldigung gebe ich euch diese Sachen。“\n\nDer Mann wechselte das Thema und überreichte euch einen Gegenstand"
  },
  Event_7051_Name = {
    Text = "Seltsamer Begleiter II"
  },
  Event_7052_ChoiceDesc1 = {
    Text = "[Verlassen]Wähle eine von 3 Befehlskarten und erhalte ein Gebet:“(EnchantConfig.Arg1)“"
  },
  Event_7052_Desc = {
    Text = "“Ich wünsche dir, dass du bekommst, was du willst.“\nDer Mann macht Platz und lässt einen Weg frei"
  },
  Event_7052_Name = {
    Text = "Seltsamer Begleiter II"
  },
  Event_7053_ChoiceDesc1 = {
    Text = "[Einstecken]"
  },
  Event_7053_Desc = {
    Text = "Eine quecksilberähnliche silberne Substanz, extrahiert aus ätzendem Schleim, enthält starke geistige Energie, hauptsächlich verwendet, um in Ritualen mehr Erwachte zu verbinden"
  },
  Event_7053_Name = {Text = "Silberkern"},
  Event_7054_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7054_Desc = {
    Text = [[
Du bist wieder in eine neue Abzweigung gegangen.
Die Sonne geht wie gewohnt auf, die Menschen sterben wie gewohnt, und du verirrst dich wie gewohnt.
Nichts ist neu]]
  },
  Event_7054_Name = {
    Text = "Labyrinth der Augen"
  },
  Event_7055_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7055_Desc = {
    Text = "Das scheint ein durch Licht gebrochener, verzerrter Schatten zu sein"
  },
  Event_7055_Name = {
    Text = "Fass mit schwimmenden Gegenständen"
  },
  Event_7056_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7056_Desc = {
    Text = "Du drehst dich um und siehst nur ein einsames Paar Schuhe. \n “Entschuldigung, ich habe keine bösen Absichten.“ \n “Wenn du meinen Körper siehst, bitte sag ihm Bescheid, sein treuester Gehgefährte wartet ruhig im Ausstellungsraum 1, Vitrine 45.“ \n “— Denk daran, es ist das Paar aus Rindsleder, nicht aus Ziegenleder.“"
  },
  Event_7056_Name = {
    Text = "Oxford-Schuhe"
  },
  Event_7057_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7057_Desc = {
    Text = "Es muss ein Alumnus sein – du öffnest die Arme, aber was folgt, ist ein durchdringender Schmerz.\nNach dem Schmerz fühlen sich deine Glieder stärker an als je zuvor"
  },
  Event_7057_Name = {
    Text = "Silberschlüssler"
  },
  Event_7058_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7058_Desc = {
    Text = "Du bemerkst, dass der Nebel vor dir sich lichtet\n\nDu fühlst, dass deine Sicht in den kommenden Aktionen schärfer wird"
  },
  Event_7058_Name = {
    Text = "Shura-Probe"
  },
  Event_7059_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7059_Desc = {
    Text = "Das Phantasma nähert sich dir, Erinnerungen kehren plötzlich zurück, und alles um dich herum wird klar"
  },
  Event_7059_Name = {
    Text = "Fata Morgana"
  },
  Event_7060_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7060_Desc = {
    Text = "Sein unbewusstes Sein hat etwas verändert"
  },
  Event_7060_Name = {Text = "Sein Blick"},
  Event_7061_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7061_Desc = {
    Text = "In der aktuellen Krise ist es nicht die Zeit, Silberkerne zu sammeln"
  },
  Event_7061_Name = {
    Text = "Beweis der Existenz"
  },
  Event_7062_ChoiceDesc1 = {
    Text = "[Verlassen]Erhalte eine Auswahl von 3 für 1 Silberrelikt, infiziere“(Skill.Arg1)“"
  },
  Event_7062_Desc = {
    Text = "Die verschwommene Gestalt wird allmählich klarer, es ist kein Fusionsschale und keine Katastrophe, sondern Clementine, die keine Flügel hat und ganz normal aussieht. \n “Wie zufällig, bist du auch hier, um den Mondschein zu bewundern?“ sagt sie lächelnd, und du verspürst einen Schwindel, “In der Nacht mit dichtem Nebel sollte man vorsichtig sein. \n Die kleinen Wesen hier sind nicht gerade ruhig.“"
  },
  Event_7062_Name = {
    Text = "Gestalt im Nebel"
  },
  Event_7063_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7063_Desc = {
    Text = "Mit dem Knall des Gipsblocks auf dem Boden zerbricht ihr Körper. Ein unzufriedenes Heulen erfüllt deinen Kopf, aber zum Glück hast du rechtzeitig gestoppt"
  },
  Event_7063_Name = {
    Text = "Körper vervollständigen"
  },
  Event_7064_ChoiceDesc1 = {
    Text = "[Der Trauer lauschen] Wähle 1 von 3 Befehlskarten aus, um ein Gebet zu erhalten: „(EnchantConfig.Arg1)\", infiziere „(Skill.Arg2)\""
  },
  Event_7064_ChoiceDesc2 = {
    Text = "[Freude hören] für jede aufgewachte Energie mit 50 oder mehr erhält 15 schwarze Siegel"
  },
  Event_7064_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte eine Auswahl von 3 für 1 Gebet"
  },
  Event_7064_Desc = {
    Text = "Sanfte, lyrische, frohe, traurige... Melodien hallen im Bereich, schwer zu erkennen, woher sie stammen.\n Ist das die Sonate, die aus dem Klang des Geisterschiffes fließt, oder ein Mitternachtsrausch, der im Bereich gefangen ist?"
  },
  Event_7064_Name = {
    Text = "Unbekannter Ton"
  },
  Event_7065_ChoiceDesc1 = {
    Text = "[Sie suchen jemanden]Entferne eine Befehlskarte und erhalte 25 das schwarze Siegel"
  },
  Event_7065_ChoiceDesc2 = {
    Text = "[Sie suchen nach einem Gegenstand]Kopiere eine Karte aus dem Deck, infiziere “(Skill.Arg1)“"
  },
  Event_7065_Desc = {
    Text = "Warum sind die Laternenträger plötzlich im Lai-Dorf erschienen? Es gibt zu viele Rätsel hier. \n Der Höllenhund Kerberos, der Direktor des Lai-Irrenhauses Franz, die Bildhauer-Gilde, die Laternenorden... \n Es muss eine Quelle geben, die sie in diesem nicht sehr bevölkerten Dorf zusammengebracht hat. \n Die Schreibmaschine spritzt plötzlich automatisch Tinte, als wolle sie dich dazu bringen, etwas einzugeben."
  },
  Event_7065_Name = {
    Text = "Mysteriöse Eingabemethode"
  },
  Event_7066_ChoiceDesc1 = {
    Text = "[Schließe die Augen]"
  },
  Event_7066_ChoiceDesc2 = {Text = "[Flucht]"},
  Event_7066_Desc = {
    Text = "Die Aufführung endete abrupt. Du schaust dich um und siehst, dass der Raum voller Zuschauer ist.\nSie haben das gleiche Gesicht wie der Junge und starren dich an.\nAh——\nSie öffnen lautlos ihre schwarzen Münder"
  },
  Event_7066_Name = {
    Text = "Abschlusszeremonie V"
  },
  Event_7067_ChoiceDesc1 = {
    Text = "[Heb das Foto auf] wähle 1 von 3 Befehlskarten, um Gebet zu erhalten: „(EnchantConfig.Arg1)“"
  },
  Event_7067_ChoiceDesc2 = {
    Text = "[Überprüfe den Film]Infiziere „(Skill.Arg1)“, tausche das erhaltene Gebet aus Option 1, kann noch einmal verwendet werden"
  },
  Event_7067_Desc = {
    Text = "Du legst den Film unter das schummrige rote Licht, der halbtransparente Träger lässt verschwommen Bilder durchscheinen. \n Hände, Füße, Augen, Innereien... Alles, was du dir an menschlichen Organen vorstellen kannst oder nicht, wurde treu auf dem Film festgehalten. \n Sie wurden sorgfältig gewaschen und angeordnet, so ordentlich wie dein erstes metrisches Gedicht."
  },
  Event_7067_Name = {
    Text = "wie es ist, aufzeichnen"
  },
  Event_7068_ChoiceDesc1 = {
    Text = "[Prinzessin Wache] weckt zufällig 1 Erwecker und infiziert „(Skill.Arg1)“"
  },
  Event_7068_ChoiceDesc2 = {
    Text = "[Denker]Wähle 1 von 3 Befehlskarten und erhalte ein Gebet: „(EnchantConfig.Arg1)“"
  },
  Event_7068_Desc = {
    Text = "“Tock, tock, tock...“\nDie Schritte nähern sich, und es sieht so aus, als würde jemand die Tür des Studios aufstoßen.\nIhr habt keinen Rückzug, nur die dunkle Beleuchtung nutzt, um euch als Wachsskulptur zu tarnen und zu versuchen, diesem prüfenden Blick zu entkommen"
  },
  Event_7068_Name = {
    Text = "Täuschend echt"
  },
  Event_7069_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7069_Desc = {
    Text = "“Wunderbar, wunderbar!“ Die Stimme war voller Freude, “Endlich bist du wie ich, Schwester Sasha!“"
  },
  Event_7069_Name = {
    Text = "“Sasa-Schwester“"
  },
  Event_7070_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7070_Desc = {
    Text = "Vielleicht hat sie jemand hierher geführt.\nDurch deine Erkundungen wird derjenige enthüllt"
  },
  Event_7070_Name = {
    Text = "Mysteriöse Eingabemethode"
  },
  Event_7071_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7071_Desc = {
    Text = "Je früher es endet, desto besser. Missagas Ermittler fürchten keine Gefahr"
  },
  Event_7071_Name = {
    Text = "Endlose Türen"
  },
  Event_7072_ChoiceDesc1 = {
    Text = "[Moral wählen]Heile Arg1 Leben"
  },
  Event_7072_ChoiceDesc2 = {
    Text = "[Leben wählen]Vollständige Heilung, Infektion“(Skill.Arg2)“"
  },
  Event_7072_Desc = {
    Text = "Vielleicht hattest du einst ein Herz aus Gold.\nEs schlug Tag und Nacht, gab alles für dein Leben und deine Existenz... warm, leidenschaftlich und voller Hoffnung.\nAber irgendwann begann es langsamer zu schlagen. Als ob es nur noch eines von beiden ertragen könnte: Leben oder Moral"
  },
  Event_7072_Name = {
    Text = "Fluch der Gier"
  },
  Event_7073_ChoiceDesc1 = {
    Text = "[Heb das Foto auf] wähle 1 von 3 Befehlskarten, um Gebet zu erhalten: „(EnchantConfig.Arg1)“"
  },
  Event_7073_ChoiceDesc2 = {
    Text = "[Überprüfe den Film]Infiziere „(Skill.Arg1)“, tausche das erhaltene Gebet aus Option 1, kann zweimal verwendet werden"
  },
  Event_7073_Desc = {
    Text = "“Also, du hast alles genau aufgezeichnet.“\n“Ja, der Film enthält die Wahrheit.“\nDas Gespräch verstummte plötzlich, unzählige unsichtbare Augen richteten sich auf dich, als ob sie auf dein letztes Urteil warteten"
  },
  Event_7073_Name = {
    Text = "Augenzeugenaussage"
  },
  Event_7074_ChoiceDesc1 = {
    Text = "[Verlassen]Erhöhe Arg1 Lebenspunkte und erhalte 25 schwarze Siegel"
  },
  Event_7074_Desc = {
    Text = "Dein Ruf wird vom Heulen des Windes verschlungen. \n “Du musst mich nicht kennen“, wird das Zischen in den Worten immer deutlicher, “Herbert, Herbert ist die Person, die ihr sucht. Lasst diesen Typen fallen, von dem falschen Traum in die harte, kalte Realität.“ \n “Ich werde euch segnen und euch das köstlichste ... dieser Welt geben ...“"
  },
  Event_7074_Name = {
    Text = "Seltsamer Begleiter VI"
  },
  Event_7075_ChoiceDesc1 = {
    Text = "[Verlassen]Erhalte Schöpfung“(RelicConfig.Arg1)“，Infektion“(Skill.Arg2)“"
  },
  Event_7075_Desc = {
    Text = "“Ja, armer Verlorener, der die Stärke hat, aber sich selbst nicht erkennt. \nWillst du ihm helfen? Oder die Waffe gegen ihn erheben?“ \nDer Mann sprang in den reißenden Fluss, und im Moment seines Sprungs trafen sich eure Blicke. Es waren Augen, die wie tropfender Honig in einem goldenen Schimmer leuchteten, die eines Schlanges. \nAn der Stelle, an der er eben stand, blieb eine kleine Lampe zurück, die lila Rauch ausströmte."
  },
  Event_7075_Name = {
    Text = "Seltsamer Begleiter VI"
  },
  Event_7076_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7076_Desc = {
    Text = "“Vorsicht ist eine Tugend, aber übermäßige Vorsicht ist unangebracht,“eine gleichbleibende, ruhige Stimme enthielt Unzufriedenheit,“die Bewegung der Sterne wird den Ursprung des Schlafes des Erweckers stören, und der richtige Zeitpunkt kann ihren Wahnsinn schnell wie das Aufblasen eines Ballons anschwellen lassen. Kurz gesagt, es ist noch nicht zu spät, den Schweif des Kometen zu ergreifen. Das nächste Mal erinnere dich daran, deine Reaktionsgeschwindigkeit zu optimieren, die mit der einer Schildkröte vergleichbar ist.“"
  },
  Event_7076_Name = {Text = "Hochwinkel"},
  Event_7077_ChoiceDesc1 = {
    Text = "[Antworten]Aktueller Stress halbieren"
  },
  Event_7077_Desc = {
    Text = "Du berührst die Druckkammer und kannst den aktuellen Druckwert wiederherstellen"
  },
  Event_7077_Name = {
    Text = "Druckstabilisierungspunkt"
  },
  Event_7078_ChoiceDesc1 = {
    Text = "[Sie trösten] Wähle 1 von 3 Befehlskarten aus, die das Gebet erhält: [(EnchantConfig.Arg1)]"
  },
  Event_7078_ChoiceDesc2 = {
    Text = "[Beschuldige sie] Zufällig 3 Befehlskarten, um Gebet zu erhalten: „(EnchantConfig.Arg1)“, Infektion „(Skill.Arg2)“"
  },
  Event_7078_Desc = {
    Text = "“Ich bin der Schatten des verstorbenen Ermittlers, der Mörder ist der silberne Schlüssel.“\nDie Frau hält sich schmerzlich den Kopf. Ihr Haar ist sehr dicht, und darauf blitzen unzählige glänzende Augen, die blinzeln, blinzeln...\n“Sie sagen immer: Das geht nicht, Charlotte! Ach, Charlotte!\nDeshalb dachte ich, wenn ich viele Erwecker auf einmal verlinken könnte, würden alle schweigen.“\n“Und dann... ich weiß auch nicht, was passiert ist, als ich aufwachte, war ich so. Ach!“"
  },
  Event_7078_Name = {
    Text = "Schatten des Ermittlers"
  },
  Event_7079_ChoiceDesc1 = {
    Text = "[Über die hohe Mauer klettern]Erhalte ein verfluchtes Relikt:“(RelicConfig.Arg1)“, Infektion“(Skill.Arg2)“"
  },
  Event_7079_ChoiceDesc2 = {
    Text = "[Das Labyrinth betreten] Eine zufällige Karte erhält das Gebet: [(EnchantConfig.Arg1)]"
  },
  Event_7079_Desc = {
    Text = [[
Dein Geist ist ein Labyrinth.
Zu viele Gedanken winden sich darin, der Ausgang liegt in Reichweite Deines Blickes, doch die hohen Mauern des Denkens stehen zwischen Euch.]]
  },
  Event_7079_Name = {
    Text = "Denk-Labyrinth"
  },
  Event_7080_ChoiceDesc1 = {
    Text = "[Fernblick Phantasma]Erhalte 3 aus 1 Silberrelikt"
  },
  Event_7080_ChoiceDesc2 = {
    Text = "[Nah am Phantasma] erhält Silberrelikt „(RelicConfig.Arg1)“, „(RelicConfig.Arg2)“, Infektion zweimal „(Skill.Arg3)“"
  },
  Event_7080_Desc = {
    Text = "In der Ferne scheint ein Vulkankegel auszubrechen, Rauch in menschlicher Gestalt erhebt sich im windgepeitschten Himmel.\nDas ist Elworth, dort gibt es nur die unaufhörlichen, hohen Bergschneelandschaften und Karst-Höhlen.\nHast du dich durch die anhaltenden Anomalien verrückt gemacht?"
  },
  Event_7080_Name = {
    Text = "Vulkanphantom"
  },
  Event_7081_ChoiceDesc1 = {
    Text = "[Was habe ich gesehen]erhalte das silberne Relikt“(RelicConfig.Arg1)“"
  },
  Event_7081_ChoiceDesc2 = {
    Text = "[Ich habe nichts gesehen]erhalte das goldene Relikt“(RelicConfig.Arg1)“、infiziere“(Skill.Arg2)“"
  },
  Event_7081_Desc = {
    Text = "Flüssigkeit sickert aus deinen Augen, das klebrige Gefühl ist beunruhigend.\nEs liegt an dem, was du gesehen hast, aber hast du wirklich nichts gesehen?"
  },
  Event_7081_Name = {
    Text = "nicht direkt ansehen"
  },
  Event_7082_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7082_Desc = {
    Text = "Du wirst auch Freude und Trauer empfinden, aber im Moment wirst du nicht von deinen Gefühlen überwältigt. Du hältst dir die Ohren zu, der silberne Schlüssel leuchtet hell.\nEndlich kannst du atmen"
  },
  Event_7082_Name = {Text = "Sucht"},
  Event_7083_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7083_Desc = {
    Text = [[
Der Besitzer des Dolches gibt einen Schrei von sich, wie ein Klagevogel auf dem Mitternachtsfriedhof.
Der Klang verweht sofort, und auch die anderen beiden Seefahrer verschwinden ohne Spur... es war nur eine Illusion, die im Bereich reflektiert wurde]]
  },
  Event_7083_Name = {
    Text = "nicht aufgeben"
  },
  Event_7084_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7084_Desc = {
    Text = "Es schwebt still in der Luft, ohne zu blinzeln, mit einem eindringlichen Blick, als wollte es dir etwas sagen.\nAugen mögen die Seele beherbergen, aber ohne Worte spürst du nur Dringlichkeit und Traurigkeit.\nEs verschwindet spurlos"
  },
  Event_7084_Name = {
    Text = "Blinder Blick"
  },
  Event_7085_ChoiceDesc1 = {
    Text = "[Zustimmung zeigen]Erhalte das Silberrelikt“(RelicConfig.Arg1)“，infiziere“(Skill.Arg2)“"
  },
  Event_7085_ChoiceDesc2 = {
    Text = "[Überbringe ein Geschenk]Erhalte Silberrelikt „(RelicConfig.Arg1)“, infiziere „(Skill.Arg2)“"
  },
  Event_7085_ChoiceDesc3 = {
    Text = "[Dreh dich um und verlasse]Erhalte 25 schwarze Siegel"
  },
  Event_7085_Desc = {
    Text = "“Wenn ich eines Tages fallen muss, dann hoffe ich, ins Wasser zu fallen.\nDas Wasser, das meine Nase überflutet, ist wie ein sanfter alter Traum,\nDie Flüssigkeit, in der ich versinke,\nist das Gefäß, das @2 am meisten begehrt.“"
  },
  Event_7085_Name = {Text = "Wasserfest"},
  Event_7086_ChoiceDesc1 = {
    Text = "[Widerstehe der Illusion] erhält goldenes Relikt „(RelicConfig.Arg1)“, Infektion „(Skill.Arg2)“"
  },
  Event_7086_ChoiceDesc2 = {
    Text = "[Wahnsinn absorbieren]Zufälliges Erwachen von 2 Körpern, zweimal Infektion“(Skill.Arg1)“"
  },
  Event_7086_Desc = {
    Text = "Die fragmentierten Dimensionen brechen allmählich zusammen, und die Illusionen anderer Dimensionen strömen in den kranken Raum."
  },
  Event_7086_Name = {
    Text = "Dimensionsillusion"
  },
  Event_7087_ChoiceDesc1 = {
    Text = "[Verlassen]Zufällig 1 Erwecker erwecken"
  },
  Event_7087_Desc = {
    Text = "Das Mädchen erstarrte, strich mit der Hand über den Saum ihres Kleides.\n“Das ist alles, was ich für dich tun kann...“"
  },
  Event_7087_Name = {
    Text = "Mädchen im weißen Kleid"
  },
  Event_7088_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7088_Desc = {
    Text = "Wer spricht?\nDu schaust nach unten und siehst ein verschwommenes Spiegelbild – es trägt dieselben Kleider wie du, hält aber ein Messer und lächelt dich an."
  },
  Event_7088_Name = {
    Text = "Du wirst nicht wollen zu finden"
  },
  Event_70892_ChoiceDesc1 = {
    Text = "[Erinnere dich an den Körper]Überspringe den Kampf und gewinne sofort, aber verliere Arg1 Lebenspunkte"
  },
  Event_70892_ChoiceDesc2 = {
    Text = "[Verlassen]Kampf beginnen"
  },
  Event_70892_Desc = {
    Text = "Trotz der außergewöhnlichen Stärke der Feinde kennst du bereits die Techniken, um sie zu besiegen."
  },
  Event_70892_Name = {
    Text = "Muskelgedächtnis"
  },
  Event_7089_ChoiceDesc1 = {
    Text = "[Kum öffnen]"
  },
  Event_7089_ChoiceDesc2 = {
    Text = "[Experiment angreifen]"
  },
  Event_7089_Desc = {
    Text = "Kum biss in den Nacken eines Versuchskörpers und wollte ihn schütteln, als dieser plötzlich wie eine Eule den Kopf um 180° drehte und auf Kums Gesicht pickte"
  },
  Event_7089_Name = {Text = "Arena"},
  Event_7090_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7090_Desc = {
    Text = "Du hältst den Silberschlüssel fest und spürst den Ruf des Genesis in den dunklen Strömungen der Dimension.\nUm gegen die unidentifizierte böse Höllenhundwesenheit zu kämpfen, musst du alles erdenkliche an Kraft nutzen"
  },
  Event_7090_Name = {
    Text = "Dimensionsillusion"
  },
  Event_7091_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7091_Desc = {
    Text = "“Was den Ermittler betrifft, der Direktor plant, ihn persönlich zu befragen...\nLass ihn am Leben...“\nDie Stimme wird schwächer und verschwindet schließlich in der Dunkelheit"
  },
  Event_7091_Name = {
    Text = "Wände haben Ohren"
  },
  Event_7092_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7092_Desc = {
    Text = "Das Gefühl der Schwerelosigkeit weckt dich plötzlich auf, der Boden unter deinen Füßen ist fest und zuverlässig, und zu deinen Füßen liegt ein fein gearbeiteter quadratischer Spiegel"
  },
  Event_7092_Name = {
    Text = "Spiegel im Spiegel"
  },
  Event_7093_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7093_Desc = {
    Text = "Du streitest nie mit jemandem, der dem Wahnsinn verfallen und hoffnungslos verloren ist – das würde deine Seele in den Fragen der Mitternacht vollständig verschlingen lassen. Verschone dich selbst!"
  },
  Event_7093_Name = {Text = "Wasserfest"},
  Event_7094_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7094_Desc = {
    Text = "Wie sollte das Gesicht der Wachsfigur aussehen? \n Du schließt die Augen und in deinem Kopf erscheinen Millionen verschwommene Gesichter. \n Sie sind wie Kerzen, die mit blassem Feuer ziehen, erscheinen und verschwinden im dunklen Fluss... \n Du gehst bis zum Ende des Flusses, wo die einzige, letzte Wachsfigur steht. \n Als du dich ihr näherst, siehst du... @2."
  },
  Event_7094_Name = {
    Text = "Unfertige Wachsfigur"
  },
  Event_7095_ChoiceDesc1 = {
    Text = "[ANG auf den Dolchträger]Infiziere“(Skill.Arg1)“，erhalte ein verfluchtes Relikt“(RelicConfig.Arg2)“"
  },
  Event_7095_ChoiceDesc2 = {
    Text = "[Befangenheit des Kämpfers]Infektion zweimal „(Skill.Arg1)“, erhalte das silberne Relikt „(RelicConfig.Arg2)“ und „(RelicConfig.Arg3)“"
  },
  Event_7095_ChoiceDesc3 = {
    Text = "[Hindernis für den Speerträger]Erhalte ein silbernes Relikt:“(RelicConfig.Arg1)“"
  },
  Event_7095_Desc = {
    Text = "Drei Seefahrer halten euch fest und ihre wahnsinnigen, glühenden Blicke scheinen euren Umhang zu entzünden.\nAls du dich umdrehst, bemerkst du, dass die drei unterschiedlich sind -\nder Seefahrer mit dem großen Schwert schreit am wütendsten, handelt aber etwas nachlässig.\nDer Seefahrer mit dem Speer folgt ihm auf Schritt und Tritt, wie ein kleinkind, das gerade sprechen lernt.\nDer Seefahrer mit dem Dolch bleibt zuletzt, und die Gebete, die er vor sich hin murmelt, beweisen seine Besessenheit."
  },
  Event_7095_Name = {
    Text = "nicht aufgeben"
  },
  Event_7096_ChoiceDesc1 = {
    Text = "[Verlassen]Erhalte Schöpfung“(RelicConfig.Arg1)“，Infektion“(Skill.Arg2)“"
  },
  Event_7096_Desc = {
    Text = "Du nimmst das Geschenk und öffnest es vorsichtig.\nEin Paar Augen liegt still in der Schachtel.\n„Ich gebe dir meine Augen.“\n„So wie er es einst für mich tat.“"
  },
  Event_7096_Name = {
    Text = "Abschlusszeremonie VI"
  },
  Event_7097_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7097_Desc = {
    Text = "Du greifst durch das Zentrum des Lichts und hebst einen erstarrten Silberkern auf. Dieser kostbare Träger von Erinnerungen und Seelen ist brennend heiß und reflektiert seltsame Farben. \n Bevor er das gesamte Licht verzerrt und vermischt, lässt der brennende Schmerz dich nicht anders können, als ihn wieder in die Dunkelheit zu werfen."
  },
  Event_7097_Name = {Text = "Nachtglanz"},
  Event_7098_ChoiceDesc1 = {
    Text = "[Verlassen]Erhalte 25 schwarze Siegel"
  },
  Event_7098_Desc = {
    Text = "Du lehnst das Geschenk des Jungen ab. \n Der Junge schaut dich mit seinen leeren Augenhöhlen an. Er seufzt leise. \n “Dann, auf Wiedersehen.“ \n Nachdem der Junge das gesagt hat, macht er eine Verbeugung und fällt dann aus dem Fenster. \n Er verschwindet, wie ein schwebender Schmetterling, und wie ein Wind."
  },
  Event_7098_Name = {
    Text = "Abschlusszeremonie VI"
  },
  Event_7099_ChoiceDesc1 = {
    Text = "Wähle eine gewöhnliche Markierung"
  },
  Event_7100_ChoiceDesc1 = {
    Text = "[Herunternehmen] erhalte das silberne Relikt“(RelicConfig.Arg1)“、infiziere“(Skill.Arg2)“"
  },
  Event_7100_ChoiceDesc2 = {
    Text = "[Weigere die Anfrage] Erhalte 3 aus 1 Gebet"
  },
  Event_7100_Desc = {
    Text = "Eine Reihe von prächtigen Noten strömt von den Fingerspitzen. \n Der melancholische Wachsfigur-Pianist sitzt allein am Fenster. \n Seit er sich seines Bewusstseins bewusst ist, ist das Wachsfigurenmuseum seine gesamte Welt. \n Er war lange isoliert und wollte etwas anderes hören, besonders... eine Musik namens Jazz. \n Schließlich reißt er sich ein Ohr ab und bittet dich, es mitzunehmen. \n “Lass mich die Musik draußen hören... es reicht, wenn du es in die Tasche steckst.“"
  },
  Event_7100_Name = {Text = "Lausch"},
  Event_7101_ChoiceDesc1 = {
    Text = "[Verbinden]Arg2 Lebenspunkte heilen。[ExDesc1]"
  },
  Event_7101_ChoiceDesc2 = {
    Text = "[Meditation] wählt 1 Erwecker aus.[ExDesc1]"
  },
  Event_7101_ChoiceDesc3 = {
    Text = "[verbanne]Entferne bis zu 3 Symptom-Karten, erhalte Arg2 schwarze Siegel"
  },
  Event_7101_Desc = {
    Text = "Du erkundest den Nebel, plötzlich leuchtet das Abzeichen auf deiner Brust schwach silbern. Wer ruft dich am anderen Ende des Kommunikators?"
  },
  Event_7101_Name = {
    Text = "Kontaktstelle"
  },
  Event_7101_Tips3 = {
    Text = "Derzeit besitzen Sie keine Symptom-Karten"
  },
  Event_7102_ChoiceDesc1 = {
    Text = "[Herausforderung annehmen]"
  },
  Event_7102_ChoiceDesc2 = {
    Text = "[Gib ihm einen Schlag]Erhalte 25 schwarze Siegel"
  },
  Event_7102_Desc = {
    Text = "Eine schlanke Gestalt taucht aus dem Schatten auf und versperrt dir den Weg. \n Eine für immer gefesselte Erinnerung dringt plötzlich in den Geheimgang ein, und der Schatten, der sich “N“ nennt, spielt mit den Chips in seiner Hand und lädt dich mit unklaren Wimmern ein, an seinem Spiel teilzunehmen. \n Dreifarbige Chips breiten sich vor dir aus; wenn du nicht eine Runde “Spiel“ mit ihm spielst, wird er dich wohl nicht so einfach entlassen."
  },
  Event_7102_Name = {
    Text = "Die Show kann beginnen"
  },
  Event_7103_ChoiceDesc1 = {
    Text = "[Silberschlüssel einstecken]"
  },
  Event_7103_Desc = {
    Text = "Im gesättigten D-Schleim scheint eine gewisse Substanz verborgen zu sein... Beobachte sie mit dem Silberschlüssel und verwandle sie in deine eigene Macht"
  },
  Event_7103_Name = {
    Text = "Ausgangspunkt"
  },
  Event_7104_ChoiceDesc1 = {
    Text = "[Kämpfend aufwachen]erhöhe Arg1 Punkte maximale Gesundheit"
  },
  Event_7104_ChoiceDesc2 = {
    Text = "[Sich dem Schlummern hingeben] 2 zufällige Befehlskarten erhalten ein Gebet: „(EnchantConfig.Arg1)\", infiziere 2 „(Skill.Arg2)\""
  },
  Event_7104_Desc = {
    Text = "In deinen Armen hältst du einen glitzernden Schatz. \n Er kriecht von deiner Brust in deinen ganzen Körper, diese warmen Erinnerungen, die das Licht einer Kerze ausstrahlen, werden schließlich in dein Gehirn gegossen. \n Das Knistern der Kohlen, der gemütliche Sessel am Kamin, der vollmundige heiße Tee und der Bauch der Katze, die sich an deinen Füßen zusammenrollt... \n In dieser behaglichen Müdigkeit ist dein Kopf schwer, und du fällst in eine weiche Unendlichkeit."
  },
  Event_7104_Name = {
    Text = "Versunken in alten Tagen"
  },
  Event_7105_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7105_Desc = {
    Text = "Du ziehst gnadenlos den restlichen Film heraus, der im Bauch der Kamera versteckt war. Das Bild darauf lässt dich sprachlos.\nDer unentwickelte Film zeigt dich, wie du in einer Pfütze aus schwarzem Schlamm liegst"
  },
  Event_7105_Name = {
    Text = "Rekord unschuldig"
  },
  Event_7106_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7106_Desc = {
    Text = "Du überprüfst die Kamera gründlich, Leder und schwarz-goldene Einfassungen reflektieren einen öligen Glanz.\nDie Linse ist auf dich gerichtet, als würde sie dich anstarren und beobachten"
  },
  Event_7106_Name = {
    Text = "Rekord unschuldig"
  },
  Event_7107_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7107_Desc = {
    Text = "Eine Handvoll Mondlicht, die in der Handfläche gehalten wird, wird auf den Grabstein gegossen. \n Jemand wurde unter schwerem Schlamm begraben, die Zuschauer behaupten, diese Person sei einem natürlichen Verfall begegnet und werde im Untergrund ruhen. \n Doch der begrabene Schlamm beginnt zu surgen, und aus den Schreien kriecht ein schlaffer Mond hervor."
  },
  Event_7107_Name = {
    Text = "Silbermondfragment"
  },
  Event_7108_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7108_Desc = {
    Text = "Du berührst sanft die dünnen schwarzen Flügel des Schmetterlings. Der Schmetterling schlägt leicht mit den Flügeln und verwandelt sich dann in schwarze Tropfen, die in deiner Handfläche landen"
  },
  Event_7108_Name = {
    Text = "Etwas, das nicht existieren sollte"
  },
  Event_7109_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7109_Desc = {
    Text = "Der einsame Mond hängt hoch am Himmel, und doch kannst du die Worte seines Gebets klar hören, die seltsame Melodie klingt wie das Flüstern von Unrat. \n Das Gebet stoppt, du bist im Begriff zu gehen. Doch hinter dir erscheint ein weißer Schatten. \n “Der, der das Schicksal und die Verfluchung beobachtet, wird sowohl Gnade als auch Preis wie vereinbart erhalten.“"
  },
  Event_7109_Name = {
    Text = "Silbermondfragment"
  },
  Event_7110_ChoiceDesc1 = {
    Text = "[Drei Punkte]"
  },
  Event_7110_ChoiceDesc2 = {
    Text = "[Sechs Uhr]"
  },
  Event_7110_ChoiceDesc3 = {
    Text = "[Ein Punkt]"
  },
  Event_7110_Desc = {
    Text = "Sieht so aus, als hättest du heute Glück.\nDer Würfel zittert und summt vor Aufregung.\nDu entscheidest dich, eine Zahl zu raten"
  },
  Event_7110_Name = {
    Text = "Endloses Glücksspiel"
  },
  Event_7111_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7111_Desc = {
    Text = "Dieses Spiel ist ein riesiger Betrug!\nDu springst auf, fühlst dich aber schwindelig.\nDie Würfel summen verführerisch in deinem Kopf:\n„Nur noch ein Spiel... das letzte...“"
  },
  Event_7111_Name = {
    Text = "Endloses Glücksspiel"
  },
  Event_7112_ChoiceDesc1 = {
    Text = "[Silberkern verwenden]Aktualisiere ein Silberrelikt zu einem goldenen Relikt „(RelicConfig.Arg1)“"
  },
  Event_7112_ChoiceDesc2 = {
    Text = "[Lege das Silber ab]erhalte ein goldenes Relikt“(RelicConfig.Arg1)“，infiziere“(Skill.Arg2)“und“(Skill.Arg3)“"
  },
  Event_7112_ChoiceDesc3 = {
    Text = "[Lege es zurück in die Schublade]erhalte 25 das schwarze Siegel"
  },
  Event_7112_Desc = {
    Text = "Im zweiten Schublade rechts auf dem Schreibtisch liegt einsam ein geformter Silberkern. Beim sanften Berühren hörst du das Heulen des Sturms, das Knirschen von Schneekörnern und das Wimmern einer Flöte"
  },
  Event_7112_Name = {
    Text = "Einsamer Silberkern"
  },
  Event_7113_ChoiceDesc1 = {
    Text = "[Lauscher] infiziere “(Skill.Arg1)“, erhalte ein verfluchtes Relikt – “(RelicConfig.Arg2)“"
  },
  Event_7113_ChoiceDesc2 = {
    Text = "[Ändern] Wähle 1 Relikt zum Zerstören und erhalte 1 Belohnung"
  },
  Event_7113_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte 50 schwarze Siegel"
  },
  Event_7113_Desc = {
    Text = "Nicht alle Melodien sind schön.\nReine Dissonanzen ergeben ein Klagelied"
  },
  Event_7113_Name = {Text = "Dissonanz"},
  Event_7114_ChoiceDesc1 = {
    Text = "[Heb es auf] Infektion „(Skill.Arg1)“, erhält Silberrelikt „(RelicConfig.Arg2)“"
  },
  Event_7114_ChoiceDesc2 = {
    Text = "[Gib es auf]erhalte 25 das schwarze Siegel"
  },
  Event_7114_Desc = {
    Text = "In der Ecke des fauligen Heuhaufens, in den Rissen der Erosion, liegt still ein Gegenstand"
  },
  Event_7114_Name = {
    Text = "hinter dem Strohballen"
  },
  Event_7115_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7115_Desc = {
    Text = "Die Gestalt kam nicht näher, sondern verwandelte sich nach einem Moment des Starrens in eine Handvoll Silbersand"
  },
  Event_7115_Name = {
    Text = "Silberschlüssler"
  },
  Event_7116_ChoiceDesc1 = {
    Text = "[Tentakel halten]Tulus Hilfe annehmen"
  },
  Event_7116_Desc = {
    Text = "Nach einem Seufzer holt Tulu dich ein.\nSchwere, kalte Tentakel packen dich und löschen den Gedanken, allein in die feindlichen Reihen zu stürmen.\n“Ich werde dir helfen, aber nur jetzt.“"
  },
  Event_7116_Name = {
    Text = "Die Verheißung des Agenten"
  },
  Event_7117_ChoiceDesc1 = {
    Text = "[Erhalte Schlüssel]"
  },
  Event_7117_Desc = {
    Text = "1.2.3......\nJenkin und der Schreibtisch sind zehn Fuß entfernt.\nDas ist eine sehr kurze Distanz, aber sie fühlt sich so lang an wie ihr ganzes Leben.\nSie denkt an das weiche Band, an das goldene Bonbonpapier und an die Tränen ihrer Mutter.\nSie denkt an viele, viele Dinge...\nIhr zartes Körperchen schwebt über den schwarzen Fluss, Stück für Stück näher zum Schreibtisch.\nDer Schlüssel liegt in der Schublade, und der Preis, um ihn zu bekommen, ist ganz einfach: Mut, Geschicklichkeit und ein wenig Glück.\nAußer Glück hat Jenkin nichts zu vermissen."
  },
  Event_7117_Name = {
    Text = "Finaler Schlüssel"
  },
  Event_7118_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7118_Desc = {
    Text = "Nur eine Wette, du wirst nicht verlieren.\nEine gravierte Münze wird hochgeworfen und fällt schnell, von deiner Hand erwärmt"
  },
  Event_7118_Name = {
    Text = "Berühmter Glücksspieler"
  },
  Event_7119_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7119_Desc = {
    Text = "Nur eine Wette, du wirst nicht verlieren.\nEine gravierte Münze wird hochgeworfen und fällt schnell, von deiner Hand erwärmt"
  },
  Event_7119_Name = {
    Text = "Berühmter Glücksspieler"
  },
  Event_7120_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7120_Desc = {
    Text = "Nur eine Wette, du wirst nicht verlieren.\nEine gravierte Münze wird hochgeworfen und fällt schnell, von deiner Hand erwärmt"
  },
  Event_7120_Name = {
    Text = "Berühmter Glücksspieler"
  },
  Event_7121_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7121_Desc = {
    Text = "Du hast nicht die Absicht, an diesem ernsten Klavierunterricht teilzunehmen. \nJedes Mal, wenn ein Takt beendet ist, drehen die Schüler mühsam ihren Kopf und tun so, als würden sie zuhören. \nIhr Lehrer beugt sich leicht vor, seine Lippen bewegen sich, und seine runden Augen schauen auf eine nicht vorhandene Partitur. \nOffensichtlich wissen sie nicht, was sie tun, und werden niemals verstehen, warum Menschen Jahre damit verbringen, solch mechanisches Üben zu betreiben. \nSie imitieren einfach nur."
  },
  Event_7121_Name = {
    Text = "Piano-Unterricht"
  },
  Event_7122_ChoiceDesc1 = {
    Text = "[Silberschlüssel einstecken]"
  },
  Event_7122_Desc = {
    Text = "Im gesättigten D-Schleim scheint eine gewisse Substanz verborgen zu sein... Beobachte sie mit dem Silberschlüssel und verwandle sie in deine eigene Macht"
  },
  Event_7122_Name = {
    Text = "Ausgangspunkt"
  },
  Event_7123_ChoiceDesc1 = {
    Text = "[Erkenne die Texte]Erhalte Silberrelikt „(RelicConfig.Arg1)“, infiziere „(Skill.Arg2)“"
  },
  Event_7123_ChoiceDesc2 = {
    Text = "[Leise summen]Erhalte ein Gebet aus 3 wähle 1"
  },
  Event_7123_Desc = {
    Text = "Das alte Seelied hallt im Bereich wider.\nDie von der Dimension gefangenen Erinnerungen singen mit dir in einer Sprache, die du noch nie gehört hast, vom Meer, vom Himmel und vom hochprozentigen Alkohol"
  },
  Event_7123_Name = {Text = "Meereslied"},
  Event_7124_ChoiceDesc1 = {
    Text = "[Rufen der Krähe]erhält 20 das schwarze Siegel, infiziert „(Skill.Arg2)“"
  },
  Event_7124_ChoiceDesc2 = {
    Text = "[Weit weg gehen]"
  },
  Event_7124_Desc = {
    Text = "Schwarze Vögel starren dich an, und nach einer Weile fällt etwas aus ihren Federn"
  },
  Event_7124_Name = {
    Text = "Aussätzige Krähe"
  },
  Event_7125_ChoiceDesc1 = {
    Text = "[Vorwärts greifen]Erwirbt 25 das schwarze Siegel"
  },
  Event_7125_ChoiceDesc2 = {
    Text = "[Freundliche Antwort]50% Chance, 50 das schwarze Siegel zu erhalten, 50% Chance, nichts zu erhalten"
  },
  Event_7125_Desc = {
    Text = "Eine Katze, die aus dem Nichts erscheint, sitzt zwischen D-Schleim, ihr verschwommener Körper zeigt, dass sie ein Bewohner der Geisterdimension sein sollte.\nDieses unkenntliche Abbild betrachtet Lotan mit klugen Augen, es hebt seine reinweißen Vorderpfoten und winkt ihr zu"
  },
  Event_7125_Name = {
    Text = "Wandernde Bewohner"
  },
  Event_7126_ChoiceDesc1 = {
    Text = "[Nach Norden rennen]"
  },
  Event_7126_ChoiceDesc2 = {
    Text = "[Geräusch ignorieren]"
  },
  Event_7126_Desc = {
    Text = "Die ANGe des Feindes prasselten wie Regen auf dich ein, die Klingen schnitten mehrmals durch deinen Umhang und erschreckten die Möwen am Pier.\n„Nach Norden... oder aufs Schiff...“\nSelbst der Dümmste konnte erkennen, dass eine Macht im Verborgenen dir half"
  },
  Event_7126_Name = {
    Text = "Nach Norden weiter"
  },
  Event_7127_ChoiceDesc1 = {
    Text = "[Lauscher der Sonne]Erhalte ein silbernes Relikt:“(RelicConfig.Arg1)“"
  },
  Event_7127_ChoiceDesc2 = {
    Text = "[Verlassen]Erhalte 25 schwarze Siegel"
  },
  Event_7127_Desc = {
    Text = "Im Zusammenspiel von Realität und Illusion drehen sich die Himmelskörper ewig auf ihren festgelegten Bahnen. \n Unzählige Begegnungen spielen eine Reihe von seltsamen und täuschenden Melodien..."
  },
  Event_7127_Name = {
    Text = "Sternenmondton"
  },
  Event_7128_ChoiceDesc1 = {
    Text = "[Verlasse in Trauer] Kopiere eine Karte. Wenn du eine Symptomkarte kopierst, erhalte 75 schwarze Siegel"
  },
  Event_7128_ChoiceDesc2 = {
    Text = "[In Wut gehen] Wähle 1 von 3 Befehlskarten aus, um ein Gebet zu erhalten: [(EnchantConfig.Arg1)]"
  },
  Event_7128_Desc = {
    Text = "Flüssigkeit sprudelt aus den Augen, kalt und reißend einen Teil der Seele mit sich"
  },
  Event_7128_Name = {
    Text = "Tränen des Seelenstrandes"
  },
  Event_7129_ChoiceDesc1 = {
    Text = "[In den Korridor vordringen]"
  },
  Event_7129_ChoiceDesc2 = {
    Text = "[Gegensätzlich]Erhalte 25 schwarze Siegel"
  },
  Event_7129_Desc = {
    Text = "Das bleiche Mondlicht ignorierte den Fluss der Zeit und ergoss sich über den stillen Korridor.\nDie Türöffnung leuchtete unheimlich im Mondlicht"
  },
  Event_7129_Name = {
    Text = "Stille Galerie"
  },
  Event_7130_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7130_Desc = {
    Text = "Du entscheidest dich, die Wachsskulptur zu reparieren. \nIn der Nähe der Skulptur liegen einige Werkzeuge, du wählst ein Farbstoff namens „Preußisch Blau“. \nEs ist so blau wie eine Krankheit"
  },
  Event_7130_Name = {
    Text = "Unfertige Wachsfigur"
  },
  Event_7131_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7131_Desc = {
    Text = "Die Eiterbeule stieß einen scharfen, grusligen Schrei aus, während ein nicht existierender Wind heulte, eine trügerische Flötenmelodie erklang und die verbotenen Stimmen des Eiters sich regten. \n Die Eiterbeule zuckte seltsam für einen Moment, dann erstarrte sie in todstiller Starre. Als du dies sahst, schien der Erwecker neben dir von einem gewissen Ruf berührt worden zu sein."
  },
  Event_7131_Name = {
    Text = "verwachsene Eiterbeule"
  },
  Event_7132_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7132_Desc = {
    Text = "Deine Fingerspitzen berühren die Statue, doch das Gefühl ist manchmal überraschend weich und eingedrückt, du dachtest immer, es sei eine Täuschung"
  },
  Event_7132_Name = {
    Text = "Zusammengesetzter Körper"
  },
  Event_7133_ChoiceDesc1 = {
    Text = "[Für sie weinen]"
  },
  Event_7133_ChoiceDesc2 = {
    Text = "[Zu ihr beten]"
  },
  Event_7133_Desc = {
    Text = "In dem Moment, als ihr Körper den Schiffsrumpf berührte, strömten Erinnerungen, die nicht ihre eigenen waren, in ihren Kopf. \n Die Menschen kleideten sie in ein heiliges weißes Kleid und schmückten sie mit Juwelen, um sie elegant und schlicht erscheinen zu lassen. Die Menschen hoben sie auf ein hohes Altar, während die Bürger des kleinen Stadt zu ihren Füßen krochen und beteten. \n Es waren Augen voller Hoffnung: Die Seemänner hofften, dass sie ihre Reisen beschützen würde, die Fischer hofften auf eine ruhige und sturmfreie Fangzeit, und viele Bürger hofften auf ein Jahr voller Glück. \n In der knienden Menge waren ihre Kindheitsfreunde sowie ihre Eltern und Geschwister, mit denen sie täglich zusammen war. \n Sie wollte nichts, sie wusste nicht, was sie wollte. \n Passiv auf die Wünsche zu reagieren, schien die einzige Pflicht ihres Lebens zu sein."
  },
  Event_7133_Name = {
    Text = "Flugvorbereitungszeremonie"
  },
  Event_7134_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7134_Desc = {
    Text = "Die blassen Augen in dem verstümmelten Körper drehten sich langsam und beobachteten deine sich entfernende Gestalt, ein schwaches Lächeln erschien"
  },
  Event_7134_Name = {
    Text = "Zusammengesetzter Körper"
  },
  Event_7135_ChoiceDesc1 = {
    Text = "[Aktiv kämpfen]Erhalte ein verfluchtes Relikt „(RelicConfig.Arg1)“, infiziere „(Skill.Arg2)“"
  },
  Event_7135_ChoiceDesc2 = {
    Text = "[Widerstand aufgeben] Wähle 1 von 3 Befehlskarten aus, um das Gebet zu erhalten: [(EnchantConfig.Arg1)]"
  },
  Event_7135_ChoiceDesc3 = {
    Text = "[Mach schnell einen Abgang]Erhalte 50 schwarze Siegel"
  },
  Event_7135_Desc = {
    Text = "Einige Wachsfiguren blockierten deinen Weg.\nSie waren schief und grob, nicht auf Rogers üblichem Niveau.\n„Befehl... der Befehl des Meisters...“"
  },
  Event_7135_Name = {Text = "Übung"},
  Event_7136_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7136_Desc = {
    Text = "Du wählst, mutig in die Augen zu schauen. \n Sie sind strahlende Sterne, die im Dunkeln funkeln. \n Dann lachen sie und verwandeln sich in unzählige, gebogene Monde. \n “Du fürchtest dich nicht vor Blicken. Du solltest auch nicht fürchten... \n Lange nicht gesehen, @2.“ \n Bevor sie verschwinden, schenken sie dir ein kleines Geschenk als “Erinnerung an das Wiedersehen“."
  },
  Event_7136_Name = {Text = "Auge"},
  Event_7137_ChoiceDesc1 = {
    Text = "[Schalter umlegen]Sichtfeld erweitern[ExDesc1]"
  },
  Event_7137_Desc = {
    Text = "Ein altes Beleuchtungsgerät, das den schwarzen Nebel vertreibt.\nDer Nebel um es herum pulsiert rhythmisch, als ob er von seinem Atem gestört wird"
  },
  Event_7137_Name = {
    Text = "Suchscheinwerfer"
  },
  Event_7138_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7138_Desc = {
    Text = "Dein Rücken entfaltet durchsichtige Flügel, die sich drehen und mit den Krähen in die stille Tiefe des Meeres fließen"
  },
  Event_7138_Name = {
    Text = "Rabenstimme"
  },
  Event_7139_ChoiceDesc1 = {
    Text = "[Es eliminieren]„Herz der Abnormität“ erhalten"
  },
  Event_7139_Desc = {
    Text = "Ein deformierter Eiterbeutel, von jemandem am Straßenrand zurückgelassen, schimmerte schmutzig grün und pulsierte unruhig.\nEs sah eher aus wie ein Eis, das in der Sonne schmilzt, bald zu einer klebrigen Pfütze wird und dann in der Luft verschwindet"
  },
  Event_7139_Name = {
    Text = "verwachsene Eiterbeule"
  },
  Event_7140_ChoiceDesc1 = {
    Text = "[Lass die Hände von den Ohren]Infektion“(Skill.Arg1)“，wähle eine Belohnung"
  },
  Event_7140_ChoiceDesc2 = {
    Text = "[Eine Krähe fangen]“(Skill.Arg1)“erhalten, eine Belohnung wählen"
  },
  Event_7140_ChoiceDesc3 = {
    Text = "[Schließe die Augen]Erhalte 50 das schwarze Siegel"
  },
  Event_7140_Desc = {
    Text = "Aufschrei, ein endloser Aufschrei——\nDie Sängerin der Krähen mit ihrem schwarzen, schimmernden Fell und dem kalten, harten Glanz auf ihrem spitzen Schnabel, durchdringt mit ihrem durchdringenden Klagelaut immer wieder dein Trommelfell. \nLass deine Hände von deinen Ohren! \nDie Krähen, die in der Nacht aus vollem Halse singen, wollen den ungeschliffenen Schauer in deinem zusammengekauerten Körper genießen. \n"
  },
  Event_7140_Name = {
    Text = "Sanges der Raben"
  },
  Event_7141_ChoiceDesc1 = {
    Text = "[Verlassen]Nichts gefunden"
  },
  Event_7141_Desc = {
    Text = "Nicht die Person, die du suchst"
  },
  Event_7141_Name = {
    Text = "2_6 vorübergehend"
  },
  Event_7142_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7142_Desc = {
    Text = "Du hast beschlossen, weiterzugehen.\nIm Vergleich zu dem psychischen und physischen Schaden, den dir die schlechten Wachskunstwerke zugefügt haben, sind diese kleinen Belästigungen wirklich nichts.\nDu hast eine größere Aufgabe zu erledigen"
  },
  Event_7142_Name = {Text = "Schritte"},
  Event_7143_ChoiceDesc1 = {
    Text = "[Weise auf das Problem hin] wähle 1 von 3 Befehlskarten, um Gebet zu erhalten: „(EnchantConfig.Arg1)“"
  },
  Event_7143_Desc = {
    Text = "“Was soll das! Magst du es so sehr, in den Wunden anderer zu stochern!“\n“Ja! Jetzt bin ich einfach 25 Jahre älter! Jetzt musst du mich Schwester Murphy nennen!“"
  },
  Event_7143_Name = {
    Text = "Eingesperrtes Leben"
  },
  Event_7144_ChoiceDesc1 = {
    Text = "[Verlassen]Erhalte eine Auswahl von 3 für 1 Silberrelikt, infiziere“(Skill.Arg1)“"
  },
  Event_7144_Desc = {
    Text = "Das Gesicht des Mädchens war so ruhig wie das Mondlicht der Nacht. Sie antwortete dir nicht, sondern hob den Kompass in ihrer Hand hoch – sie zitterte, als ob das Heben des kleinen Kompasses all ihre Kraft kostete"
  },
  Event_7144_Name = {
    Text = "Mädchen im weißen Kleid"
  },
  Event_7145_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7145_Desc = {
    Text = "“Lecker! Lecker!“ Der Rabe lacht, der faulige Geruch breitet sich mit seinen ausgebreiteten Flügeln in deiner Nase aus"
  },
  Event_7145_Name = {Text = "Fluchrabe"},
  Event_7146_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7146_Desc = {
    Text = "Wenn ich das sagen darf, ist Lärm definitiv das Vorbild der neuen Generation. \n Sie schreiten unermüdlich im Takt chaotischer Rhythmen und zerbrechlicher Melodien über die Welt. \n Ohne Mitleid, ohne Schwanken und ohne Kompromisse. \n Sie verachten Ordnung, verwerfen Themen, Lärm erfreut niemals andere — \n natürlich gehört auch unser Wachsfigurengestalter dazu."
  },
  Event_7146_Name = {
    Text = "schlechter Geschmack"
  },
  Event_7147_ChoiceDesc1 = {Text = "[Führe]"},
  Event_7147_ChoiceDesc2 = {
    Text = "[Verlassen]"
  },
  Event_7147_Desc = {
    Text = "Jemand zieht leicht an deinem Ärmel.\nEs ist der Junge von vorhin. Er hockt in der Ecke und schaut dich traurig an.\n„Ich will bei der Schulaufführung mitmachen.\nAber ich finde den Weg zur Bühne nicht.“"
  },
  Event_7147_Name = {
    Text = "Abschlusszeremonie II"
  },
  Event_7148_ChoiceDesc1 = {
    Text = "[Weiter suchen]Erhöhe Arg1 Leben, infiziere“(Skill.Arg2)“"
  },
  Event_7148_ChoiceDesc2 = {
    Text = "[Verlassen]"
  },
  Event_7148_Desc = {
    Text = "Ein vertrauter Geruch stieg dir in die Nase, heimelig und zufriedenstellend. Als du den Duft der Kantine noch einmal einatmen wolltest, war er plötzlich verschwunden"
  },
  Event_7148_Name = {
    Text = "Abnormale Verbindung"
  },
  Event_7149_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7149_Desc = {
    Text = "Sie sind warme Farben.\nLeidenschaftlich, sanft, liebevoll.\nSie gaben dem Mädchen eine nostalgische Umarmung und verschwanden wie der Wind"
  },
  Event_7149_Name = {
    Text = "Nostalgische Farben"
  },
  Event_7150_ChoiceDesc1 = {
    Text = "[Wer bist du wirklich?]"
  },
  Event_7150_ChoiceDesc2 = {
    Text = "[Wie den Ansatz ändern?]"
  },
  Event_7150_Desc = {
    Text = "Der langhaarige Mann steht erneut vor euch im Weg. Nach der letzten Erfahrung ist Ramona nicht gut gelaunt. \n “Beruhige dich, mein Freund.“ Der Mann beginnt langsam zu sprechen, seine Stimme ist magnetisch und verführerisch, als würde der Klang durch eine enge Atembahn strömen, begleitet von einem zischenden Reibegeräusch. \n “Ich habe schon eine Weile beobachtet, nur durch einen Perspektivwechsel kannst du deinem Ziel näherkommen.“"
  },
  Event_7150_Name = {
    Text = "Seltsamer Begleiter III"
  },
  Event_7151_ChoiceDesc1 = {
    Text = "[Ich suche]Erhöhe Arg1 Punkte maximale Gesundheit"
  },
  Event_7151_ChoiceDesc2 = {
    Text = "[Ich weiche aus] Wähle 1 von 3 Befehlskarten aus, um ein Gebet zu erhalten: „(EnchantConfig.Arg1)\", infiziere „(Skill.Arg2)\""
  },
  Event_7151_Desc = {
    Text = "“Ich sehe jemanden suchen, suchen nach dem Unauffindbaren, dem traurigen Gegenstück, dem, was Wahrheit genannt wird.\nIch sehe jemanden ausweichen, ausweichen vor dem Unvermeidlichen, dem verborgenen Grausamen, dem, was Wahrheit genannt wird.\nWer bist du?“"
  },
  Event_7151_Name = {
    Text = "Verfolgungsobjekt"
  },
  Event_7152_ChoiceDesc1 = {
    Text = "[Genau hinschauen]Aktualisiere ein Silberrelikt zu einem goldenen Relikt „(RelicConfig.Arg1)“"
  },
  Event_7152_ChoiceDesc2 = {
    Text = "[Versuch zuzuhören]erhalte das goldene Relikt“(RelicConfig.Arg1)“、infiziere“(Skill.Arg2)“und“(Skill.Arg3)“"
  },
  Event_7152_ChoiceDesc3 = {
    Text = "[Vorsichtig aufbewahren]erhalte 25 das schwarze Siegel"
  },
  Event_7152_Desc = {
    Text = "Der Nebel vor uns wird von einem kleinen Objekt erhellt, das wie Glasscherben oder Kristall aussieht und darin schimmernde, auffällige oder gedämpfte Farben schwappen"
  },
  Event_7152_Name = {
    Text = "Unsere Erinnerungen"
  },
  Event_7153_ChoiceDesc1 = {
    Text = "[Herausforderung annehmen]Gewinn erhalte Silberrelikt, Verlust erhalte Symptome. Unabhängig vom Ergebnis beeinflusst es nicht die nachfolgende Ermittlung"
  },
  Event_7153_ChoiceDesc2 = {
    Text = "[Verlassen]Erhalte 25 schwarze Siegel"
  },
  Event_7153_Desc = {
    Text = "Wer ist die Person im Spiegelbild?\nEr hat den gleichen Atem wie du, das gleiche Herzklopfen und teilt die gleiche seltsame, böse Idee.\nIst es ein Streich des Geheimgangs oder der Schatten, der die Dimensionen überquert?\nEs scheint, als wäre dies eine illusionäre Einladung zu einer Herausforderung?"
  },
  Event_7153_Name = {
    Text = "Seelenresonanz"
  },
  Event_7154_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7154_Desc = {
    Text = "Der Blick übersteigt Geschichte und Zeit, er könnte nichtlinear sein, er könnte dich aus dem Chaos vor der Geburt des Planeten betrachten.\nOder vielleicht wartet er an einem zukünftigen Tag auf dich"
  },
  Event_7154_Name = {Text = "spähen"},
  Event_7155_ChoiceDesc1 = {
    Text = "[abholen]Erhalte 50 schwarze Siegel"
  },
  Event_7155_Desc = {
    Text = "Dort ist nichts, schwarze Flüssigkeit fließt über den Boden und spiegelt nichts wider.\nWar es eine Täuschung? Du fühlst, wie etwas durch deine Finger schlüpft"
  },
  Event_7155_Name = {
    Text = "Spiegel darunter"
  },
  Event_7156_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7156_Desc = {
    Text = "“Du bist wirklich großzügig, ich wünsche dir alles Gute für heute, morgen und übermorgen.“\n“Übrigens, das ist ein einmaliges Geschäft...“\nDie Fee schnalzt zufrieden mit der Zunge und verabschiedet sich widerwillig von dir.“"
  },
  Event_7156_Name = {Text = "Feensegens"},
  Event_7157_ChoiceDesc1 = {
    Text = "[Gib mir meine Geldbörse zurück!] erhält 1 aus 3 Gebete"
  },
  Event_7157_ChoiceDesc2 = {
    Text = "[Zögern] Eine zufällige Befehlskarte erhält das Gebet: „(EnchantConfig.Arg1)\", infiziert „(Skill.Arg2)\""
  },
  Event_7157_Desc = {
    Text = "“Komm schon, hol dein Portemonnaie zurück!“ Die Kinder in der Ferne winken. \n Du rennst vorwärts, im Moment, als du die Hand ausstreckst, ertönt plötzlich ein lautes und chaotisches Geräusch in deinem Kopf. \n “Woher kommt dieses dreckige Kind!“ \n “Das ist die kleine Maus von der Straße, wie kann sie es wagen, den Schleier der Herzogin zu berühren!“ \n “Schmeißt ihn raus!“ \n “Hast du Münzen dabei? Ohne Münzen kannst du dir nicht einmal ein Schwarzbrot mitnehmen!“"
  },
  Event_7157_Name = {
    Text = "Buch der Leere"
  },
  Event_7158_ChoiceDesc1 = {
    Text = "[Verfolge die Melodie]Wähle eine Karte aus drei Befehlskarten und erhalte Gebet: „(EnchantConfig.Arg1)“"
  },
  Event_7158_ChoiceDesc2 = {
    Text = "[singe mit]Infektion“(Skill.Arg1)“，erneute Segnung, maximal 2 Mal"
  },
  Event_7158_Desc = {
    Text = "Die ferne Melodie zerbricht in Sternenstaub:\n„Ich verfluche das schmutzige Wasser in der Nachtgasse, die verfallene Mauer mit faulen Blumen, Ketten umschlingen das Gehirn und ziehen es in den Schlamm, bevor der Nebel meine Existenz auslöscht, wird die Dämmerung in die tiefste @2 sinken.“"
  },
  Event_7158_Name = {
    Text = "Weißes Fluch"
  },
  Event_7159_ChoiceDesc1 = {
    Text = "[Verehrung darbringen] Wähle 1 von 3 Befehlskarten aus, die das Gebet erhält: „(EnchantConfig.Arg1)\", infiziert „(Skill.Arg2)\""
  },
  Event_7159_ChoiceDesc2 = {
    Text = "[Es fortbringen] Wähle 1 von 3 Befehlskarten aus, die das Gebet erhält: „(EnchantConfig.Arg1)„, infiziert „(Skill.Arg2)"
  },
  Event_7159_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte 25 schwarze Siegel"
  },
  Event_7159_Desc = {
    Text = "Als du dich näherst, erscheint eine unordentliche chaotische Seele plötzlich aus dem Morast.\nDie schwarzen Arme umschlingen dich fest, sie weint und fleht –\nverbinde ein Opfer oder bringe mich weg"
  },
  Event_7159_Name = {Text = "Chaosgeist"},
  Event_7160_ChoiceDesc1 = {
    Text = "[Opfer hinterlassen]Zufällig die Qualität der Orison einer Karte erhöhen"
  },
  Event_7160_ChoiceDesc2 = {
    Text = "[Es mitnehmen] Wähle 1 von 3 Befehlskarten aus, um das Gebet zu erhalten: „(EnchantConfig.Arg1)\", infiziere „(Skill.Arg2)\""
  },
  Event_7160_Desc = {
    Text = "Als du dich näherst, erscheint eine unordentliche chaotische Seele plötzlich aus dem Morast.\nDie schwarzen Arme umschlingen dich fest, sie weint und fleht –\nverbinde ein Opfer oder bringe mich weg"
  },
  Event_7160_Name = {Text = "Chaosgeist"},
  Event_7161_ChoiceDesc1 = {
    Text = "[Mit der Hand verscheuchen] Eine zufällige Befehlskarte erhält das Gebet: „(EnchantConfig.Arg1)\", infiziert „(Skill.Arg2)\""
  },
  Event_7161_ChoiceDesc2 = {
    Text = "[Lass es verweilen]Wähle eine von 3 Befehlskarten und erhalte das Orison: „(EnchantConfig.Arg1)“"
  },
  Event_7161_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte 25 schwarze Siegel"
  },
  Event_7161_Desc = {
    Text = "Die Flügel des Schmetterlings trugen schwarze Flüssigkeit, schwankten hoch und tief und flogen vorbei, die Schichten von schwarzem Schleim, die von den Flügeln tropften, verfestigten sich und wurden vom Wind verweht.\nEr war müde und landete auf deiner Nasenspitze"
  },
  Event_7161_Name = {
    Text = "Schwarze Flüssigkeitsfalter"
  },
  Event_7162_ChoiceDesc1 = {
    Text = "[Mit der Hand verscheuchen] Wähle 1 von 3 Befehlskarten aus, die das Gebet erhält: „(EnchantConfig.Arg1)\", infiziert „(Skill.Arg2)\""
  },
  Event_7162_ChoiceDesc2 = {
    Text = "[Lass es verweilen]Erhalte ein Silberrelikt „(RelicConfig.Arg1)“, infiziere „(Skill.Arg2)“"
  },
  Event_7162_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte 25 schwarze Siegel"
  },
  Event_7162_Desc = {
    Text = "Die Flügel des Schmetterlings trugen schwarze Flüssigkeit, schwankten hoch und tief und flogen vorbei, die Schichten von schwarzem Schleim, die von den Flügeln tropften, verfestigten sich und wurden vom Wind verweht.\nEr war müde und landete auf deiner Nasenspitze"
  },
  Event_7162_Name = {
    Text = "Schwarze Flüssigkeitsfalter"
  },
  Event_7163_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7163_Desc = {
    Text = "“Ich sehe Mut, ich sehe Willen, ich sehe einen strahlenden Geist. Gehe zu der in Wachs versiegelten Erinnerung, du wirst Erfolg haben.“"
  },
  Event_7163_Name = {
    Text = "Verfolgungsobjekt"
  },
  Event_7164_ChoiceDesc1 = {
    Text = "[Verweilen lassen] Wähle 1 von 3 Befehlskarten aus, die das Gebet erhält: „(EnchantConfig.Arg1)\", infiziert „(Skill.Arg2)\""
  },
  Event_7164_ChoiceDesc2 = {
    Text = "[Wegwinken]erhalte Silberrelikt „(RelicConfig.Arg1)“, infektiere „(Skill.Arg2)“"
  },
  Event_7164_ChoiceDesc3 = {
    Text = "[Begrüße die Biene]Erhalte 25 das schwarze Siegel"
  },
  Event_7164_Desc = {
    Text = "Ihr wandert durch das kalte Sanatorium, als ein schwarzer Schmetterling, der in dieser Jahreszeit nicht existieren sollte, heranflattert.\nSeine Flügel tragen schwarze Flüssigkeit, die beim Fliegen tropft und nach dem Trocknen abblättert.\nEr landet erschöpft auf deinem Finger"
  },
  Event_7164_Name = {
    Text = "Etwas, das nicht existieren sollte"
  },
  Event_7165_ChoiceDesc1 = {
    Text = "[Verlassen]Erhalte eine Auswahl von 3 für 1 Silberrelikt, infiziere“(Skill.Arg1)“"
  },
  Event_7165_Desc = {
    Text = "Du fühlst dich müde.\nDein Bewusstsein zieht dich über Teiche, über Berge,\nfliegt über die Sonne hinaus, über Lichtjahre hinweg,\nzu dieser einzigartigen... Wiege des Universums"
  },
  Event_7165_Name = {
    Text = "Abschlusszeremonie IV"
  },
  Event_7166_ChoiceDesc1 = {
    Text = "[Weitersuchen]"
  },
  Event_7166_Desc = {
    Text = "Ein riesiger Schatten hüllt dich vollständig ein, stinkender Speichel durchnässt dich.\n„Kleines Mäuschen, komm her. Nur für einen Moment...“\n„Ich schwöre, ich will dich nicht fressen...“\n„Ich werde deinen saftigen Bauch nicht einmal ansehen!“"
  },
  Event_7166_Name = {
    Text = "Material Nr. 12"
  },
  Event_7167_ChoiceDesc1 = {
    Text = "[Weitersuchen]"
  },
  Event_7167_Desc = {
    Text = "Der ausgetrocknete Wachspuppen-Philosoph raucht, umhüllt von weißem Rauch.\n“Das Jenseits existiert, aber ist unerkennbar, daher ist es unbekannt.“\n“Stell dir diese Welt als Spiel vor...\nWas du suchst, könnte auf der anderen Seite der Karte sein.“"
  },
  Event_7167_Name = {
    Text = "Material Nr. 45"
  },
  Event_7168_ChoiceDesc1 = {
    Text = "[Weitersuchen]"
  },
  Event_7168_Desc = {
    Text = "“Es tut mir leid, ich wollte nicht angreifen...“\n“Ich mag keine Ratten. Das Problem mit Ratten ist, dass sie keine Angst vor Menschen haben...“\nDer bärtige Alte liegt in der Ecke und seine melancholischen Augen starren dich an.\n“Natürlich seid ihr sehr ehrgeizig. \nDas ist gut, aber nicht genug, um euch vor der Katastrophe zu bewahren...“"
  },
  Event_7168_Name = {Text = "Material 4"},
  Event_7169_ChoiceDesc1 = {
    Text = "[Den Fluch zeigen] Wähle 1 von 3 Befehlskarten aus, um ein Gebet zu erhalten: „(EnchantConfig.Arg1)\", infiziere „(Skill.Arg2)\""
  },
  Event_7169_ChoiceDesc2 = {
    Text = "[Weigere dich gegen die Krähe] erhält 1 aus 3 Gebete"
  },
  Event_7169_ChoiceDesc3 = {
    Text = "[Ignorieren]"
  },
  Event_7169_Desc = {
    Text = "Ein schwarzer, kranker многоголовый Rabe fliegt aus dem schwarzen Umhang eines Tempellicht-Gläubigen und landet auf deiner Schulter.\n„Siehst du meinen Kopf? Wenn ich den Fluch koste, werde ich einen neuen Kopf wachsen lassen. Lass mich sehen, deinen Fluch!“"
  },
  Event_7169_Name = {Text = "Fluchrabe"},
  Event_7170_ChoiceDesc1 = {
    Text = "[Ruf folgen]1 Befehlskarte löschen und Arg1 Leben wiederherstellen"
  },
  Event_7170_ChoiceDesc2 = {
    Text = "[Ich fliehe nicht]erhalte das goldene Relikt“(RelicConfig.Arg1)“、infiziere“(Skill.Arg2)“"
  },
  Event_7170_Desc = {
    Text = "Du rennst hastig durch die Gasse. Adrenalin wird freigesetzt, Milchsäure entsteht, Glukose wird verbraucht... Chaos erodiert dein Gehirn, besetzt deine Gedanken und drängt dich in bunten Illusionen zur Flucht ins Ziel. \n Ja, Flucht. Wenn du wirklich nicht fliehen würdest, warum erwartet dich dann Chaos und Nichtigkeit, das Nichts und das vergebliche Ende?"
  },
  Event_7170_Name = {Text = "Laufen"},
  Event_7171_ChoiceDesc1 = {
    Text = "[Der Klang nachspüren]"
  },
  Event_7171_ChoiceDesc2 = {
    Text = "[Lily und Kum rufen]"
  },
  Event_7171_Desc = {
    Text = "Am Ende des Dimensionstunnels ertönt eine tiefe, raue Stimme, die mit Angst, Erwartung und Unruhe vermischt ist, als würde sie euch rufen. Bald darauf folgen die verschwommenen Worte eines Mädchens, und die beiden Stimmen verebben allmählich"
  },
  Event_7171_Name = {Text = "Leitstimme"},
  Event_7172_ChoiceDesc1 = {
    Text = "[Einstecken]"
  },
  Event_7172_Desc = {
    Text = "Eine quecksilberähnliche silberne Substanz, extrahiert aus ätzendem Schleim, enthält starke geistige Energie, hauptsächlich verwendet, um in Ritualen mehr Erwachte zu verbinden"
  },
  Event_7172_Name = {Text = "Silberkern"},
  Event_7173_ChoiceDesc1 = {
    Text = "[Bitte ihn, den Weg freizumachen]"
  },
  Event_7173_ChoiceDesc2 = {
    Text = "[Frage nach Identität]"
  },
  Event_7173_Desc = {
    Text = "Ihr betretet einen dunklen Waggon, ein seltsames Gefühl steigt in eure Herzen. \n Dieser Waggon ist leer, die Passagiere sind längst geflohen, am Boden liegen die Körperreste von Monstern, die allmählich verschwinden. \n In der Mitte des Waggons steht der Mann. \n “Ich glaube, dass es Schicksal gibt, und es ist das Schicksal, das uns in dieselbe U-Bahn gebracht hat.“"
  },
  Event_7173_Name = {
    Text = "Seltsamer Begleiter IV"
  },
  Event_7174_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7174_Desc = {
    Text = "“Deine Augen sind wunderschön, sie sind wie Sterne.“\nCharlotte lachte kichernd, ihr wild umherfliegendes Haar fiel sanft herab. \n“Du bist in der Schule bestimmt sehr beliebt, ich mag dich auch.“\nBevor sie ging, küsste sie deine Stirn. \nDu fühlst dich warm und es scheint, als wäre etwas anders geworden."
  },
  Event_7174_Name = {
    Text = "Schatten des Ermittlers"
  },
  Event_7175_ChoiceDesc1 = {
    Text = "[Lesen]Wähle eine Karte aus drei Befehlskarten und erhalte Gebet: „(EnchantConfig.Arg1)“"
  },
  Event_7175_ChoiceDesc2 = {
    Text = "[In den Koffer stecken]Infektion“(Skill.Arg1)“，Schöpfung erhalten：“(RelicConfig.Arg2)“"
  },
  Event_7175_Desc = {
    Text = "Ein vergilbtes Blatt Papier fiel aus dem Mantel der Laternenträger. \n Auf dem Papier war dicht mit seltsamen, ungewöhnlich geformten Texten beschriftet, einige ähnelten Hieroglyphen, andere waren merkwürdig nach oben geneigt, und einige Schriftzeichen überlappten sich sogar, sodass nur wenige Wörter mühsam zu erkennen waren."
  },
  Event_7175_Name = {
    Text = "Geheimer Befehl · Oben"
  },
  Event_7176_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7176_Desc = {
    Text = "Du sagst: „Ach, Charlotte! Das geht nicht!“\n Charlottes Haare winden sich wie verrückt, sie ist wütend.\n„Ich werde es dir beweisen! Schau dir meine Fähigkeiten an!“"
  },
  Event_7176_Name = {
    Text = "Schatten des Ermittlers"
  },
  Event_7177_ChoiceDesc1 = {
    Text = "[Infiziere“(Skill.Arg1)“、erhalte das silberne Relikt“(RelicConfig.Arg2)“]"
  },
  Event_7177_ChoiceDesc2 = {
    Text = "[Verlassen]Erhalte 25 schwarze Siegel"
  },
  Event_7177_Desc = {
    Text = "Ereignis 302 (in Entwicklung), nicht das Endergebnis"
  },
  Event_7177_Name = {
    Text = "Ereignis 302 (in Entwicklung)"
  },
  Event_7178_ChoiceDesc1 = {
    Text = "[Anfrage empfangen]infiziere „(Skill.Arg1)“, erhalte Silberrelikt „(RelicConfig.Arg2)“"
  },
  Event_7178_ChoiceDesc2 = {
    Text = "[Weigere dich gegen die Anfrage] erhält +25 das schwarze Siegel"
  },
  Event_7178_Desc = {
    Text = "Der Kiefer knirscht mit einem gewissen rhythmischen Geräusch, und dein Begleiter versteht zufällig etwas von Kryptographie. \n Der entschlüsselte Text lautet: \n “Hallo, nenn mich bitte @2 Doktor. Ich war einmal ein Sammler, Naturforscher... \n (Hier folgt eine lange und ausführliche Vorstellung meiner Karriere und Titel, gekürzt) \n Kurz gesagt, kannst du mir helfen, meine andere Hälfte zu finden? Es handelt sich um einen kleinen Oberkiefer. \n Wenn du ihn findest, wird mein privater Schatzraum für dich geöffnet.“"
  },
  Event_7178_Name = {Text = "knarrend"},
  Event_7179_ChoiceDesc1 = {
    Text = "[Investiere hundert Fang] Infektion „(Skill.Arg1)“, erhält Silberrelikt „(RelicConfig.Arg2)“"
  },
  Event_7179_ChoiceDesc2 = {
    Text = "[Investiere fünf Fragmente] erhält +25 das schwarze Siegel"
  },
  Event_7179_Desc = {
    Text = "Eine bestickte Geldbörse kriecht auf dich zu und öffnet ihr schwarzes Maul.\nSeit sie ihre reiche Besitzerin verlassen hat, ist sie seit Jahrzehnten hungrig und muss gefüllt werden.\nDu schaust hinein, aber es ist leer, nur undurchdringliche Dunkelheit"
  },
  Event_7179_Name = {
    Text = "gierige Börse"
  },
  Event_7180_ChoiceDesc1 = {
    Text = "[Fester Entschluss]1 Befehlskarte löschen, Arg1 HP wiederherstellen"
  },
  Event_7180_ChoiceDesc2 = {
    Text = "[Der Durst nach Erfolg]Erhalte ein goldenes Relikt „(RelicConfig.Arg1)“, infiziere „(Skill.Arg2)“"
  },
  Event_7180_Desc = {
    Text = "“Zwei sture Kerle, das Armenhaus ist schon sehr gefährlich,“hörte man plötzlich Dols Stimme im Kommunikator, “wie plant ihr, weiter vorzugehen? Soll ich ihr den Kopf wieder annähen?“\n“Jetzt ist nicht die Zeit für schlaue Sprüche, Doll!“\n“Ich weiß, ich kann es hören.“sagte Doll, “Beruhigt euch, wisst ihr, was der Schlüssel zum Erfolg ist?“"
  },
  Event_7180_Name = {
    Text = "Logans Regel"
  },
  Event_7181_ChoiceDesc1 = {
    Text = "[Infiziere“(Skill.Arg1)“、erhalte das silberne Relikt“(RelicConfig.Arg2)“]"
  },
  Event_7181_ChoiceDesc2 = {
    Text = "[Verlassen]Erhalte 25 schwarze Siegel"
  },
  Event_7181_Desc = {
    Text = "Ereignis 304 (in Entwicklung), nicht das Endergebnis"
  },
  Event_7181_Name = {
    Text = "Ereignis 304 (in Entwicklung)"
  },
  Event_7182_ChoiceDesc1 = {
    Text = "[Infiziere“(Skill.Arg1)“、erhalte das silberne Relikt“(RelicConfig.Arg2)“]"
  },
  Event_7182_ChoiceDesc2 = {
    Text = "[Verlassen]Erhalte 25 schwarze Siegel"
  },
  Event_7182_Desc = {
    Text = "Ereignis 305 (in Entwicklung), nicht das Endergebnis"
  },
  Event_7182_Name = {
    Text = "Ereignis 305 (in Entwicklung)"
  },
  Event_7183_ChoiceDesc1 = {
    Text = "[Hörer ablegen]erhalte 3 wähle 1 fortgeschrittenes Gebet"
  },
  Event_7183_ChoiceDesc2 = {
    Text = "[Anruf entgegennehmen]erhalte goldenes Relikt „(RelicConfig.Arg1)“, infektiere „(Skill.Arg2)“"
  },
  Event_7183_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte 50 schwarze Siegel"
  },
  Event_7183_Desc = {
    Text = "Ihr passiert das Ruhezimmer des Zugführers, und in einer versteckten Ecke klingelt das Telefon schrill"
  },
  Event_7183_Name = {
    Text = "Zug anrufen"
  },
  Event_7184_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7184_Desc = {
    Text = "Der Glanz war düster, aber tatsächlich existent. \nSo ein trübes Silberchip ist schwer zu beschwören, um einen Erwecker zu wecken, aber es eignet sich hervorragend zum Stärken— so funktioniert die Silberchiptechnologie"
  },
  Event_7184_Name = {
    Text = "Beweis der Existenz"
  },
  Event_7185_ChoiceDesc1 = {
    Text = "[Damenporträt]steigere zufällig die Qualität einer Karte"
  },
  Event_7185_ChoiceDesc2 = {
    Text = "[Wachsfiguren-Familienfoto] Wähle 1 von 3 Befehlskarten aus, um das Gebet zu erhalten: „(EnchantConfig.Arg1)\", infiziere „(Skill.Arg2)\""
  },
  Event_7185_Desc = {
    Text = "Im Wachsfigurenkabinett sind gleichzeitig zahlreiche Gemälde ausgestellt.\nPorträts, Landschaften, Stillleben, realistisch, abstrakt...\nSie dekorieren die ursprünglich eintönischen Wände, sodass sie nicht langweilig erscheinen.\nDein Blick wird von einem der Werke angezogen, es ist ein"
  },
  Event_7185_Name = {
    Text = "Porträtgalerie"
  },
  Event_7186_ChoiceDesc1 = {
    Text = "[Weiter blättern]Zufällig 1 Befehlskarte, um ein Gebet zu erhalten:“(EnchantConfig.Arg1)“"
  },
  Event_7186_ChoiceDesc2 = {
    Text = "[Verlassen]Erhöhe Arg1 maximale Gesundheit, infiziere“(Skill.Arg2)“"
  },
  Event_7186_Desc = {
    Text = "Eine Waage zum Wiegen.\nDahinter sind unzählige Organe in rotem Formalin eingelegt.\nSie sind ordentlich im Regal gestapelt.\nDu greifst nach einem Notizbuch und blätterst: „Herz: 8 Unzen, Gehirn: 50 Unzen...“"
  },
  Event_7186_Name = {
    Text = "Organregistrierung"
  },
  Event_7187_ChoiceDesc1 = {
    Text = "[Geschenk öffnen] Spezialkarte erhalten"
  },
  Event_7187_Desc = {
    Text = "Der Schatten des Kindes huscht vorbei, und du kannst nicht unterscheiden, ob es sich um ein echtes Kind oder einen Projektion einer Art Geist im geheimen Bereich handelt. Aber – du siehst auf die zurückgelassene Schachtel auf dem Boden, auf der in sanfter Schrift „Geschenk“ steht"
  },
  Event_7187_Name = {
    Text = "Geschenk der Güte"
  },
  Event_7188_ChoiceDesc1 = {
    Text = "[Rufen der Krähe]erhält 40 das schwarze Siegel, infiziert „(Skill.Arg2)“, weiter wählen"
  },
  Event_7188_ChoiceDesc2 = {
    Text = "[Weit ziehen]Erhalte 25 das schwarze Siegel"
  },
  Event_7188_Desc = {
    Text = "Weiße Möwen ruhen auf dem Mast, der mit Reif bedeckt ist.\nDie Pfeifen vibrieren im Einklang, sie stoßen das Schwarze ab, das nicht zum Ozean gehört"
  },
  Event_7188_Name = {
    Text = "Aussätzige Krähe"
  },
  Event_7189_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7189_Desc = {
    Text = "Du erkennst, dass das Lied von einem Liebeslied abgeleitet ist.\nAm Ende des Liebesliedes sagt der Dichter:\n“Bis die Stimmen der Menschen uns wecken, ertrinken wir.“\nNicht jetzt, denkst du.\nDu wartest immer noch darauf, dass die Menschen dich wecken"
  },
  Event_7189_Name = {
    Text = "Rabenstimme"
  },
  Event_7190_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7190_Desc = {
    Text = "Eine staubige Filmrolle. Aber es gibt keinen Projektor im Raum, und es ist nicht die Zeit, das Anwesen, den Film und den Nachmittagstee zu genießen.\nVielleicht wirst du erst viel später die Gelegenheit haben, den Inhalt des Films zu erfahren"
  },
  Event_7190_Name = {
    Text = "Erinnerungsschein"
  },
  Event_7191_ChoiceDesc1 = {
    Text = "[Verlassen]Erhalte eine Auswahl von 3 für 1 fortgeschrittenes Gebet, infiziere“(Skill.Arg1)“"
  },
  Event_7191_Desc = {
    Text = "Du folgst dem Jungen, nicht zu nah und nicht zu weit. \nTapp. Tapp. Tapp... Der Junge hält an der Straßenecke an. \nDu siehst das wacklig rote Licht hinter ihm, und dein Instinkt sagt dir, dass das Wachsfigurenmuseum vor dir liegt. \nDer Junge dreht sich um. Er hat keine Augen, in seinen Augenhöhlen ist es schwarz. \nEr lächelt dich an."
  },
  Event_7191_Name = {
    Text = "Abschlusszeremonie I"
  },
  Event_7192_ChoiceDesc1 = {
    Text = "[Verlassen]Erhalte 50 schwarze Siegel, infiziere“(Skill.Arg1)“"
  },
  Event_7192_Desc = {
    Text = "Du klopfst ihm auf die Schulter. \n Der Junge dreht sich um, er hat keine Augen, in seinen Augenhöhlen ist es schwarz. \n “Guten Abend. Ich suche den Weg zum Wachsfigurenmuseum.“ \n Der Junge zeigt nach vorne. Du siehst das wacklig rote Licht hinter ihm. \n Dein Instinkt sagt dir, dass das Wachsfigurenmuseum dort ist. \n Als du wieder zu dir kommst, ist der Junge schon verschwunden, nur der Schatten der Straßenlaterne bleibt zurück."
  },
  Event_7192_Name = {
    Text = "Abschlusszeremonie I"
  },
  Event_7193_ChoiceDesc1 = {
    Text = "[Drücke den Raben]erhalte 35 das schwarze Siegel, infiziere“(Skill.Arg2)“，setze fort die Auswahl"
  },
  Event_7193_ChoiceDesc2 = {
    Text = "[Lass es bleiben]Verlassen"
  },
  Event_7193_Desc = {
    Text = "Eine einsame Krähe zupft sich heiser eine nach der anderen ihre schwarzen Federn aus.\nSie zittert vor Schmerz, schreit laut, kann aber nicht aufhören.\n„Krah—Krah—“\nBlaue Tränen, vermischt mit schwarzem Schleim, fließen aus ihren Augen, nur du siehst es"
  },
  Event_7193_Name = {
    Text = "Träne der geschmolzenen Lava"
  },
  Event_7194_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7194_Desc = {
    Text = "Unbezahlbares Wissen strömte in deinen Geist und verwandelte sich dann in Nebel... Als du wieder zu dir kamst, war das seltsame Buch mit dem gelben Einband verschwunden"
  },
  Event_7194_Name = {
    Text = "gelbe Schriftrolle"
  },
  Event_7195_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7195_Desc = {
    Text = "Du hast diese Wachsfiguren leicht besiegt. Sie liegen kopfüber vor dir. \n Am Boden der Wachsfiguren scheinen einige Zeilen Text geschrieben zu sein. \n “Überschwemmung @2 Jahr 11 \n Von Rogers im @2 Institut hergestellt“ \n Du erinnerst dich, dass Rogers an einer Kunstakademie im Bereich Skulptur studiert hat. Diese unbeholfenen Wachsfiguren sind sicherlich seine frühen Übungen."
  },
  Event_7195_Name = {Text = "Übung"},
  Event_7196_ChoiceDesc1 = {Text = "[Warum?]"},
  Event_7196_ChoiceDesc2 = {
    Text = "[In die Tiefe stürzen]"
  },
  Event_7196_Desc = {
    Text = "“Fälschung! Gib mir meinen Sohn zurück!“\n“Bist du nicht die Heilige Jungfrau des Schiffs? Ist es nicht deine Pflicht, die Schiffe zu beschützen? Warum ist nur ein Schiff zurückgekommen, sag es, sag es!“\n“Ertränkt sie! Mein Vater musste leiden, bevor er starb, sie muss es auch erleiden!“\n“Ertränkt sie, ertränkt sie!“\n“Ertränkt diese Fälschung! Bindet sie an den Stein!“\nDas Meerwasser strömte in ihre Nase und der Luft wurde aus jedem Winkel ihrer Lungen gedrückt, während sie dieses prächtige, reinweiße Kleid trug. \nFast der erste Gedanke, der nach der Heiligsprechung aufkam, kroch aus der dunkelsten Ecke ihres Kopfes hervor, kam verspätet. \n“Ja, warum sind diese Schiffe gesunken?“"
  },
  Event_7196_Name = {
    Text = "Sunkene See"
  },
  Event_7197_ChoiceDesc1 = {
    Text = "[Drücke den Raben]erhalte 30 das schwarze Siegel, infiziere“(Skill.Arg2)“，setze fort die Auswahl"
  },
  Event_7197_ChoiceDesc2 = {
    Text = "[Lass es bleiben]Verlassen"
  },
  Event_7197_Desc = {
    Text = "Eine einsame Krähe zupft sich heiser eine nach der anderen ihre schwarzen Federn aus.\nSie zittert vor Schmerz, schreit laut, kann aber nicht aufhören.\n„Krah—Krah—“\nBlaue Tränen, vermischt mit schwarzem Schleim, fließen aus ihren Augen, nur du siehst es"
  },
  Event_7197_Name = {
    Text = "Träne der geschmolzenen Lava"
  },
  Event_7198_ChoiceDesc1 = {
    Text = "[Weiter suchen]Erhöhe Arg1 Leben, infiziere“(Skill.Arg2)“"
  },
  Event_7198_ChoiceDesc2 = {
    Text = "[Verlassen]"
  },
  Event_7198_Desc = {
    Text = "Es scheint, als hätte jemand seine Hände auf deine Schultern gelegt, fest und entschlossen, aber als du dich umdrehst, ist das Gefühl verschwunden"
  },
  Event_7198_Name = {
    Text = "Abnormale Verbindung"
  },
  Event_7199_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7199_Desc = {
    Text = "Die Ryelway-Brücke, die Blutgefäße und Nerven von Lentiniën, verbindet das Herz und die Gliedmaßen der Stadt. Das Rai Sanatorium wartet ruhig an den Spitzen der Gliedmaßen auf die Lieferung von Blut und Signalen."
  },
  Event_7199_Name = {
    Text = "Eisenbahnillusion"
  },
  Event_7200_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7200_Desc = {
    Text = [[
Du stellst den Koffer auf den Boden und trittst mehrmals darauf, um sicherzustellen, dass er nicht mehr zittert, bevor du ihn wieder aufhebst.
Du klopfst den Staub ab und setzt euren Weg unter Murphys fragenden Blicken fort]]
  },
  Event_7200_Name = {
    Text = "Ungebetener Brief"
  },
  Event_7201_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7201_Desc = {
    Text = "Gefahr lauert hinter einer Holztür, nicht die Zeit, um zu verweilen. Pack es in deinen Koffer"
  },
  Event_7201_Name = {
    Text = "gelbe Schriftrolle"
  },
  Event_7202_ChoiceDesc1 = {
    Text = "[vertreibe die Krähen]Erhalte Arg1 schwarze Siegel, Infektion“(Skill.Arg2)“，weiter wählen"
  },
  Event_7202_ChoiceDesc2 = {
    Text = "[Ignorieren]Verlassen"
  },
  Event_7202_Desc = {
    Text = "Es, oder sie, kreisen im Schlafzimmer und lassen die Lampenschirme klirren"
  },
  Event_7202_Name = {
    Text = "Laternenschwarzer Rabe"
  },
  Event_7203_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7203_Desc = {
    Text = "Dies ist die Dimension des Geistes, die Welt der Gnosis.\nAußer deinen Verstand zu verwirren, können sie nichts tun"
  },
  Event_7203_Name = {
    Text = "Geistessturm"
  },
  Event_7204_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7204_Desc = {
    Text = "Schädel: Hank Tillinghast A.F.186-A.F.203 Kreol-Insel\nWirbelsäule: Andy Crawford A.F.177-A.F.203 Narragansett\n...nicht weiter darüber nachdenken"
  },
  Event_7204_Name = {Text = "Schild"},
  Event_7205_ChoiceDesc1 = {
    Text = "[Überprüfe die Fragmente]Erhalte zufällig 3 Befehlskarten aus dem Deck, wähle 1 Karte zum Löschen und erhalte 75 schwarze Siegel"
  },
  Event_7205_ChoiceDesc2 = {
    Text = "[Frage die Puppe]Erhalte zufällig 3 Befehlskarten aus dem Deck, wähle eine Karte aus, kopiere sie und füge sie ins Deck ein, erhalte 25 schwarze Siegel"
  },
  Event_7205_ChoiceDesc3 = {
    Text = "[Ignoriere]erhalte 50 das schwarze Siegel"
  },
  Event_7205_Desc = {
    Text = "Der Metallfragment, den dir Dorl gab, bewegte sich unruhig an deiner Brust, als wäre er ein erschreckter Schmetterling"
  },
  Event_7205_Name = {
    Text = "Unruhige Brosche"
  },
  Event_7206_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7206_Desc = {
    Text = "“Er wartet still am Ende, egal wo du das Ende setzt – sieh dir die junge Verwalterin an, ihr Ausweichen führt letztlich zum Wahnsinn.“"
  },
  Event_7206_Name = {
    Text = "Verfolgungsobjekt"
  },
  Event_7207_ChoiceDesc1 = {
    Text = "[Verlassen]Nichts gefunden"
  },
  Event_7207_Desc = {
    Text = "In Entwicklung, spezielles Ereignis"
  },
  Event_7207_Name = {
    Text = "2_16 vorübergehend"
  },
  Event_7208_ChoiceDesc1 = {
    Text = "[Es trösten]erhöhe Arg1 Punkte maximale Gesundheit"
  },
  Event_7208_ChoiceDesc2 = {
    Text = "[Es übergehen] 2 zufällige Befehlskarten erhalten ein Gebet: „(EnchantConfig.Arg1)\", infiziere 2 „(Skill.Arg2)\""
  },
  Event_7208_Desc = {
    Text = "Die Verbindung wärmt das noch menschliche Herzorgan.\nEs imitiert den Atemrhythmus der anderen Seite der Verbindung, als ob es dadurch nicht verlassen würde, als ob es das Recht hätte, für immer mit der Verbindung zu gehen"
  },
  Event_7208_Name = {
    Text = "Linkes Vorhof"
  },
  Event_7209_ChoiceDesc1 = {
    Text = "Zufälliges fortgeschrittenes Gebet"
  },
  Event_7210_ChoiceDesc1 = {
    Text = "[Verlassen]Erhalte 25 schwarze Siegel"
  },
  Event_7210_Desc = {
    Text = "Deine Kälte enttäuscht den Sprecher, das Wasser kräuselt sich träge und wird wieder ruhig"
  },
  Event_7210_Name = {
    Text = "Stimmen aus dem Jenseits"
  },
  Event_7211_ChoiceDesc1 = {
    Text = "[Wähle eine Karte, um Gebet zu erhalten: „(EnchantConfig.Arg1)“]Testgebet"
  },
  Event_7211_ChoiceDesc2 = {
    Text = "[Wähle eine Karte, um Gebet zu erhalten: „(EnchantConfig.Arg1)“]Testfall"
  },
  Event_7211_Desc = {
    Text = "Test zur spezifischen Orison"
  },
  Event_7211_Name = {
    Text = "Spezifische Gebetsprüfung 1"
  },
  Event_7212_ChoiceDesc1 = {
    Text = "[Verlassen]Wähle einen Erwecker, den du erwecken möchtest"
  },
  Event_7212_Desc = {
    Text = "Du streichelst dem Jungen über den Kopf und führst ihn dazu, mit dir weiterzusprechen. \n“Ein Lied für Mama——“ \nDie Stimme gleicht einer Motte in der Dunkelheit, schwebt gemeinsam von der leeren Bühne \nund fällt sanft in die tiefschwarze Zuschauerreihe."
  },
  Event_7212_Name = {
    Text = "Abschlusszeremonie III"
  },
  Event_7213_ChoiceDesc1 = {
    Text = "[Verlassen]Erhalte eine Auswahl von 3 für 1 goldenes Relikt, infiziere“(Skill.Arg1)“"
  },
  Event_7213_Desc = {
    Text = "Du bleibst unbemerkt. Eine Dame stürzt plötzlich auf die Bühne. \nSie reist dem Jungen mit Wucht den Mund auf und sticht ihm den Stock tief hinein. \n„Sprich, sprich mit mir.“ \nAus dem Mund des Jungen fließt schwarzes Blut. Er murmelt weiter. \n„Ein Lied für Mama...“"
  },
  Event_7213_Name = {
    Text = "Abschlusszeremonie III"
  },
  Event_7215_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7215_Desc = {
    Text = "Das ist kein Fenster, sondern ein Spiegel. Darin spiegelt sich Ramonas angespannte Gesicht.\nWarum gibt es in diesem Raum keine Fenster, sondern nur einen großen Spiegel an der Wand?"
  },
  Event_7215_Name = {
    Text = "Fensterspiegelung"
  },
  Event_7216_ChoiceDesc1 = {
    Text = "[Silberschlüssel halten]zufällig 1 Erwecker aktivieren, infektiere „(Skill.Arg1)“"
  },
  Event_7216_ChoiceDesc2 = {
    Text = "[Schließe die Augen]Wähle eine Karte aus drei Befehlskarten und erhalte Gebet: „(EnchantConfig.Arg1)“"
  },
  Event_7216_Desc = {
    Text = "Du wirst von einem gewaltigen Absurditätsgefühl zerrissen, deine Gliedmaßen kriechen verzerrt über den Boden, als würdest du von @2 aus einer anderen Dimension manipuliert. \n“Nein... Nein...“\n Dein Verstand bricht Stück für Stück zusammen, verworrene Lachen und Schreie vermischen sich, wie ein riesiges Netz, das dein Bewusstsein fesselt, und die Worte, die dir auf der Zunge liegen, sind nur unverständliches Jammern."
  },
  Event_7216_Name = {
    Text = "Blick des Auges"
  },
  Event_7217_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7217_Desc = {
    Text = "Die Farben der Galaxie verändern sich und zeichnen unbeschreibliche Muster unter deinen Füßen, prächtig wie Rubine, aber geschwollen wie Quallen. Der Koffer leuchtet rot"
  },
  Event_7217_Name = {
    Text = "Sternenkreuz"
  },
  Event_7218_ChoiceDesc1 = {
    Text = "[Vertreibe die Illusion]Stress +10"
  },
  Event_7218_ChoiceDesc2 = {
    Text = "[Verlassen]"
  },
  Event_7218_Desc = {
    Text = "Verschwommene Gesichter tauchen plötzlich auf, umgeben dich und stöhnen verzweifelt ohne Stimmbänder"
  },
  Event_7218_Name = {Text = "Illusion"},
  Event_7221_ChoiceDesc1 = {
    Text = "[Fangen]erhalte Silberrelikt „(RelicConfig.Arg1)“"
  },
  Event_7221_ChoiceDesc2 = {
    Text = "[Nach unten schauen]Erhalte 75 das schwarze Siegel, infiziere „(Skill.Arg2)“"
  },
  Event_7221_Desc = {
    Text = "Krähen kreisen am Himmel, der durch die kleinen Gassen in blockartige Formen zerschnitten wird, und geben ein beunruhigendes, dumpfes Geräusch von sich. \n Die Schwärme werden plötzlich unruhig, als ob eine krankhafte Natur verzerrt oder erweckt wurde. Sie schlagen und jagen sich gegenseitig mit Ungeduld und Aggressivität, während etwas in ihrem Gerangel herunterfällt."
  },
  Event_7221_Name = {
    Text = "wütende Rabenmenge"
  },
  Event_7222_ChoiceDesc1 = {
    Text = "[Anweisungen folgen]Erhöhe Leben um Arg1"
  },
  Event_7222_ChoiceDesc2 = {
    Text = "[Verlassen]"
  },
  Event_7222_Desc = {
    Text = "Du hast versucht, mit der Rückverfolgungskraft des Silberschlüssels den nächsten Verbindungspunkt zu finden, aber die erhaltenen Informationen waren mit unauffälligen Anomalien durchsetzt und schienen gestört zu sein"
  },
  Event_7222_Name = {
    Text = "Abnormale Verbindung"
  },
  Event_7223_ChoiceDesc1 = {
    Text = "[Übergebe Doll]Zufällig 1 Befehlskarte erhält das Gebet:“(EnchantConfig.Arg1)“"
  },
  Event_7223_ChoiceDesc2 = {
    Text = "[Lesen Sie das Schild]Erhöhe Arg1 Punkte maximale Gesundheit, infiziere “(Skill.Arg2)“"
  },
  Event_7223_Desc = {
    Text = "Von dem besiegten Experiment des Bildhauers fiel ein metallrahmiges Namensschild herunter. Der Silberschlüssel registrierte das Namensschild und leuchtete schwach auf"
  },
  Event_7223_Name = {Text = "Schild"},
  Event_7224_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7224_Desc = {
    Text = "Der Besitzer der Klinge stößt einen langen Schrei aus, als ob ein Geräusch klingt, das Berge und Meere durchbrechen könnte.\nDer Klang verweht sofort, und auch die anderen beiden Seefahrer verschwinden ohne Spur... es war nur eine Illusion, die im Bereich reflektiert wurde"
  },
  Event_7224_Name = {
    Text = "nicht aufgeben"
  },
  Event_7225_ChoiceDesc1 = {
    Text = "[Wachsfigur restaurieren] wählt eine Karte und reduziert ihre Arithmetica um 1"
  },
  Event_7225_Desc = {
    Text = "Du hältst eine Kerze und gehst durch den Nebel zu ihr.\nEs ist eine unvollendete Wachsfigur.\nIhr schönes Gesicht ist in zwei Hälften geteilt, eine lächelt, die andere @1.\nWerde ihr Gott.\nGib ihr Schönheit, gib ihr Tränen.\nForme sie oder zerstöre sie"
  },
  Event_7225_Name = {
    Text = "Unfertige Wachsfigur"
  },
  Event_7226_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7226_Desc = {
    Text = "“Natürlich, ich habe den Untergang mit eigenen Augen gesehen.“ antwortest du.\nJa, es war nur der plötzliche Tod einer kleinen Maus, das Verfaulen eines Herzens und die Beerdigung einer Iris in der Nacht.“"
  },
  Event_7226_Name = {
    Text = "Vergessenes Götterreich"
  },
  Event_7227_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7227_Desc = {
    Text = "“Gottes Reich... vergeht... die schattenhaften Themen... Ich weiß nicht, was es bedeutet, zu vergehen。“\nZwei Gestalten lächelten leise und ihre Umgebung erhellte sich mit schneeweißen Lichtsplittern.\n“In diesem Moment wirst du ein wahres Vergehen erleben.“"
  },
  Event_7227_Name = {
    Text = "Vergessenes Götterreich"
  },
  Event_7228_ChoiceDesc1 = {
    Text = "[Füge das Papier zusammen] erhält goldenes Relikt „(RelicConfig.Arg1)“, Infektion „(Skill.Arg2)“"
  },
  Event_7228_ChoiceDesc2 = {
    Text = "[Lesen]Wähle eine Karte aus drei Befehlskarten und erhalte Gebet: „(EnchantConfig.Arg1)“"
  },
  Event_7228_ChoiceDesc3 = {
    Text = "[Es abwerfen]Erhalte 50 das schwarze Siegel"
  },
  Event_7228_Desc = {
    Text = "Ein vergilbtes Blatt Papier fiel aus dem Mantel der Laternenträger. \n Auf dem Papier war dicht mit seltsamen Texten beschriftet, einige ähnelten Hieroglyphen, andere waren merkwürdig nach oben geneigt, und einige Schriftzeichen überlappten sich sogar, sodass nur wenige Wörter mühsam zu erkennen waren. \n Der Titel lautet «@2 Geburt des Heiligen Sohnes»."
  },
  Event_7228_Name = {
    Text = "Geheimer Befehl · Unten"
  },
  Event_7229_ChoiceDesc1 = {
    Text = "[Kampf]erhalte Silberrelikt „(RelicConfig.Arg1)“, infektiere „(Skill.Arg2)“"
  },
  Event_7229_ChoiceDesc2 = {
    Text = "[Eingesunken]Erhalte ein silbernes Relikt „(RelicConfig.Arg1)“, infiziere „(Skill.Arg2)“"
  },
  Event_7229_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte 25 schwarze Siegel"
  },
  Event_7229_Desc = {
    Text = "“Ich leide so sehr, so sehr...“\n“Warum ich, warum muss ich das durchmachen?“\n“Barmherziger Vater, was habe ich falsch gemacht?“\nTrauer, Schmerz, Wut, Unzufriedenheit... Die Gefühle der „Patienten“ lasteten schwer auf dir, du hieltest dir die Brust, unfähig zu atmen"
  },
  Event_7229_Name = {Text = "Sucht"},
  Event_7230_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7230_Desc = {
    Text = [[
Der Blick durchdringt das Fleisch und brennt sich auf die Netzhaut des Vorreiters ein.
Niemand kann entkommen, genauso wie niemand@2]]
  },
  Event_7230_Name = {Text = "spähen"},
  Event_7231_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7231_Desc = {
    Text = "Konzentriere dich, erkenne die Texte, dann trifft dich das chaotische Wortgeflecht im Hinterkopf.\nDas sind keine Worte, die Menschen verstehen können"
  },
  Event_7231_Name = {Text = "Meereslied"},
  Event_7232_ChoiceDesc1 = {
    Text = "[Durchführen der Prüfung]Infiziere „(Skill.Arg1)“, gewinne goldenes Relikt bei Sieg, erhalte 50 das schwarze Siegel bei Niederlage"
  },
  Event_7232_ChoiceDesc2 = {
    Text = "[Verlassen]Erhalte 50 schwarze Siegel"
  },
  Event_7232_Desc = {
    Text = "Du hast einige Geheimnisse in der spiegelnden schwarzen Flüssigkeit unter dir gesehen.\nIhr verschwommenes Spiegelbild ist von schwarzem Rauch umgeben, es kommt dir bekannt vor, aber du kannst es nicht identifizieren"
  },
  Event_7232_Name = {
    Text = "Spiegel darunter"
  },
  Event_7233_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7233_Desc = {
    Text = "Die geheimnisvollen Briefe nimmst du nicht ernst, du verbrennst sie und sie zerfallen zu Asche"
  },
  Event_7233_Name = {
    Text = "Noch eine Notrufnachricht"
  },
  Event_7234_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7234_Desc = {
    Text = "Du untersuchst den Brief, die klebrige Flüssigkeit am Siegel scheint eine Mischung aus Blut und schwarzem Schleim zu sein, vermischt mit ein paar Haaren"
  },
  Event_7234_Name = {
    Text = "Noch eine Notrufnachricht"
  },
  Event_7235_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7235_Desc = {
    Text = "Du folgst der Richtung, in die der Brief fiel, und siehst an der Ecke etwas Glänzendes"
  },
  Event_7235_Name = {
    Text = "Noch eine Notrufnachricht"
  },
  Event_7236_ChoiceDesc1 = {
    Text = "[Weiter suchen]Erhöhe Arg1 Leben, infiziere“(Skill.Arg2)“"
  },
  Event_7236_ChoiceDesc2 = {
    Text = "[Verlassen]"
  },
  Event_7236_Desc = {
    Text = "Ein schwaches Licht erscheint vor deinen Augen, hell und warm, aber als du ihm folgen willst, verschwindet es plötzlich"
  },
  Event_7236_Name = {
    Text = "Abnormale Verbindung"
  },
  Event_7237_ChoiceDesc1 = {
    Text = "[Verlassen]Alle Erwachten heilen Arg1 Wahnsinn"
  },
  Event_7237_Desc = {
    Text = "Du hast vor Angst fest die Augen geschlossen. \n“Du hast das Tuch angehoben... \n Geheimnis, du hast ein Geheimnis entdeckt...“ \n Die Geräuschwelle vereint sich zu einem lärmenden Ozean, der Boden vibriert heftig in schrecklicher Resonanz. \n Du kannst nicht mehr aushalten, öffnest plötzlich die Augen, nur um festzustellen, dass die Umgebung leer ist."
  },
  Event_7237_Name = {
    Text = "Abschlusszeremonie V"
  },
  Event_7238_ChoiceDesc1 = {
    Text = "[Weiter suchen]Erhöhe Arg1 Leben, infiziere“(Skill.Arg2)“"
  },
  Event_7238_ChoiceDesc2 = {
    Text = "[Verlassen]"
  },
  Event_7238_Desc = {
    Text = "Ein vertrauter Geruch stieg dir in die Nase, heimelig und zufriedenstellend. Als du den Duft der Kantine noch einmal einatmen wolltest, war er plötzlich verschwunden"
  },
  Event_7238_Name = {
    Text = "Abnormale Verbindung"
  },
  Event_7239_ChoiceDesc1 = {
    Text = "[Weiter suchen]Erhöhe Arg1 Leben, infiziere“(Skill.Arg2)“"
  },
  Event_7239_ChoiceDesc2 = {
    Text = "[Verlassen]"
  },
  Event_7239_Desc = {
    Text = "Vertraute Worte in deinen Ohren, beruhigend und tröstlich, aber als du der Stimme folgst, verstummt sie"
  },
  Event_7239_Name = {
    Text = "Abnormale Verbindung"
  },
  Event_7240_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7240_Desc = {
    Text = "Die Rückverfolgungskraft kann für kurze Zeit keinen Verbindungspunkt für dich finden, doch du hast zumindest vorübergehende Trost gefunden"
  },
  Event_7240_Name = {
    Text = "Abnormale Verbindung"
  },
  Event_7241_ChoiceDesc1 = {
    Text = "[Weiter suchen]Erhöhe Arg1 Leben, infiziere“(Skill.Arg2)“"
  },
  Event_7241_ChoiceDesc2 = {
    Text = "[Verlassen]"
  },
  Event_7241_Desc = {
    Text = "Es scheint, als hätte jemand seine Hände auf deine Schultern gelegt, fest und entschlossen, aber als du dich umdrehst, ist das Gefühl verschwunden"
  },
  Event_7241_Name = {
    Text = "Abnormale Verbindung"
  },
  Event_7242_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7242_Desc = {
    Text = "“Der Schatten von „N“ wird durch den Schlag zerschlagen, schwarze Partikel verschmelzen mit dem dichten Nebel des Bereichs, kaum zu verfolgen.\n„Langweilig, aber ein interessanter Kerl. Ich freue mich auf unser tatsächliches Treffen...““"
  },
  Event_7242_Name = {
    Text = "Die Show kann beginnen"
  },
  Event_7243_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7243_Desc = {
    Text = "“Braves Kind. Aber eine kleine Strafe muss sein.“\nDaphdales Lachen verschwindet im Dimensionsriss"
  },
  Event_7243_Name = {
    Text = "Hinweiszeit"
  },
  Event_7244_ChoiceDesc1 = {
    Text = "[Vorderseite]50% Chance, ein goldenes Relikt „(RelicConfig.Arg2)“ zu erhalten, 50% Chance zu infizieren „(Skill.Arg3)“"
  },
  Event_7244_ChoiceDesc2 = {
    Text = "[Gegenseite]50% Wahrscheinlichkeit, 75 das schwarze Siegel zu erhalten, 50% Wahrscheinlichkeit, „(Skill.Arg3)“ zu infizieren"
  },
  Event_7244_ChoiceDesc3 = {
    Text = "[schwarze Chips]50% Wahrscheinlichkeit, das verfluchte Relikt“(RelicConfig.Arg2)“zu erhalten, 50% Wahrscheinlichkeit für die Infektion“(Skill.Arg3)“"
  },
  Event_7244_Desc = {
    Text = "Sehr gut... sehr gut......\n Dann wähle die Chips, die du möchtest."
  },
  Event_7244_Name = {
    Text = "Die Show kann beginnen"
  },
  Event_7245_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7245_Desc = {
    Text = "“Na gut, na gut. Dieser Typ hat immer eine Obsession für interdimensionale Wesen, ich habe auch einige Mühe aufbringen müssen, um mich frei durch diese Risse zwischen den Dimensionen bewegen zu können. Ah, das muss vor dreitausend Jahren gewesen sein, oder?“"
  },
  Event_7245_Name = {
    Text = "Hinweiszeit"
  },
  Event_7246_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7246_Desc = {
    Text = "Ich glaube nicht, dass der Forschungsleiter eine Bombe in deine Brust einbauen würde"
  },
  Event_7246_Name = {
    Text = "Unruhige Brosche"
  },
  Event_7247_ChoiceDesc1 = {
    Text = "[Verlassen]Lösche eine Befehlskarte, erhalte 25 schwarze Siegel"
  },
  Event_7247_Desc = {
    Text = "“Ein gutherziger Passant, der den Verirrten den richtigen Weg zeigt,“ sein Lächeln ist bösartig, “Reist leicht, Kerberos wartet auf euch.“\nDas Steuergerät in seiner Hand vibriert plötzlich"
  },
  Event_7247_Name = {
    Text = "Seltsamer Begleiter III"
  },
  Event_7248_ChoiceDesc1 = {
    Text = "[Langsame Bewegung]wähle eine von 3 Befehlskarten, um ein Gebet zu erhalten:“(EnchantConfig.Arg1)“"
  },
  Event_7248_ChoiceDesc2 = {
    Text = "[Sich flachlegen] wählt 1 aus 3 Befehlskarten und erhält Orison: „(EnchantConfig.Arg1)“"
  },
  Event_7248_Desc = {
    Text = "“Wenn du auf ein Moor triffst, kämpfe nicht dagegen an.“\nDu merkst dir diese Überlebensregel und stehst wie eine Osterinselstatue still.\nFünf Minuten, zehn Minuten, eine Stunde...der schwarze Schlamm verliert schließlich die Geduld und verschwindet von deinen Füßen"
  },
  Event_7248_Name = {
    Text = "dunkles Sumpfgebiet"
  },
  Event_7249_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7249_Desc = {
    Text = "Du bemerkst eine ungewöhnliche Hand. Sie ist zart, weiß und ruhig.\nWichtiger ist – du erkennst sie, es ist deine eigene Hand.\nDu hältst sie sanft.\nDie Hand hält dich zurück. Du spürst eisige Kälte und Leere, dann verschwindet der Sumpf"
  },
  Event_7249_Name = {
    Text = "dunkles Sumpfgebiet"
  },
  Event_7250_ChoiceDesc1 = {
    Text = "[Schnappe dir eine Hand]wähle 1 von 3 Befehlskarten und erhalte ein Gebet:“(EnchantConfig.Arg1)“"
  },
  Event_7250_ChoiceDesc2 = {
    Text = "[Sie beruhigen]wähle eine von 3 Befehlskarten und erhalte das Gotteszeichen: „(EnchantConfig.Arg1)“"
  },
  Event_7250_Desc = {
    Text = "Du schwingst dein Schwert und zerschneidest sie.\nBlut spritzt auf dich; Gesicht, Haare, Kleidung, du merkst es nicht.\nUnzählige Hände schreien schmerzhaft, der Sumpf verschwindet.\nErst eine Woche später hörst du in deinen Träumen auf, diese Schreie zu hören"
  },
  Event_7250_Name = {
    Text = "dunkles Sumpfgebiet"
  },
  Event_7251_ChoiceDesc1 = {
    Text = "[Sammle Silberkern] aktualisiere ein Silberrelikt zu einem goldenen Relikt “(RelicConfig.Arg1)“"
  },
  Event_7251_ChoiceDesc2 = {
    Text = "[Try Awakening]Erhalte das goldene Relikt“(RelicConfig.Arg1)“、infiziere“(Skill.Arg2)“und“(Skill.Arg3)“"
  },
  Event_7251_ChoiceDesc3 = {
    Text = "[Ignorieren] erhalte 25 schwarze Mal"
  },
  Event_7251_Desc = {
    Text = "Unter dem lockeren Decksbalken quillt ein schmutziges schwarzes Gemisch heraus. \n Der Glanz in der schwarzen Masse ist der dir bestens bekannte “Silberkern“."
  },
  Event_7251_Name = {
    Text = "Beweis der Existenz"
  },
  Event_7252_ChoiceDesc1 = {
    Text = "[Wähle die Maus]Zufällig eine Befehlskarte ziehen und Gebet erhalten: „(EnchantConfig.Arg1)“"
  },
  Event_7252_ChoiceDesc2 = {
    Text = "[Wähle die Kerze]Erhöhe Arg1 Punkte maximale Gesundheit, infiziere „(Skill.Arg2)“"
  },
  Event_7252_Desc = {
    Text = "Der aufgelöste Körper schwindet vor dir, der kalte schwarze Asche vermischt sich mit dem Nebel und formt eine merkwürdige Waage. Auf einer Seite liegt eine schlafende Maus, auf der anderen eine Kerze, die in Form eines Jungen geschnitzt ist.\nIm Stillen weißt du, dass du eine Wahl treffen musst"
  },
  Event_7252_Name = {
    Text = "Vernunft und Gefühl"
  },
  Event_7253_ChoiceDesc1 = {
    Text = "[Erkundende Stimme]"
  },
  Event_7253_ChoiceDesc2 = {
    Text = "[Heimlich folgen]"
  },
  Event_7253_Desc = {
    Text = "Als du um eine Ecke gehst, wird alles um dich herum immer verschwommener, nur das schreckliche Geschrei bleibt klar. \n Schritte ertönen, und als du dich umdrehst, siehst du schemenhaft eine seltsame Gestalt: Es scheint eine Person zu sein, aber dahinter sind paarweise Schatten, die auf den ersten Blick wie eine riesige Motte aussehen. \n “Vorsicht“, flüstert Ramona, “im Geheimgang ist das, was du siehst, nicht unbedingt die Wahrheit. Wenn du unüberlegt folgst, könnte es gefährlich werden.“"
  },
  Event_7253_Name = {
    Text = "Gestalt im Nebel"
  },
  Event_7254_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7254_Desc = {
    Text = "Du ziehst den silbernen Schlüssel heraus, hältst ihn traurig in deiner Hand, ein schwaches Licht umhüllt dich.\nIn der Stille bleibt nur ein Seufzen übrig"
  },
  Event_7254_Name = {
    Text = "Blick des Auges"
  },
  Event_7255_ChoiceDesc1 = {
    Text = "[Wähle den Silberfluss]Zufällig eine Befehlskarte ziehen und Gebet erhalten: „(EnchantConfig.Arg1)“"
  },
  Event_7255_ChoiceDesc2 = {
    Text = "[Wähle den Regenbogenweg]Erhöhe Arg1 Punkte maximale Gesundheit, infiziere „(Skill.Arg2)“"
  },
  Event_7255_Desc = {
    Text = "Poch, poch, poch.\nDas Herz schlägt wie eine Trommel, der Mund ist trocken, und der Blick aus der Höhe durchbohrt deine Brust.\nVor dir teilt sich der Weg, ein Sternenfluss fließt, ein Regenbogen schimmert"
  },
  Event_7255_Name = {
    Text = "Sternenkreuz"
  },
  Event_7256_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7256_Desc = {
    Text = "Der verbleibende Blick ist weiterhin auf dich gerichtet, während die Fleischzellen unter deiner Haut verrückt schreien und fliehen, während die Blutgefäße wie Würmer unter der Haut kriechen.\nDu fühlst eine strömende Kraft, die in den seltsamen Veränderungen deiner Glieder ausbricht"
  },
  Event_7256_Name = {
    Text = "Blick des Auges"
  },
  Event_7257_ChoiceDesc1 = {
    Text = "[Verlassen]Infektion“(Skill.Arg1)“"
  },
  Event_7257_ChoiceDesc2 = {
    Text = "[Verlassen]Infektion“(Skill.Arg1)“"
  },
  Event_7257_ChoiceDesc3 = {
    Text = "[Verlassen]Infektion“(Skill.Arg1)“"
  },
  Event_7257_Desc = {
    Text = "“Nein, das ist nicht wahr. Im Vergleich zu Kakerlaken habt ihr zumindest einen pelzigen Körper. \n Niemand kann einem pelzigen Körper widerstehen.“\n Die Ratten tuscheln und stimmen schließlich widerwillig deiner Meinung zu. \n“Es ist nicht so schlimm... eigentlich gibt es nicht so viel Fell.“\n Gelobt zu werden, ist immer erfreulich. Bevor sie gehen, schenken dir die Ratten ein kleines Geschenk."
  },
  Event_7257_Name = {Text = "Pest"},
  Event_7258_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7258_Desc = {
    Text = "“Ich stimme zu! Menschen und Ratten können nicht zusammenleben!“\nDie Ratten zeigten ihre weißen Zähne, etwas verärgert.\n“Was machst du dann noch hier? Nimm deine Sachen und komm nie wieder.“"
  },
  Event_7258_Name = {Text = "Pest"},
  Event_7259_ChoiceDesc1 = {
    Text = "[Verlassen]Erhalte Schöpfung“(RelicConfig.Arg1)“，Infektion“(Skill.Arg2)“"
  },
  Event_7259_Desc = {
    Text = "Seltsame Flügelschläge umgeben dich. Plötzlich siehst du, wie Rogers mit der Puppe George blutüberströmt auf dem Untersuchungstisch liegt.\nDu öffnest die Augen und siehst, dass Clementine verschwunden ist.\nWach auf, Clementine ist weg"
  },
  Event_7259_Name = {
    Text = "Hypnotherapie"
  },
  Event_7260_ChoiceDesc1 = {
    Text = "[Öffnen]Benutze Schlüssel"
  },
  Event_7260_ChoiceDesc2 = {
    Text = "[Verlassen]"
  },
  Event_7260_Desc = {
    Text = "Eine Tür blockiert deinen Weg. Du hast alles versucht, sie bleibt unbeweglich"
  },
  Event_7260_Name = {
    Text = "Rostige Tür"
  },
  Event_7260_Tips1 = {
    Text = "Benötigt den „verrosteten Schlüssel“"
  },
  Event_7261_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7261_Desc = {
    Text = "Du schaust in die Richtung, die du für die Quelle des Blicks hältst. Die Decke der Werkstatt erhöht sich abrupt, riesige irisierende Schatten überlagern sich, obwohl nur ein Teil von ihnen dir entgegenblickt, fühlst du dennoch gewaltigen Druck"
  },
  Event_7261_Name = {Text = "Wer blickt"},
  Event_7262_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7262_Desc = {
    Text = "Die schwarze Katze schleicht vorsichtig näher und erbricht in deine Handfläche eine schwarze Masse"
  },
  Event_7262_Name = {
    Text = "Nachtkatzenfluch"
  },
  Event_7263_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7263_Desc = {
    Text = "“Ja, kluge Wahl. Angesichts eines großen Feindes will man sicher alles wissen, oder? Aber zu viele Geheimnisse über Dimensionen zu kennen, kann den Verstand stören, weißt du?“\n“Dieser Typ hat immer eine Obsession für interdimensionale Wesen, ich habe auch einige Mühe aufbringen müssen, um mich frei durch diese Risse zwischen den Dimensionen bewegen zu können. Ah, das muss vor dreitausend Jahren gewesen sein, oder?“"
  },
  Event_7263_Name = {
    Text = "Hinweiszeit"
  },
  Event_7264_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7264_Desc = {
    Text = "“Miau, miau miau, miau miau miau...“\nDu quälst deine Stimme, um dich schwach und harmlos erscheinen zu lassen. \n“Miau! Miau miau! Miau miau miau!“\nDie Katzen scheinen deine Freundlichkeit zu akzeptieren und antworten mit lauten Rufen. Euer Geschrei wechselt sich ab, ununterbrochen Tag und Nacht, der Mond versteckt sich verängstigt hinter den Wolken."
  },
  Event_7264_Name = {
    Text = "Katzenstadt"
  },
  Event_7265_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7265_Desc = {
    Text = "Du hast den spitzen Schnabel der Krähe, die vorhatte, an ihren Federn zu knabbern, mit aller Kraft zurückgedreht, doch sie wehrte sich unnachgiebig und drehte sich mit solcher Kraft, dass deine Knochen laut knackten. \n Dein Gesicht wurde rot vor Anstrengung, und mit all deiner Kraft gelang es dir, den Körper der Krähe zu fixieren und ihr wahnsinniges Selbstverletzen zu stoppen. \n Als du gerade aufatmen wolltest, drehte sich der bereits halbnackte Hals der Krähe ruckartig nach hinten, ihr Körper wurde schlaff und verwandelte sich in deinen Händen in einen Haufen schwarzer, dicker Flüssigkeit."
  },
  Event_7265_Name = {
    Text = "Träne der geschmolzenen Lava"
  },
  Event_7266_ChoiceDesc1 = {
    Text = "[Drücke den Raben]erhalte 20 das schwarze Siegel, infiziere“(Skill.Arg2)“"
  },
  Event_7266_ChoiceDesc2 = {
    Text = "[Lass es bleiben]Verlassen"
  },
  Event_7266_Desc = {
    Text = "Eine einsame Krähe zupft sich heiser eine nach der anderen ihre schwarzen Federn aus.\nSie zittert vor Schmerz, schreit laut, kann aber nicht aufhören.\n„Krah—Krah—“\nBlaue Tränen, vermischt mit schwarzem Schleim, fließen aus ihren Augen, nur du siehst es"
  },
  Event_7266_Name = {
    Text = "Träne der geschmolzenen Lava"
  },
  Event_7267_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7267_Desc = {
    Text = "Krähen rissen an ihren Federn, wie Menschen an ihrem eigenen Körper.\nIn dieser Welt der Angst ist das nichts Ungewöhnliches, du kannst nicht alle retten"
  },
  Event_7267_Name = {
    Text = "Träne der geschmolzenen Lava"
  },
  Event_7268_ChoiceDesc1 = {
    Text = "[Verlassen]Erhalte Schöpfung“(RelicConfig.Arg1)“，Infektion“(Skill.Arg2)“"
  },
  Event_7268_Desc = {
    Text = "“Ich werde mit den Schülern zurückkommen.“ sagte das Mädchen entschlossen und zog am Rock des Erwachens, “Pass auf dich auf... Fall nicht ins Meer.“"
  },
  Event_7268_Name = {
    Text = "Segen der Heiligen Seefahrerin"
  },
  Event_7269_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7269_Desc = {
    Text = "Haha, Schwarz, meine Lieblingsfarbe. Chaos, Unordnung, Schmerz... du hättest es wissen sollen, Schwarz ist kein gutes Omen.\nAlso, was ist deine nächste Wahl?"
  },
  Event_7269_Name = {
    Text = "Die Show kann beginnen"
  },
  Event_7270_ChoiceDesc1 = {
    Text = "[Drücke den Raben]erhalte 25 das schwarze Siegel, infiziere“(Skill.Arg2)“，setze fort die Auswahl"
  },
  Event_7270_ChoiceDesc2 = {
    Text = "[Lass es bleiben]Verlassen"
  },
  Event_7270_Desc = {
    Text = "Eine einsame Krähe zupft sich heiser eine nach der anderen ihre schwarzen Federn aus.\nSie zittert vor Schmerz, schreit laut, kann aber nicht aufhören.\n„Krah—Krah—“\nBlaue Tränen, vermischt mit schwarzem Schleim, fließen aus ihren Augen, nur du siehst es"
  },
  Event_7270_Name = {
    Text = "Träne der geschmolzenen Lava"
  },
  Event_7271_ChoiceDesc1 = {
    Text = "[Verlassen]Wähle eine von 3 Befehlskarten und erhalte ein Gebet:“(EnchantConfig.Arg1)“"
  },
  Event_7271_Desc = {
    Text = "Das ist der alte, dunkle Schiffsrumpf.\nDas Mädchen wird mit dem Segen der Schiffsjungfrau aufbrechen, das ist ihr Versprechen"
  },
  Event_7271_Name = {
    Text = "Segen der Heiligen Seefahrerin"
  },
  Event_7272_ChoiceDesc1 = {
    Text = "[Verfolge die Melodie]Wähle eine Karte aus drei Befehlskarten und erhalte Gebet: „(EnchantConfig.Arg1)“"
  },
  Event_7272_ChoiceDesc2 = {
    Text = "[singe mit]Infektion“(Skill.Arg1)“，erneutes zufälliges Gebet"
  },
  Event_7272_Desc = {
    Text = "Die ferne Melodie zerbricht in Sternenstaub:\n„Ich verfluche das schmutzige Wasser in der Nachtgasse, die verfallene Mauer mit faulen Blumen, Ketten umschlingen das Gehirn und ziehen es in den Schlamm, bevor der Nebel meine Existenz auslöscht, wird die Dämmerung in die tiefste @3 sinken.“"
  },
  Event_7272_Name = {
    Text = "Weißes Fluch"
  },
  Event_7273_ChoiceDesc1 = {
    Text = "[Verfolge die Melodie]Wähle eine Karte aus drei Befehlskarten und erhalte Gebet: „(EnchantConfig.Arg1)“"
  },
  Event_7273_Desc = {
    Text = "Die ferne Melodie zerbricht in Sternenstaub:\n„Ich verfluche das schmutzige Wasser in der Nachtgasse, die verfallene Mauer mit faulen Blumen, Ketten umschlingen das Gehirn und ziehen es in den Schlamm, bevor der Nebel meine Existenz auslöscht, wird die Dämmerung in die tiefste @4 sinken.“"
  },
  Event_7273_Name = {
    Text = "Weißes Fluch"
  },
  Event_7274_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7274_Desc = {
    Text = "Der Silberkern reagiert nicht auf dein Erwachen, strahlt aber eine warme Atmosphäre aus"
  },
  Event_7274_Name = {
    Text = "Einsamer Silberkern"
  },
  Event_7275_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7275_Desc = {
    Text = "Schwarzer Nebel kroch die Wirbelsäule hinauf, bis du zu Boden fielst, wiederholtest du immer wieder diesen Satz"
  },
  Event_7275_Name = {
    Text = "nicht direkt ansehen"
  },
  Event_7276_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7276_Desc = {
    Text = "Ja, die Glaskörperflüssigkeit, die langsam aus deiner Pupille fließt, ist der Beweis, dass du von Tabus korrodiert wurdest.\nEhrlichkeit steht dir in diesem Moment entgegen der Tugend"
  },
  Event_7276_Name = {
    Text = "nicht direkt ansehen"
  },
  Event_7277_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7277_Desc = {
    Text = "Die alte Münze war klebrig, als wäre sie von Schmutz ausgespuckt, mit sichtbarem schwarzen Dunst"
  },
  Event_7277_Name = {
    Text = "Doppelte Antike Münze"
  },
  Event_7278_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7278_Desc = {
    Text = "Deine scharfen Nervenenden senden eine tödliche Warnung, du zuckst zusammen und ziehst widerwillig zurück.\nWieder entkommen...\nFluch? Oder eine Wiedergeburt?"
  },
  Event_7278_Name = {
    Text = "Doppelte Antike Münze"
  },
  Event_7279_ChoiceDesc1 = {
    Text = "[Schmetterling freigeben] Wähle 1 von 3 Befehlskarten aus, die das Gebet erhält: „(EnchantConfig.Arg1)\", infiziert „(Skill.Arg2)\""
  },
  Event_7279_ChoiceDesc2 = {
    Text = "[Werde ein Schmetterling]erhalte das silberne Relikt“(RelicConfig.Arg1)“、infiziere“(Skill.Arg2)“"
  },
  Event_7279_ChoiceDesc3 = {
    Text = "[Wieder schlucken]erhält 25 das schwarze Siegel"
  },
  Event_7279_Desc = {
    Text = "In dieser Nacht ist so viel passiert. \n Der ANG auf den Hafen, das Geisterschiff, die Seefahrer, Tulu, Murphy, Ramona ... alles dreht sich im Wirbel und wird zu dem Haferbrei, der um sieben Uhr im Misaq-Restaurant serviert wird. \n Du möchtest den Erwecker vor dir fragen, weißt aber nicht, wie du anfangen sollst, wie ein Kloß im Hals – oder besser gesagt, wie der Schmetterling im Magen."
  },
  Event_7279_Name = {
    Text = "Schmetterlingseffekt"
  },
  Event_7280_ChoiceDesc1 = {
    Text = "[Vertreibe die Illusion]Verliere (Arg3) Lebenspunkte"
  },
  Event_7280_ChoiceDesc2 = {
    Text = "[Verlassen]"
  },
  Event_7280_Desc = {
    Text = "Verschwommene Gesichter tauchen plötzlich auf, umgeben dich und stöhnen verzweifelt ohne Stimmbänder"
  },
  Event_7280_Name = {Text = "Illusion"},
  Event_7281_ChoiceDesc1 = {
    Text = "[Gebet beitreten] erhält Silberrelikt „(RelicConfig.Arg1)“, Infektion „(Skill.Arg2)“"
  },
  Event_7281_ChoiceDesc2 = {
    Text = "[In die Tiefe des Meeres]Erhalte ein goldenes Relikt „(RelicConfig.Arg1)“, infiziere „(Skill.Arg2)“, „(Skill.Arg3)“"
  },
  Event_7281_ChoiceDesc3 = {
    Text = "[An die Oberfläche kommen]Erhalte 25 schwarze Siegel"
  },
  Event_7281_Desc = {
    Text = "“Sanfter Gott, erhabener Gott. \n Bitte zähme den bösartigen Sturm, bitte stoppe den reißenden Fluss. \n Lass den Ozean zu unserem tiefen Zuhause werden, lass ihn unseren Staat mit einem ewigen Schleier bedecken...“ \n Das Flüstern der Gläubigen hat sich schließlich zu verständlichen Worten verbunden, doch damit verbunden ist die unerträgliche Erstickung."
  },
  Event_7281_Name = {Text = "Traumgebet"},
  Event_7282_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7282_Desc = {
    Text = "Du wirfst die verbliebenen Fleischstücke in die Menge.\nSchwarze Katzen stürzen sich darauf, reißen es in Stücke und zerstreuen sich schnell.\nUnglücklicherweise war dies verdorbenes Fleisch. Es stillt zwar den Hunger, aber zufrieden macht es nicht"
  },
  Event_7282_Name = {
    Text = "Katzenstadt"
  },
  Event_7283_ChoiceDesc1 = {
    Text = "[Einstecken]"
  },
  Event_7283_Desc = {
    Text = "Eine quecksilberähnliche silberne Substanz, extrahiert aus ätzendem Schleim, enthält starke geistige Energie, hauptsächlich verwendet, um in Ritualen mehr Erwachte zu verbinden"
  },
  Event_7283_Name = {Text = "Silberkern"},
  Event_7284_ChoiceDesc1 = {
    Text = "[Verlassen]Wähle einen Erwecker und verringere die Kosten für seine Erwachenskarten um 2 Punkte. Infiziere“(Skill.Arg1)“"
  },
  Event_7284_ChoiceDesc2 = {
    Text = "[Verlassen]"
  },
  Event_7284_Desc = {
    Text = "Vielleicht kannst du es jetzt nicht aussprechen, aber sie werden euren Ruf irgendwann hören"
  },
  Event_7284_Name = {Text = "Leitstimme"},
  Event_7285_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7285_Desc = {
    Text = "Die wandernden Versuchskörper haben dich erschöpft, eine kurze Pause fühlt sich an wie Regen in der Wüste"
  },
  Event_7285_Name = {
    Text = "Endlose Türen"
  },
  Event_7286_ChoiceDesc1 = {
    Text = "[Verlassen]Zufällig 1 Erwecker erwecken"
  },
  Event_7286_ChoiceDesc2 = {
    Text = "[Verlassen]"
  },
  Event_7286_Desc = {
    Text = "Diese Stimme wird euch zu eurem Ziel führen, die Antwort auf diese Untersuchung"
  },
  Event_7286_Name = {Text = "Leitstimme"},
  Event_7287_ChoiceDesc1 = {
    Text = "[Genau beobachten]"
  },
  Event_7287_Desc = {
    Text = "Mit Kristallkugel kannst du ferne Orte sehen"
  },
  Event_7287_Name = {
    Text = "Kristallkugel"
  },
  Event_7288_ChoiceDesc1 = {
    Text = "[vertreibe die Krähen]Erhalte Arg1 schwarze Siegel, Infektion“(Skill.Arg2)“，weiter wählen"
  },
  Event_7288_ChoiceDesc2 = {
    Text = "[Ignorieren]Verlassen"
  },
  Event_7288_Desc = {
    Text = "Ein Rabe sitzt auf dem Schrank und ritzt mit seinem scharfen Schnabel seltsame Muster in die Holztür"
  },
  Event_7288_Name = {
    Text = "Laternenschwarzer Rabe"
  },
  Event_7289_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7289_Desc = {
    Text = "Du nimmst den Kontakt der Schule an, die vertraute Stimme beruhigt dich. Du sammelst dich und gehst weiter"
  },
  Event_7289_Name = {
    Text = "Kontaktstelle"
  },
  Event_7290_ChoiceDesc1 = {
    Text = "[Hier verweilen] erhält Silberrelikt „(RelicConfig.Arg1)“"
  },
  Event_7290_ChoiceDesc2 = {
    Text = "[Ausstieg suchen]erhalte das goldene Relikt „(RelicConfig.Arg1)“, Infektion „(Skill.Arg2)“"
  },
  Event_7290_Desc = {
    Text = "Du trittst in eine blasse Stille ein, die überlappenden Türen drehen sich unermüdlich und ziehen deinen Körper wie in einem Wirbel hinein. \n Schwindelig kämpfst du dich innerhalb der umgekehrten Türen, versuchst vage, die Fluchtrichtung zu erkennen, doch unweigerlich fällst du immer wieder durch eine andere Tür. \n Diesmal bleibst du erneut vor einer Tür stehen, das unbekannte, das hinter ihr pulsiert, strahlt eine tödliche Anziehung aus, doch dein Verstand spannt sich angespannt. \n Ja, es ist in der Tat tödlich."
  },
  Event_7290_Name = {
    Text = "Jenseits der verschlossenen Türen"
  },
  Event_7291_ChoiceDesc1 = {
    Text = "[In Ekstase]Lösche 1 Befehlskarte und stelle Arg1 Leben wieder her"
  },
  Event_7291_ChoiceDesc2 = {
    Text = "[Halt einlegen] erhält goldenes Relikt „(RelicConfig.Arg1)“, Infektion „(Skill.Arg2)“"
  },
  Event_7291_Desc = {
    Text = "Als ob dein Schädel leicht aufgebrochen wurde, erlebst du ein erbrechendes Schwindelgefühl in deinem Gehirn, während unsichtbare Hände dein Gehirn umwühlen und durcheinanderbringen, sodass die ohnehin schon flüssige Substanz zu einem Haufen zerfällt. \n Es ist, als ob unverdauter breiiger Mageninhalt bereits der Schwerkraft entkommen ist und in deine hohle, arme Hirnrinde zurückfließt. \n Es wird geknetet, vermischt, gegriffen und mit zerschnittenem Freude bestreut, während die Überreste des Sonnenuntergangs in das Fleisch eingearbeitet werden."
  },
  Event_7291_Name = {
    Text = "Stirnrunzeln"
  },
  Event_7292_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7292_Desc = {
    Text = "Im Vergleich zu plötzlich auftauchenden Höllenhunden ist gewöhnlicher Schnee nicht der Mühe wert. Du ignorierst die fallenden Schneeflocken und stürzt in die Nacht"
  },
  Event_7292_Name = {Text = "Schnee"},
  Event_7293_ChoiceDesc1 = {
    Text = "[Verbinden]Arg2 Lebenspunkte heilen"
  },
  Event_7293_Desc = {
    Text = "Du erkundest den Nebel, plötzlich leuchtet das Abzeichen auf deiner Brust schwach silbern. Wer ruft dich am anderen Ende des Kommunikators?"
  },
  Event_7293_Name = {
    Text = "Kontaktstelle"
  },
  Event_7294_ChoiceDesc1 = {
    Text = "[Fühle Angst]erhalte das goldene Relikt“(RelicConfig.Arg1)“、infiziere“(Skill.Arg2)“"
  },
  Event_7294_ChoiceDesc2 = {
    Text = "[Entschlossene Willenskraft]wähle eine von 3 Befehlskarten und erhalte das Gotteszeichen: „(EnchantConfig.Arg1)“"
  },
  Event_7294_Desc = {
    Text = "Die unheimlichen Klagegeräusche hallen unaufhörlich wider, aber alles in Lentiniën bleibt stumm, als wäre es bereits tot oder im Schlaf. \n Du wanderst unbewusst unter der Eisenbahnbrücke umher und erinnerst dich an Alistairs Warnung. \n Er steht höflich auf und kommt auf dich zu, scheint dir etwas zu erzählen, doch seine Worte sind schwerfällig und undeutlich. \n Du blickst auf, schwarze, zähflüssige Tropfen fließen aus seinem Mund und blockieren seine Kehle, behindern seine Sätze—"
  },
  Event_7294_Name = {
    Text = "Chaosgeheul"
  },
  Event_7295_ChoiceDesc1 = {
    Text = "[Verlassen]Erhalte eine Auswahl von 3 für 1 Gebet"
  },
  Event_7295_Desc = {
    Text = "“Natürlich, natürlich. Wenn es dir nichts ausmacht, helfe ich euch gerne.“\nEr reicht euch einen antiken Handspiegel.\n“Der Ritter ist bereits auf dem Schachbrett, und der König wird nicht lange auf sich warten lassen. Ihr werdet ihn bald sehen. Das wird spannend.“"
  },
  Event_7295_Name = {
    Text = "Seltsamer Begleiter IV"
  },
  Event_7296_ChoiceDesc1 = {
    Text = "[Briefpapier zerreißen]2 Karten löschen"
  },
  Event_7296_ChoiceDesc2 = {
    Text = "[Weiter lesen]Erhalte ein verfluchtes Relikt:“(RelicConfig.Arg1)“, Infektion“(Skill.Arg2)“"
  },
  Event_7296_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte Arg1 schwarze Siegel"
  },
  Event_7296_Desc = {
    Text = "Vor dir entfaltet sich eine schwirrende schwarze Schmetterlingsschwarm, der unaufhörlich überquillt, mit den Flügeln schlägt und immer wieder auf den Schreibtisch fällt. \n Das ausgebreitete leere Briefpapier ist mit Tinte bespritzt, die verletzten Schmetterlinge liegen erschöpft auf der Oberfläche des Papiers. \n Die schwarze Flüssigkeit an den Flügeln verbindet sich zu einem Text, der als Tabu gilt. \n Du ziehst dieses Briefpapier aus der Schreibmaschine."
  },
  Event_7296_Name = {
    Text = "Schmetterlingseinteilung"
  },
  Event_7297_ChoiceDesc1 = {
    Text = "[Biene anfliegen]Entferne eine Befehlskarte, erhalte Arg1 das schwarze Siegel"
  },
  Event_7297_ChoiceDesc2 = {
    Text = "[Nicht mehr verweilen]"
  },
  Event_7297_Desc = {
    Text = "In letzter Zeit kursiert in Lentiniën ein Spruch: “Ein Flattern des Schmetterlings im Akute-Land könnte vielleicht einen Sturm im Königreich Leo auslösen.“\nAls du die Schmetterlinge herausströmen siehst, denkst du unwillkürlich an diesen Satz.\nDiese Schmetterlinge könnten vielleicht eine Katastrophe auslösen, die den Planeten überflutet."
  },
  Event_7297_Name = {
    Text = "Geistessturm"
  },
  Event_7298_ChoiceDesc1 = {
    Text = "[Verlassen]Erhalte 50 schwarze Siegel"
  },
  Event_7298_Desc = {
    Text = "Du legst einen Finger an deine Lippen, um dich selbst zum Schweigen zu bringen. \nEine schwarze Katzenphantasma schoss vorbei und hinterließ ein dunkles Geschenk an deinem Fuß"
  },
  Event_7298_Name = {
    Text = "Nachtkatzenfluch"
  },
  Event_7299_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7299_Desc = {
    Text = "Er glitt wie Seide in Ihre Tasche, und mit dem leichten Gewichtszuwachs hörten Sie ein leises Dankeschön.\nDanach war es still"
  },
  Event_7299_Name = {Text = "Chaosgeist"},
  Event_7300_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7300_Desc = {
    Text = "Das Weinen des Geistes des Chaos wird immer schriller, bis es schließlich zu einem durchdringenden Schrei wird, der um dich herum widerhallt.\nEr sinkt mit deinem Opfer und unentrinnbarem Kummer wieder in den Sumpf"
  },
  Event_7300_Name = {Text = "Chaosgeist"},
  Event_7301_ChoiceDesc1 = {
    Text = "[Wahrheitsgemäß ausfüllen]"
  },
  Event_7301_ChoiceDesc2 = {
    Text = "[Kritzelei]"
  },
  Event_7301_Desc = {
    Text = "Die Straßen im Ostviertel sind verworren, und schon bald hast du die Kinder aus den Augen verloren. \n Als du ratlos bist, spricht dich eine geheimnisvolle Frau an. \n “Ich weiß, wo die Kinder hingegangen sind, aber bevor ich es dir sage, könntest du mir bitte einen kleinen Gefallen tun?“ \n Sie zieht ein Blatt Papier heraus und lächelt freundlich. \n “Ich heiße Clementine und bin Psychologin. Ich führe eine psychologische Untersuchung über die Bewohner von Lentiniën durch. Wenn du mir helfen könntest, diesen Fragebogen auszufüllen. \n Wenn du ihn wahrheitsgemäß ausfüllst, bin ich gerne bereit, dir und deinen Begleitern etwas Hilfe anzubieten.“"
  },
  Event_7301_Name = {
    Text = "Psychologische Bewertung"
  },
  Event_7302_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7302_Desc = {
    Text = "“Das ist auch meine Wahl“, sagte die Gestalt mit den Süßigkeiten, “aber sie wird zu seinem Druckmittel, und du wirst wählen müssen. \n Es gibt kein perfektes Ende in dieser Welt.“ \n Tiefe Trauer überwältigt dich. Die Gestalt verschwindet, du hältst dir das Herz und weißt nicht, ob das eben Gesehene eine Projektion oder eine Illusion ist, die unter dem Druck der Seele entstanden ist."
  },
  Event_7302_Name = {
    Text = "verzweigter Pfad"
  },
  Event_7303_ChoiceDesc1 = {
    Text = "[Goldene Axt]"
  },
  Event_7303_ChoiceDesc2 = {
    Text = "[Silberne Axt]"
  },
  Event_7303_ChoiceDesc3 = {
    Text = "[Ich habe nichts verloren]"
  },
  Event_7303_Desc = {
    Text = "“Pionier der Dimensionen.“\nEine alte Stimme ertönt, als käme sie aus der Urzeit, durch die Ewigkeit.\nIn höchster Anspannung hörst du die vertraute Frage.\n“Hast du diese goldene Axt oder diese silberne Axt verloren?“"
  },
  Event_7303_Name = {
    Text = "Stimmen aus dem Jenseits"
  },
  Event_7304_ChoiceDesc1 = {
    Text = "[Verlassen]Erhalte 25 schwarze Siegel"
  },
  Event_7304_Desc = {
    Text = "“Oh, das...“ Sie nahm den Fragebogen zurück und sah etwas ratlos aus. “Egal, du hast es eilig. Die Kinder sind dorthin gegangen, sie sind nicht weit.“\nDu drehst dich hastig um und hörst kaum das Flüstern hinter dir. \n“Wir werden uns wiedersehen.“"
  },
  Event_7304_Name = {
    Text = "Psychologische Bewertung"
  },
  Event_7305_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7305_Desc = {
    Text = "“Wer bist du?“\n“Ich bin der Schatten des ermordeten Silberschlüsslers, der Mörder ist eine listige Albino-Schlange.“\n“Albino-Schlange? Was ist das?“\n“Ein Fehler. Ein Wesen, das aus der Kreuzung von Mensch und Schlange entstand... Verfluchung.“\nDu möchtest weiter fragen, doch der Schatten zerstreut sich plötzlich und hinterlässt einen Haufen goldenen Staubs."
  },
  Event_7305_Name = {
    Text = "Silberschlüssler"
  },
  Event_7306_ChoiceDesc1 = {
    Text = "[Infiziere“(Skill.Arg1)“、erhalte das goldene Relikt“(RelicConfig.Arg2)“]"
  },
  Event_7306_ChoiceDesc2 = {
    Text = "[Verlassen]Erhalte 50 schwarze Siegel"
  },
  Event_7306_Desc = {
    Text = "Ereignis 355 (in Entwicklung), nicht das Endergebnis"
  },
  Event_7306_Name = {
    Text = "Ereignis 355 (in Entwicklung)"
  },
  Event_7307_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7307_Desc = {
    Text = "Sinkt in den Magen, tanzt mit den Schmetterlingen.\nGedankenstaub und Schmetterlinge verweben sich, Schnee fällt im Magen.\nDu klärst alles auf, beim nächsten Mal wirst du sicher sprechen"
  },
  Event_7307_Name = {
    Text = "Schmetterlingseffekt"
  },
  Event_7308_ChoiceDesc1 = {
    Text = "[Widerlegen]infiziert „(Skill.Arg1)“, zufällig 1 Karte erhält Orison: „(EnchantConfig.Arg2)“"
  },
  Event_7308_ChoiceDesc2 = {
    Text = "[folge ihnen]Infektion“(Skill.Arg1)“，Zufällig 1 Karte erhält das Gebet:“(EnchantConfig.Arg2)“"
  },
  Event_7308_ChoiceDesc3 = {
    Text = "[Neue Perspektive einbringen]wähle 1 von 3 Befehlskarten und erhalte Gebet: „(EnchantConfig.Arg1)“"
  },
  Event_7308_Desc = {
    Text = "“Haltet Abstand zu uns.“\nEine Gruppe von Ratten umzingelt dich, mindestens fünf Fuß Abstand haltend. \n“Wir bemühen uns um Fortpflanzung, wir gedeihen, wir sind nicht wählerisch – und so bringen wir den Menschen Krankheiten, Angst und Leid.“\n“Wir sollten nicht zu nah an den Menschen sein, das ist nicht der Ort, an dem du sein solltest.“\nUm die Ratten zu beruhigen, entscheidest du dich zu –"
  },
  Event_7308_Name = {Text = "Pest"},
  Event_7309_ChoiceDesc1 = {
    Text = "[Öffne die Eisen Tür]infiziere“(Skill.Arg1)“、erhalte das goldene Relikt“(RelicConfig.Arg2)“"
  },
  Event_7309_ChoiceDesc2 = {
    Text = "[Ignorieren]Erwirbt 50 das schwarze Siegel"
  },
  Event_7309_Desc = {
    Text = "Es ist eine typische Bogenbrücke, die Treppe neben den Gleisen führt zu einem Eisentor. Dahinter hört man ein regelmäßiges Klackern.\nDu bleibst stehen und siehst ein schweres Vorhängeschloss, das aber nicht verschlossen ist"
  },
  Event_7309_Name = {
    Text = "Hinter der Eisentür"
  },
  Event_7310_ChoiceDesc1 = {
    Text = "[Verlassen]Infiziere“(Skill.Arg1)“，erhalte 50 schwarze Siegel"
  },
  Event_7310_Desc = {
    Text = "Der Versuchung widerstehend, bleibst du unbeeindruckt.\nDer Besitzer der Stimme klingt enttäuscht, ein paar Wellen breiten sich auf der Wasseroberfläche aus, und dann kehrt wieder Stille ein."
  },
  Event_7310_Name = {
    Text = "Stimmen aus dem Jenseits"
  },
  Event_7311_ChoiceDesc1 = {
    Text = "[Infiziere“(Skill.Arg1)“、erhalte das goldene Relikt“(RelicConfig.Arg2)“]"
  },
  Event_7311_ChoiceDesc2 = {
    Text = "[Verlassen]Erhalte 50 schwarze Siegel"
  },
  Event_7311_Desc = {
    Text = "Ereignis 353 (in Entwicklung), nicht das Endergebnis"
  },
  Event_7311_Name = {
    Text = "Ereignis 353 (in Entwicklung)"
  },
  Event_7312_ChoiceDesc1 = {
    Text = "[Verlassen]Infiziere“(Skill.Arg1)“，erhalte 50 schwarze Siegel"
  },
  Event_7312_Desc = {
    Text = "“Habt ihr Menschen keine anderen Antworten mehr?“\nDer Besitzer der Stimme knurrte ungeduldig, und der ganze Raum bebte.\n“Gierig und unwissend... das ist der Grund, warum ich euch verachte.“"
  },
  Event_7312_Name = {
    Text = "Stimmen aus dem Jenseits"
  },
  Event_7313_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7313_Desc = {
    Text = "Akzeptiere die Anordnung des Bereichs, verliere im Gewinnen und genieße die verfluchte Umarmung"
  },
  Event_7313_Name = {Text = "Wahnwelle"},
  Event_7314_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7314_Desc = {
    Text = "Das Auge blinzelte langsam, ohne zu wissen, ob es deine Frage verstanden hatte. \n Ein Tropfen goldrot gemischter Tränen fiel aus dem Augenwinkel, wie ein winziger Stern, der ein Licht wie die Sonne ausstrahlt. Er fiel, fiel, getragen von Traurigkeit und Mitleid, und zerbrach auf dem Stein zu einem kleinen Staubkorn. \n Du kamst plötzlich wieder zu dir, das Auge war bereits verschwunden."
  },
  Event_7314_Name = {
    Text = "Blinder Blick"
  },
  Event_7315_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7315_Desc = {
    Text = "Einige einfach gekleidete, sogar schmutzige Kinder rannten auf der Straße, verfolgt von einem Polizisten. Eines der Kinder trug eine braune Kapuze, die dir bekannt vorkam"
  },
  Event_7315_Name = {
    Text = "Unsere Erinnerungen"
  },
  Event_7316_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7316_Desc = {
    Text = "“Hör auf zu singen—“\nDu warnst den unmusikalischen Sänger, deine Ohren nicht weiter zu quälen"
  },
  Event_7316_Name = {
    Text = "Schurke auf dem schmalen Pfad"
  },
  Event_7317_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7317_Desc = {
    Text = "“Halt an!!! Selbst kriechende, ätzende Monster kennen ihre Gliedmaßen besser als du!“\nLass die Zuschauer in Ruhe...\nDu betest im Stillen"
  },
  Event_7317_Name = {
    Text = "Schurke auf dem schmalen Pfad"
  },
  Event_7318_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7318_Desc = {
    Text = [[
Schwarzer Schlamm tropfte auf dein Gesicht und verursachte ein kribbelndes Jucken.
Du konntest es nicht ertragen und schlugst nach dem Schmetterling.
Der Schmetterling entkam deiner feindseligen Bewegung und verschwand lautlos in der Ferne]]
  },
  Event_7318_Name = {
    Text = "Etwas, das nicht existieren sollte"
  },
  Event_7319_ChoiceDesc1 = {
    Text = "[Lobe es]Wähle eine aus 3 Befehlskarten und erhalte ein Gebet:“(EnchantConfig.Arg1)“"
  },
  Event_7319_Desc = {
    Text = "Jenkins sagte: Wach auf, Johnny! Gedichte schreiben wird deine Schulden nicht begleichen und auch das Problem mit dem undichten Boden in deinem Haus nicht lösen. \n Du sagst: Leider werden deine Zellen, die nach Wahrheit streben, mit einer Geschwindigkeit von 100.000 pro Tag absterben, und bald wirst du ein echtes Gehirn werden. \n Das Gehirn zuckte gleichgültig mit den Schultern – wenn es welche hätte. \n Das Gehirn sagte: Ich denke, also bin ich. Wenn du eine Gedanken Tiefe wie ich erreichen kannst, wirst du dich nicht mehr um das Gehirn kümmern."
  },
  Event_7319_Name = {
    Text = "Philosophisches Gehirn"
  },
  Event_7320_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7320_Desc = {
    Text = "Das Klavier seufzte leise, als ob es Trost spendete oder in Erinnerungen schwelgte, ähnlich dem Lächeln einer Person am Ende eines Stückes.\n„Solange die Kinder... solange...“\nDu hast nicht genug Zeit, um es klar zu hören, schon zerstreut sich das Phantasma des Klaviers im Wind"
  },
  Event_7320_Name = {
    Text = "Kindheitsmelodie"
  },
  Event_7321_ChoiceDesc1 = {
    Text = "[Verlassen]Erhalte eine Auswahl von 3 für 1 Silberrelikt, infiziere“(Skill.Arg1)“"
  },
  Event_7321_Desc = {
    Text = "Du nimmst die dicke Krankenakte und öffnest sie, auf der ersten Seite stehen die Buchstaben „G·R“.\n„Oh, ist das nicht deine Akte?“ Clementine scheint es nicht zu stören. „Das Studium anderer kann auch das Selbstverständnis fördern.“\nBevor du fragen kannst, ist sie verschwunden"
  },
  Event_7321_Name = {
    Text = "Krankenakte"
  },
  Event_7322_ChoiceDesc1 = {
    Text = "[Verlassen]Wähle einen Erwecker, infiziere“(Skill.Arg1)“"
  },
  Event_7322_Desc = {
    Text = "Du nimmst die dünne Krankenakte und öffnest sie, darin liegt nur ein Blatt Papier mit einem Satz.\n„Im ewigen Chaos beobachtet das blinde Auge unaufhörlich.“\nDu willst Clementine fragen, aber sie ist schon weg"
  },
  Event_7322_Name = {
    Text = "Krankenakte"
  },
  Event_7323_ChoiceDesc1 = {
    Text = "[Verbinden]Alle Lebenspunkte heilen"
  },
  Event_7323_ChoiceDesc2 = {
    Text = "[Meditation] wählt 1 Erwecker aus"
  },
  Event_7323_Desc = {
    Text = "Du erkundest den Nebel, plötzlich leuchtet das Abzeichen auf deiner Brust schwach silbern. Wer ruft dich am anderen Ende des Kommunikators?"
  },
  Event_7323_Name = {
    Text = "Kontaktstelle"
  },
  Event_7324_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7324_Desc = {
    Text = "Wichtige Beweismittel sollten sorgfältig aufbewahrt und zur Analyse an die Geschichtsabteilung übergeben werden"
  },
  Event_7324_Name = {
    Text = "Geheimer Befehl · Oben"
  },
  Event_7325_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7325_Desc = {
    Text = "Die strahlende Sonne durchdringt den Nebel und weckt müde Seelen"
  },
  Event_7325_Name = {Text = "Hochwinkel"},
  Event_7326_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7326_Desc = {
    Text = "Du fühlst dich zufrieden, ihre Blicke funkeln im Nachthimmel über dir und fokussieren sich auf dich"
  },
  Event_7326_Name = {
    Text = "Kuppelaugen"
  },
  Event_7327_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7327_Desc = {
    Text = "Du kannst den stechenden Blicken nicht entkommen und natürlich auch nicht die Gaben der Götter ablehnen"
  },
  Event_7327_Name = {
    Text = "Kuppelaugen"
  },
  Event_7328_ChoiceDesc1 = {
    Text = "[Verlassen]Erhalte Schöpfung“(RelicConfig.Arg1)“，Infektion“(Skill.Arg2)“"
  },
  Event_7328_Desc = {
    Text = "“Wer bist du eigentlich?“fragst du erschrocken.\n“Das ist nicht wichtig. Der Feind meines Feindes ist mein Freund, oder?“lächelte der Mann.\n“Das Geschenk liegt auf dem Sitz, viel Glück.“"
  },
  Event_7328_Name = {
    Text = "Seltsamer Begleiter IV"
  },
  Event_7329_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7329_Desc = {
    Text = "Ramona trat näher heran, in der Hoffnung, mehr über den “weißen Kittel“ zu erfahren. “Jemand lauscht!“ Die Stimme des Phonographen wurde plötzlich lauter, “lauschen, lauschen, lauschen!“"
  },
  Event_7329_Name = {
    Text = "Fremde Ohren"
  },
  Event_7330_ChoiceDesc1 = {
    Text = "[Verlassen]Alle Erwachten heilen Arg1 Wahnsinn"
  },
  Event_7330_Desc = {
    Text = "Du hältst die weiche Hand des Jungen und gehst durch eine Tür nach der anderen, bis ihr vor einer kleinen, verfallenen Bühne steht.\nDer Junge drückt deine Hand als Dank.\n“Danke, auf Wiedersehen.“"
  },
  Event_7330_Name = {
    Text = "Abschlusszeremonie II"
  },
  Event_7331_ChoiceDesc1 = {
    Text = "[Weiter fallen]Erhalte ein silbernes Relikt:“(RelicConfig.Arg1)“, weiter fallen?"
  },
  Event_7331_ChoiceDesc2 = {
    Text = "[Zieh dich zurück] erhält +25 das schwarze Siegel"
  },
  Event_7331_Desc = {
    Text = "“Du“ lädt dich ein.\nIn den Tiefen der Spirale senden dir die „Du“ aus Vergangenheit und Zukunft Geschenke aus verschiedenen Dimensionen"
  },
  Event_7331_Name = {
    Text = "Spiralabgrund"
  },
  Event_7332_ChoiceDesc1 = {
    Text = "[Den Mund halten]erhalte 25 das schwarze Siegel"
  },
  Event_7332_ChoiceDesc2 = {
    Text = "[Nach vorne greifen]50% Chance 50 das schwarze Siegel zu erhalten, 50% Chance nichts zu erhalten"
  },
  Event_7332_Desc = {
    Text = "“Ich habe nur eine Weisheit zu sagen – niemand kann eine Katze töten!“ \n “Die verdammte schwarze Katze hätte aufgeschnitten und in der Wildnis ausgesetzt werden sollen, doch sie hat mein Familiengrab aufgebrochen, das verweste Fleisch der überlebenden Menschen wurde von ihr vollständig gefressen, die Knochen und Gliedmaßen lagen zerstreut herum.“ \n “Unter dem kalten, dunklen Blick der schmalen Pupillen stieg eine Schicht übelriechenden Eiters auf, ich bin dort weggerollt und -gekrochen, von Albträumen gequält und geistig erschöpft.“ \n “Warte... was wollt ihr tun, ich bin nicht verrückt! Ich bin es nicht! Ihr wollt bestimmt etwas vertuschen! Das ist wahr –“ \n Das ist tatsächlich wahr, während du den Schatten des Wahnsinnigen verschwinden siehst, blickst du in die Augen der schwarzen Katze, die ruhig zu deinen Füßen sitzt."
  },
  Event_7332_Name = {
    Text = "Nachtkatzenfluch"
  },
  Event_7333_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7333_Desc = {
    Text = "Du fragst ihn nach der Richtung zum Wachsfigurenmuseum.\nSeltsam, wenn man bedenkt, dass ihr euch heute Abend schon fünfmal begegnet seid. Du hast ihm fünfmal Feuer gegeben und fünfmal nach dem Weg gefragt.\nAber du kannst dich immer noch nicht an den Standort des Wachsfigurenmuseums erinnern, genau wie ihr euch weiterhin ständig begegnen werdet."
  },
  Event_7333_Name = {
    Text = "Die Silhouette unter der Straßenlaterne"
  },
  Event_7334_ChoiceDesc1 = {
    Text = "[vertreibe die Krähen]Erhalte 25 schwarze Siegel, Infektion“(Skill.Arg2)“，weiter wählen"
  },
  Event_7334_ChoiceDesc2 = {
    Text = "[Weiter dem Kind nachjagen]Verlassen"
  },
  Event_7334_Desc = {
    Text = "Die dritte Krähe ist weggeflogen, in die unerreichbare Dunkelheit"
  },
  Event_7334_Name = {
    Text = "Schwarze Krähe Blick"
  },
  Event_7335_ChoiceDesc1 = {
    Text = "[Verlassen]Erhalte 75 schwarze Siegel, infiziere“(Skill.Arg2)“"
  },
  Event_7335_Desc = {
    Text = "Das Fell an den Tentakeln ist weich und warm, es trägt noch die Wärme von Kums Leben.\nEs ist der letzte Sonnenstrahl vor dem Sonnenuntergang, die flüchtige Restwärme"
  },
  Event_7335_Name = {Text = "Restwärme"},
  Event_7336_ChoiceDesc1 = {
    Text = "[Verfolgen]"
  },
  Event_7336_Desc = {
    Text = "Du suchst die Wand gründlich ab und findest schließlich einen versteckten Abwasserkanaleingang hinter dem Gebüsch. Du kriechst durch den Kanal, aber das Monster ist längst weg"
  },
  Event_7336_Name = {Text = "Sackgasse"},
  Event_7337_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7337_Desc = {
    Text = "Vögel haben ihre eigenen Regeln, sie handeln nicht nach deinem Willen, und du hast kein Recht, die Gesetze der Natur zu stören"
  },
  Event_7337_Name = {
    Text = "Aussätzige Krähe"
  },
  Event_7338_ChoiceDesc1 = {
    Text = "[Spiegelblick] erhält 25 das schwarze Siegel"
  },
  Event_7338_ChoiceDesc2 = {
    Text = "[Geht es dir gut?]Erhalte ein Silberrelikt „(RelicConfig.Arg1)“, infiziere „(Skill.Arg2)“"
  },
  Event_7338_Desc = {
    Text = "“Weißt du... die neue Wirtin nebenan, die immer hinter verschlossenen Türen bleibt... Ich habe sie neulich auf ein Bier eingeladen, und als der Schaum vollständig verschwunden war, bemerkte ich plötzlich... im Glas, sie hatte keinen Schatten!“"
  },
  Event_7338_Name = {
    Text = "Erinnerungsfragment: Bier"
  },
  Event_7339_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7339_Desc = {
    Text = "“Ich möchte so gerne wieder mit dir singen...“\nSarahs wahnsinniges, verzerrtes Wehklagen verstummte plötzlich, ihr entstelltes Gesicht zeigte einen Hauch von Verwirrung"
  },
  Event_7339_Name = {
    Text = "“Sasa-Schwester“"
  },
  Event_7340_ChoiceDesc1 = {
    Text = "[Verlassen]Erhalte 50 schwarze Siegel"
  },
  Event_7340_Desc = {
    Text = "“So glücklich! So glücklich!“ Eine laute, schrille und kindliche Stimme ertönt in deinem Ohr, “Für dich, für dich!“"
  },
  Event_7340_Name = {Text = "Nachtelf"},
  Event_7341_ChoiceDesc1 = {
    Text = "[Dicke Krankenakte]"
  },
  Event_7341_ChoiceDesc2 = {
    Text = "[Dünne Krankenakte]"
  },
  Event_7341_Desc = {
    Text = "Eine dir ziemlich vertraute Stimme hielt dich an, du blinzelst, kannst aber ihre Gestalt überhaupt nicht erkennen. \n “Ich weiß, dass du es eilig hast“, sagte die Ärztin Clementine mit fröhlichem Ton, “ich verspreche, dich nicht zu lange aufzuhalten.“ \n Zwei Hände durchdrangen den Nebel in deinem Kopf und hielten jeweils eine Krankenakte, eine dick und abgenutzt, die andere dünn und neu. \n “Basierend auf deinen Fragebogenergebnissen habe ich mir erlaubt, eine Krankenakte für dich anzulegen. Aber ich habe vergessen, welche deine ist, wie wäre es, wenn du eine auswählst?“ \n Aus irgendeinem Grund strömte von der dünnen Krankenakte ein vertrauter Duft aus, der leise mit der geistigen Verbindung zwischen dir und dem Erwecker resonierte."
  },
  Event_7341_Name = {
    Text = "Krankenakte"
  },
  Event_7342_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7342_Desc = {
    Text = "Eine gewöhnliche Wand, du klopfst darauf und bemerkst, dass sie nicht massiv ist"
  },
  Event_7342_Name = {
    Text = "Seltsame Wand"
  },
  Event_7343_ChoiceDesc1 = {
    Text = "[Ich bin nicht an der Oberfläche]verbessere zufällig 1 silbernes Relikt zu einem goldenen Relikt“(RelicConfig.Arg1)“"
  },
  Event_7343_ChoiceDesc2 = {
    Text = "[Nach unten schauen]Erhalte ein Silberrelikt „(RelicConfig.Arg1)“, infiziere „(Skill.Arg2)“"
  },
  Event_7343_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte 25 schwarze Siegel"
  },
  Event_7343_Desc = {
    Text = "“Hehe, Schutzherr, erinnerst du dich an Winkles Warnung? Hör zu, nicht·schauen·auf·dein·Spiegel·bei·Mittag.“"
  },
  Event_7343_Name = {
    Text = "unsichtbares Spiegelbild"
  },
  Event_7343_Tips1 = {
    Text = "Noch keine Silberrelikte"
  },
  Event_7344_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7344_Desc = {
    Text = "Ein Phantasma aus ferner Zukunft, verborgen in den Bergschlucht von Elworth"
  },
  Event_7344_Name = {
    Text = "Vulkanphantom"
  },
  Event_7345_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7345_Desc = {
    Text = "Der Schmetterling zerbrach in deiner Handfläche, wie eine Glasdecke, die plötzlich zerschmettert wurde, die Bruchstücke fielen zur Erde, fielen, fielen—"
  },
  Event_7345_Name = {
    Text = "Illusion der Stahlbrücke"
  },
  Event_7346_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7346_Desc = {
    Text = "Warte, bis sie aus dem Schatten treten"
  },
  Event_7346_Name = {
    Text = "Laternenschwarzer Rabe"
  },
  Event_7347_ChoiceDesc1 = {
    Text = "[Schalter umlegen]Sichtfeld erweitern"
  },
  Event_7347_Desc = {
    Text = "Ein altes Beleuchtungsgerät, das den schwarzen Nebel vertreibt.\nDer Nebel um es herum pulsiert rhythmisch, als ob er von seinem Atem gestört wird"
  },
  Event_7347_Name = {
    Text = "Suchscheinwerfer"
  },
  Event_7348_ChoiceDesc1 = {
    Text = "[Weise auf das Problem hin] wähle 1 von 3 Befehlskarten, um Gebet zu erhalten: „(EnchantConfig.Arg1)“"
  },
  Event_7348_ChoiceDesc2 = {
    Text = "[Fragen schlucken]infiziert „(Skill.Arg1)“, druckt neu, maximal 2 Mal durchführen"
  },
  Event_7348_Desc = {
    Text = "Bis jetzt schwelgst du immer noch in den Erinnerungen an Murphys Erzählungen aus der Vergangenheit.\nDie Erinnerungen lassen dich in Symbiose fühlen, sie fesseln und drücken dein Gehirn, selbst die letzte Ermahnung von Goliath an Murphy konnte dir keinen Trost spenden.\n... Warte, sie sagten, der Moment der Sternen-Ausrichtung wird in fünfundzwanzig Jahren sein...\nAber die Murphy vor dir ist eindeutig nur ein halbes Kind..."
  },
  Event_7348_Name = {
    Text = "Eingesperrtes Leben"
  },
  Event_7349_ChoiceDesc1 = {
    Text = "[Verlassen]Erhalte eine Auswahl von 3 für 1 Silberrelikt, infiziere“(Skill.Arg1)“"
  },
  Event_7349_Desc = {
    Text = "Sie sollte weinen, niemand hat mehr Grund dazu als sie.\nAber warum tut sie es nicht? Warum bleibt sie außen vor, als ob die Menschen nicht für sie beten würden"
  },
  Event_7349_Name = {
    Text = "Flugvorbereitungszeremonie"
  },
  Event_7350_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7350_Desc = {
    Text = "Egal was, es ist unhöflich, die Privatsphäre anderer zu durchdringen"
  },
  Event_7350_Name = {
    Text = "Wie im Brief gelesen"
  },
  Event_7351_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7351_Desc = {
    Text = "Es muss nur eine vorübergehende Sehschwäche sein."
  },
  Event_7351_Name = {
    Text = "Schwarze Krähe Blick"
  },
  Event_7352_ChoiceDesc1 = {
    Text = "[Verlassen]Erhalte eine Auswahl von 3 für 1 Gebet"
  },
  Event_7352_Desc = {
    Text = "In den Erinnerungen beten alle zu ihr, flehen sie an. Du kannst nicht anders, als in deinem Herzen zu murmeln"
  },
  Event_7352_Name = {
    Text = "Flugvorbereitungszeremonie"
  },
  Event_7353_ChoiceDesc1 = {
    Text = "[Verlassen]Erhalte 25 schwarze Siegel"
  },
  Event_7353_Desc = {
    Text = "Unter der schwarzen Katze tropft schwarzer Schleim, der sich zu einem Bach sammelt und in die Kanalisation fließt. Da du nicht näher kommst, springt die Katze in die Kanalisation und verschwindet"
  },
  Event_7353_Name = {Text = "Nachtelf"},
  Event_7354_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7354_Desc = {
    Text = "Du bist in Panik und stößt einen schrillen Schrei aus. \n Anscheinend verwirrt von deinem Schrei zögert die zuvor unruhige Hand einen Moment. \n Du nutzt diese Gelegenheit und rennst sofort hinaus."
  },
  Event_7354_Name = {
    Text = "dunkles Sumpfgebiet"
  },
  Event_7355_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7355_Desc = {
    Text = "Verzerren, kriechen, winden... du versuchst alles, um diese lästigen Arme loszuwerden.\nAm Ende entkommst du, aber verlierst eine neue Schuluniform, zwei Rippen und Hunderte von Haaren"
  },
  Event_7355_Name = {
    Text = "dunkles Sumpfgebiet"
  },
  Event_7356_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7356_Desc = {
    Text = "“Normales Phänomen, mach keinen Aufstand, als wärest du ein unerfahrener Neuling,“\nDoll trat näher und richtete dir die Brosche, “das bedeutet, dass es in der Nähe einen Zugang zu einer besonderen Dimension gibt. Es scheint in Richtung des Irrenhauses zu sein.“"
  },
  Event_7356_Name = {
    Text = "Unruhige Brosche"
  },
  Event_7357_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7357_Desc = {
    Text = "Du hast keinen Grund, die Anforderungen der Tempellicht-Gläubigen zu akzeptieren.\nDie Raben schütteln ihre schmutzigen, furchterregenden Häuflein und machen ein Geräusch, das man nur am Grab hören würde, bevor sie jammernd davonfliegen"
  },
  Event_7357_Name = {Text = "Fluchrabe"},
  Event_7358_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7358_Desc = {
    Text = "“Das ist auch meine Wahl“, sagte die Gestalt mit dem Teddybär, “aber sie wird zu seiner Marionette, und sie werden alle sterben. \n Du wirst der Komplize des Bösen sein.“ \n Starke Schuldgefühle überwältigen dich. Die Gestalt verschwindet, du hältst dir das Herz und weißt nicht, ob das eben Gesehene eine Projektion oder eine Illusion ist, die unter dem Druck der Seele entstanden ist."
  },
  Event_7358_Name = {
    Text = "verzweigter Pfad"
  },
  Event_7359_ChoiceDesc1 = {
    Text = "[Weiter halten die Ohren zu]Erhalte die höchste Wahnsinnswert eines Erweckers in gleich vielen schwarzen Siegeln (Arg1)"
  },
  Event_7359_ChoiceDesc2 = {
    Text = "[Weiter halten die Ohren zu]Heile (Arg1) Lebenspunkte, die vorhandenen schwarzen Siegel erhöhen die Heilung"
  },
  Event_7359_Desc = {
    Text = "Du hast den bösartigen Flüstern in deinem Ohr nachgegeben. Ein schriller Schmerz, scharf wie eine Nadel, bohrt sich tief in deinen Schädel.\n\n„Hör auf – bitte hör auf – ich habe getan, was du verlangt hast – lass es aufhören –“\n\nDu umklammerst deinen Kopf in Qual und hörst nur das ferne, höhnische Lachen der Krähen."
  },
  Event_7359_Name = {
    Text = "Sanges der Raben"
  },
  Event_7360_ChoiceDesc1 = {
    Text = "[Fange eine Krähe] für jede geweckte Erweckerin +25 das schwarze Siegel"
  },
  Event_7360_ChoiceDesc2 = {
    Text = "[Kreisende Schreie]wählt 1 Erwecker zum Erwachen und fügt seiner Erwachenskarte „inhärent“ und „beibehalten“ Effekte hinzu"
  },
  Event_7360_Desc = {
    Text = "Du wirst plötzlich verspielt und fängst eine Krähe.\nSie kämpft verzweifelt in deiner Hand und explodiert schließlich in einer warmen Wasserblase"
  },
  Event_7360_Name = {
    Text = "Sanges der Raben"
  },
  Event_7361_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7361_Desc = {
    Text = "Du hältst dir die Ohren zu und schließt die Augen.\nDum-Dum, Dum-Dum... Dein Herzschlag mischt sich mit schrillen Schreien, eine chaotische Todesmelodie.\nIn diesem Moment fühlst du eine nie da gewesene Stille"
  },
  Event_7361_Name = {
    Text = "Sanges der Raben"
  },
  Event_7362_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7362_Desc = {
    Text = "Im Bereich herrschen viele Gefahren, nicht auf jedes Licht kann man sich als Wegweiser verlassen.\n Es könnte auch das Kerzenlicht sein, das die Motten anlockt"
  },
  Event_7362_Name = {Text = "Nachtglanz"},
  Event_7363_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7363_Desc = {
    Text = "„Du bist längst tot und kannst nicht nach Unser Zuhause zurückkehren.\" Deine Stimme ist kalt wie der Heulen Wind über dem Ros-Schneefeld. Das Emoji des Reisenden verändert sich nicht im Geringsten, als ob es so sein müsste. Er ergreift erneut deine Hand: „Hilf mir! Ich bin ein Soldat, der den Befehl erhalten hat, in den fernen Osten aufzubrechen...\""
  },
  Event_7363_Name = {
    Text = "Verschlinger"
  },
  Event_7364_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7364_Desc = {
    Text = "Der Telegraf ist beschädigt. Du kannst dir die Verzweiflung des Besitzers während des Sturms vorstellen... denn du fühlst sie jetzt auch"
  },
  Event_7364_Name = {
    Text = "Stummes Telegramm"
  },
  Event_7365_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7365_Desc = {
    Text = "“Gehe fünfzig Yards nach vorne, dann links abbiegen, dann rechts abbiegen, dann wieder links abbiegen...\nund dann geradeaus bis zum Ende, dein Zuhause ist dort.“\nDer Reisende war überglücklich. Er winkte dir zu und ging dann weg. \nDu seufzt erleichtert und fühlst plötzlich, wie jemand deine Hand ergreift. Das vertraute Stimme ertönt erneut in deinem Ohr: \n“Hilf mir!\nIch bin ein Soldat, beauftragt, in den fernen Osten zu reisen...“"
  },
  Event_7365_Name = {
    Text = "Verschlinger"
  },
  Event_7366_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7366_Desc = {
    Text = "Du hast endlich das Labyrinth verlassen.\nIn diesem Moment verstehst du plötzlich, dass das Wachsfigurenkabinett ein lebendiges Wesen ist.\nAlles Unheimliche, Schöne und Grausame ist durch ein altes Ritual verbunden.\nUnd das Auge des Rituals ist Rogers"
  },
  Event_7366_Name = {
    Text = "Labyrinth der Augen"
  },
  Event_7367_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7367_Desc = {
    Text = "“Ist Rollenspiel interessant, Hüter?“ Ramona zupfte an deinem Ärmel, „Der Ausgang ist nicht weit von uns entfernt, ich hoffe, dass Sie auch gegenüber der Frau Narzisse diesen Humor bewahren können.“"
  },
  Event_7367_Name = {
    Text = "Erinnerungsfragment: Alte Träume wiederbelebt"
  },
  Event_7368_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7368_Desc = {
    Text = "“Erwachte Körper können dem Willen des Verbinders schwer widerstehen,“ antwortest du, “aber wir werden nicht aufgeben.“"
  },
  Event_7368_Name = {Text = "Ihre Wahl"},
  Event_7369_ChoiceDesc1 = {
    Text = "[Betreten]Durch die Wand gehen, um zu erkunden"
  },
  Event_7369_ChoiceDesc2 = {
    Text = "[Verlassen]"
  },
  Event_7369_Desc = {
    Text = "Du näherst dich der Wand, die plötzlich verzerrt, als wolle sie dich verschlingen"
  },
  Event_7369_Name = {
    Text = "Verzerrter Raum"
  },
  Event_7370_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7370_Desc = {
    Text = "“Nein, das ist nicht wahr. Im Vergleich zu Kakerlaken habt ihr zumindest einen pelzigen Körper. \n Niemand kann einem pelzigen Körper widerstehen.“\n Die Mäuse tuscheln und stimmen schließlich widerwillig deiner Meinung zu. \n“Naja... eigentlich gibt es nicht so viel Fell.“\n Gelobt zu werden, ist immer erfreulich. Bevor sie gehen, schenken dir die Mäuse ein kleines Geschenk."
  },
  Event_7370_Name = {Text = "Pest"},
  Event_7371_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7371_Desc = {
    Text = "“Ich stimme zu! Menschen und Ratten können nicht zusammenleben!“\nDie Ratten zeigten ihre weißen Zähne, etwas verärgert.\n“Was machst du dann noch hier? Nimm deine Sachen und komm nie wieder.“"
  },
  Event_7371_Name = {Text = "Pest"},
  Event_7372_ChoiceDesc1 = {
    Text = "[Bestätigen]"
  },
  Event_7372_Desc = {
    Text = "Willkommen tief unter dem Meer, wo jeder Schritt mit schwerem Druck verbunden ist.\n\nDas lichtundurchlässige Chaosnebel verbirgt alles, kannst du unter diesem Dunklen Meer hindurchgehen?"
  },
  Event_7372_Name = {
    Text = "Unter der Flut"
  },
  Event_7373_ChoiceDesc1 = {
    Text = "[Schau dich um]Lösche 1 Karte"
  },
  Event_7373_ChoiceDesc2 = {
    Text = "[Genau ansehen]Erhalte „(RelicConfig.Arg1)“, Infektion „(Skill.Arg2)“"
  },
  Event_7373_Desc = {
    Text = "“Tack tack...“\nDie Schreibmaschine spuckt langsam schwarze Tinte aus, als wäre sie betrunken.\nDu erkennst das Wort „Mason“ und ziehst sofort das Papier heraus"
  },
  Event_7373_Name = {
    Text = "Schreibmaschine"
  },
  Event_7374_ChoiceDesc1 = {
    Text = "[Direkter Blick in die Augen]Erhalte goldenes Relikt“(RelicConfig.Arg1)“，Infektion“(Skill.Arg2)“"
  },
  Event_7374_ChoiceDesc2 = {
    Text = "[Augen schließen]Zufälliges Erwachen von 2 Erwachten, Infektion zweimal“(Skill.Arg1)“"
  },
  Event_7374_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte 50 schwarze Siegel"
  },
  Event_7374_Desc = {
    Text = "Unzählige Augen flüstern dir ins Ohr. \n“Wir reisen, wir halten an, wir schreiten mit großen Schritten durch zehntausende Jahre und sogar noch länger. \nWenn die Sonne im Blick allmählich verblasst, während das Leben der alten Erde von Fluten verschlungen wird. \nWir sind längst von den Geheimnissen des Universums tief fasziniert.“"
  },
  Event_7374_Name = {Text = "Auge"},
  Event_7375_ChoiceDesc1 = {
    Text = "[Anweisungen folgen]Erhöhe Leben um Arg1"
  },
  Event_7375_ChoiceDesc2 = {
    Text = "[Verlassen]"
  },
  Event_7375_Desc = {
    Text = "Du hast versucht, mit der Rückverfolgungskraft des Silberschlüssels den nächsten Verbindungspunkt zu finden, aber die erhaltenen Informationen waren mit unauffälligen Anomalien durchsetzt und schienen gestört zu sein"
  },
  Event_7375_Name = {
    Text = "Abnormale Verbindung"
  },
  Event_7376_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7376_Desc = {
    Text = "Du wischst vorsichtig die Oberfläche der Schreibmaschine mit dem standardmäßigen Leinen-Taschentuch aus dem Mizag-Studentenanzug.\nDie Schreibmaschine kommt wieder zur Ruhe. Was das verschmutzte Taschentuch betrifft... lass es im Bereich"
  },
  Event_7376_Name = {
    Text = "Das Flüstern der Schreibmaschine"
  },
  Event_7377_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7377_Desc = {
    Text = "Du siehst genau hin und erkennst in den verwischten Tintenflecken einen Namen: „Fingal Johansen“.\nWer ist das?"
  },
  Event_7377_Name = {
    Text = "Das Flüstern der Schreibmaschine"
  },
  Event_7378_ChoiceDesc1 = {
    Text = "[Nach oben schauen]Wähle eine von 3 Befehlskarten und erhalte das Orison: „(EnchantConfig.Arg1)“, infiziere „(Skill.Arg2)“"
  },
  Event_7378_ChoiceDesc2 = {
    Text = "[Sonne Winkel?]wähle 1 Erwecker und Infektion „(Skill.Arg1)“"
  },
  Event_7378_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte 25 schwarze Siegel"
  },
  Event_7378_Desc = {
    Text = "“„Jetzt, sofort nach oben schauen in die südöstliche Richtung, der Winkel der Sonne ist auf seiner Position.““ Die Anweisung von Puppe kam durch das Kommunikationsgerät"
  },
  Event_7378_Name = {Text = "Hochwinkel"},
  Event_7379_ChoiceDesc1 = {
    Text = "[Infiziere“(Skill.Arg1)“、erhalte das goldene Relikt“(RelicConfig.Arg2)“]"
  },
  Event_7379_ChoiceDesc2 = {
    Text = "[Verlassen]Erhalte 50 schwarze Siegel"
  },
  Event_7379_Desc = {
    Text = "Ereignis 354 (in Entwicklung), nicht das Endergebnis"
  },
  Event_7379_Name = {
    Text = "Ereignis 354 (in Entwicklung)"
  },
  Event_7380_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7380_Desc = {
    Text = "Die Stimmen der Kinder fließen von den Tasten. \n„Alter Charlie hatte eine getigerte Katze, die er sehr liebte...“ \nUnter dem Gesang der Kinder singt auch eine junge Frau leise und sanft. \nHast du dich verhört?"
  },
  Event_7380_Name = {
    Text = "Kindheitsmelodie"
  },
  Event_7381_ChoiceDesc1 = {
    Text = "[Dreh dich um]Erhalte 25 schwarze Siegel"
  },
  Event_7381_ChoiceDesc2 = {
    Text = "[Weiter gehen]Erhalte ein silbernes Relikt:“(RelicConfig.Arg1)“, Infektion“(Skill.Arg2)“"
  },
  Event_7381_Desc = {
    Text = "Hinter dir sind Schritte zu hören.\nWie ein Schatten, langsam und gleichmäßig.\nIhre Schritte vermischen sich mit deinen und hallen im leeren Ausstellungsraum wider"
  },
  Event_7381_Name = {
    Text = "Oxford-Schuhe"
  },
  Event_7382_ChoiceDesc1 = {
    Text = "[Briefpapier einpacken]2 Karten löschen"
  },
  Event_7382_ChoiceDesc2 = {
    Text = "[Papier bewahren] erhält verfluchtes Relikt „(RelicConfig.Arg1)“, Infektion „(Skill.Arg2)“"
  },
  Event_7382_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte Arg1 schwarze Siegel"
  },
  Event_7382_Desc = {
    Text = "Eine neue Schreibmaschine. \n Sie hat eine einzigartige Tastatur, prächtig und fein wie ein Mikroskop. \n Du bist fasziniert von ihrer perfekten mechanischen Struktur, als plötzlich schwarze Schrift erscheint. \n “Sehr geehrter Herr Rogers, \n mit schwerem Herzen teilen wir Ihnen mit, dass Sie von der Akademie ausgeschlossen wurden. \n Wie allgemein bekannt ist, ist die @2-Akademie im ganzen Königreich für ihre strenge wissenschaftliche Haltung berühmt, und die erstaunlichen Gerüchte @3 haben uns zutiefst beunruhigt...“"
  },
  Event_7382_Name = {
    Text = "Wie im Brief gelesen"
  },
  Event_7383_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7383_Desc = {
    Text = "Die ferne, stehende Taschenuhr scheint eine Art Aufforderung zu sein, die dich daran erinnert, nicht in der Falle von Raum und Zeit zu versinken"
  },
  Event_7383_Name = {Text = "Sein Blick"},
  Event_7384_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7384_Desc = {
    Text = [[
Schwarzer Schlamm tropfte auf dein Gesicht und verursachte ein kribbelndes Jucken.
Du konntest es nicht ertragen und schlugst nach dem Schmetterling.
Der Schmetterling entkam deiner feindseligen Bewegung und verschwand lautlos in der Ferne]]
  },
  Event_7384_Name = {
    Text = "Schwarze Flüssigkeitsfalter"
  },
  Event_7385_ChoiceDesc1 = {
    Text = "[Genau beobachten]"
  },
  Event_7385_ChoiceDesc2 = {Text = "[Graben]"},
  Event_7385_Desc = {
    Text = "Kum trug euch drei durch das Irrenhaus auf der Suche nach einem Eingang.\nPlötzlich bremste sie scharf, fast hättet ihr den Halt verloren.\nAuf eure Fragen hin schnüffelte Kum am weichen Boden und deutete euch an, dass darunter etwas vergraben sei"
  },
  Event_7385_Name = {
    Text = "Vergrabenes Objekt"
  },
  Event_7386_ChoiceDesc1 = {
    Text = "[abholen]Erhalte 3 wählbare goldene Relikte"
  },
  Event_7386_Desc = {
    Text = "Dort ist nichts, schwarze Flüssigkeit fließt über den Boden und spiegelt nichts wider.\nWar es eine Täuschung? Du fühlst, wie etwas durch deine Finger schlüpft"
  },
  Event_7386_Name = {
    Text = "Spiegel darunter"
  },
  Event_7387_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7387_Desc = {
    Text = "Die schwarzen Flügel fallen auf den feuchten Boden der Gasse und verwandeln sich in schwarzen, schlammigen D-Schleim"
  },
  Event_7387_Name = {
    Text = "wütende Rabenmenge"
  },
  Event_7388_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7388_Desc = {
    Text = "“Die Frau Narzisse wird deinen Humor mögen.» Ramona winkte mit der Hand, der nebelhafte Schatten zerstreute sich, „Lass dich nicht zum Preis der Dimension reisen.“"
  },
  Event_7388_Name = {
    Text = "Erinnerungsfragment: Alte Träume wiederbelebt"
  },
  Event_7389_ChoiceDesc1 = {
    Text = "[abholen]Erhalte 3 wählbare goldene Relikte"
  },
  Event_7389_Desc = {
    Text = "Oh ja, das abscheuliche Spiegelbild bist du selbst.\nDie aufsteigende Bosheit tanzt mit dem schwarzen Schlamm zu deinen Füßen. Wenn es dir nichts ausmacht, will es auf deine Schulter klettern"
  },
  Event_7389_Name = {
    Text = "Spiegel darunter"
  },
  Event_7390_ChoiceDesc1 = {
    Text = "[Stillstand]erhält 25 das schwarze Siegel"
  },
  Event_7390_ChoiceDesc2 = {
    Text = "[ziehe umher]Erhalte das Silberrelikt“(RelicConfig.Arg1)“，Infektion“(Skill.Arg2)“"
  },
  Event_7390_Desc = {
    Text = "Du zertrittst deinen eigenen Schatten und fällst in eine Pfütze aus Nacht. \n Der zerbrochene, zerfledderte Schatten ist das einzige, was in der verlorenen Welt mit dir verbunden ist. \n Musst du wirklich im schwarzen Albtraum wandeln? Du hast noch keinen Weg gefunden."
  },
  Event_7390_Name = {
    Text = "Alptraumwandler"
  },
  Event_7391_ChoiceDesc1 = {
    Text = "[Die Quelle suchen]erhalte das silberne Relikt „(RelicConfig.Arg1)“, Infektion „(Skill.Arg2)“"
  },
  Event_7391_ChoiceDesc2 = {
    Text = "[Platte wiederholen]Alle Erwachten heilen 50 Wahnsinn, Infektion“(Skill.Arg1)“"
  },
  Event_7391_ChoiceDesc3 = {
    Text = "[Zerlege den Plattenspieler] erhält 1 aus 3 Gebete"
  },
  Event_7391_Desc = {
    Text = "Du begegnest einem alten, gebrauchten Phonographen. \n Nachdem du den Aufzug aufgezogen hast, setzt du die Nadel auf die zerkratzte Schallplatte, und die Symphonie verzerrt sich, als ob das Abziehen von Klebeband Geräusche verursacht. Blasinstrumente und Streichinstrumente schlagen sich gegenseitig, kein Teil kann unversehrt aus diesem Stück entkommen. \n Am Ende des Stücks, das zischt und knistert, hörst du jedoch ein regelmäßiges Klopfen. \n “Dong Dong... Dong Dong Dong... Dong...“ \n Du runzelst die Stirn und ziehst die Nadel zurück, doch das Klopfen bleibt unverändert."
  },
  Event_7391_Name = {
    Text = "Versteckte Spur"
  },
  Event_7392_ChoiceDesc1 = {
    Text = "[Beträchtlich leuchten]Wähle 1 Relikt, das zu einem verfluchten Relikt wird:“(RelicConfig.Arg1)“"
  },
  Event_7392_ChoiceDesc2 = {
    Text = "[Berühre den Glanz]Erhalte das Silberrelikt“(RelicConfig.Arg1)“，infiziere“(Skill.Arg2)“"
  },
  Event_7392_ChoiceDesc3 = {
    Text = "[Dreh dich um und verlasse]Erhalte 25 schwarze Siegel"
  },
  Event_7392_Desc = {
    Text = "Unter der Vision des Traums legt der Nebel des Geheimgangs einen schwarzen Schleier über die Realität. Alles, was man sieht, erscheint vage, als ob es existiert und doch nicht. \n In der Unschärfe durchdringt der Glanz von etwas den Nebel. Wie ein Leuchtturm für ein Schiff, wie Rauch für ein verlorenes Kind, weist es den sicheren Weg."
  },
  Event_7392_Name = {Text = "Nachtglanz"},
  Event_7393_ChoiceDesc1 = {
    Text = "[Musik pausieren] aktualisiere ein Silberrelikt zu einem goldenen Relikt “(RelicConfig.Arg1)“"
  },
  Event_7393_ChoiceDesc2 = {
    Text = "[Mit ihm sprechen]Erhalte ein goldenes Relikt:“(RelicConfig.Arg1)“、infiziere“(Skill.Arg2)“und“(Skill.Arg3)“"
  },
  Event_7393_ChoiceDesc3 = {
    Text = "[Stille hören] erhalte 25 schwarze Siegel"
  },
  Event_7393_Desc = {
    Text = "Du nimmst einige zersplitterte Erinnerungen aus einer Pfütze verunreinigter schwarzer Flüssigkeit auf. \n Die Kristalle sind klar und leuchtend, einige Fäden tanzen darin und die verbleibenden Erinnerungsfragmente wehen wie vom Wind verwehte Sandkörner in der Luft. \n Chaotische, bizarre und seltsame Bilder steigen neben dir auf. \n Du schaust hin—— \n"
  },
  Event_7393_Name = {
    Text = "Silbermondfragment"
  },
  Event_7394_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7394_Desc = {
    Text = "Ihr fangt einige fallenden Schneeflocken auf und schaut genau hin. Der Schnee schmilzt nicht zu klaren Wassertropfen, sondern zu dickflüssigem, dunklem D-Schleim"
  },
  Event_7394_Name = {Text = "Schnee"},
  Event_7395_ChoiceDesc1 = {
    Text = "[Ich bin nicht an der Oberfläche]verbessere zufällig 1 silbernes Relikt zu einem goldenen Relikt“(RelicConfig.Arg1)“"
  },
  Event_7395_ChoiceDesc2 = {
    Text = "[Nach unten schauen]Erhalte ein Silberrelikt „(RelicConfig.Arg1)“, infiziere „(Skill.Arg2)“"
  },
  Event_7395_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte 25 schwarze Siegel"
  },
  Event_7395_Desc = {
    Text = "Der Nebel lichtet sich und eine dürren Handfläche reicht dir entgegen. \n Sie scheint von Fleisch und Blut verfallen zu sein, die unebene Handfläche ist mit einer zähflüssigen schwarzen Masse bedeckt, und an ihr hängen Ringe und Halsketten, die in goldenem Licht strahlen. \n Sie winkt dir zu, als wolle sie dich näher heranlocken. \n Nur im Schatten der Gefahr scheint der Schatz besonders strahlend."
  },
  Event_7395_Name = {
    Text = "Verwirrende Teufelklauen"
  },
  Event_7395_Tips1 = {
    Text = "Noch keine Silberrelikte"
  },
  Event_7396_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7396_Desc = {
    Text = "Das Phantasma winkte dir zu und verschwand dann. Übrig bleibt dir nur die kalte Kälte und die majestätischen Berge"
  },
  Event_7396_Name = {
    Text = "Vulkanphantom"
  },
  Event_7397_ChoiceDesc1 = {
    Text = "[Silbermondbeerdigung]Wähle ein Relikt, um zu einem verfluchten Relikt „(RelicConfig.Arg1)“ zu werden"
  },
  Event_7397_ChoiceDesc2 = {
    Text = "[Silbermondgebet]Erhalte Silberrelikt „(RelicConfig.Arg1)“, infiziere „(Skill.Arg2)“"
  },
  Event_7397_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte 25 schwarze Siegel"
  },
  Event_7397_Desc = {
    Text = "Du nimmst einige zersplitterte Erinnerungen aus einer Pfütze verunreinigter schwarzer Flüssigkeit auf. \n Die Kristalle sind klar und leuchtend, einige Fäden tanzen darin und die verbleibenden Erinnerungsfragmente wehen wie vom Wind verwehte Sandkörner in der Luft. \n Chaotische, bizarre und seltsame Bilder steigen neben dir auf. \n Du schaust hin——"
  },
  Event_7397_Name = {
    Text = "Silbermondfragment"
  },
  Event_7398_ChoiceDesc1 = {
    Text = "[Brennstoff hinzufügen] erhält 3 aus 1 Orison"
  },
  Event_7398_ChoiceDesc2 = {
    Text = "[Lösche es aus]Wähle 1 von 3 Befehlskarten und erhalte ein Gebet: „(EnchantConfig.Arg1)“, infiziere „(Skill.Arg2)“"
  },
  Event_7398_Desc = {
    Text = "“Ich bin der Schatten der ermordeten Dienerin, der Mörder ist das falsche grüne Feuer.“\nDie schwach rötliche Flamme flackerte und klagte dich an.\n“Ich lebte einst am Ufer des reflektierenden Mondsees, strahlend und prächtig.“"
  },
  Event_7398_Name = {
    Text = "dämmriges Feuer"
  },
  Event_7399_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7399_Desc = {
    Text = "Du und der Schatten stehen unter der Straßenlaterne, niemand spricht.\nHeute Nacht gibt es keinen Mond, alle Häuser sind still.\nDu winkst dem Schatten zu und drehst dich um, um zu gehen"
  },
  Event_7399_Name = {
    Text = "Die Silhouette unter der Straßenlaterne"
  },
  Event_7400_ChoiceDesc1 = {
    Text = "[vertreibe die Krähen]Erhalte Arg1 schwarze Siegel, Infektion“(Skill.Arg2)“，weiter wählen"
  },
  Event_7400_ChoiceDesc2 = {
    Text = "[Ignorieren]Verlassen"
  },
  Event_7400_Desc = {
    Text = "Ein Rabe sitzt am Kopfende des Bettes und starrt dich mit roten Augen an"
  },
  Event_7400_Name = {
    Text = "Laternenschwarzer Rabe"
  },
  Event_7401_ChoiceDesc1 = {
    Text = "[Behaupte, du hast kein Portemonnaie]Erhalte ein Gebet aus 3 wähle 1"
  },
  Event_7401_ChoiceDesc2 = {
    Text = "[Das Netz zerreißen] Eine zufällige Befehlskarte erhält das Gebet: „(EnchantConfig.Arg1)\", infiziert „(Skill.Arg2)\""
  },
  Event_7401_Desc = {
    Text = "Das orange-gelbe Netz schwebt still in der Luft, seine Löcher sind spärlich und bei weitem nicht so kunstvoll wie die eines Verwandten, der an der Wand sitzt. \n Du kannst nicht anders, als deine Hand auszustrecken, das zerbrechliche Netz löst sich im Handumdrehen auf, das Lachen der Kinder ertönt in deinen Ohren. \n “Das goldene, das silberne, das gelbe, das rote, alle Geldbörsen gehören uns!“"
  },
  Event_7401_Name = {
    Text = "verirrtes Netzwerk"
  },
  Event_7402_ChoiceDesc1 = {
    Text = "[Wartung der Telegrafen]Infektion“(Skill.Arg1)“, Zufällig 1 Befehlskarte, um ein Gebet zu erhalten:“(EnchantConfig.Arg2)“"
  },
  Event_7402_ChoiceDesc2 = {
    Text = "[Telegraphenmaschine begraben]infiziere „(Skill.Arg1)“, zufällig 1 Befehlskarte erhält Gebet: „(EnchantConfig.Arg2)“"
  },
  Event_7402_ChoiceDesc3 = {
    Text = "[Ignoriere]wähle 1 von 3 Befehlskarten und erhalte ein Gebet:“(EnchantConfig.Arg1)“"
  },
  Event_7402_Desc = {
    Text = "Du versteckst dich in einer schmalen Felsspalte, um dem Schneesturm zu entkommen. Aber du weißt, dass du hier nicht lange bleiben kannst, wenn die schwarz gekleideten Kreaturen dich finden, gibt es kein Entkommen.\nIn der Ecke der Spalte entdeckst du ein beschädigtes Telegrafengerät"
  },
  Event_7402_Name = {
    Text = "Vorherige Hinterlassenschaften"
  },
  Event_7403_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7403_Desc = {
    Text = "Solche Porträts hast du an vielen Orten im Königreich gesehen. \n “Die Königin“ steht im Mittelpunkt des Bildes und strahlt im Geleite schwarzer Rosen. \n Nur eine Sache ist anders – ihr Gesicht wurde rücksichtslos herausgerissen und hinterlässt ein verbranntes, schwarzes Loch. \n Bis heute kannst du das wahre Antlitz der Königin nicht sehen."
  },
  Event_7403_Name = {
    Text = "Porträtgalerie"
  },
  Event_7404_ChoiceDesc1 = {
    Text = "[Lass sie frei]erhalte ein verfluchtes Relikt“(RelicConfig.Arg1)“，infiziere“(Skill.Arg2)“"
  },
  Event_7404_ChoiceDesc2 = {
    Text = "[Ihr helfen] Wähle 1 von 3 Befehlskarten aus, um das Gebet zu erhalten: [(EnchantConfig.Arg1)]"
  },
  Event_7404_ChoiceDesc3 = {
    Text = "[Ich gehe meinen eigenen Weg]erhalte 50 das schwarze Siegel"
  },
  Event_7404_Desc = {
    Text = "Drei Schatten blockieren deinen Weg. \n “Du kannst sie freigeben“, sagt die Gestalt mit dem mit A-Schleim bedeckten Teddybär in den Armen, “sie ist nur ängstlich und nicht böse. Sie möchte niemandem schaden.“ \n “Du kannst ihr helfen“, sagt die Gestalt, die eine kunstvoll verpackte Süßigkeit in den Händen hält, “du kannst das tun, was sie nicht kann, du kannst das alles beenden.“ \n “Du musst uns nicht zuhören“, sagt die Gestalt, die mit leeren Händen dasteht, “du hast deinen eigenen Weg.“"
  },
  Event_7404_Name = {
    Text = "verzweigter Pfad"
  },
  Event_7405_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7405_Desc = {
    Text = "Daffodils Stimme hielt einen Moment inne. \n “Oh, hast du das gewählt? Gute Wahl, als Belohnung werde ich dir ein besonderes Geschenk machen.“ \n “Ich kenne das Kind nicht gut, aber ich habe eine Vermutung über Franz. Ich denke, dass die Emotion, die sie beherrscht und ihr die Fähigkeit gegeben hat, zu „sehen“, eine starke Reue ist. Ich weiß nicht, welche Wahl sie aufgrund dieser Reue treffen wird...“"
  },
  Event_7405_Name = {
    Text = "Hinweiszeit"
  },
  Event_74068_ChoiceDesc1 = {
    Text = "[In das Gehirn im Glas aufnehmen] Mische den “Ersatzgehirnzylinder“ in den Ziehstapel."
  },
  Event_74068_Desc = {
    Text = "Im komplexen Relief des Rundbogens, auf dem schrägen Dach der roten Ziegelmauer und vor den Nischen der Wände, tanzen die verlängerten Schatten und verlangen nach Antworten auf die Fragen. \nBedeutet Mittelmäßigkeit den Tod? \nFührt Zufriedenheit mit dem Status quo zwangsläufig zur Auslöschung?"
  },
  Event_74068_Name = {
    Text = "Noch nicht verlorene Bewusstsein"
  },
  Event_74069_ChoiceDesc1 = {
    Text = "[Weiter aufnehmen]Wähle bis zu 2 Befehlskarten aus dem Deck zum Entfernen aus und lege sie in den “Ersatzgehirnzylinder“."
  },
  Event_74069_Desc = {
    Text = "„Ich habe sie gesehen. Viele Menschen, viele wirren Worte, Weise, Oberflächliche, Vernünftige, Verrückte. Manchmal entstehen auch aus der Asche Funken der Hoffnung.“"
  },
  Event_74069_Name = {
    Text = "Noch nicht verlorene Bewusstsein"
  },
  Event_7406_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7406_Desc = {
    Text = "Du nimmst die Maus vorsichtig von der Waage, sie atmet ruhig und ihr pelziger Körper wärmt deine Handfläche"
  },
  Event_7406_Name = {
    Text = "Vernunft und Gefühl"
  },
  Event_7407_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7407_Desc = {
    Text = "Der matte Silberkern strahlte kurz auf und zerfiel zu Asche, die wie Sand durch die Finger rieselte.\nDer Silberkern verbrauchte seine letzte Gnosis, die unbekannte Seele konnte keinen neuen Körper formen, hinterließ aber Spuren ihrer Existenz, bevor sie vollständig verblasste."
  },
  Event_7407_Name = {
    Text = "Beweis der Existenz"
  },
  Event_7408_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7408_Desc = {
    Text = "“Ich kenne das Kind nicht gut, aber ich habe eine Vermutung über Franz. Ich denke, dass die Emotion, die sie beherrscht und ihr die Fähigkeit gegeben hat, zu „sehen“, eine starke Reue ist. Ich weiß nicht, welche Wahl sie aufgrund dieser Reue treffen wird...“"
  },
  Event_7408_Name = {
    Text = "Hinweiszeit"
  },
  Event_7409_ChoiceDesc1 = {
    Text = "[Papier herausziehen]1 Karte löschen"
  },
  Event_7409_ChoiceDesc2 = {
    Text = "[Nicht der richtige Zeitpunkt]Erhalte „(RelicConfig.Arg1)“, infiziert „(Skill.Arg2)“"
  },
  Event_7409_Desc = {
    Text = "Die tragbare Schreibmaschine im Koffer begann plötzlich von selbst zu tippen und schrieb eine halbe Seite krummer Wörter.\n“Du hast Ihn gesehen, Er ist neben dir, diese von Wahnsinn verschmutzten, fanatischen Schatten... Schau nicht direkt auf Seine Konturen.“"
  },
  Event_7409_Name = {
    Text = "Ungebetene Warnung"
  },
  Event_7410_ChoiceDesc1 = {
    Text = "[Nach links gehen]wählt 1 von 3 Befehlskarten und erhält Orison: „(EnchantConfig.Arg1)“, infiziert „(Skill.Arg2)“"
  },
  Event_7410_ChoiceDesc2 = {
    Text = "[Nach rechts gehen]wählt 1 Erwecker zum Erwachen, infiziert „(Skill.Arg1)“"
  },
  Event_7410_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte 25 schwarze Siegel"
  },
  Event_7410_Desc = {
    Text = "Du scheinst in einem Labyrinth zu sein.\nLinks, rechts, wieder links... Du verlierst die Geduld, bis du aufblickst und das Auge siehst.\nDas Auge beobachtet euch, ruhig und majestätisch, als wäre es der Herrscher hier"
  },
  Event_7410_Name = {
    Text = "Labyrinth der Augen"
  },
  Event_7411_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7411_Desc = {
    Text = "Du ziehst deine Hände mit aller Kraft zurück und hörst deutlich das Knacken der Knochen.\nDas ist der Preis für deine Neugier"
  },
  Event_7411_Name = {
    Text = "Inspirationsschub"
  },
  Event_7412_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7412_Desc = {
    Text = "Du überprüfst die Kamera gründlich, Leder und schwarz-goldene Einfassungen reflektieren einen öligen Glanz.\nDie Linse ist auf dich gerichtet, als würde sie dich anstarren und beobachten"
  },
  Event_7412_Name = {
    Text = "Rekord unschuldig"
  },
  Event_7413_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7413_Desc = {
    Text = "Du ziehst gnadenlos den restlichen Film heraus, der im Bauch der Kamera versteckt war. Das Bild darauf lässt dich sprachlos.\nDer unentwickelte Film zeigt dich, wie du in einer Pfütze aus schwarzem Schlamm liegst"
  },
  Event_7413_Name = {
    Text = "Rekord unschuldig"
  },
  Event_74145_ChoiceDesc1 = {
    Text = "[Lesen]Entferne eine Befehlskarte und erhalte 25 schwarze Siegel"
  },
  Event_74145_ChoiceDesc2 = {
    Text = "[Weiter tippen]Kopiere eine Karte aus dem Deck, infiziere “(Skill.Arg1)“"
  },
  Event_74145_Desc = {
    Text = "Der Drucker spritzt heftig Tinte. \n Schwarze Tinte strömt wie ein Geist aus der Düse und erfüllt die Luft, wodurch ein dichter und drückender schwarzer Nebel entsteht. \n Auf der Tastatur scheint sich ein Hinweis zu verbergen, der darauf wartet, von unschuldigen Fingern berührt zu werden."
  },
  Event_74145_Name = {
    Text = "GeisterTinte"
  },
  Event_74146_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_74146_Desc = {
    Text = "Du trittst seitlich in die dunkle Gasse, der Nebel nagt an den Ecken deiner Kleidung, doch der Schatten verwandelt sich hinter dir in unzählige Augen. Der rostige Glockenklang bringt feuchte Vorzeichen mit sich. \n\nDu weißt, dass alle gewundenen Wege letztendlich zu einem sich wiederholenden Kokon zusammenfallen werden – vor der verrottenden Dämmerung wirst du deinem eigenen Spiegelbild wiederbegegnen."
  },
  Event_74146_Name = {Text = "Zeit Asche"},
  Event_74147_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_74147_Desc = {
    Text = "Du zeichnest stumm den Umriss auf deiner Brust, um für die Verstorbenen ein stilles Gebet abzulegen.\nIn dieser auslöschenden Welt gibt es zu vieles, das du nicht retten konntest.\nDie Knochen schimmern, die Schätze, die ihr Herr im Leben verborgen hielt, lugen hervor."
  },
  Event_74147_Name = {
    Text = "verblichene Knochen"
  },
  Event_74148_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_74148_Desc = {
    Text = "“Der Vatergott wird sich deiner Barmherzigkeit erinnern. Er wird über uns wachen und uns von der Last unserer Leiden erlösen.“\n\nIhr Phantom verblasste allmählich, und die Klänge der heiligen Musik verwandelten sich in einen gnadenlosen Wind, der vorbeirauschte."
  },
  Event_74148_Name = {
    Text = "Gebet der Orgel"
  },
  Event_74149_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_74149_Desc = {
    Text = "Du schiebst vorsichtig das entblößte Skelett, das langsam und natürlich in die schwarze Schleimmasse sinkt und spurlos verschwindet.\nMöge die Seele in der Leere Ruhe finden."
  },
  Event_74149_Name = {
    Text = "verblichene Knochen"
  },
  Event_7414_ChoiceDesc1 = {
    Text = "[Verlassen]Du hast den Gegner besiegt, nichts passiert"
  },
  Event_7414_Desc = {
    Text = "“Es scheint, der Kleine muss ein bisschen leiden, um zu verstehen, dass man die Geheimnisse einer Frau nicht leichtfertig erforschen sollte.“\nMit Daffodils Worten erscheint ein riesiges Monster vor dir"
  },
  Event_7414_Name = {
    Text = "Hinweiszeit"
  },
  Event_74150_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_74150_Desc = {
    Text = "In dem Glockenturm, in dem die kleine Maus sich versteckt, sollten solche kranken Spielzeuge nicht existieren. Dieses Geräusch stammt aus deinem Kopf, aus deinen Erinnerungen. \n Du erinnerst dich an das Gefühl, das du als Gehirn im Tank hattest, als die Schallwellen in elektrische Ströme umgewandelt wurden. \n Das ungewöhnliche Geräusch wird allmählich normal und sanft, verwandelt sich in eine fließende klassische Melodie, die in deinem Kopf in einer Schleife abgespielt wird."
  },
  Event_74150_Name = {
    Text = "Fremde Geräusche vom Glockenturm"
  },
  Event_74151_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_74151_Desc = {
    Text = "Das ist keine Katze... das sind die sich regenden Laternenträger.\n Unter dem schwarzen Schleier blitzen Abscheu und Feindseligkeit auf, und das Geflüster kratzt an deinem Bewusstsein und bringt seltsame, unerklärliche Trugbilder."
  },
  Event_74151_Name = {
    Text = "Katzenflüstern"
  },
  Event_74152_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_74152_Desc = {
    Text = "Sie packten deine Schuhe, deine Fußgelenke. Sie waren gierig, sie waren begierig, sie wollten dich in den Abgrund ziehen, in dem sie selbst waren. \nDu kämpftest mit Mühe, um dich aufrecht zu halten, und machtest einige Schritte rückwärts, um zu entkommen. \nWie zufällig fiel etwas herunter."
  },
  Event_74152_Name = {
    Text = "Alptraumspiegel"
  },
  Event_74153_ChoiceDesc1 = {
    Text = "[Ausweichen]Erhalte 3 aus 1 Gebet"
  },
  Event_74153_ChoiceDesc2 = {
    Text = "[Verhindern]Wähle eine von 3 Befehlskarten und erhalte das Gebet: „(EnchantConfig.Arg1)“, infiziere „(Skill.Arg2)“"
  },
  Event_74153_Desc = {
    Text = "Die vertrauten Bilder lassen deine Nerven zucken, krampfen und Angst empfinden. \n “Wieder einmal...“ \n Ein grausamer Albtraum erscheint, ein überwältigendes Gefühl der Ohnmacht umhüllt dich. \n Kannst du ihr Schicksal wirklich nicht ändern? \n Es ist zu spät, im aufgerissenen Kopf von Sara wartet der silberne, riesige Mund darauf, dich abzubeißen und zu verschlingen."
  },
  Event_74153_Name = {
    Text = "Albtraum kehrt zurück"
  },
  Event_74154_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_74154_Desc = {
    Text = "Du hörst ein beunruhigendes Gemurmel.\n\n„Wir kommen aus den Bergen und Sümpfen ferner Sterne. Unsere Körper sind Docht und Brennstoff der Laterne; wir werden das Feuer der Erde entzünden, um den Weg in eine neue Welt zu erhellen.“"
  },
  Event_74154_Name = {
    Text = "Katzenflüstern"
  },
  Event_74155_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_74155_Desc = {
    Text = "Sonnenuntergang, Glockenturm, fliegende Vögel...\nDas Mädchen nimmt die Augenbinde ab, ihr grauer Blick lässt dich erstarren.\nDie Illusion ist wie eine Fata Morgana, sie zerfällt in deinen Augen, doch die besorgten Gedanken verschwinden nicht."
  },
  Event_74155_Name = {
    Text = "weißer Augenschutz"
  },
  Event_74156_ChoiceDesc1 = {
    Text = "[Aufheben]Erhalte eine Auswahl von 3 Silberrelikten"
  },
  Event_74156_ChoiceDesc2 = {
    Text = "[Erinnerung]Erhalte das Silberrelikt „(RelicConfig.Arg1)“ und „(RelicConfig.Arg2)“, infiziere zweimal mit „(Skill.Arg3)“"
  },
  Event_74156_Desc = {
    Text = "In der Ecke liegt eine kleine weiße Augenmaske in der Schmelzschleimschicht. \nDie Erinnerung erfasst dein Herz."
  },
  Event_74156_Name = {
    Text = "weißer Augenschutz"
  },
  Event_74157_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_74157_Desc = {
    Text = "Die transparente Handfläche tanzt mühelos über die schwarz-weißen Tasten, doch die entstehenden Klangwellen sind zerfetzt, wie eine verstimmte Spieluhr, die jede Note mit einem disharmonischen Jammer erfüllt, als ob sie um Hilfe kämpfen würde. \n Schließlich endet das Spiel abrupt in einem verzweifelten Akkord. \n Was im Leben nicht erlangt werden konnte, hinterlässt in diesem Moment nur Wehmut."
  },
  Event_74157_Name = {
    Text = "Sonata des Bedauerns"
  },
  Event_74158_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_74158_Desc = {
    Text = "“Sehr geehrte Frau Sarah: \nIch bitte um die Entlassung aus meiner Position als Pflegehelfer im Armenhaus. \nIch erkenne Ihre Philosophie nicht mehr an. Ihre Lehren sind falsch, die Kinder im Ostviertel sollten nicht unter Ihrem Schutz aufwachsen und an reine Güte und selbstlose Hingabe glauben. \nEines Tages müssen sie Ihre Flügel verlassen und lernen, nach den Gesetzen des Überlebens im Ostviertel zu leben. \n\n......“\n\nDie nachfolgenden Schriftzeichen wurden von einer schwarzen Flüssigkeit durchnässt und sind verschwommen."
  },
  Event_74158_Name = {
    Text = "GeisterTinte"
  },
  Event_74159_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_74159_Desc = {
    Text = "“Was ich den Kindern bieten kann, ist nur ein Dach über dem Kopf, das sie vor Regen schützt, und eine Mahlzeit, die sie nicht verhungern lässt. Wenn nicht der gutherzige Herr Rogers einen Arzt gerufen hätte, könnten sie bei Krankheit nicht einmal eine Tablette bekommen. \n Ich habe nicht viele Bücher gelesen, aber alles, was ich tun kann, ist, dafür zu sorgen, dass sie nicht auf der Straße erfrieren oder verhungern. \n Ich habe niemals eingegriffen, was für Menschen sie werden sollen, aber sie müssen überleben. \n......“"
  },
  Event_74159_Name = {
    Text = "GeisterTinte"
  },
  Event_7415_ChoiceDesc1 = {
    Text = "[Ursprung erkunden]erhalte goldenes Relikt „(RelicConfig.Arg1)“"
  },
  Event_7415_ChoiceDesc2 = {
    Text = "[Brief abwerfen]Wähle eine von 3 Befehlskarten und erhalte das Orison: „(EnchantConfig.Arg1)“"
  },
  Event_7415_ChoiceDesc3 = {
    Text = "[Überprüfe die Briefe]Erhalte 50 schwarze Siegel"
  },
  Event_7415_Desc = {
    Text = "Ein weiterer Brief fiel vor dir zu Boden, das zerfetzte Briefpapier ließ dein Herz sinken, und du hobst das Papier an. \n “Es ist wieder da, das, was ich vorhergesagt habe, sind keine leeren Worte! @4 Hier beginnt es und hier wird es enden.“ \n “Ich will fliehen... Ich habe mich in den Schrank zurückgezogen, meine Hände zittern unkontrolliert, aber das Geräusch der klebrigen Gliedmaßen, die auf den Boden schlagen, kommt immer näher... Ich hörte einen Namen! Es ist es! @5!“"
  },
  Event_7415_Name = {
    Text = "Noch eine Notrufnachricht"
  },
  Event_74160_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_74160_Desc = {
    Text = "“Danke dir, die Schöpfungskraft des All-Vaters wird unseren Körper neu formen und uns ewiges Licht und Feuer bringen. \n\nWenn ich das Ziel erreiche, werde ich im Angesicht des All-Vaters für dich segnen.“\n\nIhr Phantom verblasste allmählich, und die Klänge der heiligen Musik verwandelten sich in einen gnadenlosen Wind, der vorbeirauschte."
  },
  Event_74160_Name = {
    Text = "Gebet der Orgel"
  },
  Event_74161_ChoiceDesc1 = {
    Text = "[Beerdigen]Arg2 Lebenspunkte wiederherstellen [ExDesc1], 1 Befehlskarte zum Löschen wählen."
  },
  Event_74161_ChoiceDesc2 = {
    Text = "[Pray] Erhalte die Goldene Kreation „(RelicConfig.Arg1),\" aber entwickle „(Skill.Arg2)\"."
  },
  Event_74161_Desc = {
    Text = "Ein weißer Knochen, zur Hälfte in schwarzer Auflösungsschleim getaucht."
  },
  Event_74161_Name = {
    Text = "verblichene Knochen"
  },
  Event_74162_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_74162_Desc = {
    Text = "Du trittst direkt in den Nebel ein, die Schatten umhüllen deinen Körper wie ein Spinnennetz, das kalte Gefühl dringt bis ins Mark. \n Ihr Flüstern verwandelt sich in Bruchstücke von Erinnerungen und durchbohrt deine Brust. \n Als du hindurchgehst, bleibt hinter dir nur Nichtigkeit, während vor dir im dichten Nebel weitere verschwommene Schatten erscheinen, die darauf warten, zu verschlingen."
  },
  Event_74162_Name = {Text = "Zeit Asche"},
  Event_74163_ChoiceDesc1 = {
    Text = "[Gehe um die Illusion herum]Erhalte das goldene Relikt „(RelicConfig.Arg1)“, infiziere „(Skill.Arg2)“"
  },
  Event_74163_ChoiceDesc2 = {
    Text = "[Durch die Illusion]Erhalte eine Auswahl von 3 für 1 goldenes Relikt, infiziere „(Skill.Arg1)“"
  },
  Event_74163_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte Silberrelikt“(RelicConfig.Arg1)“"
  },
  Event_74163_Desc = {
    Text = "Der Dunst ist wie ein schwerer Vorhang, der die Straßen verhüllt, jeder Schritt fühlt sich an, als würdest du auf der Asche der Zeit treten. \n In der Ferne erscheinen zwei verschwommene Schatten im Nebel, als wären sie Geister der Vergangenheit, die flüstern von längst vergessenen Geschichten. \n Die unkontrollierbare Fantasie verwandelt sich erneut in schreckliche Schatten, die sich verzerren und verbreiten, wie Vorzeichen der Zukunft, die dir die Luft zum Atmen rauben. \n Du weißt, dass der Weg vor dir nur dunkler werden kann, doch deine Schritte dürfen nicht und sollten nicht anhalten."
  },
  Event_74163_Name = {Text = "Zeit Asche"},
  Event_74164_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_74164_Desc = {
    Text = "Du bist Sarahs erstem schnellen ANG gerade so entkommen. \n Beim nächsten Mal wirst du vielleicht nicht so viel Glück haben."
  },
  Event_74164_Name = {
    Text = "Albtraum kehrt zurück"
  },
  Event_74165_ChoiceDesc1 = {
    Text = "[Richtung weisen]Erhalte das Silberrelikt „(RelicConfig.Arg1)“, infiziere „(Skill.Arg2)“"
  },
  Event_74165_ChoiceDesc2 = {
    Text = "[Gemeinsam beten]Erhalte 3 aus 1 Gebet"
  },
  Event_74165_Desc = {
    Text = "Die Klänge des Klaviers und der Orgel verweben sich im grauen Wind. Es scheint, als ob eine magische Melodie durch die verlassenen Gassen schwebt. \n Eine namenlose Nonne betet im Klang der Musik. \n “Ein einfaches Gebet bedarf keiner feierlichen Zeremonie, der große All-Vater wird uns Hoffnung säen, so wie er uns einst fromme Lehren gegeben hat.“"
  },
  Event_74165_Name = {
    Text = "Gebet der Orgel"
  },
  Event_74166_ChoiceDesc1 = {
    Text = "[Widerstand leisten]Wähle 1 Relikt aus, das zu einem goldenen Relikt „(RelicConfig.Arg1)“ wird"
  },
  Event_74166_ChoiceDesc2 = {
    Text = "[Heb den Stern auf]Erhalte das Silberrelikt „(RelicConfig.Arg1)“, infiziere „(Skill.Arg2)“"
  },
  Event_74166_ChoiceDesc3 = {
    Text = "[Ignoriere] Erhalte 25 schwarze Siegel"
  },
  Event_74166_Desc = {
    Text = "Der Regen von Meteoriten fällt auf den Glockenturm. \n Ein klarer Kristall fällt direkt vor deine Füße und schlägt ein kleines Loch in den Boden. \n Du bist immer noch tief in der Umklammerung, die unterschiedlich geformten Fusionsschalen erscheinen wie verzerrte Schatten, das Gebrüll und Geschrei ist unaufhörlich. \n Du entscheidest dich —"
  },
  Event_74166_Name = {
    Text = "Gefallener Stern"
  },
  Event_74167_ChoiceDesc1 = {
    Text = "[Augen reiben]Erhalte 50 das schwarze Siegel"
  },
  Event_74167_ChoiceDesc2 = {
    Text = "[Augen schließen]Erhalte 75 das schwarze Siegel, infiziere „(Skill.Arg2)“"
  },
  Event_74167_Desc = {
    Text = "Hinter Yvonne drängten sich abscheuliche schwarze Katzen, murmelten unverständliche Laute und verbreiteten heimliche, feindselige Drohungen."
  },
  Event_74167_Name = {
    Text = "Katzenflüstern"
  },
  Event_74168_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_74168_Desc = {
    Text = "Der Stoff ist billig und fühlt sich etwas rau an, aber er wurde sorgfältig gewaschen und gereinigt. Bewahre ihn gut auf und warte auf den Tag, an dem er zu seinem rechtmäßigen Besitzer zurückkehren kann."
  },
  Event_74168_Name = {
    Text = "weißer Augenschutz"
  },
  Event_74169_ChoiceDesc1 = {
    Text = "[Abstand halten]Erhalte 25 schwarze Siegel"
  },
  Event_74169_ChoiceDesc2 = {
    Text = "[Erbarmen zeigen] Erhalte das Silberrelikt „(RelicConfig.Arg1)“, infiziere „(Skill.Arg2)“"
  },
  Event_74169_Desc = {
    Text = "Sie stürmen von deinen Füßen herauf. \nIn ihren verschwommenen, schmerzverzerrten Gesichtern siehst du deinen zerrenden Schatten. \nBist du wirklich mit dem Privileg ausgestattet, sie zu richten?"
  },
  Event_74169_Name = {
    Text = "Alptraumspiegel"
  },
  Event_7416_ChoiceDesc1 = {
    Text = "[Zerreisse die Fragmente] hat besonderes Relikt, Infektion mit dem Symptom: „(EnchantConfig.Arg1)“ – Symptom: Auflösung des Wahnsinns"
  },
  Event_7416_ChoiceDesc2 = {
    Text = "[Bruchstücke ergänzen]Kein spezielles Artefakt, Infektion“(Skill.Arg1)“, erhalte Infektion“(Skill.Arg2)“"
  },
  Event_7416_Desc = {
    Text = "Die bleichen Glieder winden sich langsam vor dir, sie beugt sich vor und streckt ihren gebrochenen Arm aus. Aus ihren vor Schmerz zusammengekniffenen Augen fließen weiße Tränen aus Gips.\n“Nur noch... nur noch ein Stück, dann kann ich...“"
  },
  Event_7416_Name = {
    Text = "Körper vervollständigen"
  },
  Event_74170_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_74170_Desc = {
    Text = [[
Du musst versuchen, sie zu retten. 
Aber lass dich nicht von ihnen assimilieren.]]
  },
  Event_74170_Name = {
    Text = "Alptraumspiegel"
  },
  Event_74171_ChoiceDesc1 = {
    Text = "[Blick abwenden]Erhöhe Arg1 Punkte maximale Gesundheit"
  },
  Event_74171_ChoiceDesc2 = {
    Text = "[Den Blick halten] 1 zufällige Befehlskarte erhält ein Gebet: „(EnchantConfig.Arg1)\", infiziere 1 „(Skill.Arg2)\""
  },
  Event_74171_Desc = {
    Text = "“Das Ende ist gekommen.“\nDein Herz zieht sich zusammen und verkrampft. \nJuliettes überzeugter Ton enthält ohne Zweifel eine Art Hypnose und telepathische Kraft. \nWas unterscheidet Juliette in dieser Dimension von der Juliette, die du in der Vergangenheit gekannt hast? \nEs gibt zu viele Rätsel, und die Hindernisse sind zahlreich. \nDu hebst den Blick und beobachtest Juliette, doch du stellst fest, dass auch sie dich anstarrt."
  },
  Event_74171_Name = {
    Text = "Blick des Endes"
  },
  Event_74172_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_74172_Desc = {
    Text = "Du hebst die Hand und schlägst unsicher auf die illusionären Tasten. \n Die Tasten erklingen klirrend und scheppernd, jede Note ist wie ein fallender Tau, klar und durchsichtig, und das meisterhafte Spiel stammt nicht von deinen Fingern. \n Plötzlich siehst du ein paar unsichtbare, lange Hände, die sich auf deinen Handrücken legen und mit dem Fortschritt des Spiels auf und ab gleiten. \n Die Zeit scheint stillzustehen, bis der letzte Nachhall der Klänge verklingt. \n Du hörst einen zufriedenen Seufzer."
  },
  Event_74172_Name = {
    Text = "Sonata des Bedauerns"
  },
  Event_74173_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_74173_Desc = {
    Text = "Das häufig wechselnde Bewusstsein ist nicht stabil, du musst sinnlose Störungen ausschließen. \nDu richtest deine Aufmerksamkeit auf Jenkins vor dir, und das Geräusch des Grammophons verblasst allmählich und verliert sich im Nebel."
  },
  Event_74173_Name = {
    Text = "Fremde Geräusche vom Glockenturm"
  },
  Event_74174_ChoiceDesc1 = {
    Text = "[Die Quelle des Geräusches suchen]erhalte das silberne Relikt „(RelicConfig.Arg1)“, infiziere „(Skill.Arg2)“"
  },
  Event_74174_ChoiceDesc2 = {
    Text = "[Erinnerung]Alle Erwachten regenerieren 50 Wahnsinn, infizieren“(Skill.Arg1)“"
  },
  Event_74174_ChoiceDesc3 = {
    Text = "[Ignoriere das Geräusch]Erhalte 3 aus 1 Gebet"
  },
  Event_74174_Desc = {
    Text = "Du hörst das verzerrte Geräusch der Grammophonadel. \n Die verbogene Nadel fährt über die beschädigten Spiralspuren und erzeugt ein unheimliches Vibrieren, weder eilig noch zögernd."
  },
  Event_74174_Name = {
    Text = "Fremde Geräusche vom Glockenturm"
  },
  Event_74175_ChoiceDesc1 = {
    Text = "[Für ihn spielen] Wähle 1 von 3 Befehlskarten aus, um ein Gebet zu erhalten: „(EnchantConfig.Arg1)\", infiziere „(Skill.Arg2)\""
  },
  Event_74175_ChoiceDesc2 = {
    Text = "[Klängen lauschen]Für jeden Erwecker mit einem Wahnsinnswert von 50 oder mehr erhältst du 15 schwarze Siegel"
  },
  Event_74175_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte eine Auswahl von 3 für 1 Gebet"
  },
  Event_74175_Desc = {
    Text = "“Lieber John:\n    Kürzlich ist mir plötzlich aufgefallen, dass es schon mehrere Jahre her ist, seit du das letzte Mal für uns Klavier gespielt hast.\n    Ich bin jetzt 81 Jahre alt, und je älter ich werde, desto mehr wird mir der Wert der Erinnerungen aus meiner Jugend bewusst.\n    Wenn du diesen Brief erhältst, halte bitte das nächste Mal, wenn du durch Lentiniën kommst, vor meiner Wohnung an und spiele ein Stück für mich.“"
  },
  Event_74175_Name = {
    Text = "Sonata des Bedauerns"
  },
  Event_74176_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_74176_Desc = {
    Text = "Der Überlebenswille tobt in deiner Brust, und du zögerst nicht, den Befehl zu erteilen. \n Während du dich durchkämpfst und dich umdrehst, ist der Stern bereits im A-Schleim versunken. \n Inmitten des strömenden A-Schleims ertönt eine Reihe von scharfen, rhythmischen Geräuschen. \n Du berührst die Oberfläche des A-Schleims, und ein verrotteter Stern fällt in deine Handfläche."
  },
  Event_74176_Name = {
    Text = "Gefallener Stern"
  },
  Event_74177_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_74177_Desc = {
    Text = "Du hebst den Stern auf, doch in deiner Hand verliert er sein Licht. \n Ein Gefühl von Druck überkommt dich, und eine eisige Kälte lässt deinen Rücken frösteln. \n In einem Augenblick von Leben und Tod weichst du zur Seite aus und entgehst einem heftigen ANG, doch auf deinem Arm bleibt eine zwei Zoll lange Wunde zurück."
  },
  Event_74177_Name = {
    Text = "Gefallener Stern"
  },
  Event_74178_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_74178_Name = {
    Text = "Albtraum kehrt zurück"
  },
  Event_74179_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_74179_Desc = {
    Text = "Du schaust dich um und wanderst hin und her, der Klang ist wie eine Maus, die mit dir Verstecken spielt, mal links, mal rechts, mal weit weg, mal nah. \n Du drehst dich im Kreis, aber der Lärm wird immer lauter, das metallische Kratzen versetzt dich in eine tiefere Unruhe. \n Plötzlich hast du eine Idee und tastest in deiner Tasche, obwohl du die Quelle des Geräuschs nicht findest, entdeckst du einen kleinen Schatz."
  },
  Event_74179_Name = {
    Text = "Fremde Geräusche vom Glockenturm"
  },
  Event_7417_ChoiceDesc1 = {
    Text = "[Verlassen]Du verlierst (Arg1) Leben, Infektion“(Skill.Arg2)“"
  },
  Event_7417_Desc = {
    Text = "“Braves Kind. Aber eine kleine Strafe muss sein.“\nDaphdales Lachen verschwindet im Dimensionsriss"
  },
  Event_7417_Name = {
    Text = "Hinweiszeit"
  },
  Event_74180_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_74180_Desc = {
    Text = "Du wendest deinen Blick ab, um nicht mit ihr zu kollidieren. \nDoch eine unsichtbare Kraft lässt dein Herz unruhig pochen."
  },
  Event_74180_Name = {
    Text = "Blick des Endes"
  },
  Event_74181_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_74181_Desc = {
    Text = "Juliette sieht dir in die Augen. \n Im nächsten Moment zeigt sie ein völlig wahnsinniges Lächeln, als würde sie dein Übermut und deine Unwissenheit verspotten. \n Doch das Lächeln verfliegt im Nu, und auch die anderen zeigen keine Reaktion darauf... es scheint nur eine Illusion zu sein."
  },
  Event_74181_Name = {
    Text = "Blick des Endes"
  },
  Event_7418_ChoiceDesc1 = {
    Text = "[Aufgabenrelikt 1, Erhalte ein goldenes Relikt „(RelicConfig.Arg1)“]"
  },
  Event_7418_ChoiceDesc2 = {
    Text = "[Aufgabenrelikt 2, Erhalte ein goldenes Relikt „(RelicConfig.Arg1)“]"
  },
  Event_7418_ChoiceDesc3 = {
    Text = "[Zufällig 1 Befehlskarte erhält das Gebet:“(EnchantConfig.Arg1)“]"
  },
  Event_7418_Desc = {
    Text = "Ereignis 254 (in Entwicklung), nicht das Endergebnis"
  },
  Event_7418_Name = {
    Text = "Ereignis 254 (in Entwicklung)"
  },
  Event_7419_ChoiceDesc1 = {
    Text = "[Spezialgebet einreichen 1, zufällig 1 Befehlskarte erhält Gebet: „(EnchantConfig.Arg1)“"
  },
  Event_7419_ChoiceDesc2 = {
    Text = "[Spezialgebet einreichen 2, zufällig 1 Befehlskarte erhält Gebet: „(EnchantConfig.Arg1)“"
  },
  Event_7419_ChoiceDesc3 = {
    Text = "[Infiziere“(Skill.Arg1)“und“(Skill.Arg2)“、erhalte das goldene Relikt“(RelicConfig.Arg3)“]"
  },
  Event_7419_Desc = {
    Text = "Ereignis 255 (in Entwicklung), nicht das Endergebnis"
  },
  Event_7419_Name = {
    Text = "Ereignis 255 (in Entwicklung)"
  },
  Event_7420_ChoiceDesc1 = {
    Text = "[Schmetterlingskarte meiden]Lösche 2 Karten"
  },
  Event_7420_ChoiceDesc2 = {
    Text = "[Umarme den Schmetterling] erhält verfluchtes Relikt „(RelicConfig.Arg1)“, Infektion „(Skill.Arg2)“"
  },
  Event_7420_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte Arg1 schwarze Siegel"
  },
  Event_7420_Desc = {
    Text = "Eine Ecke, noch eine Ecke, der Weg, den du verfolgst, scheint endlos zu sein, während du dem Höllenhund nachjagst. \n Die schmerzenden Knöchel, das angeschwollene Gehirn, in der Verwirrung siehst du erneut den Schmetterling. Du weißt, dass es der Wahnwitz der Illusion und das Gemurmel des Geheimgangs ist. Sie strömen von allen Seiten heran."
  },
  Event_7420_Name = {Text = "Wahnwelle"},
  Event_7421_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7421_Desc = {
    Text = "Du hältst die Windglocke sanft fest. Das Klingeln verstummt nach ein paar Tönen. Sie ist nun zurückgezogen—nur in Albträumen wird sie wiederkehren"
  },
  Event_7421_Name = {Text = "Windglocke"},
  Event_7422_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7422_Desc = {
    Text = "Das Glockenläuten verstummt nach ein paar Schlägen. Es ist zurückgetreten – es wird nur in Albträumen wiederkehren"
  },
  Event_7422_Name = {Text = "Windglocke"},
  Event_7423_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7423_Desc = {
    Text = "“Nicht schlecht, du bist vorsichtig.“\nEine ferne Stimme kam aus dem Windspiel.\n“Vorsicht bringt dir eine kleine Belohnung, aber das war's auch schon.“"
  },
  Event_7423_Name = {Text = "Windglocke"},
  Event_74245_ChoiceDesc1 = {
    Text = "[Verlassen]Erhalte Silberrelikt“(RelicConfig.Arg1)“"
  },
  Event_74245_Desc = {
    Text = "Klack, klack, die Würfel tanzen aufgeregt im Würfelbecher, bis sie erschöpft sind.  \n\n“Du hast verloren. Aber als Belohnung dafür, dass du mit mir gespielt hast, kannst du dennoch eine Belohnung erhalten.“"
  },
  Event_74245_Name = {
    Text = "N's Botschaft"
  },
  Event_74246_ChoiceDesc1 = {
    Text = "[Tor schließen]Infiziere „(Skill.Arg1)“, zufällig 1 Befehlskarte erhält ein Gebet: „(EnchantConfig.Arg2)“"
  },
  Event_74246_ChoiceDesc2 = {
    Text = "[Flucht]Infektion „(Skill.Arg1)“, zufällig erhält 1 Befehlskarte das Gebet: „(EnchantConfig.Arg2)“"
  },
  Event_74246_ChoiceDesc3 = {
    Text = "[Ignoriere]wähle 1 von 3 Befehlskarten und erhalte ein Gebet:“(EnchantConfig.Arg1)“"
  },
  Event_74246_Desc = {
    Text = "Du bist in diesem Labyrinth aus Dampf und Zahnrädern gefangen, während die Messingrohre über dir zu einem Spinnennetz verwoben sind. Bei jedem Atemzug wirbelt der zähflüssige Maschinenölnebel auf. \n Das außer Kontrolle geratene Ziffernblatt der Maschine zuckt an der Wand, die Zeiger durchschneiden die Skala und sprühen Funken wie sterbende Glühwürmchen in einem viktorianischen Labor. Die Nietenfugen sickern mit Rost, wie die verwundete Stelle dieses stählernen Ungeheuers, während deine Taschenuhr längst stehen geblieben ist – die Zeit hier ist nur das Orison der ineinandergreifenden Zahnräder."
  },
  Event_74246_Name = {
    Text = "Dampfgeisterstadt"
  },
  Event_74247_ChoiceDesc1 = {
    Text = "[Wagen]Infiziere “(Skill.Arg1)“，betrete das Glücksspiel"
  },
  Event_74247_ChoiceDesc2 = {
    Text = "[Lass es bleiben]Erhalte 25 das schwarze Siegel"
  },
  Event_74247_Desc = {
    Text = "In der tiefen schwarzen Nebel an der Straßenecke breitet sich ein erstickender Atem aus.\nIm Nebel erscheinen zwei alte und kalte Würfel, deren Oberfläche mit unlesbaren Symbolen und seltsamen Mustern bedeckt ist.\nSie liegen still auf der glitschigen Steinplatte, als würden sie auf einen unbekannten Beschwörung warten.\n“Du weißt, wer ich bin. Willst du wetten?“"
  },
  Event_74247_Name = {
    Text = "N's Botschaft"
  },
  Event_74248_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_74248_Desc = {
    Text = "\"Ich träumte von einer alles verschlingenden Katastrophe, die das Licht der Vergangenheit auslösch"
  },
  Event_74248_Name = {
    Text = "Letzte Worte"
  },
  Event_74249_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_74249_Desc = {
    Text = "Schwarzer Rauch zitterte enttäuscht.  \nDann verschwanden die Würfel mit einem Augenblinzeln.  \n\nDie einzige Frage, die in deinem Kopf blieb:  \nWoraus bestanden diese Würfel eigentlich?"
  },
  Event_74249_Name = {
    Text = "N's Botschaft"
  },
  Event_7424_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7424_Desc = {
    Text = "Du drehst dich um und siehst ein Paar Schuhe sowie einen verschwommenen menschlichen Schatten. \n Es scheint sich um einen jungen Gentleman zu handeln. \n “Ich will nicht stören, haben Sie vielleicht ein schwarzes Paar Oxford-Schuhe gesehen?“ \n “Hier steht ein Paar vor Ihnen.“ \n “Nein, nein... das sind Ziegenleder, nicht Rindsleder. \n Ich bin seit zwölf Jahren in diesem Wachsfigurenkabinett gefangen, es muss an den falschen Schuhen liegen...“ \n Die Stimme murmelt und wird allmählich schwächer."
  },
  Event_7424_Name = {Text = "Schritte"},
  Event_74250_ChoiceDesc1 = {
    Text = "[Ermittle die Stimme des Mannes]Ziehe zufällig 3 Befehlskarten aus dem Deck und wähle 1 Karte zur Kopie"
  },
  Event_74250_ChoiceDesc2 = {
    Text = "[Die Stimme der Frau unterscheiden] Wähle 1 von 3 Befehlskarten aus, um ein Gebet zu erhalten: „(EnchantConfig.Arg1)\", infiziere „(Skill.Arg2)\""
  },
  Event_74250_ChoiceDesc3 = {
    Text = "[Erkenne die Stimme des Älteren]Erhalte 25 das schwarze Siegel"
  },
  Event_74250_Desc = {
    Text = "Du stehst allein in einem dunklen Sumpf. \n In der Dämmerung hörst du das chaotische Gemurmel, das wie eine Flutwelle kommt, einige Stimmen stammen von alten Männern im hohen Alter, andere von kleinen Kindern, die gerade zu sprechen beginnen, einige von ängstlichen Frauen, und andere von Männern, die aus unerklärlicher Angst sprechen..."
  },
  Event_74250_Name = {
    Text = "Letzte Worte"
  },
  Event_74251_ChoiceDesc1 = {
    Text = "[Vorwärts]Erhalte zufällig 3 Befehlskarten aus dem Deck, wähle 1 Karte zum Löschen und erhalte 75 schwarze Siegel"
  },
  Event_74251_ChoiceDesc2 = {
    Text = "[Ausruhen]Erhalte zufällig 3 Befehlskarten aus dem Deck, wähle eine Karte aus, erstelle eine exakte Kopie und füge sie ins Deck ein, erhalte 25 schwarze Siegel"
  },
  Event_74251_ChoiceDesc3 = {
    Text = "[Zurückschauen]Erhalte 50 schwarze Siegel"
  },
  Event_74251_Desc = {
    Text = "Du wanderst durch die leeren Straßen, deine Schritte hinterlassen tiefe Eindrücke in der Asche. \n\nDie Straßen der Stadt gleichen einem Spinnennetz, du bist die gefangene Motte."
  },
  Event_74251_Name = {Text = "Nebelstadt"},
  Event_74252_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_74252_Desc = {
    Text = "Im Moment, als das Dampfventil krachend geschlossen wurde, hörtest du, wie dein Schatten von präzise ineinander greifenden Gewinden Zentimeter für Zentimeter zerquetscht wurde."
  },
  Event_74252_Name = {
    Text = "Dampfgeisterstadt"
  },
  Event_74253_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_74253_Desc = {
    Text = "Das gleiche Bild wiederholt sich immer wieder vor deinen Augen – du hast kein Entkommen."
  },
  Event_74253_Name = {
    Text = "Dampfgeisterstadt"
  },
  Event_74254_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_74254_Desc = {
    Text = "Die Zeit ist eine nutzlose Koordinate. Die einzige Wahrheit, auf die du wartest."
  },
  Event_74254_Name = {
    Text = "Dampfgeisterstadt"
  },
  Event_74255_ChoiceDesc1 = {
    Text = "[Drei Punkte]"
  },
  Event_74255_ChoiceDesc2 = {
    Text = "[Sechs Uhr]"
  },
  Event_74255_ChoiceDesc3 = {
    Text = "[Ein Punkt]"
  },
  Event_74255_Desc = {
    Text = "Wer würde schon den Würfel werfen, der Unglück und Wahnsinn bringt? \nDu, natürlich du. \nDu triffst deine Entscheidung—"
  },
  Event_74255_Name = {
    Text = "N's Botschaft"
  },
  Event_74256_ChoiceDesc1 = {
    Text = "[Verlassen]Erhalte 50 schwarze Siegel"
  },
  Event_74256_Desc = {
    Text = "Klack, klack, die Würfel tanzen aufgeregt im Würfelbecher, bis sie erschöpft sind.  \n\n“Du hast verloren. Aber als Belohnung dafür, dass du mit mir gespielt hast, kannst du dennoch eine Belohnung erhalten.“"
  },
  Event_74256_Name = {
    Text = "N's Botschaft"
  },
  Event_74257_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_74257_Desc = {
    Text = "Der Weg, den du zurückgelegt hast, führt durch endlose Dunkelheit und grenzenloses Chaos. \nDu hast keine Zeit mehr, über dein Schicksal zu reflektieren. Bevor das Urteil hereinbricht, musst du die Angst beiseiteschneiden und dein Ziel erreichen."
  },
  Event_74257_Name = {Text = "Nebelstadt"},
  Event_74258_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_74258_Desc = {
    Text = "“Als ich im Schatten der Jahre saß, spürte ich die kalte Hand des Todes, die sich allmählich näherte. Die Welt draußen wurde immer dunkler, erfüllt von den Flüstern der Katastrophe. Ich fürchtete das bevorstehende Urteil, die Abrechnung für unsere Dummheit. Die Straßen waren von einem unheilvollen Duft durchzogen, ich befürchtete, dass unser Gerichtstag naht. Unsere Zivilisation ist wacklig, als ob sie von der Zerstörung verschlungen werden sollte, gefangen in unserer eigenen törichten Arroganz.“"
  },
  Event_74258_Name = {
    Text = "Letzte Worte"
  },
  Event_74259_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_74259_Desc = {
    Text = "Aus dem Tod zu entkommen war schon schwer genug, du solltest nicht mehr erwarten. \nDie Schatten der zerstörten Säulen und Ruinen rufen dich immer noch."
  },
  Event_74259_Name = {Text = "Nebelstadt"},
  Event_7425_ChoiceDesc1 = {
    Text = "[Verlassen]Erhalte eine Auswahl von 3 für 1 Gebet"
  },
  Event_7425_Desc = {
    Text = "“So ist es...sehr interessant.“\nSie nimmt den Fragebogen zurück und zeigt in die Richtung, in die die Kinder gegangen sind. Du gehst eilig weg und hörst kaum das Flüstern hinter dir.\n“Ich freue mich auf unser nächstes Treffen.“"
  },
  Event_7425_Name = {
    Text = "Psychologische Bewertung"
  },
  Event_74260_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_74260_Desc = {
    Text = "Du befindest dich unter der Kontrolle einer gewaltigen Kraft oder eines mächtigen Schicksals. Eine kurze Pause kann diese Situation nicht ändern, aber zumindest deinen schmerzenden Beinen neuen Schwung nach vorne geben."
  },
  Event_74260_Name = {Text = "Nebelstadt"},
  Event_74261_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_74261_Desc = {
    Text = "“Die Stadt ist nicht länger ein warmer Zufluchtsort, sondern ein verstecktes Grab, das Horror und Verzweiflung gebiert. Die einst lebendigen Träume sind nun nur noch Fragmente der Angst. Ich kann nicht mehr so tun, als ob ich keine Angst hätte; die Welt vor mir ist wie ein Albtraum, aus dem ich nicht aufwachen kann.“"
  },
  Event_74261_Name = {
    Text = "Letzte Worte"
  },
  Event_74262_ChoiceDesc1 = {
    Text = "[Verlassen]Erhalte goldenes Relikt“(RelicConfig.Arg1)“"
  },
  Event_74262_Desc = {
    Text = "Klack, klack, die Würfel tanzen aufgeregt im Würfelbecher, bis sie erschöpft sind.  \n\n“Du hast verloren. Aber als Belohnung dafür, dass du mit mir gespielt hast, kannst du dennoch eine Belohnung erhalten.“"
  },
  Event_74262_Name = {
    Text = "N's Botschaft"
  },
  Event_7426_ChoiceDesc1 = {
    Text = "[Verlassen]Erhalte zufällig 1 Befehlskarten, erhalte Gebet: Spiegelbild"
  },
  Event_7426_Desc = {
    Text = "“Keine Sorge, ich habe die Antwort bereits in deinen Augen gesehen. Ich habe noch einige Dinge zu erledigen und werde vorerst gehen. Du hast auch etwas zu erledigen, oder? Sieh mal dort, jemand kommt, um dich zu suchen.“\nDu drehst dich um, die Gestalt des Laternenordens erscheint am Ende des Weges."
  },
  Event_7426_Name = {
    Text = "Seltsamer Begleiter V"
  },
  Event_7427_ChoiceDesc1 = {
    Text = "[Verlassen]Erhalte zufällig 1 Befehlskarten, erhalte Gebet: Überlegung"
  },
  Event_7427_Desc = {
    Text = "“Es scheint, dass du mir noch nicht dein Herz öffnen möchtest. Ich bin enttäuscht, aber das ist in Ordnung, ich werde dir dennoch den freundlichsten Hinweis geben: Was möchte der Laternenorden hier eigentlich suchen?“\n“Oh, es scheint, als ob jemand nicht möchte, dass wir uns unterhalten. Sieh mal dort, jemand kommt, um dich zu suchen.“\nDu drehst dich um, die Gestalt der Laternenträger erscheint am Ende des Weges."
  },
  Event_7427_Name = {
    Text = "Seltsamer Begleiter V"
  },
  Event_7428_ChoiceDesc1 = {
    Text = "[Verlassen]Erhalte zufällig 1 Befehlskarten, erhalte Gebet: Inspiration"
  },
  Event_7428_Desc = {
    Text = "“Du bist sehr ehrlich und das ist lobenswert. Daher habe ich beschlossen, dir einen kleinen Hinweis zu geben: Warum wurde dir gleich zu Beginn deiner Ankunft im Lai-Dorf von ihr Aufmerksamkeit geschenkt?“\n“Oh, es scheint, als ob jemand nicht möchte, dass wir uns unterhalten. Sieh mal dort, jemand kommt, um dich zu suchen.“\nDu drehst dich um, die Gestalt der Laternenträger erscheint am Ende des Weges."
  },
  Event_7428_Name = {
    Text = "Seltsamer Begleiter V"
  },
  Event_7429_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7429_Desc = {
    Text = "Das chaotische Geräusch ließ nach, deine Hände sind leer, aber das flüchtige Gefühl ist im Silbernen Schlüssel festgehalten"
  },
  Event_7429_Name = {
    Text = "Buch der Leere"
  },
  Event_7430_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7430_Desc = {
    Text = "Inmitten des Chaos greifst du um dich und spürst ein seltsames Objekt in deiner Hand, das sich allmählich formt"
  },
  Event_7430_Name = {
    Text = "Buch der Leere"
  },
  Event_7431_ChoiceDesc1 = {
    Text = "[Gehen] Wähle 1 von 3 Befehlskarten aus, um ein Gebet zu erhalten: „(EnchantConfig.Arg1)\", infiziere „(Skill.Arg2)\""
  },
  Event_7431_Desc = {
    Text = "“Hast du schon von der Jagdmethode der Schlangen gehört? Schlangen können nur am Boden kriechen und sich winden, weshalb sie nicht wie Geparden mit Kraft verfolgen können, noch wie Wolfsschwärme ihre Beute umzingeln können. Im Gegensatz dazu hat die Schlange gelernt, still zu warten.“\n“Sie warten auf den Moment, in dem ihre Beute die Wachsamkeit verliert, und starten dann den Hinterhalt, um sie mit einem Schlag zu verschlingen.“"
  },
  Event_7431_Name = {
    Text = "Seltsamer Begleiter III"
  },
  Event_7432_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7432_Desc = {
    Text = "Es scheint, als wäre die schwarze Katze gestört worden. Ihr glänzendes Fell hinterließ nur einen brennenden Schmerz an deinen Fingerspitzen, bevor sie im Nebel verschwand"
  },
  Event_7432_Name = {
    Text = "Nachtkatzenfluch"
  },
  Event_7433_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7433_Desc = {
    Text = "Nur die absurden Träume dieser dummen, wahnsinnigen Gläubigen"
  },
  Event_7433_Name = {
    Text = "Geheimer Befehl · Unten"
  },
  Event_7434_ChoiceDesc1 = {
    Text = "[Weiter lauschen]Erhalte 3 wähle 1 Gebet"
  },
  Event_7434_ChoiceDesc2 = {
    Text = "[Laut husten]wähle eine von 3 Befehlskarten und erhalte das Gotteszeichen: „(EnchantConfig.Arg1)“, Infektion „(Skill.Arg2)“"
  },
  Event_7434_Desc = {
    Text = "In der Ecke sind viele feine Risse aufgetreten, die sich wie Blutgefäße schlängeln. \n Begleitet von einem leisen Summen hörst du die tiefe Stimme eines Mannes von der gegenüberliegenden Seite. \n “Quinton Bezirk 5, Wellington Bezirk 10, Norman Bezirk 15... \n Das Material dieses Monats ist vollständig verladen und bereit für den Versand, Artikelnummer I-0234... \n ... \n Außerdem, dank dieser Misaq-Bande, ist der White Chapel District derzeit unter Belagerung, wir haben die größte Materialquelle verloren.“"
  },
  Event_7434_Name = {
    Text = "Wände haben Ohren"
  },
  Event_7435_ChoiceDesc1 = {
    Text = "[vertreibe die Krähen]Erhalte 20 schwarze Siegel, Infektion“(Skill.Arg2)“"
  },
  Event_7435_ChoiceDesc2 = {
    Text = "[Weiter dem Kind nachjagen]Verlassen"
  },
  Event_7435_Desc = {
    Text = "Unter deinem Schreck flogen alle Krähen in alle Richtungen auf, ihre fallenden dunklen Flügel verwandelten sich in Schleim und tropften in die Form des schwarzen Siegels"
  },
  Event_7435_Name = {
    Text = "Schwarze Krähe Blick"
  },
  Event_7436_ChoiceDesc1 = {
    Text = "[Gib den Widerstand auf]entferne 1 Befehlskarte, erhalte Arg1 das schwarze Siegel"
  },
  Event_7436_ChoiceDesc2 = {
    Text = "[Hände zurückziehen]"
  },
  Event_7436_Desc = {
    Text = "Eine neue Schreibmaschine.\nSie hat eine einzigartige Tastatur, prächtig und fein wie ein Mikroskop.\nNeugierig legst du deine Hände darauf, aber sie fliegen unkontrolliert über die Tasten, immer schneller und schneller"
  },
  Event_7436_Name = {
    Text = "Inspirationsschub"
  },
  Event_7437_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7437_Desc = {
    Text = "Aber es sind nur Lebewesen, die ums Überleben kämpfen und ein Stück Treibholz suchen, um sich auszuruhen...\nDu seufzt und lässt den schwarzen Saft vom Schmetterlingsschwanz über deine Wange fließen"
  },
  Event_7437_Name = {
    Text = "Schwarze Flüssigkeitsfalter"
  },
  Event_7438_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7438_Desc = {
    Text = "Du nimmst den Kontakt der Schule an, die vertraute Stimme beruhigt dich. Du sammelst dich und gehst weiter"
  },
  Event_7438_Name = {
    Text = "Kontaktstelle"
  },
  Event_7439_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7439_Desc = {
    Text = "Du nimmst den Kontakt der Schule an, die vertraute Stimme beruhigt dich. Du sammelst dich und gehst weiter"
  },
  Event_7439_Name = {
    Text = "Kontaktstelle"
  },
  Event_7440_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7440_Desc = {
    Text = "Deine Zweifel verhallen in der Luft, niemand antwortet, warmes gelbes Licht strömt durch das Fenster, warm wie eine Erinnerung"
  },
  Event_7440_Name = {
    Text = "Vulkanische Erinnerung"
  },
  Event_7441_ChoiceDesc1 = {
    Text = "[Heb auf] Infektion „(Skill.Arg1)“, erhält Silberrelikt „(RelicConfig.Arg2)“"
  },
  Event_7441_ChoiceDesc2 = {
    Text = "[Zögern]Erhalte 25 das schwarze Siegel"
  },
  Event_7441_Desc = {
    Text = "Ein seltsam gefärbter Gegenstand schwimmt in einem Fass in der Gassenecke. Seine Anwesenheit scheint zu warnen: „Nicht berühren“"
  },
  Event_7441_Name = {
    Text = "Fass mit schwimmenden Gegenständen"
  },
  Event_7442_ChoiceDesc1 = {
    Text = "[Übergib es ihr]Erhalte 3 aus 1 Silberrelikt"
  },
  Event_7442_ChoiceDesc2 = {
    Text = "[Eine Situation]Erhalte ein silbernes Relikt „(RelicConfig.Arg1)“ „(RelicConfig.Arg2)“, infiziere zweimal „(Skill.Arg3)“"
  },
  Event_7442_Desc = {
    Text = "“Hier ist die Mitteilung von Mythag, ich bin Erica. Abnormale gnostische Indexschwankungen des Erweckens Lotan wurden festgestellt, benötigst du Unterstützung?“"
  },
  Event_7442_Name = {
    Text = "Unterstützungskommunikation"
  },
  Event_7443_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7443_Desc = {
    Text = "Du hast den bösartigen Flüstern in deinem Ohr nachgegeben. Ein schriller Schmerz, scharf wie eine Nadel, bohrt sich tief in deinen Schädel.\n\n„Hör auf – bitte hör auf – ich habe getan, was du verlangt hast – lass es aufhören –“\n\nDu umklammerst deinen Kopf in Qual und hörst nur das ferne, höhnische Lachen der Krähen."
  },
  Event_7443_Name = {
    Text = "Lied der Raben"
  },
  Event_7444_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7444_Desc = {
    Text = "An dieser Position platziert zu sein, bedeutet entweder, dass man übersehen oder geschätzt wird. Wenn Letzteres der Fall ist, sollte es dem ursprünglichen Besitzer überlassen werden"
  },
  Event_7444_Name = {
    Text = "Einsamer Silberkern"
  },
  Event_7445_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7445_Desc = {
    Text = "Das Glücklichste ist die Unwissenheit."
  },
  Event_7445_Name = {Text = "spähen"},
  Event_7446_ChoiceDesc1 = {
    Text = "[Normales Monster erzeugen]"
  },
  Event_7446_ChoiceDesc2 = {
    Text = "[Leeres Feld erzeugen]"
  },
  Event_7446_ChoiceDesc3 = {
    Text = "[Leere erzeugen]"
  },
  Event_7446_Desc = {
    Text = "Schau mal, was generiert werden kann"
  },
  Event_7446_Name = {
    Text = "[Ziel 1 Verpackungstext ausstehend]"
  },
  Event_7447_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7447_Desc = {
    Text = "“Beruhige dich,“ Ramona klopft dir auf den Kopf, „nur Fragmente der Vergangenheit. Ich weiß nicht, wer sie in diesem Dimensionstunnel zurückgelassen hat.“\nTatsächlich, es riecht nach Nostalgie"
  },
  Event_7447_Name = {
    Text = "Erinnerungsfragment: Whisky"
  },
  Event_7448_ChoiceDesc1 = {
    Text = "[Sammle es ein]upgrade 1 Silberrelikt zu einem goldenen Relikt“(RelicConfig.Arg1)“"
  },
  Event_7448_ChoiceDesc2 = {
    Text = "[Wirf sie weg] erhält goldenes Relikt „(RelicConfig.Arg1)“, Infektion „(Skill.Arg2)“ und „(Skill.Arg3)“"
  },
  Event_7448_ChoiceDesc3 = {
    Text = "[Genau beobachten]Erhalte 25 das schwarze Siegel"
  },
  Event_7448_Desc = {
    Text = "Hier gibt es viele zerbrochene Silberkerne.\nDüster, zerbrochen... offensichtlich keine hochwertige Ware.\nVielleicht sind sie einer der Gründe, warum diese Wachsfiguren „lebendig“ werden können.\nSelbst die rauesten Silberkerne haben das Potenzial, Wunder zu schaffen"
  },
  Event_7448_Name = {
    Text = "Gebundene Seele"
  },
  Event_7449_ChoiceDesc1 = {
    Text = "[Verlassen]Erhalte 50 schwarze Siegel"
  },
  Event_7449_Desc = {
    Text = [[
Kum hat alles gegeben, was sie konnte.
Jetzt liegt es an dir, ihren Opfer nicht umsonst sein zu lassen]]
  },
  Event_7449_Name = {Text = "Restwärme"},
  Event_7450_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7450_Desc = {
    Text = "Möge der Schneesturm euch ewige Ruhe schenken"
  },
  Event_7450_Name = {
    Text = "Vorherige Hinterlassenschaften"
  },
  Event_7451_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7451_Desc = {
    Text = "Du wirkst immer noch stark, selbst im Gesang bleibst du dir treu.\nDu glaubst nicht an das Flüstern in deinen Ohren, vertraust nur auf menschliche Vernunft.\nAber... wenn der feste Boden, auf dem du stehst, von schwarzem Schleim bedeckt ist, wird das Ausgraben deiner Augen dein letzter Ausweg sein"
  },
  Event_7451_Name = {
    Text = "Lied der Raben"
  },
  Event_7452_ChoiceDesc1 = {
    Text = "[Verlassen]Wähle eine von 3 Befehlskarten und erhalte ein Gebet:“(EnchantConfig.Arg1)“"
  },
  Event_7452_Desc = {
    Text = "Du rissest Kum plötzlich weg, gerade noch rechtzeitig, um einem Schlag zu entgehen. Sie nickte dir dankbar zu und stürzte sich erneut auf den Versuchskörper"
  },
  Event_7452_Name = {Text = "Arena"},
  Event_7453_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7453_Desc = {
    Text = "Klingeling...\nDie Münze fiel in das Portemonnaie und erzeugte ein klares, angenehmes Echo.\nDas Portemonnaie kaute zufrieden und gab schließlich ein sattes Rülpser von sich.\nEs ist von deiner Großzügigkeit beeindruckt und lässt all seine Abwehr fallen.\nJetzt wird es dir dienen."
  },
  Event_7453_Name = {
    Text = "gierige Börse"
  },
  Event_7454_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7454_Desc = {
    Text = "Die Kupfermünze fiel in den bodenlosen Abgrund, ohne ein Geräusch zu machen.\nDu wartetest geduldig fünf Minuten. Die Geldbörse stöhnte schmerzlich und spuckte schließlich eine schwarze, klebrige Flüssigkeit aus.\nDas war ihr stummer Protest"
  },
  Event_7454_Name = {
    Text = "gierige Börse"
  },
  Event_7455_ChoiceDesc1 = {
    Text = "[In die Ferne schauen]"
  },
  Event_7455_ChoiceDesc2 = {
    Text = "[Höre genau zu]"
  },
  Event_7455_Desc = {
    Text = "Celeste schwenkte den Kompass in der Hand, sie sprach nicht, aber leise erklang ein Lied.\nDas Lied der Matrosen überquerte die Zeit und vermischte sich hier, ein chaotisches, aber kraftvolles Schiffs­lied wies dir den Weg und ließ dich zur anderen Seite des Schiffes blicken"
  },
  Event_7455_Name = {
    Text = "Schiffslied"
  },
  Event_7456_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7456_Desc = {
    Text = "Du trittst vor und unterbrichst diese kleine Unterrichtsübung. \n Von den Handbewegungen beim Spielen bis hin zur grundlegenden Musiktheorie, du kommentierst alles gnadenlos. \n Die Musik verstummt plötzlich, der Junge und der Lehrer schauen dich gleichzeitig an, mit dem gleichen täuschenden Lächeln im Gesicht. \n 133, 355, 244... \n Die Klänge ertönen erneut, immer noch völlig falsch. \n Es stellt sich heraus, dass sie nichts hören können."
  },
  Event_7456_Name = {
    Text = "Piano-Unterricht"
  },
  Event_7457_ChoiceDesc1 = {
    Text = "[Einstecken]"
  },
  Event_7457_Desc = {
    Text = "Die schwarzen Spuren, die im Bereich gefunden werden, können angeboten werden, um die D-Marke zu opfern und um Projektionen stattfinden zu lassen. Sie verschwinden schnell zu schwarzem Schlamm, wenn du das aktuelle Gebiet verlässt"
  },
  Event_7457_Name = {
    Text = "Schwarzes Mal"
  },
  Event_7458_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7458_Desc = {
    Text = "Es ist wichtiger, diesen mysteriösen Mann zu finden. Dachte Ramona und ging schnell weg"
  },
  Event_7458_Name = {
    Text = "Fremde Ohren"
  },
  Event_7459_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7459_Desc = {
    Text = "Lass dich treiben, folge dem Gebet und tauche in die Tiefen.\nDu siehst das goldene Königreich unter Wasser, die unsterblichen Statuen und blickst in die leuchtenden Augen der Dunkelheit...\n“Diejenigen ohne göttliches Blut... verlasst diesen Ort.“"
  },
  Event_7459_Name = {Text = "Traumgebet"},
  Event_7460_ChoiceDesc1 = {
    Text = "[Verlassen]Wähle ein verfluchtes Relikt, infiziere“(Skill.Arg1)“"
  },
  Event_7460_Desc = {
    Text = "Ramona durchbohrt die Kehle des Experiments mit ihrem Schwert, Kum wirft den leblosen Körper weg und stürmt auf das nächste Ziel zu"
  },
  Event_7460_Name = {Text = "Arena"},
  Event_7461_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7461_Desc = {
    Text = "Krähen rissen an ihren Federn, wie Menschen an ihrem eigenen Körper.\nIn dieser Welt der Angst ist das nichts Ungewöhnliches, du kannst nicht alle retten"
  },
  Event_7461_Name = {
    Text = "Träne der geschmolzenen Lava"
  },
  Event_7462_ChoiceDesc1 = {
    Text = "[Beruhige Kum]"
  },
  Event_7462_ChoiceDesc2 = {
    Text = "[Hilf Kum zu rufen]"
  },
  Event_7462_Desc = {
    Text = "Das riesige Ungeheuer brüllte das kleine Menschlein an, wollte alte Gefährten wecken, aber seine zerrissenen Stimmbänder gaben nur dumpfe Laute von sich"
  },
  Event_7462_Name = {
    Text = "Ruf der Freundschaft"
  },
  Event_7463_ChoiceDesc1 = {
    Text = "[Verlassen]Suche Scheinwerfer"
  },
  Event_7463_ChoiceDesc2 = {
    Text = "[In den Nebel eindringen]Verliere Arg2 Leben"
  },
  Event_7463_Desc = {
    Text = "Vor uns liegt ein dichter schwarzer Nebel, ein unvorsichtiger Eintritt wird zu Katastrophen führen.\nVielleicht solltest du \"Die Scheinwerfer\" finden, um den Nebel zu vertreiben"
  },
  Event_7463_Name = {Text = "unbekannt"},
  Event_7464_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7464_Desc = {
    Text = "“Ein Kiefer, der so knirscht wie deiner? Das habe ich noch nie gesehen.“\nDu lehnst die unverschämte Bitte von Mr. Kiefer ab. Mr. Kiefer ist enttäuscht, behält aber seine Haltung.\nAls Dank für dein geduldiges Zuhören gibt er dir ein kleines Geschenk"
  },
  Event_7464_Name = {Text = "knarrend"},
  Event_7465_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7465_Desc = {
    Text = "Du hast dieser seltsamen Bitte zugestimmt und Mr. Kiefer mitgenommen. \n Er liegt in deiner Tasche und knarrt ununterbrochen. Laut der Übersetzung deines Begleiters enthält seine Rede etwa Dankbarkeit, Nostalgie und Bedauern. \n Warum er so geworden ist, möchte Mr. Kiefer nicht viel darüber sagen, er sagt nur: \n “Du weißt, wenn du @2 anblickst, blickt @2 auch dich an.“"
  },
  Event_7465_Name = {Text = "knarrend"},
  Event_7466_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7466_Desc = {
    Text = "Er glitt wie Seide in Ihre Tasche, und mit dem leichten Gewichtszuwachs hörten Sie ein leises Dankeschön.\nDanach war es still"
  },
  Event_7466_Name = {Text = "Chaosgeist"},
  Event_7467_ChoiceDesc1 = {
    Text = "[Vorrücken]"
  },
  Event_7467_Desc = {
    Text = "Knack.\nDu steckst den Schlüssel ins Schloss, öffnest die Tür vorsichtig.\nDer gesamte Vorgang verlief reibungslos, was dir neues Vertrauen für die bevorstehende Untersuchung gab"
  },
  Event_7467_Name = {
    Text = "Rostige Tür"
  },
  Event_7468_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7468_Desc = {
    Text = "Die Stimme lachte tief, die Flüssigkeit unter deinen Füßen kräuselte sich.\n“Du wirst bald verstehen, dass es außer dem Tod nichts gibt, was man unbedingt tun muss.“"
  },
  Event_7468_Name = {
    Text = "Du wirst nicht wollen zu finden"
  },
  Event_7469_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7469_Desc = {
    Text = "Du lässt diese Erinnerung los und ziehst dein Bewusstsein aus der trügerischen Beruhigung zurück"
  },
  Event_7469_Name = {
    Text = "Versunken in alten Tagen"
  },
  Event_7470_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7470_Desc = {
    Text = "Nur ein kurzer Schlaf, ohne Trost, wie wirst du die lange Nacht überstehen"
  },
  Event_7470_Name = {
    Text = "Versunken in alten Tagen"
  },
  Event_7471_ChoiceDesc1 = {
    Text = "[Heb das Foto auf] wähle 1 von 3 Befehlskarten, um Gebet zu erhalten: „(EnchantConfig.Arg1)“"
  },
  Event_7471_Desc = {
    Text = "Dies ist eine Gruppenaufnahme. \n Lustlose Menschen hocken hinter dem Eisengitter und sehen leidend aus. \n Ein Foto zieht deine Aufmerksamkeit auf sich. Es sollte sich um eine schwache junge Frau handeln, deren Gesicht leer ist. \n Das unendlich verfluchte Geschöpf wickelt sich spiralförmig um ihren Körper. \n Du kannst ihr Gesicht nicht sehen, aber in deiner Vorstellung hat sie bestimmt keinen Ausdruck."
  },
  Event_7471_Name = {
    Text = "wie es ist, aufzeichnen"
  },
  Event_7472_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7472_Desc = {
    Text = "Das sind die Überreste des Vogels."
  },
  Event_7472_Name = {
    Text = "wütende Rabenmenge"
  },
  Event_7473_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7473_Desc = {
    Text = "Du lehnst die Bitte des Pianisten kalt ab.\nDer Pianist ist zutiefst enttäuscht. Er reißt sich auch das andere Ohr ab und wirft sie beide aus dem Fenster.\n„Ich brauche sie sowieso nicht.“\nDer melancholische Pianist spielt mit traurigem Gesicht eine Reihe von düsteren Noten"
  },
  Event_7473_Name = {Text = "Lausch"},
  Event_7474_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7474_Desc = {
    Text = "Das Weinen des Geistes des Chaos wird immer schriller, bis es schließlich zu einem durchdringenden Schrei wird, der um dich herum widerhallt.\nEr sinkt mit deinem Opfer und unentrinnbarem Kummer wieder in den Sumpf"
  },
  Event_7474_Name = {Text = "Chaosgeist"},
  Event_7475_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7475_Desc = {
    Text = "Das ist ein einseitiger Durchgang, durch den du nicht zurück zum Eingang gelangen kannst"
  },
  Event_7475_Name = {Text = "Durchgang"},
  Event_7476_ChoiceDesc1 = {
    Text = "[Verlassen]Erhalte Schöpfung“(RelicConfig.Arg1)“，Infektion“(Skill.Arg2)“"
  },
  Event_7476_Desc = {
    Text = "“Schließe die Augen und spüre seine Schritte.“\nDu schließt die Augen, und plötzlich dröhnt das Atmen eines seltsamen Tieres in deinen Ohren.\nAls du erschrocken die Augen öffnest, ist der Mann verschwunden"
  },
  Event_7476_Name = {
    Text = "Seltsamer Begleiter I"
  },
  Event_7477_ChoiceDesc1 = {
    Text = "[Verlassen]Erhalte 25 schwarze Siegel"
  },
  Event_7477_Desc = {
    Text = "“Das ist wirklich schade.“\nDie Stimme des Mannes war niedergeschlagen, und er rückte seine Brille zurecht.\n“Aber wenn ihr noch nie davon gehört habt, warum seid ihr dann mitten in der Nacht hierhergekommen?“\nOhne auf eure Antwort zu warten, drehte sich der Mann zur Seite und ging weg"
  },
  Event_7477_Name = {
    Text = "Seltsamer Begleiter I"
  },
  Event_7478_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7478_Desc = {
    Text = [[
Du gehst entschlossen weiter.
Ein Schritt, zwei Schritte, drei Schritte...
Die Schritte hinter dir verschwinden in der Dunkelheit.
Ihr werdet euch wiedersehen]]
  },
  Event_7478_Name = {
    Text = "Oxford-Schuhe"
  },
  Event_7479_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7479_Desc = {
    Text = "Du beugst dich halb vor, hebst das Tablett vom Tisch neben dir und verwandelst dich in den Wächter der Prinzessin. \n Wer die glückliche Prinzessin ist – natürlich ist es deine treueste Partnerin. \n “Wenn du die Tasse in mein Gesicht kippst, kannst du nächsten Monat nicht mit den Unterrichtsnotizen rechnen.“ \n Das ist die Warnung, die die Prinzessin dir gibt."
  },
  Event_7479_Name = {
    Text = "Täuschend echt"
  },
  Event_7480_ChoiceDesc1 = {
    Text = "[höre still zu]Verbessere zufällig die Gebetsqualität 1 Karte"
  },
  Event_7480_ChoiceDesc2 = {
    Text = "[Sie ist es] Wähle 1 von 3 Befehlskarten aus, um das Gebet zu erhalten: „(EnchantConfig.Arg1)\", infiziere „(Skill.Arg2)\""
  },
  Event_7480_Desc = {
    Text = "Sarahs Schrei hallte in deinem Kopf wider, eine vertraute, leise Stimme flüsterte irgendwoher „Sasa-Schwester“, „Sasa-Schwester“.\n„Sasa-Schwester, wo bist du?“"
  },
  Event_7480_Name = {
    Text = "“Sasa-Schwester“"
  },
  Event_7481_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7481_Desc = {
    Text = "“...Ich glaube tatsächlich, dass du einen Funken Wahrheit sagst, aber der Wunsch kann dir nicht helfen, den Aufgelösten Körper zu lösen. Lass uns lieber etwas Praktisches tun.“"
  },
  Event_7481_Name = {
    Text = "Logans Regel"
  },
  Event_7482_ChoiceDesc1 = {
    Text = "[Erhalte 100 schwarze Siegel]"
  },
  Event_7482_ChoiceDesc2 = {
    Text = "[2 zufällige Befehlskarten erhalten ein Gebet: „(EnchantConfig.Arg1)\"]"
  },
  Event_7482_Desc = {
    Text = "Schöpfungen bestehen aus stabilisiertem Wissen, vielleicht können sie harmonische Melodien bringen"
  },
  Event_7482_Name = {Text = "Dissonanz"},
  Event_7483_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7483_Desc = {
    Text = "“Es sind Erinnerungsfragmente von jemandem, der diese Dimension betreten hat,“ antwortete Ramona, “Es ist leicht, solche Dinge zu treffen, wenn man durch Dimensionen reist. Pass auf, dass du sie nicht mit deinen eigenen Erinnerungen verwechselst.“"
  },
  Event_7483_Name = {
    Text = "Erinnerungsfragment: Whisky"
  },
  Event_7484_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7484_Desc = {
    Text = "Folge dem Rhythmus deines Herzens, jage dem Licht nach. Ihr werdet nicht getrennt, wie niemand Tag und Nacht genau trennen kann"
  },
  Event_7484_Name = {
    Text = "Linkes Vorhof"
  },
  Event_7485_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7485_Desc = {
    Text = "Du streichelst immer wieder diese unruhigen Hände, versuchst, sie zu beruhigen.\nBald ist deine Welt völlig still.\nLiebe wird immer belohnt"
  },
  Event_7485_Name = {
    Text = "dunkles Sumpfgebiet"
  },
  Event_7486_ChoiceDesc1 = {
    Text = "[Kämpfe] Infektion „(Skill.Arg1)“, erhält Silberrelikt „(RelicConfig.Arg2)“"
  },
  Event_7486_ChoiceDesc2 = {
    Text = "[Gib auf]infiziere“(Skill.Arg1)“，erhalte ein Silberrelikt“(RelicConfig.Arg2)“"
  },
  Event_7486_ChoiceDesc3 = {
    Text = "[Vorsicht]Erhalte 25 schwarze Siegel"
  },
  Event_7486_Desc = {
    Text = "Schmutz strömt in deinen Kopf, das Gefühl von Unreinheit ist besonders klar.\nDie trübe, stinkende Flüssigkeit sickert und füllt deine Gedanken, Schmerz kriecht über dein angstverzerrtes Gesicht, du bist in einem endlosen Albtraum gefangen, aus dem du nicht entkommen kannst"
  },
  Event_7486_Name = {
    Text = "Schädelwunde"
  },
  Event_7487_ChoiceDesc1 = {
    Text = "[Memphis Ritualspiegel]"
  },
  Event_7487_ChoiceDesc2 = {
    Text = "[Richtkompass]"
  },
  Event_7487_ChoiceDesc3 = {
    Text = "[Ich habe nichts verloren]"
  },
  Event_7487_Desc = {
    Text = "“Pionier der Dimensionen.“\n\nEine alte Stimme ertönt, als käme sie aus der Urzeit, durch die Ewigkeit.\n\nIn höchster Anspannung hörst du die vertraute Frage.\n\n“Was hast du verloren, dieses runde Ding, das dir am Anfang der Runde Karten ziehen lässt?“"
  },
  Event_7487_Name = {
    Text = "Stimmen aus dem Jenseits"
  },
  Event_7488_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7488_Desc = {
    Text = "“Ich bin hier nicht die Wertstoffstation,“ murmelte Doll und nahm es entgegen, „na gut, wenigstens kann ich noch ein wenig Nützliches extrahieren.“"
  },
  Event_7488_Name = {Text = "Schild"},
  Event_7489_ChoiceDesc1 = {
    Text = "Zufälliges normales Orison"
  },
  Event_7490_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7490_Desc = {
    Text = "Du liest die zerfetzten, beschädigten Seiten,“Zwillinge“、“Durchdringung“、“Opfer“、“Unwirksam“...\nEs sind immer noch fragmentierte Konzepte und schwer verständliche Texte, nur dein pochender Kopf beweist, dass du diese Seite gelesen hast"
  },
  Event_7490_Name = {
    Text = "Geheimer Befehl · Unten"
  },
  Event_7491_ChoiceDesc1 = {
    Text = "[Was bist du bereit zu opfern?]steigere zufällig die Gebetsqualität einer Karte"
  },
  Event_7491_ChoiceDesc2 = {
    Text = "[Ihnen einen abgelaufenen Bloody Mary spendieren] Wähle 1 von 3 Befehlskarten aus, um das Gebet zu erhalten: „(EnchantConfig.Arg1)\", infiziere „(Skill.Arg2)\""
  },
  Event_7491_Desc = {
    Text = "“Willkommen, mein wertvoller Gast. Wählen Sie nach Belieben, all diese Pracht existiert nur für Sie.“\n“Ähm, entschuldigen Sie bitte, sind Sie... die Zwillingsschwester von Frau Daffodil?“\n“Ich bin Daffodil selbst. Darf ich fragen, was Sie heute hierher führt...?“\n“Entschuldigung, Entschuldigung, Sie sind noch anmutiger als zuvor, ich habe Sie nicht erkannt. Erinnern Sie sich? Vor zwanzig Jahren haben Sie einen Unhold aus meiner Bar entfernt... Gestern ist der Albtraum zurückgekehrt, er hat die Bar eingenommen, mit seinen Geschwistern, in Scharen...“"
  },
  Event_7491_Name = {
    Text = "Erinnerungsfragment: Alte Träume wiederbelebt"
  },
  Event_7492_ChoiceDesc1 = {
    Text = "[vertreibe die Krähen]Erhalte 30 schwarze Siegel, Infektion“(Skill.Arg2)“，weiter wählen"
  },
  Event_7492_ChoiceDesc2 = {
    Text = "[Weiter dem Kind nachjagen]Verlassen"
  },
  Event_7492_Desc = {
    Text = "Die zweite Krähe flog davon, ihre Schwanzfedern zeigten im Flattern einen Hauch von Weiß, wie Knochen"
  },
  Event_7492_Name = {
    Text = "Schwarze Krähe Blick"
  },
  Event_7493_ChoiceDesc1 = {
    Text = "[Wagen]Infiziere “(Skill.Arg1)“，betrete das Glücksspiel"
  },
  Event_7493_ChoiceDesc2 = {
    Text = "[Lass es bleiben]Erhalte 25 das schwarze Siegel"
  },
  Event_7493_Desc = {
    Text = "“Lass uns wetten? Rate unsere Punktzahl! Nur ein kleiner Einsatz!“\nDie weggeworfenen Würfel summen laut, als ob sie mit dir sprechen.\n“Wirf mich! Wirf mich!“\n“Einmal! Nur einmal!“\nNa gut, nur einmal—\nDu nimmst einen Chip. Du entscheidest—"
  },
  Event_7493_Name = {
    Text = "Endloses Glücksspiel"
  },
  Event_7494_ChoiceDesc1 = {
    Text = "[Widerstehe bösen Gedanken] erhält Silberrelikt „(RelicConfig.Arg1)“, Infektion „(Skill.Arg2)“"
  },
  Event_7494_ChoiceDesc2 = {
    Text = "[Umarme böse Gedanken] erhält Silberrelikt „(RelicConfig.Arg1)“, Infektion „(Skill.Arg2)“"
  },
  Event_7494_ChoiceDesc3 = {
    Text = "[Wach auf und geh]Erhalte 25 schwarze Siegel"
  },
  Event_7494_Desc = {
    Text = "Das böse Gedankenspiel wurde zu einer scharfen Klinge, als ob es scharfe Zähne hätte.\n Sie zernagen den geschwächten Verstand im Bereich, verschlingen den verbleibenden Willen, so wie die Realität dir Unrecht antut"
  },
  Event_7494_Name = {
    Text = "unberechtigte Gedanken"
  },
  Event_7495_ChoiceDesc1 = {
    Text = "[Heftiges Ringen] entfernt 1 Befehlskarte und erhält Arg1 das schwarze Siegel"
  },
  Event_7495_ChoiceDesc2 = {
    Text = "[Spinnennetz entzünden]1 Befehlskarte kopieren, Infektion“(Skill.Arg1)“"
  },
  Event_7495_ChoiceDesc3 = {
    Text = "[Still warten]wähle eine von 3 Befehlskarten und erhalte das Gotteszeichen: „(EnchantConfig.Arg1)“"
  },
  Event_7495_Desc = {
    Text = "Fadenschlingen winden sich wie ein Spinnennetz um dich, in diesem Moment bist du das Opfer des Bereichs"
  },
  Event_7495_Name = {Text = "versunken"},
  Event_7496_ChoiceDesc1 = {
    Text = "[Empfänger: ∞]Infektion“(Skill.Arg1)“"
  },
  Event_7496_ChoiceDesc2 = {
    Text = "[Empfänger: Selbst]1 Karte löschen"
  },
  Event_7496_ChoiceDesc3 = {
    Text = "[Empfänger: Lehrer]erhalte 25 das schwarze Siegel"
  },
  Event_7496_Desc = {
    Text = "Er gab dem Wanderer im Bereich eine Chance: Eine Chance, die zum Unbekannten führt.\nEinige beschädigte Papiere, eine Schreibmaschine, die mit Tinte dampft, und ein unbekannter, einseitiger Empfänger.\nDer Wille wird entscheiden, wohin deine Botschaft gesendet werden kann"
  },
  Event_7496_Name = {
    Text = "Einfache Konfession"
  },
  Event_7497_ChoiceDesc1 = {
    Text = "[Zustimmen]"
  },
  Event_7497_ChoiceDesc2 = {Text = "[Ablehnen]"},
  Event_7497_Desc = {
    Text = "In der leeren Umgebung hallen geflüsterte Worte wider. \n “Oh, das ist der Idiot, der von einem berühmten Spieler redet, der entweder stirbt oder gewinnt. Ein Versager, halte dich besser von ihm fern.“ \n Eine dürr und deprimiert wirkende Gestalt wirft dir einige Münzen zu, das metallische Klirren dringt in deine Handfläche. \n “Lass uns spielen.“"
  },
  Event_7497_Name = {
    Text = "Berühmter Glücksspieler"
  },
  Event_7498_ChoiceDesc1 = {
    Text = "[Bei uns ist alles in Ordnung] Wähle 1 von 3 Befehlskarten aus, die das Gebet erhält: „(EnchantConfig.Arg1)\", infiziert „(Skill.Arg2)\""
  },
  Event_7498_ChoiceDesc2 = {
    Text = "[Wer bist Du?] Wähle 1 von 3 Befehlskarten aus, die das Gebet erhält: „(EnchantConfig.Arg1)\", infiziert „(Skill.Arg2)\""
  },
  Event_7498_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte 25 schwarze Siegel"
  },
  Event_7498_Desc = {
    Text = "Die Schreibmaschine spritzt plötzlich Tinte, die ! auf ihr blenden wie nie zuvor.\n„Doll, geht es dir gut??? Warum ist der Hüter verschwunden und du auch!!! Bitte antworte, wenn du wohlauf bist!!! Wenn das so weitergeht, verliert William seine Haare!!!“"
  },
  Event_7498_Name = {
    Text = "Notfallkommunikation"
  },
  Event_7499_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7499_Desc = {
    Text = "Du hast den letzten Gips wieder aufgetragen; sie brach in scharfen Gelächter aus, dunkle Energie umschlang sie, ihre schwebende Gestalt verschwand aus deinem Blickfeld"
  },
  Event_7499_Name = {
    Text = "Körper vervollständigen"
  },
  Event_7500_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7500_Desc = {
    Text = "Du ziehst den silbernen Schlüssel heraus, hältst ihn traurig in deiner Hand, ein schwaches Licht umhüllt dich.\nIn der Stille bleibt nur ein Seufzen übrig"
  },
  Event_7500_Name = {
    Text = "Blick des Auges"
  },
  Event_7501_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7501_Desc = {
    Text = "Der verbleibende Blick ist weiterhin auf dich gerichtet, während die Fleischzellen unter deiner Haut verrückt schreien und fliehen, während die Blutgefäße wie Würmer unter der Haut kriechen.\nDu fühlst eine strömende Kraft, die in den seltsamen Veränderungen deiner Glieder ausbricht"
  },
  Event_7501_Name = {
    Text = "Blick des Auges"
  },
  Event_7502_ChoiceDesc1 = {
    Text = "[Blick abwenden]wecke zufällig 1 Erwecker"
  },
  Event_7502_ChoiceDesc2 = {
    Text = "[Direkter Blick]Wähle 1 Erwecker aus und reduziere die Arithmetica-Kosten der Wachenkarten um 2 Punkte. Infektion“(Skill.Arg1)“"
  },
  Event_7502_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte 50 schwarze Siegel"
  },
  Event_7502_Desc = {
    Text = "Der Dimensionstunnel verbindet unzählige Universen; auf dem höchsten Gang starren unzählige Augen die schleichenden euch an"
  },
  Event_7502_Name = {Text = "Sein Blick"},
  Event_7503_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7503_Desc = {
    Text = "Zu chaotisch, zu chaotisch.\nAlle Gedanken wurden im Fluss des Denkens mitgerissen, in die Ferne getragen.\nIm Tal des Gehirns blieben nur endlose Verwirrung und Schmerz zurück"
  },
  Event_7503_Name = {
    Text = "Inspirationsschub"
  },
  Event_7504_ChoiceDesc1 = {
    Text = "[Einstecken]"
  },
  Event_7504_Desc = {
    Text = "Im gesättigten D-Schleim scheint eine gewisse Substanz verborgen zu sein... Beobachte sie mit dem Silberschlüssel und verwandle sie in deine eigene Macht"
  },
  Event_7504_Name = {
    Text = "Ausgangspunkt"
  },
  Event_7505_ChoiceDesc1 = {
    Text = "[vertreibe die Krähen]Erhalte 35 schwarze Siegel, Infektion“(Skill.Arg2)“，weiter wählen"
  },
  Event_7505_ChoiceDesc2 = {
    Text = "[Weiter dem Kind nachjagen]Verlassen"
  },
  Event_7505_Desc = {
    Text = "Eine Krähe fliegt weg, eine schwarze Feder schwebt langsam herab"
  },
  Event_7505_Name = {
    Text = "Schwarze Krähe Blick"
  },
  Event_7506_ChoiceDesc1 = {
    Text = "[Bestätigen]"
  },
  Event_7506_Desc = {
    Text = "Hier ist das Blutbad des Abgrunds, der Kampf erfordert nicht nur Mut, sondern auch Weisheit. \n\nReibe deine Augen klar, beobachte deine Gegner, du musst sie nicht alle besiegen, du musst nur ihren Anführer besiegen!"
  },
  Event_7506_Name = {
    Text = "Shura-Probe"
  },
  Event_7507_ChoiceDesc1 = {
    Text = "[Verbinden]Arg2 Lebenspunkte heilen"
  },
  Event_7507_Desc = {
    Text = "Du erkundest den Nebel, plötzlich leuchtet das Abzeichen auf deiner Brust schwach silbern. Wer ruft dich am anderen Ende des Kommunikators?"
  },
  Event_7507_Name = {
    Text = "Kontaktstelle"
  },
  Event_7508_ChoiceDesc1 = {
    Text = "[Ihm folgen]"
  },
  Event_7508_ChoiceDesc2 = {
    Text = "[Begrüßen]"
  },
  Event_7508_Desc = {
    Text = "Tapp. Tapp. Tapp.\nEine weiße Gestalt schreitet langsam durch den dichten Nebel, wie ein Schiff, das in die stille Nacht segelt.\nVon hinten sieht es aus wie ein Junge.\nDu hörst seinen müden Schritten zu und triffst eine Entscheidung"
  },
  Event_7508_Name = {
    Text = "Abschlusszeremonie I"
  },
  Event_7509_ChoiceDesc1 = {
    Text = "[Zustimmen]"
  },
  Event_7509_ChoiceDesc2 = {
    Text = "[Misstrauisch sein]"
  },
  Event_7509_Desc = {
    Text = "Der Fusionsschale schreit und fällt, und du bist überrascht zu entdecken, dass Clementine dahinter steht. \n “Ich bin hier, um mich zu verabschieden“, antwortet sie nicht auf deine Fragen, “um dir meinen Dank auszudrücken, kann ich dir einige Hinweise geben. Aber... das wird dein Vertrauen erfordern. \n Lass mich dich hypnotisieren, dann wirst du alles wissen, was ich weiß.“ \n Kannst du ihr vertrauen? \n “Sei vorsichtig“, warnt Ramona, “sie hat nichts Gutes im Sinn.“"
  },
  Event_7509_Name = {
    Text = "Hypnotherapie"
  },
  Event_7510_ChoiceDesc1 = {
    Text = "[Bestätigen]"
  },
  Event_7510_Desc = {
    Text = "Du konzentrierst dich, die Illusion zerstreut sich wie Tinte. Du gehst weiter, aber der Schatten in deinem Herzen bleibt"
  },
  Event_7510_Name = {Text = "Illusion"},
  Event_7511_ChoiceDesc1 = {
    Text = "[Armes Wesen?]"
  },
  Event_7511_ChoiceDesc2 = {
    Text = "[Evolvierter Mensch?]"
  },
  Event_7511_ChoiceDesc3 = {
    Text = "[Wer bist du?]"
  },
  Event_7511_Desc = {
    Text = "Der Mann, den ihr zum sechsten Mal seht, steht hoch oben auf dem Stahlgerüst und blickt auf die Erde herab. Der heulende Wind hebt sein langes Haar und enthüllt das wahre Antlitz einer Schlange. \n Sein Blick konzentriert sich auf euch, bevor er einen Moment später in die ferne Dunkelheit schweift. \n “Ah, was für ein bedauernswertes Wesen. \n Das Gefühl des Verrats muss so süß sein wie das eines<Bold: Evolutions>menschen.“"
  },
  Event_7511_Name = {
    Text = "Seltsamer Begleiter VI"
  },
  Event_7512_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7512_Desc = {
    Text = "Wer würde sich unter dem Blick eines Höllenhundes um einen Filmstreifen kümmern?"
  },
  Event_7512_Name = {
    Text = "Erinnerungsschein"
  },
  Event_7513_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7513_Desc = {
    Text = "Nicht hinschauen, nicht diskutieren, nicht zuhören, nicht einmal daran denken—die Wahl der Klugen"
  },
  Event_7513_Name = {Text = "Rune Wahn"},
  Event_7514_ChoiceDesc1 = {
    Text = "[Verlassen]Lösche 2 Karten"
  },
  Event_7514_Desc = {
    Text = "Inmitten der lauten Geräusche um dich herum hörst du schwach das seltsame Flattern. Der Silberschlüssel auf deiner Brust vibriert plötzlich heftig, und du wirst von einer Art Kraft gezwungen, den Kopf zu heben und das riesige schwarze Loch in der Luft zu sehen. \n“Schade, schade, aber das ist nicht schlimm. Wir werden uns wiedersehen, mein geehrtes Auge ohne Augen.“"
  },
  Event_7514_Name = {
    Text = "Hypnotherapie"
  },
  Event_7515_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7515_Desc = {
    Text = "Du kannst alles um dich herum ignorieren, aber nicht das Schlagen deines Herzens. Es schlägt schneller, drängt und tadelt dich"
  },
  Event_7515_Name = {
    Text = "Linkes Vorhof"
  },
  Event_7516_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7516_Desc = {
    Text = "“Das ist gut!!! Williams Haare sind gerettet!!!“\nObwohl es nur Text war, hörtest du in deinem Kopf ein verzweifeltes Brüllen"
  },
  Event_7516_Name = {
    Text = "Notfallkommunikation"
  },
  Event_7517_ChoiceDesc1 = {
    Text = "[Ihm die Wahrheit sagen]wählt zufällig 1 Erwecker, infiziert „(Skill.Arg1)“"
  },
  Event_7517_ChoiceDesc2 = {
    Text = "[verschweige die Wahrheit]Erhalte 3 wählbare Gebete"
  },
  Event_7517_Desc = {
    Text = "“Hilf mir!“\n Der melancholische Reisende ergreift deine Hand. Er wandert seit Hunderten von Jahren hier umher. \n“Ich bin ein Soldat, beauftragt, in den fernen Osten zu reisen, um Heiden zu bekämpfen. \n Ich habe dichte Wälder durchquert und Flüsse überquert, aber ich habe den Weg verloren und bin immer wieder am selben Ort gelandet. \n Etwas beobachtet mich im Dunkeln. Ich kann es nicht sehen, aber ich weiß es. Es sieht mich ständig an. \n Jetzt möchte ich nur nach Hause zurück...“\n Du blickst auf die schwebenden Schatten hinter ihm. Zuerst sind sie verschwommen, dann werden sie allmählich klarer – es ist ein weit geöffnetes Maul, das darauf wartet, die seit hundert Jahren verlorene Seele zu genießen."
  },
  Event_7517_Name = {
    Text = "Verschlinger"
  },
  Event_7518_ChoiceDesc1 = {
    Text = "[In die Dunkelheit vordringen]"
  },
  Event_7518_ChoiceDesc2 = {Text = "[Abschied]"},
  Event_7518_Desc = {
    Text = "“Celeste, wirst du mir dieses Mal helfen?“\nDas Mädchen ging unruhig auf der Stelle und schaute immer wieder zu dem stillen Erwecker zurück. \nSie antwortete dem Mädchen nicht, und als das Gesicht des Mädchens immer besorgter wurde, hob der Wind den weißen Schleier und schob das Mädchen sanft in eine bestimmte Richtung. \n“Ich werde dich beschützen.“ \nIch werde dich beschützen, auch wenn ich bei der “Schutz“-Sache einmal versagt habe. \nAber dieses Mal werde ich dich nicht allein in der Dunkelheit verloren gehen lassen."
  },
  Event_7518_Name = {
    Text = "Segen der Heiligen Seefahrerin"
  },
  Event_7519_ChoiceDesc1 = {
    Text = "[Verlassen]Wähle eine von 3 Befehlskarten und erhalte ein Gebet:“(EnchantConfig.Arg1)“"
  },
  Event_7519_Desc = {
    Text = "Diese Lieder sind teils uralt, verloren vor der großen Flut; andere sind neu, singen vom letzten Neujahr, als die Frau neue Handschuhe im Lentinen-Kaufhaus kaufte... Nach dem Chaos der Emotionen bleibt nur eine Leere im Herzen"
  },
  Event_7519_Name = {
    Text = "Schiffslied"
  },
  Event_7520_ChoiceDesc1 = {
    Text = "[vertreibe die Farben]Erhalte das goldene Relikt“(RelicConfig.Arg1)“，Infektion“(Skill.Arg2)“"
  },
  Event_7520_ChoiceDesc2 = {
    Text = "[Umarme die Farben] erhält 1 aus 3 goldene Relikte, Infektion „(Skill.Arg1)“"
  },
  Event_7520_ChoiceDesc3 = {
    Text = "[Dreh dich um und verlasse]Erhalte das Silberrelikt“(RelicConfig.Arg1)“"
  },
  Event_7520_Desc = {
    Text = "Murphy folgte dicht hinter dir, blieb aber an einer Ecke plötzlich stehen.\nSchillernde Farben wirbelten vor ihren Augen und ließen die Luft seufzen.\n„Mur@1...“\nWar es der Geist eines Ertrunkenen, der im Sonaniel gefangen war? Oder ein verstorbener Verwandter, der den Lebenden folgte?"
  },
  Event_7520_Name = {
    Text = "Nostalgische Farben"
  },
  Event_7521_ChoiceDesc1 = {
    Text = "[Weiter suchen]Erhöhe Arg1 Leben, infiziere“(Skill.Arg2)“"
  },
  Event_7521_ChoiceDesc2 = {
    Text = "[Verlassen]"
  },
  Event_7521_Desc = {
    Text = "Vertraute Worte in deinen Ohren, beruhigend und tröstlich, aber als du der Stimme folgst, verstummt sie"
  },
  Event_7521_Name = {
    Text = "Abnormale Verbindung"
  },
  Event_7522_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7522_Desc = {
    Text = "“Das war eine entweihende Melodie.“\nDu hieltest dir die Ohren zu, aus denen Blut floss, und warst dir sicher"
  },
  Event_7522_Name = {
    Text = "Verbotene Klangfarbe"
  },
  Event_7523_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7523_Desc = {
    Text = "Die Farben verzerrten sich vage zu zwei menschlichen Gestalten, aber sie standen nur in der Ecke und schickten euch ihren letzten Segen mit ihren Blicken"
  },
  Event_7523_Name = {
    Text = "Nostalgische Farben"
  },
  Event_7524_ChoiceDesc1 = {
    Text = "[Lauscher]Erhalte 3 wähle 1 goldenes Relikt"
  },
  Event_7524_Desc = {
    Text = "Daffodils Stimme hielt einen Moment inne. \n “Oh, hast du das gewählt? Gute Wahl, als Belohnung werde ich dir ein besonderes Geschenk machen.“"
  },
  Event_7524_Name = {
    Text = "Hinweiszeit"
  },
  Event_7525_ChoiceDesc1 = {
    Text = "[Fragen stellen]Infektion“(Skill.Arg1)“"
  },
  Event_7525_ChoiceDesc2 = {
    Text = "[Aufhören zu fragen]1 Karte löschen"
  },
  Event_7525_Desc = {
    Text = "“Ja, kluge Wahl. Angesichts eines großen Feindes will man sicher alles wissen, oder? Aber zu viele Geheimnisse über Dimensionen zu kennen, kann den Verstand stören, weißt du?“"
  },
  Event_7525_Name = {
    Text = "Hinweiszeit"
  },
  Event_7526_ChoiceDesc1 = {
    Text = "[Fragen stellen]Daphdell wütend machen, in den Kampf gehen"
  },
  Event_7526_ChoiceDesc2 = {
    Text = "[Aufhören zu fragen]Kleine Strafe erleiden"
  },
  Event_7526_Desc = {
    Text = "“Oh? Du denkst immer noch daran, mich zu verfolgen? Kleiner, Gier ist nicht gut.“"
  },
  Event_7526_Name = {
    Text = "Hinweiszeit"
  },
  Event_7527_ChoiceDesc1 = {
    Text = "[Genau hinschauen]erhöhe Arg1 Punkte maximale Gesundheit"
  },
  Event_7527_ChoiceDesc2 = {
    Text = "[Ignorieren] 2 zufällige Befehlskarten erhalten ein Gebet: „(EnchantConfig.Arg1)\", infiziere 2 „(Skill.Arg2)\""
  },
  Event_7527_Desc = {
    Text = "Ihr verfolgt den Höllenhund durch die Straßen der Stadt.\nKalte Schneeflocken beginnen zu fallen, sanft auf eure Wangen und Brust, beruhigen euer unruhiges Herz"
  },
  Event_7527_Name = {Text = "Schnee"},
  Event_7528_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7528_Desc = {
    Text = "Du schwingst deine Arme, um die lästigen Krähen zu vertreiben.\nSie krähen höhnisch, als ob sie deine Dummheit und Schwäche verspotten.\nDoch dein Mut beeindruckt sie und du erhältst deine Belohnung"
  },
  Event_7528_Name = {
    Text = "Sanges der Raben"
  },
  Event_7529_ChoiceDesc1 = {
    Text = "[Über Lily] erhält Silberrelikt „(RelicConfig.Arg1)“"
  },
  Event_7529_ChoiceDesc2 = {
    Text = "[Über den Höllenhund] erhält goldenes Relikt „(RelicConfig.Arg1)“, Infektion „(Skill.Arg2)“"
  },
  Event_7529_Desc = {
    Text = "Durch das endlose Tor, aus unerreichbarer Ferne, ertönte Daphdales Stimme.\n„Hier ist Daphdales Tipp-Zeit.“"
  },
  Event_7529_Name = {
    Text = "Hinweiszeit"
  },
  Event_7530_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7530_Desc = {
    Text = "Du wirkst immer noch stark, selbst im Gesang bleibst du dir treu.\nDu glaubst nicht an das Flüstern in deinen Ohren, vertraust nur auf menschliche Vernunft.\nAber... wenn der feste Boden, auf dem du stehst, von schwarzem Schleim bedeckt ist, wird das Ausgraben deiner Augen dein letzter Ausweg sein"
  },
  Event_7530_Name = {
    Text = "Sanges der Raben"
  },
  Event_7531_ChoiceDesc1 = {
    Text = "[Blick auf die Höllenhund-Quelle]Erhalte goldenes Relikt“(RelicConfig.Arg1)“，Infektion“(Skill.Arg2)“"
  },
  Event_7531_ChoiceDesc2 = {
    Text = "[Kampf im Fokus]Wähle eine von 3 Befehlskarten und erhalte das Orison: „(EnchantConfig.Arg1)“"
  },
  Event_7531_Desc = {
    Text = "Die Konturen des Höllenhundes verändern sich.\nSein Körper verbindet sich mit dem Spalt in der Wand und offenbart eine bizarre Illusion"
  },
  Event_7531_Name = {Text = "von Winkel"},
  Event_7532_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7532_Desc = {
    Text = "“Miau, miau miau, miau miau miau...“\nDu drückst deine Stimme zusammen und bemühst dich, schwach und harmlos zu erscheinen.\n“Miau! Miau miau! Miau miau miau!“\nDie Katzen scheinen deine Freundlichkeit anzunehmen und antworten mit einem lauten Ruf. Euer Miauen wechselt sich ab, ununterbrochen Tag und Nacht, der Mond versteckt sich vor Angst hinter den Wolken."
  },
  Event_7532_Name = {
    Text = "Katzenstadt"
  },
  Event_7533_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7533_Desc = {
    Text = "Aber es sind nur Lebewesen, die ums Überleben kämpfen und ein Stück Treibholz suchen, um sich auszuruhen...\nDu seufzt und lässt den schwarzen Saft vom Schmetterlingsschwanz über deine Wange fließen"
  },
  Event_7533_Name = {
    Text = "Schwarze Flüssigkeitsfalter"
  },
  Event_7534_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7534_Desc = {
    Text = "Du rennst mit aller Kraft, bis du weit weg von den Katzen bist.\nAls du zurückblickst, sind die Katzen wieder an ihren Plätzen. Sie putzen sich, dösen oder kämpfen...\nEhrlich gesagt, sie kümmern sich nicht um Menschen"
  },
  Event_7534_Name = {
    Text = "Katzenstadt"
  },
  Event_7535_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7535_Desc = {
    Text = "Du wirfst die verbliebenen Fleischstücke in die Menge.\nSchwarze Katzen stürzen sich darauf, reißen es in Stücke und zerstreuen sich schnell.\nUnglücklicherweise war dies verdorbenes Fleisch. Es stillt zwar den Hunger, aber zufrieden macht es nicht"
  },
  Event_7535_Name = {
    Text = "Katzenstadt"
  },
  Event_7536_ChoiceDesc1 = {
    Text = "[Direkter Blick in die Augen]Erhalte goldenes Relikt“(RelicConfig.Arg1)“，Infektion“(Skill.Arg2)“"
  },
  Event_7536_ChoiceDesc2 = {
    Text = "[Gib den Widerstand auf]wecke zufällig 2 Erwecker, infiziere 2 mal“(Skill.Arg1)“"
  },
  Event_7536_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte 50 schwarze Siegel"
  },
  Event_7536_Desc = {
    Text = "Unzählige Augen umgeben dich und flüstern. \n“Wir reisen, wir halten an, wir schreiten mit großen Schritten durch zehntausende Jahre und noch länger. \nWenn die Sonne im Blick allmählich verblasst, während das Leben der alten Erde von Fluten verschlungen wird. \nWir sind schon lange von den Geheimnissen des Universums fasziniert.“"
  },
  Event_7536_Name = {Text = "Auge"},
  Event_7537_ChoiceDesc1 = {
    Text = "[Fühle Panik]wecke zufällig 1 Erwecker"
  },
  Event_7537_ChoiceDesc2 = {
    Text = "[Fühle Zufriedenheit]wähle 1 Erwecker und reduziere die Kosten für die Arithmetica der Erwachungskarte um 2 Punkte. infiziere“(Skill.Arg1)“"
  },
  Event_7537_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte 50 schwarze Siegel"
  },
  Event_7537_Desc = {
    Text = "Hast du jemals einen Himmel ohne Mond und Sterne gesehen, in dem unzählige vergrößerte Pupillen hoch oben schweben? \n Es ist, als könntest du sie mit einem Handgriff abdrehen und das Blut und das Fleisch spritzen lassen. \n Doch wenn du deine Finger ausstreckst, berührst du nur die Leere. \n Die Augen des Schicksals starren dich unentwegt an, während sie aus dem chaotischen Universum ein kristallines Sandkorn aufheben."
  },
  Event_7537_Name = {
    Text = "Kuppelaugen"
  },
  Event_7538_ChoiceDesc1 = {
    Text = "[Lege die Hände vor die Ohren]erhalte ein Silberrelikt“(RelicConfig.Arg1)“"
  },
  Event_7538_ChoiceDesc2 = {
    Text = "[Weiter halten die Ohren zu]Erhalte 75 schwarze Siegel, Infektion“(Skill.Arg2)“"
  },
  Event_7538_Desc = {
    Text = "Aufschrei, ein endloser Aufschrei——\nDie Sängerin der Krähen mit ihrem schwarzen, schimmernden Fell und dem kalten, harten Glanz auf ihrem spitzen Schnabel, durchdringt mit ihrem durchdringenden Klagelaut immer wieder dein Trommelfell. \nLass deine Hände von deinen Ohren! \nDie Krähen, die in der Nacht aus vollem Halse singen, wollen den ungeschliffenen Schauer in deinem zusammengekauerten Körper genießen."
  },
  Event_7538_Name = {
    Text = "Lied der Raben"
  },
  Event_7539_ChoiceDesc1 = {
    Text = "[Miau nachahmen]erhalte 50 das schwarze Siegel"
  },
  Event_7539_ChoiceDesc2 = {
    Text = "[Füttere mit Nahrung] erhält +75 das schwarze Siegel, Infektion „(Skill.Arg2)“"
  },
  Event_7539_Desc = {
    Text = "Du bist in das Revier der schwarzen Katze geraten. \n Unzählige Augen öffnen sich plötzlich in der Dunkelheit, voller Neugier, Misstrauen und Wachsamkeit... nur nicht mit Freundlichkeit. \n Smaragdgrün, Bernstein-gelb, Pfauenblau... \n Du fühlst dich, als befändest du dich in einem Meer aus schimmernden Edelsteinen. \n Um zu entkommen, musst du—"
  },
  Event_7539_Name = {
    Text = "Katzenstadt"
  },
  Event_7540_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7540_Desc = {
    Text = "Du bemerkst eine ungewöhnliche Hand. Sie ist zart, weiß und bleibt durchweg ruhig. \n Wichtiger ist – du erkennst sie, es ist deine eigene Hand. \n Du zögerst nicht und brichst sie heftig. \n In deinen Ohren ertönt unzählige schmerzhafte Aufschreie, der Sumpf verschwindet schließlich."
  },
  Event_7540_Name = {
    Text = "dunkles Sumpfgebiet"
  },
  Event_7541_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7541_Desc = {
    Text = "“Eine weise Entscheidung“, sagte die gestalt mit leeren Händen, “bewährte Entscheidungen haben ein festgelegtes Ende, während unbekannte Handlungen zu einer neuen Zukunft führen.“\nEin zarter Hoffnungsschimmer umhüllt dich sanft. Die Gestalt verschwindet, du hältst dir das Herz und weißt nicht, ob das eben Gesehene eine Projektion oder eine Illusion ist, die unter dem Druck der Seele entstanden ist."
  },
  Event_7541_Name = {
    Text = "verzweigter Pfad"
  },
  Event_7542_ChoiceDesc1 = {
    Text = "[Lobe es]Wähle eine aus 3 Befehlskarten und erhalte ein Gebet:“(EnchantConfig.Arg1)“"
  },
  Event_7542_ChoiceDesc2 = {
    Text = "[Ihn verspotten]infiziert „(Skill.Arg1)“, druckt neu, maximal 2 Mal durchführen"
  },
  Event_7542_Desc = {
    Text = "Das Gehirn sagt: Die Ketten haben mein Frontalhirn, meinen Hirnstamm und meine Großhirnrinde gefangen, aber sie können über 10 Milliarden kleine Zellen, die nach Wahrheit streben, nicht fesseln. \n Du sagst: Wer hat dich hier eingesperrt? Wo ist dein Körper? \n Das Gehirn sagt: Körper? Mach keinen Scherz. Früher nannten sie mich “der alte Johnny, der Schweinefleisch verkauft“. \n Als ich noch einen Körper hatte, konnte ich nicht einmal einfache Additionen und Subtraktionen im Zehnerbereich verstehen. \n Aber nachdem der Direktor meinen überflüssigen Körper entfernt hat, schau, was ich geworden bin! Ein Physiker, ein Philosoph und ein Amateurpoet."
  },
  Event_7542_Name = {
    Text = "Philosophisches Gehirn"
  },
  Event_7543_ChoiceDesc1 = {
    Text = "[Beweise die Goldbachschen Vermutung]Erhalte das Silberrelikt“(RelicConfig.Arg1)“"
  },
  Event_7543_ChoiceDesc2 = {
    Text = "[Der Endpunkt der Reise]erhalte zufällig 1 Karte und ein Gebet:“(EnchantConfig.Arg1)“"
  },
  Event_7543_ChoiceDesc3 = {
    Text = "[Weigere dich zu fragen] erhält +50 das schwarze Siegel"
  },
  Event_7543_Desc = {
    Text = "Als Du das Spiritismus-Tablet aufnimmst, drang die Stimme einer jungen Frau in dein Gehirn.\n„Frag mich, ich weiß alles.“\n„Aus meiner Antwort wirst Du das Geschenk des Schicksals erhalten.“"
  },
  Event_7543_Name = {
    Text = "Ouija-Brett"
  },
  Event_7544_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7544_Desc = {
    Text = "Du liest die zerfetzten, beschädigten Seiten, fragmentierte Sätze kommen aus deinem Mund,“Ahnen“、“Heiliger Sohn“、“Ewiger Tod“、“Lange Erinnerung“und andere Begriffe fluten dein Gehirn und reizen deine ohnehin schon durch Albträume empfindlichen Nerven"
  },
  Event_7544_Name = {
    Text = "Geheimer Befehl · Oben"
  },
  Event_7545_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7545_Desc = {
    Text = [[
Schwarzer Schlamm tropfte auf dein Gesicht und verursachte ein kribbelndes Jucken.
Du konntest es nicht ertragen und schlugst nach dem Schmetterling.
Der Schmetterling entkam deiner feindseligen Bewegung und verschwand lautlos in der Ferne]]
  },
  Event_7545_Name = {
    Text = "Schwarze Flüssigkeitsfalter"
  },
  Event_7546_ChoiceDesc1 = {
    Text = "[Verlassen]Suche Scheinwerfer"
  },
  Event_7546_ChoiceDesc2 = {
    Text = "[In den Nebel eindringen]Verliere Arg2 Leben"
  },
  Event_7546_ChoiceDesc3 = {
    Text = "[Direkt betreten]"
  },
  Event_7546_Desc = {
    Text = "Vor uns liegt ein dichter schwarzer Nebel, ein unvorsichtiger Eintritt wird zu Katastrophen führen.\nVielleicht solltest du \"Die Scheinwerfer\" finden, um den Nebel zu vertreiben"
  },
  Event_7546_Name = {Text = "unbekannt"},
  Event_7547_ChoiceDesc1 = {
    Text = "[Trugbild annehmen] Wähle 1 von 3 Befehlskarten aus, die das Gebet erhält: „(EnchantConfig.Arg1)\", infiziert „(Skill.Arg2)\""
  },
  Event_7547_ChoiceDesc2 = {
    Text = "[Illusion verleugnen]erhält Silberrelikt „(RelicConfig.Arg1)“, infiziert „(Skill.Arg2)“"
  },
  Event_7547_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte 25 schwarze Siegel"
  },
  Event_7547_Desc = {
    Text = "Unter der schweren, dunklen Eisenbrücke, am stillen Ufer mit Schilfrohr, fliegt plötzlich ein leuchtender Schmetterling heraus. \n Der Schmetterling landet sanft in deiner Handfläche, das schreckliche Geschrei verstummt und wird ersetzt durch den gleichmäßigen Gesang der Arbeiter, die Stahlträger transportieren, das Klopfen der Nagelköpfe und das klare metallische Geräusch der Nietverbindungen..."
  },
  Event_7547_Name = {
    Text = "Illusion der Stahlbrücke"
  },
  Event_7548_ChoiceDesc1 = {
    Text = "[vertreibe die Krähen]Erhalte 40 schwarze Siegel, Infektion“(Skill.Arg2)“，weiter wählen"
  },
  Event_7548_ChoiceDesc2 = {
    Text = "[Weiter das Kind verfolgen]Erhalte 25 schwarze Siegel, verlasse"
  },
  Event_7548_Desc = {
    Text = "Eine Krähe steht an der Deckenlampe. \n Zwei Krähen stehen an der Deckenlampe. \n Drei Krähen stehen an der Deckenlampe. \n ... \n Diese pechschwarzen Wesen verdrehen ihre Hälse und stehen an der Deckenlampe am Ende der Gasse, während sie dich mit böswilligen Blicken anstarren. Die schattenhaften Köpfe scheinen denselben in A-Schleim getauchten Körper zu teilen."
  },
  Event_7548_Name = {
    Text = "Schwarze Krähe Blick"
  },
  Event_7549_ChoiceDesc1 = {
    Text = "[Verlassen]Hast du weniger als 3 erwachte Erwecker, erhalte Silberrelikt“(RelicConfig.Arg1)“"
  },
  Event_7549_ChoiceDesc2 = {
    Text = "[Verlassen]Hast du mindestens 3 erwachte Erwecker, erhalte ein goldenes Relikt“(RelicConfig.Arg1)“"
  },
  Event_7549_Desc = {
    Text = "Du beachtest die Spur nicht und gehst weiter.\n<Italic:Das Erwachen des Geistes ist schwer>, die Spur wird größer und windet sich, als könnte eine Hand dich in die Tiefe ziehen"
  },
  Event_7549_Name = {
    Text = "Kriechender Riss"
  },
  Event_7550_ChoiceDesc1 = {
    Text = "[Blick erwidern]erhalte das goldene Relikt „(RelicConfig.Arg1)“, Infektion „(Skill.Arg2)“"
  },
  Event_7550_ChoiceDesc2 = {
    Text = "[Wende dich vom Blick ab]Wache zufällig 2 Erwecker auf，infiziere zweimal“(Skill.Arg1)“"
  },
  Event_7550_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte 50 schwarze Siegel"
  },
  Event_7550_Desc = {
    Text = "Du spürst einen Blick, eine Anschauung, die jenseits der Dimensionen und weit über den Bereich hinaus schaut, fixiert auf dich und das Mädchen vor dir. \nDein Atem wird schneller, und in den tiefsten Teilen deines Verstandes beginnt primitive Angst zu schreien"
  },
  Event_7550_Name = {Text = "Wer blickt"},
  Event_7551_ChoiceDesc1 = {
    Text = "[Weiter suchen]Erhöhe Arg1 Leben, infiziere“(Skill.Arg2)“"
  },
  Event_7551_ChoiceDesc2 = {
    Text = "[Verlassen]"
  },
  Event_7551_Desc = {
    Text = "Ein schwaches Licht erscheint vor deinen Augen, hell und warm, aber als du ihm folgen willst, verschwindet es plötzlich"
  },
  Event_7551_Name = {
    Text = "Abnormale Verbindung"
  },
  Event_7552_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7552_Desc = {
    Text = "Leise im Einklang mit ihrem Gesang, bringt dir der warme Wasserstrom den Segen der Heimkehr"
  },
  Event_7552_Name = {Text = "Meereslied"},
  Event_7553_ChoiceDesc1 = {
    Text = "[Bestätigen]"
  },
  Event_7553_Desc = {
    Text = "Du siehst ein schwaches Licht vor dir und durchbrichst endlich den erstickenden Nebel"
  },
  Event_7553_Name = {Text = "Chaosnebel"},
  Event_7554_ChoiceDesc1 = {
    Text = "[Untere Zweige lösen]"
  },
  Event_7554_Desc = {
    Text = "Die verbleibenden Gnosis aus dem Bereich verweben sich und bilden ein instabiles Kraftfeld.\nVielleicht kannst du die verknäuelte Seele lösen, um dir den Weg nach vorne zu ebnen"
  },
  Event_7554_Name = {
    Text = "Verflochtener Pfad"
  },
  Event_7555_ChoiceDesc1 = {
    Text = "[Obere Zweige lösen]"
  },
  Event_7555_Desc = {
    Text = "Die verbleibenden Gnosis aus dem Bereich verweben sich und bilden ein instabiles Kraftfeld.\nVielleicht kannst du die verknäuelte Seele lösen, um dir den Weg nach vorne zu ebnen"
  },
  Event_7555_Name = {
    Text = "Verflochtener Pfad"
  },
  Event_7556_ChoiceDesc1 = {
    Text = "[Linke Zweige lösen]"
  },
  Event_7556_Desc = {
    Text = "Die verbleibenden Gnosis aus dem Bereich verweben sich und bilden ein instabiles Kraftfeld.\nVielleicht kannst du die verknäuelte Seele lösen, um dir den Weg nach vorne zu ebnen"
  },
  Event_7556_Name = {
    Text = "Verflochtener Pfad"
  },
  Event_7557_ChoiceDesc1 = {
    Text = "[Linke Zweige lösen]"
  },
  Event_7557_Desc = {
    Text = "Die verbleibenden Gnosis aus dem Bereich verweben sich und bilden ein instabiles Kraftfeld.\nVielleicht kannst du die verknäuelte Seele lösen, um dir den Weg nach vorne zu ebnen"
  },
  Event_7557_Name = {
    Text = "Verflochtener Pfad"
  },
  Event_7558_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7558_Desc = {
    Text = "Ihr steht noch vor vielen Kämpfen, jetzt ist nicht die Zeit für gemütliche Untersuchungen"
  },
  Event_7558_Name = {
    Text = "Organregistrierung"
  },
  Event_7559_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7559_Desc = {
    Text = "Die Zeichen auf dem Papier wurden plötzlich vollständig und lebendig, und die erschreckenden Worte waren genug, um den Glauben und die Grundlagen aller unbewussten Leidenden zu erschüttern. Je mehr du liest, desto verwirrender und angsterfüllter wirst du, und du kannst nicht anders, als mit den Fingern über deine Kopfhaut zu kratzen. \nPlötzlich verschwanden die mit Flüchen gefüllten Symbole. Ramona unterbrach dein Lesen und stopfte die Seiten gewaltsam in den Koffer."
  },
  Event_7559_Name = {
    Text = "Geheimer Befehl · Unten"
  },
  Event_7560_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7560_Desc = {
    Text = "Freude, Trauer, Kummer, Verzweiflung... all das sind deine Gefühle.\nDu und unzählige andere Versionen von dir in anderen Dimensionen"
  },
  Event_7560_Name = {Text = "Sucht"},
  Event_7561_ChoiceDesc1 = {
    Text = "[Still zuhören] Wähle 1 von 3 Befehlskarten aus, die das Gebet erhält: „(EnchantConfig.Arg1)\", infiziert „(Skill.Arg2)\""
  },
  Event_7561_ChoiceDesc2 = {
    Text = "[Sie ist hier] Wähle 1 von 3 Befehlskarten aus, die das Gebet erhält: „(EnchantConfig.Arg1)\", infiziert „(Skill.Arg2)\""
  },
  Event_7561_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte 25 schwarze Siegel"
  },
  Event_7561_Desc = {
    Text = "Das Wehklagen des Monsters hallte in deinem Kopf wider, in der formlosen schwarzen Flüssigkeit flüsterte eine schwache Stimme „Sasa-Schwester“, „Sasa-Schwester“.\n„Sasa-Schwester, wo bist du?“"
  },
  Event_7561_Name = {
    Text = "“Sasa-Schwester“"
  },
  Event_7562_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7562_Desc = {
    Text = "“Schließe dich ihm an, schließe dich ihnen an, schließe dich uns an. \n Werde sein Wächter, werde sein Executor. \n Lass seine Träume deine Richtung vorgeben...“ \n Das chaotische Gebet verwirrt dein Bewusstsein, und erst als die Stimmen verstummen, bemerkst du, dass du bereits schweißgebadet bist."
  },
  Event_7562_Name = {Text = "Traumgebet"},
  Event_7563_ChoiceDesc1 = {
    Text = "[Nie gehört]"
  },
  Event_7563_ChoiceDesc2 = {
    Text = "[Schon gehört]"
  },
  Event_7563_Desc = {
    Text = "“Entschuldigung, darf ich kurz stören?\nIch möchte euch ein paar Minuten in Anspruch nehmen, um euch lokale Legenden zu erzählen.\nHabt ihr schon von einem Wesen namens 'Kerberos' gehört?“"
  },
  Event_7563_Name = {
    Text = "Seltsamer Begleiter I"
  },
  Event_7564_ChoiceDesc1 = {
    Text = "[Gib das Denken auf]erhalte ein verfluchtes Relikt“(RelicConfig.Arg1)“，infiziere“(Skill.Arg2)“"
  },
  Event_7564_ChoiceDesc2 = {
    Text = "[Einblick einholen] Eine zufällige Befehlskarte erhält das Gebet: [(EnchantConfig.Arg1)]"
  },
  Event_7564_Desc = {
    Text = "Ein ANG auf den Hafen, ein mysteriöser Frachter ohne Rückkehr und neue „Freunde“ mit Flossen... Ist das eine sorgfältig geplante Falle oder nur eine weitere unvorhersehbare Reise?\nRealität und Vernunft zerren aneinander, unzählige Inspirationen und Gedanken strömen aus dem Kopf"
  },
  Event_7564_Name = {
    Text = "Inspirationsschub"
  },
  Event_7565_ChoiceDesc1 = {
    Text = "[Elworths Vulkan?]Erhöhe Arg1 maximale Gesundheit"
  },
  Event_7565_ChoiceDesc2 = {
    Text = "[Angestrengt erinnern] Wähle 1 von 3 Befehlskarten aus, um ein Gebet zu erhalten: „(EnchantConfig.Arg1)\", infiziere „(Skill.Arg2)\""
  },
  Event_7565_Desc = {
    Text = "Lilys Wangen liefen schwarze Tränen hinunter. “Wir haben uns gesehen, Mama,“ flüsterte sie leise, “in dem Vulkan von Aelwys...“"
  },
  Event_7565_Name = {
    Text = "Vulkanische Erinnerung"
  },
  Event_7566_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7566_Desc = {
    Text = "“Tauch@1... ins Meer......“\n Die Runen erscheinen vor deinen Augen, scheinen zu verschwinden und wieder aufzutauchen, und du kannst nicht anders, als in die Leere zu greifen, um sie zu ergreifen—\n “Was starrst du so! Sie kommen gleich näher!“ \n Das mysteriöse Mädchen zieht dich zur anderen Seite des Decks, unterbricht damit deine Verbindung zu den Runen. \n Aber es gibt tatsächlich eine Kraft, die Spuren an deinen Fingerspitzen hinterlässt."
  },
  Event_7566_Name = {Text = "Rune Wahn"},
  Event_7567_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7567_Desc = {
    Text = "Du bist von diesen mystischen Gerede nicht beeindruckt und willst keine Risiken eingehen, die dein Verstand zerrütten könnten"
  },
  Event_7567_Name = {
    Text = "Ein Hilferuf"
  },
  Event_7568_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7568_Desc = {
    Text = "Egal was, die Pflicht des Hüters wächst in dir. Du darfst die Hoffnung nicht aufgeben, den Absender zu finden, auch wenn es unklar ist"
  },
  Event_7568_Name = {
    Text = "Ein Hilferuf"
  },
  Event_7569_ChoiceDesc1 = {
    Text = "[Beobachte es]Erhalte 25 schwarze Siegel"
  },
  Event_7569_ChoiceDesc2 = {
    Text = "[Streicheln sie] 50% Chance auf +50 das schwarze Siegel, 50% Chance nichts"
  },
  Event_7569_Desc = {
    Text = "Plötzlich springt eine schwarze Katze aus der Gasse und schmiegt sich auf ungewöhnlich vertraute Weise an eure Füße. Ihre leuchtend grünen, schmalen Pupillen blitzen mit einem unheimlichen Licht, als würde sie sagen: “Hör auf zu verfolgen, spiel eine Weile mit mir.“\n “Du hast ihn bereits gesehen, er ist direkt neben dir, die von Wahnsinn verschmutzten, fanatischen Schatten... Schau nicht direkt auf seine Silhouette.“"
  },
  Event_7569_Name = {Text = "Nachtelf"},
  Event_7570_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7570_Desc = {
    Text = "“Unmöglich, ich glaube es nicht!“ schrie die Stimme, “Diese Frau, die mich dem Teufel übergab, ist nicht meine Schwester Sasha!“"
  },
  Event_7570_Name = {
    Text = "“Sasa-Schwester“"
  },
  Event_7571_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7571_Desc = {
    Text = "“Empfangen, wir werden die Grundlagenlieferung durchführen, bitte achtet auf den Empfang。“"
  },
  Event_7571_Name = {
    Text = "Unterstützungskommunikation"
  },
  Event_7572_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7572_Desc = {
    Text = "Unbrauchbar"
  },
  Event_7572_Name = {
    Text = "Vorherige Hinterlassenschaften"
  },
  Event_7573_ChoiceDesc1 = {
    Text = "[Detailliert ansehen]Erhalte 3 aus 1 Orison"
  },
  Event_7573_ChoiceDesc2 = {
    Text = "[Plakat abreißen] Eine zufällige Befehlskarte erhält das Gebet: „(EnchantConfig.Arg1)\", infiziert „(Skill.Arg2)\""
  },
  Event_7573_Desc = {
    Text = "Ein überall im Wachsfigurenkabinett zu findender Kerzenhalter.\nIm krankenhaften orangefarbenen Licht entdeckst du ein handgezeichnetes Plakat an der Wand"
  },
  Event_7573_Name = {
    Text = "Lachen in der Dunkelheit"
  },
  Event_7574_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7574_Desc = {
    Text = "“Lily hat ihr eigenes Herz, sie muss niemandem gehorchen.“ antwortest du selbstbewusst.\nFrancis schnaubt verächtlich, ohne zu antworten"
  },
  Event_7574_Name = {Text = "Ihre Wahl"},
  Event_7575_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7575_Desc = {
    Text = "Dies ist eine Gruppe von Gruppenfotos.\nDie lustlosen Menschen hocken hinter dem Eisenzaun und sehen voller Qual aus.\nEin Foto zieht deine Aufmerksamkeit auf sich. Es muss sich um eine dünne junge Frau handeln, deren Gesicht leer ist.\nDas unendlich verfluchte Geschöpf umschlingt sich immer wieder um ihren Körper.\nDu kannst ihr Gesicht nicht sehen, aber in deiner Vorstellung sollte sie ausdruckslos sein."
  },
  Event_7575_Name = {
    Text = "wie es ist, aufzeichnen"
  },
  Event_7576_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7576_Desc = {
    Text = "Du starrst wie gebannt auf das glitzernde Schmuckstück, und ehe Du es bemerkst, hast Du bereits die dürre, schwarze, schleimige Hand ergriffen.\nSie drückt die Hand nur leicht zusammen und lässt sie dann wieder los.\nNichts geschieht, nur ein Hauch schwarzen Nebels gleitet an Deinen Fingerspitzen entlang in den Ärmel."
  },
  Event_7576_Name = {
    Text = "Verwirrende Teufelklauen"
  },
  Event_7577_ChoiceDesc1 = {
    Text = "[Mache ein paar Töne]erhalte das silberne Relikt“(RelicConfig.Arg1)“、infiziere“(Skill.Arg2)“"
  },
  Event_7577_ChoiceDesc2 = {
    Text = "[Den Deckel schließen]erhalte 3 Auswahlen für das Gotteszeichen"
  },
  Event_7577_Desc = {
    Text = "Das Klavier an der Wand steht offen. Es hat vergilbte Tasten und rissige Kanten, die das Holz freilegen, aber jede Taste ist sehr sauber.\nEs ist die Quelle der Freude für so viele"
  },
  Event_7577_Name = {
    Text = "Kindheitsmelodie"
  },
  Event_7578_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7578_Desc = {
    Text = "Der Speerträger gibt ein leises Stöhnen von sich, als wäre er ein schikaniertes Kind, das schluchzt.\nDer Klang verweht sofort, und auch die anderen beiden Seefahrer verschwinden ohne Spur... es war nur eine Illusion, die im Bereich reflektiert wurde"
  },
  Event_7578_Name = {
    Text = "nicht aufgeben"
  },
  Event_7579_ChoiceDesc1 = {
    Text = "[Verlassen]Erhalte Silberrelikt“(RelicConfig.Arg1)“"
  },
  Event_7579_Desc = {
    Text = "„Richtig.\"\nDer Besitzer der Stimme war sehr zufrieden mit dieser Antwort, ein glänzendes Objekt wurde aus dem Wasser geworfen.\n„Denke daran, alles hat seinen Preis.\""
  },
  Event_7579_Name = {
    Text = "Stimmen aus dem Jenseits"
  },
  Event_7580_ChoiceDesc1 = {
    Text = "[Vertreibe die Illusion]Infiziere Symptom"
  },
  Event_7580_ChoiceDesc2 = {
    Text = "[Verlassen]"
  },
  Event_7580_Desc = {
    Text = "Verschwommene Gesichter tauchen plötzlich auf, umgeben dich und stöhnen verzweifelt ohne Stimmbänder"
  },
  Event_7580_Name = {Text = "Illusion"},
  Event_7581_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7581_Desc = {
    Text = "Du beachtest die Spur nicht und gehst weiter.\nDoch sie scheint wütend zu werden, wird größer und windet sich, als könnte eine Hand dich in die Tiefe ziehen"
  },
  Event_7581_Name = {
    Text = "Kriechender Riss"
  },
  Event_7582_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7582_Desc = {
    Text = "Du wirst nicht leicht getäuscht und drehst dich entschlossen um und gehst"
  },
  Event_7582_Name = {
    Text = "Kriechender Riss"
  },
  Event_7583_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7583_Desc = {
    Text = "Du bemerkst die ungewöhnliche Rissbildung, kniest dich hin, um sie zu untersuchen. Seltsamerweise, der Riss, der sich gerade noch ausbreitete, ist plötzlich wie tot und in ewiger Stille verharrt"
  },
  Event_7583_Name = {
    Text = "Kriechender Riss"
  },
  Event_7584_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7584_Desc = {
    Text = "“Nein, es ist ein klarer Verstand. Entschlossenheit kann dir nicht helfen, den Aufgelösten Körper, den Hüter, zu lösen. Denk sorgfältig über deine Strategie nach.“"
  },
  Event_7584_Name = {
    Text = "Logans Regel"
  },
  Event_7585_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7585_Desc = {
    Text = "Du kannst dem Drang in deinem Inneren nicht widerstehen. \n Deine Finger wandern und spielen wie ein verlorenes Kind im Wald über die Tastatur... \n Allmählich fliegen Schmetterlinge aus der Schreibmaschine. \n Eins, zwei, drei... \n Auf deinem Gesicht und deinen Fingern, Schmetterlinge wie Feuerwerk am Himmel, leuchten wie Edelsteine im Dunkeln. \n Diese Schreibmaschine hat keinen praktischen Nutzen, aber sie ist ein Meister der Schönheit."
  },
  Event_7585_Name = {Text = "Auge"},
  Event_7586_ChoiceDesc1 = {
    Text = "[Henne anbinden]"
  },
  Event_7586_Desc = {
    Text = "Spezialität aus Lai, lebendige Hühner, eine kulinarische Verlockung"
  },
  Event_7586_Name = {
    Text = "Falle herstellen"
  },
  Event_7587_ChoiceDesc1 = {Text = "[Erledigt]"},
  Event_7587_Desc = {
    Text = "Billige, aber effektive Fallen!"
  },
  Event_7587_Name = {
    Text = "Falle herstellen"
  },
  Event_7588_ChoiceDesc1 = {
    Text = "[Freigeben von Fallen]"
  },
  Event_7588_Desc = {
    Text = "Metallfalle, der faule Jäger's Helfer"
  },
  Event_7588_Name = {
    Text = "Falle herstellen"
  },
  Event_7589_ChoiceDesc1 = {
    Text = "[Überprüfe den Telegraphen]Infiziere „(Skill.Arg1)“, erhalte ein goldenes Relikt „(RelicConfig.Arg2)“"
  },
  Event_7589_ChoiceDesc2 = {
    Text = "[Ignoriere]erhalte 50 das schwarze Siegel"
  },
  Event_7589_Desc = {
    Text = "Du versteckst dich in einer schmalen Felsspalte, um dem Schneesturm zu entkommen. Aber du weißt, dass du hier nicht lange bleiben kannst, wenn die schwarz gekleideten Kreaturen dich finden, gibt es kein Entkommen.\nIn der Ecke der Spalte entdeckst du ein Telegrafengerät"
  },
  Event_7589_Name = {
    Text = "Stummes Telegramm"
  },
  Event_7590_ChoiceDesc1 = {
    Text = "[Überprüfe den Film]Zufällig den Effekt von 2 Karten aufwerten"
  },
  Event_7590_ChoiceDesc2 = {
    Text = "[Überprüfe die Kamera]Wähle 1 von 3 Befehlskarten und erhalte ein Gebet: „(EnchantConfig.Arg1)“"
  },
  Event_7590_Desc = {
    Text = "Wie bei einem herausgerissenen inneren Organ wird der Film im Bauch der Kamera zerfetzt und hier liegengelassen, ohne dass sich jemand darum kümmert. \n Ein grelles weißes Licht blitzt auf, die an der Straßenecke zurückgelassene Kamera ist schief und der Verschluss wird willkürlich betätigt. \n “Klick—“ \n Dein verwunderter, perplexer Ausdruck wird treu auf dem Film in der Kamera festgehalten."
  },
  Event_7590_Name = {
    Text = "Rekord unschuldig"
  },
  Event_7591_ChoiceDesc1 = {
    Text = "[Sängerin am Hals packen]erhalte verfluchtes Relikt „(RelicConfig.Arg1)“, infektiere „(Skill.Arg2)“"
  },
  Event_7591_ChoiceDesc2 = {
    Text = "[Den Schritt des Tänzers stolpern lassen] Wähle 1 von 3 Befehlskarten aus, um das Gebet zu erhalten: [(EnchantConfig.Arg1)]"
  },
  Event_7591_ChoiceDesc3 = {
    Text = "[Poetisches Papier entziehen]du erhälst 50 das schwarze Siegel"
  },
  Event_7591_Desc = {
    Text = "Drei klebrige Gestalten versperren dir den Weg. \n Eine Gestalt singt ein Lied, die Stimme krächzend, die Texte seltsam, du hältst dir die Ohren zu und umgehst sie. \n Eine Gestalt tanzt, die Bewegungen steif, die Schritte zögerlich, du schließt die Augen und weicht ihr aus. \n Eine Gestalt rezitiert Gedichte, der Rhythmus bricht, die Sätze sind unverständlich, du kannst es nicht länger ertragen, also—"
  },
  Event_7591_Name = {
    Text = "Schurke auf dem schmalen Pfad"
  },
  Event_7592_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7592_Desc = {
    Text = "“Nein! Der Fortschritt der Menschheit beruht nicht auf Geschichte oder Technologie, sondern auf den Ratten.“\n“Es waren die Ratten, die diese dunkle Ära einleiteten, und erst danach erlebte die Menschheit das Licht der Wiedergeburt.“\n“Die Menschheit braucht euch – obwohl nicht jeder das versteht.“\nDie Ratten waren durch deine lange Rede etwas verwirrt, ließen dich aber trotzdem gehen."
  },
  Event_7592_Name = {Text = "Pest"},
  Event_7593_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7593_Desc = {
    Text = "Du unterdrückst das Zucken deiner Sehnerven und versuchst mühevoll zu erkennen...\nDort scheint ein bereits zerrissener, runder magischer Zirkel gezeichnet zu sein.\nDer Zirkel besteht aus zahllosen Bögen, die statisch wirken und gleichzeitig zu fließen scheinen, was einen schwindelig macht"
  },
  Event_7593_Name = {Text = "von Winkel"},
  Event_7594_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7594_Desc = {
    Text = "<Bold:Wachsfigurenkabinett Rogers\nSouthwark Street 44, Lentiniens Stadt@2Bezirk\nBesuchszeiten: 21:00-6:00\nEinlass bis 3:00 (Wochenende geschlossen)\n\n<Bold:Aktuelle Ausstellung\nWladimir@2:\nDie Philosophie des Lächelns"
  },
  Event_7594_Name = {
    Text = "Lachen in der Dunkelheit"
  },
  Event_7595_ChoiceDesc1 = {
    Text = "[Augen begegnen]wähle eine von 3 Befehlskarten und erhalte das Gotteszeichen: „(EnchantConfig.Arg1)“, Infektion „(Skill.Arg2)“"
  },
  Event_7595_ChoiceDesc2 = {
    Text = "[Augen schließen]Wähle 1 Erwecker und infiziere „(Skill.Arg1)“"
  },
  Event_7595_ChoiceDesc3 = {
    Text = "[Wende dich ab]Erhalte 25 schwarze Siegel"
  },
  Event_7595_Desc = {
    Text = "Es hätte nicht den Anschein haben sollen, als ob man den Sternenhimmel sieht. \n Im Geheimgang der Sonanir strahlt der Himmel in prunkvollem Licht, und die Gestalten von Sternen und Mond sind verborgen. \n In der dunklen Kabine solltest du auch den Sternenhimmel nicht sehen. \n Hier sollten nur vereinzelte Glühbirnen und alte Laternen sein - aber warum hast du dennoch den Blick des hoch oben schwebenden Himmels gespürt?"
  },
  Event_7595_Name = {Text = "spähen"},
  Event_7596_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7596_Desc = {
    Text = "Du wählst, den Augen mutig ins Gesicht zu sehen. \n Sie sind strahlende Sterne, die im Dunkeln funkeln. \n Dann lachen sie und verwandeln sich in unzählige gebogene Monde. \n Die Augen sagen: „Du fürchtest dich nicht vor dem Blick. Du solltest auch nicht fürchten... lange nicht gesehen, @2.” \n Bevor sie verschwinden, schenken sie dir ein kleines Geschenk als „Erinnerung an das Wiedersehen“."
  },
  Event_7596_Name = {Text = "Auge"},
  Event_7597_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7597_Desc = {
    Text = "Die Eisenbahnbrücke, Lentiniëns Adern und Nerven, verbindet das Herz und die Gliedmaßen der Stadt. Solange die Sonne hier nicht untergeht, wird Lentiniëns Herz immer leidenschaftlich schlagen."
  },
  Event_7597_Name = {
    Text = "Illusion der Stahlbrücke"
  },
  Event_7598_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7598_Desc = {
    Text = "Eine überaus prachtvolle Fuge, der Komponist ist unbekannt.\nZahlreiche Stimmen mit ähnlichen Themen verweben sich; jede Note ist so präzise und eiskalt wie das Skalpell eines Chirurgen.\nPräzise und prachtvoll - das ist Rogers Ästhetik.\nFuga, flieg!"
  },
  Event_7598_Name = {
    Text = "schlechter Geschmack"
  },
  Event_7599_ChoiceDesc1 = {
    Text = "[Begrüßende Stimme]"
  },
  Event_7599_ChoiceDesc2 = {
    Text = "[Hilfe suchen]"
  },
  Event_7599_Desc = {
    Text = "In dem Moment, als du dich an die Reling der Schiffwand lehnst, siehst du ein Mädchen im weißen Kleid. \n Erhaben, heilig, illusorisch... und irgendwie vertraut. \n Wo hast du sie nur schon einmal gesehen? Du versuchst mühsam, die chaotischen Erinnerungen zu durchforsten, doch sie scheint plötzlich deine Existenz wahrzunehmen und schaut dich durch den Raum an. \n Ihre Augen sind so ruhig wie der Ozean im Frühling, doch du liest seltsamerweise etwas darin... \n Sie scheint darauf zu warten, dass du sie begrüßt, selbst wenn es nur ein Gespräch über das Wetter heute ist."
  },
  Event_7599_Name = {
    Text = "Mädchen im weißen Kleid"
  },
  Event_7600_ChoiceDesc1 = {
    Text = "[Lobe es]Wähle eine aus 3 Befehlskarten und erhalte ein Gebet:“(EnchantConfig.Arg1)“"
  },
  Event_7600_ChoiceDesc2 = {
    Text = "[Ihn verspotten]infiziert „(Skill.Arg1)“, erneut zufällig drucken"
  },
  Event_7600_Desc = {
    Text = "Jenkins sagte: Johnny! Du bist wirklich ... ganz anders als früher, egal aus welcher Perspektive. \n Du sagst: Du bist wirklich ein fleißiger und zielstrebiger Kopf. \n Der Kopf zappelte ein wenig, offensichtlich sehr erfreut. \n Der Kopf sagte: Komm schon! Da ihr meine derzeitigen Errungenschaften so anerkennt, werde ich euch mein Lebenswissen verleihen..."
  },
  Event_7600_Name = {
    Text = "Philosophisches Gehirn"
  },
  Event_7601_ChoiceDesc1 = {
    Text = "[Prachtvolle Fuge]erhält Silberrelikt „(RelicConfig.Arg1)“, infiziert „(Skill.Arg2)“"
  },
  Event_7601_ChoiceDesc2 = {
    Text = "[Einfache Serenade]Alle Erwachten regenerieren 50 Wahnsinn, infiziere“(Skill.Arg1)“"
  },
  Event_7601_ChoiceDesc3 = {
    Text = "[Sinnloses Geräusch]Erhalte 3-wählen-1 Gebet"
  },
  Event_7601_Desc = {
    Text = "“Ich persönlich stimme dem Musikgeschmack des Direktors nicht zu, du verstehst schon...\nDas ist viel zu extravagant, und ich bin ein bodenständiger Mensch.“\nAus dem knarrenden Phonographen ertönt die müde Stimme eines Mannes, der einsam klagt.\n“Aber das ist mein Job... Gut, lass uns Zeit sparen und eine Platte auswählen.“"
  },
  Event_7601_Name = {
    Text = "schlechter Geschmack"
  },
  Event_7602_ChoiceDesc1 = {
    Text = "[Ein besonderes Relikt, Erhalte ein goldenes Relikt „(RelicConfig.Arg1)“]"
  },
  Event_7602_ChoiceDesc2 = {
    Text = "[Verlassen]Erhalte 50 schwarze Siegel"
  },
  Event_7602_Desc = {
    Text = "Ereignis 253 (in Entwicklung), nicht das Endergebnis"
  },
  Event_7602_Name = {
    Text = "Ereignis 253 (in Entwicklung)"
  },
  Event_7603_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7603_Desc = {
    Text = "Du rennst so schnell du kannst von der Szene weg. \n Jetzt steht ihr dem hartnäckigsten und widerlichsten Monster gegenüber, das es je gab – diesen ganzen Wachsfiguren. \n Im Vergleich zu ihnen sind diese einfachen Tonklumpen wirklich nicht der Rede wert. \n Alles hat seine Prioritäten – das ist eines der Prinzipien, die ein Schutzherr befolgen sollte."
  },
  Event_7603_Name = {Text = "Übung"},
  Event_7604_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7604_Desc = {
    Text = "Der Silberschlüssel blitzt; der silberne Glanz erfüllt den Raum und verwandelt die dicke, fließende Farbe in reines Silber.\nDas Licht vergeht im Nu, nur der Wind hinterlässt das traurige Wehklagen"
  },
  Event_7604_Name = {
    Text = "Nostalgische Farben"
  },
  Event_7605_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7605_Desc = {
    Text = "Das schillernde Licht betört dich, und ohne es zu merken, verlierst du dich darin..."
  },
  Event_7605_Name = {
    Text = "Sternenkreuz"
  },
  Event_7606_ChoiceDesc1 = {
    Text = "[Weiter fallen]Infiziere“(Skill.Arg1)“, weiter fallen?"
  },
  Event_7606_ChoiceDesc2 = {
    Text = "[Zieh dich zurück] erhält +25 das schwarze Siegel"
  },
  Event_7606_Desc = {
    Text = "“Du“ lädt dich ein.\nIn den Tiefen der Spirale senden dir die „Du“ aus Vergangenheit und Zukunft Geschenke aus verschiedenen Dimensionen"
  },
  Event_7606_Name = {
    Text = "Spiralabgrund"
  },
  Event_7607_ChoiceDesc1 = {
    Text = "[Verstanden]Erhalte ein goldenes Relikt:“(RelicConfig.Arg1)“、Infektion“(Skill.Arg2)“"
  },
  Event_7607_ChoiceDesc2 = {
    Text = "[Ich weiß nichts]Erhalte 1 aus 3 goldene Relikte, infiziere“(Skill.Arg1)“"
  },
  Event_7607_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte Silberrelikt“(RelicConfig.Arg1)“"
  },
  Event_7607_Desc = {
    Text = "Zwei silberne, leuchtende Silhouetten erscheinen vor deinen Augen, sie nehmen eine dichte, flüssige Form an und schweben in der Luft. \n“Hier ist der Ort, an dem ich vergehen werde.“Eine Silhouette kniete sich nieder. \n“Im göttlichen Reich ohne Krankheit und Leid gibt es kein Verlangen und keinen Verlust, du weißt nicht wirklich, was es bedeutet, zu vergehen.“\n Die andere Silhouette seufzte und wandte ihren Blick dir zu."
  },
  Event_7607_Name = {
    Text = "Vergessenes Götterreich"
  },
  Event_7608_ChoiceDesc1 = {
    Text = "[Verlassen]Suche Scheinwerfer"
  },
  Event_7608_ChoiceDesc2 = {
    Text = "[In den Nebel eindringen]Infektion“(Skill.Arg2)“"
  },
  Event_7608_ChoiceDesc3 = {
    Text = "[Direkt betreten]"
  },
  Event_7608_Desc = {
    Text = "Vor uns liegt ein dichter schwarzer Nebel, ein unvorsichtiger Eintritt wird zu Katastrophen führen.\nVielleicht solltest du \"Die Scheinwerfer\" finden, um den Nebel zu vertreiben"
  },
  Event_7608_Name = {Text = "unbekannt"},
  Event_7609_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7609_Desc = {
    Text = "“Das ist eine Projektion der Erinnerung,“ erklärte Ramona dir, “es könnte jemandem gehören oder eine gemeinsame Erinnerung mehrerer Personen sein.“\nWertvolle Erinnerungen, die sorgfältig bewahrt werden sollten"
  },
  Event_7609_Name = {
    Text = "Unsere Erinnerungen"
  },
  Event_7610_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7610_Desc = {
    Text = "Selbst wenn du es jetzt nicht entziffern kannst, hast du nicht aufgegeben, sondern es geduldig gefaltet und in deine Tasche gesteckt, um nach der Rückkehr zur Schule nach einer anderen Methode zu suchen, um die Informationen zu lesen. \n Nur, während der Brief auf seltsame Weise zusammengekrümmt wird, beginnt auch deine Brust leicht zu schmerzen."
  },
  Event_7610_Name = {
    Text = "gekritzelter Brief"
  },
  Event_7611_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7611_Desc = {
    Text = "Die Kerze entzündete sich sofort, als sie die Waage verließ, und ließ milchweiße Tränen durch deine Finger tropfen und verschwinden"
  },
  Event_7611_Name = {
    Text = "Vernunft und Gefühl"
  },
  Event_7612_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7612_Desc = {
    Text = "Hastig reißt du das Papier aus der Schreibmaschine—doch sie läuft weiter. In diesem Moment der Panik fällt eine Befehlskarte hinein und wird mit der schwärzesten Tinte unbrauchbar verschmiert.\nDu nimmst dir einen Moment, um sie sorgfältig zu entsorgen, kannst aber nicht umhin, den unheilverkündenden, sich wiederholenden Text zu bemerken, der nun darauf geschrieben steht;\n<Bold:NICHT DIREKT HINSCHAUEN>\n<Bold:NICHT DIREKT HINSCHAUEN>\n<Bold:NICHT DIREKT HINSCHAUEN>\n<Bold:NICHT DIREKT HINSCHAUEN>\n<Bold:NICHT DIREKT HINSCHAUEN>\n<Bold:NICHT DIREKT HINSCHAUEN>\n<Bold:NICHT DIREKT HINSCHAUEN>\n<Bold:NICHT DIREKT HINSCHAUEN>"
  },
  Event_7612_Name = {
    Text = "Ungebetene Warnung"
  },
  Event_7613_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7613_Desc = {
    Text = "Als deine Finger den eiskalten Rand des Bechers berührten, fröstelte es dich und du wurdest wach.\nEgal was, es sollte nicht am Straßenrand liegen. Pack es in den Koffer"
  },
  Event_7613_Name = {Text = "Honigwein"},
  Event_7614_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7614_Desc = {
    Text = "Du hustest heftig.\nDas Geräusch scheint erschrocken zu sein und verstummt.\nDu hast das Gefühl, eine wichtige Spur verpasst zu haben...\nAber das Leben ist voller verpasster Gelegenheiten und Bedauern, nicht wahr?"
  },
  Event_7614_Name = {
    Text = "Wände haben Ohren"
  },
  Event_7615_ChoiceDesc1 = {
    Text = "[Den Mund halten]erhalte 25 das schwarze Siegel"
  },
  Event_7615_ChoiceDesc2 = {
    Text = "[Nach vorne greifen]50% Chance 50 das schwarze Siegel zu erhalten, 50% Chance nichts zu erhalten"
  },
  Event_7615_Desc = {
    Text = "“Ich habe nur ein Wort der Weisheit zu sagen – niemand kann eine Katze töten!“ \n “Die verdammte schwarze Katze hätte aufgeschlitzt und im Freien zur Schau gestellt werden sollen, stattdessen hat sie das Grab meiner Familie aufgebrochen, das verweste menschliche Fleisch wurde von ihr bis auf den letzten Bissen aufgefressen, die Knochen und Gliedmaßen lagen zerstreut herum.“ \n “Unter dem kalten, düsteren Blick der schmalen Pupillen stieg ein übelriechender, dunkler Eiter auf, ich bin davon gerollt und gekrochen, gequält von Albträumen und völlig erschöpft.“ \n “Warte... was wollt ihr tun, ich bin nicht verrückt! Ich bin nicht! Ihr wollt bestimmt etwas vertuschen! Das ist die Wahrheit –“ \n Das ist in der Tat die Wahrheit, während du dem Schatten des Wahnsinnigen nachblickst, blickst du dem schwarzen Kätzchen, das ruhig zu deinen Füßen sitzt, in die Augen."
  },
  Event_7615_Name = {
    Text = "Nachtkatzenfluch"
  },
  Event_7616_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7616_Desc = {
    Text = "Während du zögerst, sinkt es in die Erosionsspuren und verschwindet schnell"
  },
  Event_7616_Name = {
    Text = "Fass mit schwimmenden Gegenständen"
  },
  Event_7617_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7617_Desc = {
    Text = "Du knüllst den Brief genervt zusammen und wirfst ihn zu deinen Füßen"
  },
  Event_7617_Name = {
    Text = "gekritzelter Brief"
  },
  Event_7618_ChoiceDesc1 = {
    Text = "[Bestätigen]"
  },
  Event_7618_Desc = {
    Text = "Du konzentrierst dich, die Illusion zerstreut sich wie Tinte. Du gehst weiter, aber der Schatten in deinem Herzen bleibt"
  },
  Event_7618_Name = {Text = "Illusion"},
  Event_7619_ChoiceDesc1 = {
    Text = "[Vorsichtig ansehen]Erhalte das Silberrelikt“(RelicConfig.Arg1)“，infiziere“(Skill.Arg2)“"
  },
  Event_7619_ChoiceDesc2 = {
    Text = "[Weiche der Silhouette aus]Erhalte Silberrelikt „(RelicConfig.Arg1)“, infiziere „(Skill.Arg2)“"
  },
  Event_7619_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte 25 schwarze Siegel"
  },
  Event_7619_Desc = {
    Text = "Ramona bewegte sich vorsichtig durch die Menschenmengen in der Irrenanstalt.\nSie versteckte sich in einem kleinen Raum.\nPlötzlich erschien eine Gestalt im Fenster"
  },
  Event_7619_Name = {
    Text = "Fensterspiegelung"
  },
  Event_7620_ChoiceDesc1 = {
    Text = "[Verlassen]Erhalte 50 schwarze Siegel"
  },
  Event_7620_Desc = {
    Text = "Jetzt ist es wichtiger, die Urheber dieser Tatsachen vor Gericht zu bringen. Doch der zornige Same keimt und wächst in deinem Herzen. Bevor ihr antworten könnt, dreht der Mann sich um und verlässt den Raum"
  },
  Event_7620_Name = {
    Text = "Riesentierfährte"
  },
  Event_7621_ChoiceDesc1 = {
    Text = "[Verlassen]Erhalte 75 schwarze Siegel, infiziere“(Skill.Arg2)“"
  },
  Event_7621_Desc = {
    Text = "Die Erziehung in Missaga hat dich gelehrt, dieses Abbild nicht zu ignorieren. Du wischtest den Staub und die Fußabdrücke ab, und in diesem Moment hörtest du scheinbar eine Antwort aus einer fernen Dimension: „Danke“"
  },
  Event_7621_Name = {
    Text = "Riesentierfährte"
  },
  Event_7622_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7622_Desc = {
    Text = "Du umklammerst den silbernen Schlüssel, das sanfte Silberlicht und die schwache Vibration geben dir ein Gefühl der Sicherheit. Der Blick scheint verschwunden zu sein, oder auch nicht, aber er hat auf jeden Fall eine unsichtbare Spur auf dir hinterlassen"
  },
  Event_7622_Name = {Text = "Wer blickt"},
  Event_7623_ChoiceDesc1 = {
    Text = "[Geheimgang suchen]"
  },
  Event_7623_Desc = {
    Text = "Du und Ramona und Lotan teilen euch in drei Gruppen auf und beginnt die Höllenhunde zu verfolgen. \n\n Du rennst durch mehrere Gassen, als sich der massive Körper vor dir zeigt. \n Als es dich sieht, biegt es sofort um die nächste Ecke. \n Du rennst hinterher, doch vor dir erscheint eine Sackgasse, umgeben von hohen Wänden, die den engen quadratischen Himmel umschließen."
  },
  Event_7623_Name = {Text = "Sackgasse"},
  Event_7624_ChoiceDesc1 = {
    Text = "[Vorbeigehen]"
  },
  Event_7624_ChoiceDesc2 = {
    Text = "[Streicheln]"
  },
  Event_7624_Desc = {
    Text = "Neben dem sauberen, weichen Operationstisch liegt der bereits erschlaffte Körper von Kum. \n Sie ist immer noch sehr groß, wie ein kleiner Hügel, so wie du sie zum ersten Mal gesehen hast. \n Nur im Vergleich zu dem echten “Höllenhund“ in der Höhe ist sie so klein, so klein wie ein Kind."
  },
  Event_7624_Name = {Text = "Restwärme"},
  Event_7625_ChoiceDesc1 = {
    Text = "[Erhalte Silberkern]"
  },
  Event_7625_Desc = {
    Text = "Eh, da vorn scheinen viele glänzende Dinge zu sein!\nRiech mal... es riecht gut.\nLeck mal... es ist schön kühl!\nSieht aus wie sehr wertvolle Dinge, schnell aufheben und zu kleinen Jenkin bringen, vielleicht können wir viel Käse tauschen!"
  },
  Event_7625_Name = {Text = "glänzend"},
  Event_7626_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7626_Desc = {
    Text = "Eine fremde Enttäuschung stieg in dir auf, das illusorische Netz löste sich langsam auf und gab den Weg frei"
  },
  Event_7626_Name = {
    Text = "verirrtes Netzwerk"
  },
  Event_7627_ChoiceDesc1 = {
    Text = "[verstehe es]Zufällig 1 Erwecker erwecken, Infektion“(Skill.Arg1)“"
  },
  Event_7627_ChoiceDesc2 = {
    Text = "[Ignoriere es]erhalte 3 aus 1 Gebet"
  },
  Event_7627_Desc = {
    Text = "Fließende Runen strömten aus dem Brüllen des fischförmigen Wesens, sie füllten deine Ohren, deine Nase, deinen Hals. Sie brannten in deinem Körper, in zehn Sekunden wirst du die Bedeutung des Brüllens verstehen"
  },
  Event_7627_Name = {Text = "Rune Wahn"},
  Event_7628_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7628_Desc = {
    Text = "Du beißt die Zähne zusammen und versuchst, die verwirrenden Halluzinationen zu bekämpfen. Ramona legt dir einen kalten Gegenstand in die Hand.\n“Ich habe das gerade gefunden, vielleicht hilft es dir.“"
  },
  Event_7628_Name = {
    Text = "Dimensionsillusion"
  },
  Event_7629_ChoiceDesc1 = {
    Text = "Wähle eine fortgeschrittene Markierung"
  },
  Event_7630_ChoiceDesc1 = {
    Text = "[Die Krähe festhalten] Wähle 1 von 3 Befehlskarten aus, um ein Gebet zu erhalten: „(EnchantConfig.Arg1)\", infiziere „(Skill.Arg2)\""
  },
  Event_7630_ChoiceDesc2 = {
    Text = "[Kille die Krähe]Erhalte 3-wählen-1 Gebet"
  },
  Event_7630_ChoiceDesc3 = {
    Text = "[Verlassen]"
  },
  Event_7630_Desc = {
    Text = "Eine einsame Krähe zupft sich heiser eine nach der anderen ihre schwarzen Federn aus.\nSie zittert vor Schmerz, schreit laut, kann aber nicht aufhören.\n„Krah—Krah—“\nBlaue Tränen, vermischt mit schwarzem Schleim, fließen aus ihren Augen, nur du siehst es.\n"
  },
  Event_7630_Name = {
    Text = "Träne der geschmolzenen Lava"
  },
  Event_7631_ChoiceDesc1 = {
    Text = "[Verlassen]Erhöhe Arg1 maximale Gesundheit"
  },
  Event_7631_Desc = {
    Text = "“Überlass das mir,“ streichst du über das Rückgrat des Ungeheuers, als würdest du eine wütende kleine Katze beruhigen, „sie wird aufwachen, wir werden ihr nicht wehtun.“"
  },
  Event_7631_Name = {
    Text = "Ruf der Freundschaft"
  },
  Event_7632_ChoiceDesc1 = {
    Text = "[Verlassen]Erhöhe Arg1 maximale Gesundheit, infiziere“(Skill.Arg2)“und“(Skill.Arg3)“"
  },
  Event_7632_Desc = {
    Text = "“Wach auf, Lily, Koom möchte auch, dass du bald aufwachst—“"
  },
  Event_7632_Name = {
    Text = "Ruf der Freundschaft"
  },
  Event_7633_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_7633_Desc = {
    Text = "Unbrauchbar"
  },
  Event_7633_Name = {
    Text = "Stummes Telegramm"
  },
  Event_79429_ChoiceDesc1 = {
    Text = "Wähle einen Erwecker und verwandle ihn durch ein Lebensritual in den “Schwarm“. Die Befehlskarten des “Schwarms“ kosten 1 Arithmetica weniger, werden aber nach dem Ausspielen verbraucht."
  },
  Event_79429_Desc = {
    Text = "“Im Prozess der Selbstwahrnehmung ist Schmerz immer präsent, und das gilt auch für Verwandlung und Neugeboren.“\nSie lächelt sanft und streichelt liebevoll dein Gesicht. \n“Hab keine Angst, ich bin hier bei dir, also öffne deinen Geist und alles, nimm es an.“\n“Braves Kind, ich warte auf deine Wiedergeburt, ich warte darauf, dass du... ein Teil von uns wirst.“"
  },
  Event_79429_Name = {
    Text = "Die Verwandlung des Lebens"
  },
  Event_80463_ChoiceDesc1 = {
    Text = "[Verlassen]Erhalte eine Auswahl von 3 für 1 Silberrelikt, infiziere“(Skill.Arg1)“"
  },
  Event_80463_Desc = {
    Text = "Du hast den Weg gewählt und ziehst den kleinen William mit aller Kraft mit. \nZum Glück war deine Wahl richtig. \nDie geistige Verschmutzung, all die identischen Clementines, endlich hast du sie abgeschüttelt. \nNatürlich hast du dafür einen Preis gezahlt."
  },
  Event_80463_Name = {
    Text = "“Die Clementinen“"
  },
  Event_80464_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_80464_Desc = {
    Text = "Eine Erinnerung, die über das Verständnis hinausgeht, wird in dein Gehirn eingepflanzt und zerschmettert direkt deinen Verstand.\nIn den Bildern, die wie ein schneller Vorlauf erscheinen, erinnerst du dich nur an eine Szene: einen dreieckigen Tempel.\nDas ist das große Werk der @2Insektoiden, das für die großartige Torheit des @4 errichtet wurde."
  },
  Event_80464_Name = {
    Text = "Tiefe Erinnerung"
  },
  Event_80465_ChoiceDesc1 = {
    Text = "[Verlassen]Wähle einen Erwecker, infiziere“(Skill.Arg1)“"
  },
  Event_80465_Desc = {
    Text = "Du hast den Weg gewählt und ziehst den kleinen William mit aller Kraft mit. \nZum Glück war deine Wahl richtig. \nDie geistige Verschmutzung, all die identischen Clementines, endlich hast du sie abgeschüttelt. \nNatürlich hast du dafür einen Preis gezahlt."
  },
  Event_80465_Name = {
    Text = "“Die Clementinen“"
  },
  Event_80466_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_80466_Desc = {
    Text = "«Klak. Klak. Klak»  \nDie «Arbeit» ist endlich erledigt – aber abgesehen von der «Arbeit» selbst, was hast du sonst noch gewonnen?"
  },
  Event_80466_Name = {
    Text = "Ewige Qualen"
  },
  Event_80467_ChoiceDesc1 = {
    Text = "[Verlassen]Erhalte eine Auswahl von 3 für 1 Gebet"
  },
  Event_80467_Desc = {
    Text = "“Es freut mich, deine ehrliche Antwort zu hören.“\n“Ich freue mich auf unser nächstes Treffen.“"
  },
  Event_80467_Name = {Text = "Traum-Ruf"},
  Event_80468_ChoiceDesc1 = {
    Text = "[Verlassen]Erhalte 25 schwarze Siegel"
  },
  Event_80468_Desc = {
    Text = "“Ach je, wirklich ein unehrliches Kind.“\n“Aber macht nichts, nächstes Mal wirst du mir die Wahrheit sagen.“\n“Alle wahren Worte, die von Herzen und Seele kommen.“"
  },
  Event_80468_Name = {Text = "Traum-Ruf"},
  Event_80469_ChoiceDesc1 = {
    Text = "[Beginne „Arbeit“] Entferne 1 Befehlskarte, erhalte Arg1 das schwarze Siegel"
  },
  Event_80469_ChoiceDesc2 = {
    Text = "Zurücktreten"
  },
  Event_80469_Desc = {
    Text = "“Klak.“\nDas Geräusch der Schreibmaschine ertönt. Solange die “Arbeit“ nicht erledigt ist, wirst du immer ihr Sklave bleiben."
  },
  Event_80469_Name = {
    Text = "Ewige Qualen"
  },
  Event_80470_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_80470_Desc = {
    Text = "“Das ist wirklich schade. Deine Vorsicht hat dir die einzige Chance genommen, die Wahrheit zu erfahren.“\nEs seufzte und zerfiel lautlos."
  },
  Event_80470_Name = {
    Text = "Tiefe Erinnerung"
  },
  Event_80471_ChoiceDesc1 = {
    Text = "[Vollständiger ANG]"
  },
  Event_80471_ChoiceDesc2 = {
    Text = "[Zurückweichen und kämpfen]"
  },
  Event_80471_Desc = {
    Text = "Eine unerwartete Gestalt erscheint vor dir – Clementine.  \n„Keine Sorge, ich möchte nur einen besonderen Test durchführen.“  \n„Was genau getestet wird? Das ist ein Geheimnis.“ Clementine lächelt. „Für dich ist die einzige Prüfung des Tests –“  \n„am Leben zu bleiben.“"
  },
  Event_80471_Name = {
    Text = "Spezialtest"
  },
  Event_80472_ChoiceDesc1 = {
    Text = "[Erinnerung an die Vergangenheit]"
  },
  Event_80472_ChoiceDesc2 = {
    Text = "Die Schuppen entfernen"
  },
  Event_80472_Desc = {
    Text = "“Bitte glaube mir, ich habe keine bösen Absichten, ich möchte dir nur helfen.“\nClementine verfolgt dich und ruft laut. \nIhre Stimme klingt unglaublich ehrlich, doch du kannst nichts mehr glauben. \nDeine Moral wurde von der “Embodied Cognition Theory“ durchbrochen, und dein Verstand steht kurz vor dem Absturz. \nDu musst, du musst etwas tun, um den Insektenchitin-Schuppen in deinem Fleisch zu widerstehen, um dem Wahnsinn und der Verzweiflung, die allmählich in deine Seele eindringen, zu widerstehen."
  },
  Event_80472_Name = {
    Text = "kämpfende Seele"
  },
  Event_80473_ChoiceDesc1 = {
    Text = "[Verlassen]Lösche 2 Karten"
  },
  Event_80473_Desc = {
    Text = "“Möchtest du deine Kraft für die letzte entscheidende Schlacht aufsparen?“\n“Eine kluge Wahl. Doch während der Mensch gewinnt, verliert er in Wirklichkeit auch etwas.“\n“Denn in dieser brennenden, grausamen Welt erfordert das bloße Überleben bereits einen Preis.“"
  },
  Event_80473_Name = {
    Text = "Spezialtest"
  },
  Event_80474_ChoiceDesc1 = {
    Text = "[Ignoriere es]erhalte 3 aus 1 Gebet"
  },
  Event_80474_ChoiceDesc2 = {
    Text = "[Es berühren] Eine zufällige Befehlskarte erhält das Gebet: „(EnchantConfig.Arg1)\", infiziert „(Skill.Arg2)\""
  },
  Event_80474_Desc = {
    Text = "Ähnliche Sporen erregen deine Aufmerksamkeit.\nSie gleichen einer zarten, aus Fleisch gebildeten Qualle oder den Nervenfasern im tiefsten Gehirn, die Signale speichern.\n„Berühre mich.“, lockt es dich lautlos, „Ich werde dir eine grausame Erinnerung zeigen.“"
  },
  Event_80474_Name = {
    Text = "Tiefe Erinnerung"
  },
  Event_80475_ChoiceDesc1 = {
    Text = "[Verlassen]Erhalte eine Auswahl von 3 für 1 Gebet"
  },
  Event_80475_Desc = {
    Text = "“Ramona, Doll, Lotan, Ogier...“\nDu wiederholst nervös diese Namen immer wieder im Flüstern. \nDein zusammengebrochenes Verstand kann sich nicht mehr an ihr Aussehen erinnern, aber die Existenz, die diese Namen repräsentieren, kann immer noch dein Herz und deine Seele wärmen. \nSie haben existiert, sie haben gelacht, sie... sind dein gegenwärtiger Anker und die Grenze, die deine Menschlichkeit aufrechterhält."
  },
  Event_80475_Name = {
    Text = "kämpfende Seele"
  },
  Event_80476_ChoiceDesc1 = {
    Text = "[Verlassen]Erhalte eine Auswahl von 3 für 1 Silberrelikt, infiziere“(Skill.Arg1)“"
  },
  Event_80476_Desc = {
    Text = "“Aaaaaaah –“\nDu öffnest deinen Mund und schreist laut, doch der Laut ist eher ein Kreischen als ein richtiger Schrei.\nDie herausgerissenen Insektenchitin-Schuppen wachsen bereits nach, und der zerbrochene Verstand kehrt niemals zurück."
  },
  Event_80476_Name = {
    Text = "kämpfende Seele"
  },
  Event_80477_ChoiceDesc1 = {
    Text = "[Verlassen]Erhalte Schöpfung“(RelicConfig.Arg1)“，Infektion“(Skill.Arg2)“"
  },
  Event_80477_Desc = {
    Text = "Du hast nichts verborgen und gibst dein Bestes. Diese Haltung erfreut Clementine offensichtlich. \n “Was für ein gutes Kind.“ \n “In diesem Fall werde ich dich ein wenig belohnen. Natürlich hat es seinen Preis.“ \n “Denn in dieser brennenden, grausamen Welt erfordert das bloße Überleben bereits einen Preis.“"
  },
  Event_80477_Name = {
    Text = "Spezialtest"
  },
  Event_80478_ChoiceDesc1 = {
    Text = "[Beginne „Arbeit“] Entferne 1 Befehlskarte, erhalte Arg1 das schwarze Siegel"
  },
  Event_80478_ChoiceDesc2 = {
    Text = "Zurücktreten"
  },
  Event_80478_Desc = {
    Text = "“Klick. Klick.“  \nDas Geräusch der Schreibmaschine ertönt. Während der “Arbeit“ bist du nur ein Werkzeug, um die “Arbeit“ zu erledigen."
  },
  Event_80478_Name = {
    Text = "Ewige Qualen"
  },
  Event_80479_ChoiceDesc1 = {
    Text = "[Nach links laufen]"
  },
  Event_80479_ChoiceDesc2 = {
    Text = "[Nach rechts laufen]"
  },
  Event_80479_Desc = {
    Text = "Vertraute Gestalten folgen dir dicht auf den Fersen, nicht nur ein oder zwei, sondern Dutzende, Hunderte. \n Der enge Flur kann so viele „Clementines“ nicht fassen, daher werden einige „Clementines“ zu Boden gestoßen, andere zu Brei getreten. \n Doch sie rufen einheitlich nach dir und wiederholen den Satz, der dich in geistige Verschmutzung stürzt. \n „Warum willst du fliehen? Ich möchte dir doch nur eine psychologische Beratung anbieten.“ \n Und du rennst durch den Flur des Sanatoriums, konfrontiert mit der Wahl an der Weggabelung."
  },
  Event_80479_Name = {
    Text = "“Die Clementinen“"
  },
  Event_80480_ChoiceDesc1 = {
    Text = "[Beginne „Arbeit“] Entferne 1 Befehlskarte, erhalte Arg1 das schwarze Siegel"
  },
  Event_80480_ChoiceDesc2 = {
    Text = "Zurücktreten"
  },
  Event_80480_Desc = {
    Text = "“Ändern! Arbeiten! Hör nicht auf!“\nUnzählige Summen hallen in deinen Ohren und ziehen dich unwillkürlich zu der plötzlich auftauchenden Schreibmaschine. \n“Was soll ich tun, was soll ich tun, ich schreibe von früh bis spät, aber die Arbeit scheint niemals zu enden.“\n“Ändern! Ändern! Änderungsanträge, Anforderungen stellen, Arbeit erledigen!“\n“Arbeiten! Arbeiten!! Arbeiten!!!“\nDie summende Seele prallt gegen die unermüdlich tippende Schreibmaschine, schließlich, die Schreibmaschine hört endlich auf. \nDoch einen Moment später beginnt die Schreibmaschine erneut zu laufen. \n“Ändern! Arbeiten! Hör nicht auf!“\nDenn die Arbeit hat kein Ende."
  },
  Event_80480_Name = {
    Text = "Ewige Qualen"
  },
  Event_80481_ChoiceDesc1 = {
    Text = "[Wahrheitsgemäß antworten]"
  },
  Event_80481_ChoiceDesc2 = {
    Text = "[Antwort verweigern]"
  },
  Event_80481_Desc = {
    Text = "In einem Augenblick wird die Szenerie vor dir verschwommen und unwirklich. \n Du dachtest, der Raum würde sich verzerren und verändern, aber später wurde dir klar, dass dein Sehnerv infiltriert wurde. \n “Wir sehen uns wieder.“ \n In der verschwommenen Sicht lächelt Clementine sanft. \n “Obwohl wir uns früher treffen, als gedacht, freue ich mich trotzdem sehr. Ich frage mich, ob auch %player% du dieses Gefühl hast?“"
  },
  Event_80481_Name = {Text = "Traum-Ruf"},
  Event_80595_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_80595_Desc = {
    Text = "\nTrotz deiner Versuche, ihn zu vertreiben, bleibt der Schmetterling unbeeindruckt.\nBeharrlich folgt er deiner Handfläche und stirbt schließlich in deiner Hand.\n„Ah, wie warm...“\nDies sind seine letzten Gedanken."
  },
  Event_80595_Name = {
    Text = "SchmetterlingsTraum"
  },
  Event_80596_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_80596_Desc = {
    Text = "„Ich wünsche mir, dass die Blumen immer blühen, ich wünsche mir, dass das Lächeln ewig währt.\"\n„Ich wünsche mir, dass alle, die an Auflösung leiden, geheilt und in Frieden sind, ich wünsche mir, dass diese Welt in die Vergangenheit zurückkehrt und nicht mehr brennt.\"\n„Ich wünsche mir...\"\nDer kleine Schmetterling schlägt mit seinen Flügeln und verblasst langsam in deiner Handfläche.\nZumindest hat jemand seine Stimme gehört."
  },
  Event_80596_Name = {
    Text = "SchmetterlingsTraum"
  },
  Event_80597_ChoiceDesc1 = {
    Text = "[Schmetterling vertreiben] 1 zufällige Befehlskarte erhält ein Gebet: „(EnchantConfig.Arg1)\", infiziere „(Skill.Arg2)\""
  },
  Event_80597_ChoiceDesc2 = {
    Text = "[Wunsch anhören]Wähle eine von drei Befehlskarten und erhalte ein Gebet: „(EnchantConfig.Arg1)“"
  },
  Event_80597_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte 25 schwarze Siegel"
  },
  Event_80597_Desc = {
    Text = "Der kleine Schmetterling trägt viele Träume.\nDiese Träume sind in den Blumenmeeren, in den Krankenzimmern und auf dem mit Blut und Fleisch von @2 gefüllten Altar verstreut.\nNun hat er endlich auf seine Bindung gewartet und fragt sich, ob du bereit bist, seinen kleinen, kleinen Wunsch zu hören."
  },
  Event_80597_Name = {
    Text = "SchmetterlingsTraum"
  },
  Event_80610_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_80610_Desc = {
    Text = "“Rationalität? Eine interessante Antwort.“\n“Ich hoffe, du wirst deine Entscheidung nicht bereuen.“"
  },
  Event_80610_Name = {
    Text = "Der Preis der Menschlichkeit"
  },
  Event_80612_ChoiceDesc1 = {
    Text = "[Füttere sie]erhalte das silberne Relikt „(RelicConfig.Arg1)“, wähle 1 Mal ein Symptom zur Infektion"
  },
  Event_80612_ChoiceDesc2 = {
    Text = "[Ignorieren]Wähle eine von 3 Befehlskarten und erhalte das Gebet: „(EnchantConfig.Arg1)“, infiziere „(Skill.Arg2)“"
  },
  Event_80612_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte 25 schwarze Siegel"
  },
  Event_80612_Desc = {
    Text = "Die Bewohner kommen und gehen, aber die Ratten bleiben lange Zeit. \n Im Vergleich zu den Menschen sind sie die “Ureinwohner“ dieser Burg. \n Doch sie haben nichts gegen das Eindringen der Menschen. \n Denn diese schmackhaften, zarten, hässlichen Wesen füttern sie mit ebenso schmackhaften, zarten, hässlichen Wesen. \n “Und du, hässliches Wesen, zu welcher Art gehörst du?“"
  },
  Event_80612_Name = {
    Text = "Das Geheimnis der Burg"
  },
  Event_80613_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_80613_Desc = {
    Text = "\nAus der Dunkelheit ertönt ein sanftes Lachen.\n„Ich erwarte dich, komm zu mir.“\n„Tapferer kleiner Wurm.“"
  },
  Event_80613_Name = {
    Text = "“Ihr“ spähen"
  },
  Event_80614_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_80614_Desc = {
    Text = "“Halt den Mund, halt den Mund, das klingt schrecklich.“ \n Die schwarze Katze hält menschlich die Ohren zu. \n “Mensch, deine Katzensprache ist wirklich schlecht, du redest nur wirres Zeug!“ \n Obwohl sie das sagt, wird der Gesichtsausdruck der schwarzen Katze friedlicher. \n “Weil du mit deinem Miau mein Wohlwollen gewinnst, schenke ich dir ein Geschenk.“ \n “Was das Geschenk beinhaltet, hängt von deinem Glück ab.“"
  },
  Event_80614_Name = {Text = "Nigerman"},
  Event_80615_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_80615_Desc = {
    Text = "\n“Mutter, nach dem Verlust von Freunden, Ehemann und Sohn habe ich auch für immer Diana, meine kleine Tochter, verloren.“\n“Als sie vor meinen Augen zu Asche wurde, war mein Verstand leer...“Der nachfolgende Text ist unleserlich. \nDu kannst nur die nächste Zeile lesen. \nIch habe meinen Entschluss gefasst. Wenn ich euch wiedersehe, bitte beschuldigt mich nicht, ich habe euch einfach... zu sehr vermisst."
  },
  Event_80615_Name = {
    Text = "Verblassende Sehnsucht"
  },
  Event_80616_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_80616_Desc = {
    Text = "Dein Vertreiben zeigt Wirkung. Eine Handvoll unidentifizierbarer Gestalten verzerrt sich und flieht, während die meisten an Ort und Stelle bleiben. \n Sie lachen nicht mehr, sie singen nicht mehr, sondern weinen laut. \n Das Weinen der Kinder hallt in deinem Ohr und wiederholt nur einen Satz. \n “Tötet das Ungeziefer!“"
  },
  Event_80616_Name = {
    Text = "“Seine“ Kindheit"
  },
  Event_80617_ChoiceDesc1 = {
    Text = "[Verlassen]Infektion“(Skill.Arg1)“"
  },
  Event_80617_ChoiceDesc2 = {
    Text = "[Verlassen]Infektion“(Skill.Arg1)“"
  },
  Event_80617_ChoiceDesc3 = {
    Text = "[Verlassen]Infektion“(Skill.Arg1)“"
  },
  Event_80617_Desc = {
    Text = "Deine Fütterung hat die Ratten erfreut.\nDie riesige Rattenmenge bewegt sich und schenkt dir ein grob verpacktes Geschenk.\nDu kannst die Form des Geschenks nicht erkennen, nur das viele Blut, das die Verpackung durchtränkt."
  },
  Event_80617_Name = {
    Text = "Das Geheimnis der Burg"
  },
  Event_80618_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_80618_Desc = {
    Text = "“...“\n“...“\n“...“\nDer schwarze Schatten schweigt. Er möchte weinen, aber er hat bereits die Fähigkeit verloren, Tränen zu vergießen.\nSchließlich seufzt er nur tief auf.\n“Freund, ich hoffe, du kannst das, was dir am wertvollsten ist, beschützen.“"
  },
  Event_80618_Name = {Text = "Hohlmann"},
  Event_80619_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_80619_Desc = {
    Text = "Dein Schimpfen hat keine Wirkung, sondern macht sie nur noch wilder und fröhlicher. \n Das Gelächter und Singen wird immer lauter, während sie ein anderes Kinderlied singen \n „Kleiner Wilhelm, lebt in der Burg, Menschenfressende Ratten laufen durch die Wände. \n Wenn es Zeit für das Menschenopfer ist, werden Alle nacheinander angeknabbert.\""
  },
  Event_80619_Name = {
    Text = "“Seine“ Kindheit"
  },
  Event_80620_ChoiceDesc1 = {
    Text = "[Blick abwenden]wecke zufällig 1 Erwecker"
  },
  Event_80620_ChoiceDesc2 = {
    Text = "[Direkter Blick]Wähle 1 Erwecker aus und reduziere die Arithmetica-Kosten der Wachenkarten um 2 Punkte. Infektion“(Skill.Arg1)“"
  },
  Event_80620_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte 50 schwarze Siegel"
  },
  Event_80620_Desc = {
    Text = "Alles im Sanatorium unterliegt ihrer Kontrolle und Beobachtung. Natürlich gehörst auch du dazu. \nDoch sie ist bereit, für dich ein Auge zuzudrücken. \nSchließlich ist ein Spiel erst dann interessant, wenn es wechselseitig ist."
  },
  Event_80620_Name = {
    Text = "“Ihr“ spähen"
  },
  Event_80621_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_80621_Desc = {
    Text = "Du legst den Umschlag zurück und machst dich bereit zu gehen, als du plötzlich ein verschwommenes Flüstern hörst. \n “Auf mein Ersuchen hin hat Dr. Clementine endlich nachgegeben. \n In dem weiten Universum, das sie mir beschrieben hat, in diesem mysteriösen Universum, muss es einen Weg geben, um euch zu retten. \n Ich bin bereit für die Neugeboren“, egal wie viele Lichtjahre ich treiben muss, ich sehne mich danach, euch wiederzusehen.“"
  },
  Event_80621_Name = {
    Text = "Verblassende Sehnsucht"
  },
  Event_80622_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_80622_Desc = {
    Text = "Doktor Clementine hat mich gerettet. \n Sie ist wirklich ein sehr, sehr guter Mensch, der bereit ist, meiner Stimme zuzuhören. \n Ich möchte wirklich etwas Fröhliches, etwas Glückliches sagen, doch in diesem Moment gibt es für mich außer Schmerz und Verzweiflung nichts anderes. \n Fürchte ich, werde ich die guten Absichten der Ärztin enttäuschen. \n Nach dem Verlust von euch ist das Leben für mich nur noch karg."
  },
  Event_80622_Name = {
    Text = "Verblassende Sehnsucht"
  },
  Event_80623_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_80623_Desc = {
    Text = "“Du, du...“\n«Hmpf, nicht schlecht. Diesmal hast du bestanden. Beim nächsten Mal wird es aber nicht so einfach sein!»\nDie schwarze Katze sprang geschickt davon."
  },
  Event_80623_Name = {Text = "Nigerman"},
  Event_80624_ChoiceDesc1 = {
    Text = "[ANG auf die schwarze Katze]50% Wahrscheinlichkeit, 125 schwarze Siegel zu erhalten, 50% Wahrscheinlichkeit, infiziert zu werden “(Skill.Arg2)“"
  },
  Event_80624_ChoiceDesc2 = {
    Text = "[Miau nachahmen]75% Chance, 100 schwarze Siegel zu erhalten, 25% Chance, infiziert zu werden mit „(Skill.Arg2)“"
  },
  Event_80624_ChoiceDesc3 = {
    Text = "[Versuche, die Katze zu streicheln]Erhalte 50 schwarze Siegel"
  },
  Event_80624_Desc = {
    Text = "“Hey! Du, halt an.“ \n Die schwarzen Katzen springen plötzlich hervor und blockieren deinen Weg. \n Sie lecken elegant ihre Pfoten und wirken stolz und herausfordernd. \n “Vor dir liegt Gefahr, die nicht für schwache Menschen wie dich bestimmt ist.“ \n Du drückst deinen Willen aus, weiterzugehen, da dreht die führende schwarze Katze ihre senkrechten Pupillen und offenbart ihre grausame Natur im Umgang mit Beute. “Dann zeig uns deinen Willen.“"
  },
  Event_80624_Name = {Text = "Nigerman"},
  Event_80625_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_80625_Desc = {
    Text = "\nDeine Ignoranz hat die Ratten aufgebracht. Sie kreischen und stürzen sich auf dich. Doch du bist schon lange davongelaufen, bevor die Rattenmenge sich bewegen konnte."
  },
  Event_80625_Name = {
    Text = "Das Geheimnis der Burg"
  },
  Event_80626_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_80626_Desc = {
    Text = "“Ah, genau so, brich mir die Flügel.“\n“Zeit, Gesundheit, Würde, Leben – sie haben mir bereits viel zu viel genommen.“\n“Dieser letzte Traum gehört mir natürlich auch nicht.“\n“Denn ich bin nur ein Vogel, der eingesperrt ist und seine Freiheit verloren hat.“"
  },
  Event_80626_Name = {Text = "Hohlmann"},
  Event_80627_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_80627_Desc = {
    Text = "“Romantisch? Eine interessante Antwort.“\n“Ich hoffe, du wirst deine Entscheidung nicht bereuen.“"
  },
  Event_80627_Name = {
    Text = "Der Preis der Menschlichkeit"
  },
  Event_80628_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_80628_Desc = {
    Text = "“Ich akzeptiere dein Gebet.“\nEin Summen nähert sich und dringt langsam durch den Gehörgang in dein Gehirn ein.\nDein Gehirn zittert, und in diesem Zittern hörst du die „Stimme“ des Universums.\n„Verbinde dich mit mir.“"
  },
  Event_80628_Name = {
    Text = "Dunkle Erlösung"
  },
  Event_80629_ChoiceDesc1 = {
    Text = "[Flehen]Zufällig 1 Erwecker erwecken, Infektion „(Skill.Arg1)“"
  },
  Event_80629_ChoiceDesc2 = {
    Text = "[Weigere dich] Erhalte eine Auswahl von 3 für 1 Gebet"
  },
  Event_80629_Desc = {
    Text = "“So sollte es nicht sein, so sollte es nicht sein.“\n“Ich sollte mich eindeutig von dieser niederen menschlichen Existenz befreien und zu etwas Höherem evolvieren...“\nAus der Dunkelheit ertönt ein schmerzhaftes Schluchzen.\nDiese Schluchzer sammeln sich, surgen und bilden ein gewaltiges Summen.\n“Diese brennende Welt, wie ein nie gesättigtes schwarzes Loch, verschlingt jeden Einzelnen, deshalb—“\n“Bittet mich, das endlose Universum wird euch Erlösung schenken.“"
  },
  Event_80629_Name = {
    Text = "Dunkle Erlösung"
  },
  Event_80630_ChoiceDesc1 = {
    Text = "[Briefumschlag öffnen]Erhalte das goldene Relikt „(RelicConfig.Arg1)“, infiziere „(Skill.Arg2)“"
  },
  Event_80630_ChoiceDesc2 = {
    Text = "[Lesen]Wähle eine Karte aus drei Befehlskarten und erhalte Gebet: „(EnchantConfig.Arg1)“"
  },
  Event_80630_ChoiceDesc3 = {
    Text = "[Zurücklegen]Erhalte 50 schwarze Siegel"
  },
  Event_80630_Desc = {
    Text = "In einer unbeachteten Ecke lag ein vergessener Brief. \nViele der auf dem Brief geschriebenen Wörter waren bereits unleserlich, doch nur ein einziges Wort drang klar durch das Papier. \nDieses Wort war „Mutter“."
  },
  Event_80630_Name = {
    Text = "Verblassende Sehnsucht"
  },
  Event_80631_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_80631_Desc = {
    Text = "„Hmpf, kleiner Mensch, du hast die falsche Entscheidung getroffen.“ \n Die schwarzen Katzen blicken dich kalt an und stürzen sich plötzlich auf dich. \n „Du wirst bezahlen müssen – natürlich respektieren wir auch Stärke.“"
  },
  Event_80631_Name = {Text = "Nigerman"},
  Event_80632_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_80632_Desc = {
    Text = "\nAus der Dunkelheit ertönt ein sanftes Lachen.\n„Ich warte auf dich, komm zu mir.“\n„Herrlicher kleiner Wurm.“"
  },
  Event_80632_Name = {
    Text = "“Ihr“ spähen"
  },
  Event_80633_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_80633_Desc = {
    Text = [[
Unter deinem ANG fliehen diese verzerrten und seltsamen Gestalten endlich. 
 Es ist still um dich herum, nur dein Herzschlag weint stumm. 
 So sieht also seine Kindheit aus.]]
  },
  Event_80633_Name = {
    Text = "“Seine“ Kindheit"
  },
  Event_80635_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_80635_Desc = {
    Text = "„Ah, die kleine Wortfalle wurde durchschaut.“ \n „Das ist die Belohnung. Weil...“ \n „Nicht jede Wahl muss getroffen werden.“"
  },
  Event_80635_Name = {
    Text = "Der Preis der Menschlichkeit"
  },
  Event_80636_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_80636_Desc = {
    Text = "“@3 Widerspenstiger“ \n Das Summen wird schwächer und verschwindet schließlich. Nur die letzten Worte bleiben zurück. \n „Die Bewahrung der Menschlichkeit allein reicht nicht aus, um in dieser grausamen Welt zu überleben.“"
  },
  Event_80636_Name = {
    Text = "Dunkle Erlösung"
  },
  Event_80637_ChoiceDesc1 = {
    Text = "[Die Ablehnung]Entferne 1 Befehlskarte, erhalte Arg1 das schwarze Siegel"
  },
  Event_80637_ChoiceDesc2 = {
    Text = "[Wahl des Gehorsams]Kopiere 1 Befehlskarte, infiziere “(Skill.Arg1)“"
  },
  Event_80637_ChoiceDesc3 = {
    Text = "[Wähle eine Umarmung]Wähle eine von 3 Befehlskarten und erhalte das Orison: „(EnchantConfig.Arg1)“"
  },
  Event_80637_Desc = {
    Text = "“Ich bin ein Vogel im Käfig, eingesperrt in einem Hof voller vieler Räume.“\nIm Dunkeln schwirren verschwommene Schatten umher, das sind die Besessenheiten der Verstorbenen.\n“Sie sagen, das ist eine Nervenheilanstalt, aber ich weiß, das ist ein spezieller Käfig der Menschheit, der die freien Vögel einsperrt, die sich nicht an die gesellschaftlichen Regeln halten wollen.“\n“Aber kann man einen Vogel noch einen Vogel nennen, wenn er nicht fliegen kann?“\nDie Besessenheiten nähern sich dir und bitten um Erlösung.\n“Bitte brecht mir die Flügel, ich habe es satt zu fliegen.“"
  },
  Event_80637_Name = {Text = "Hohlmann"},
  Event_80638_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_80638_Desc = {
    Text = "“...“\n“............“\n“..................“\nDer schwarze Schatten zittert plötzlich und schmilzt in deinen Körper. \n“Freund, geh voran, um das, was dir am wertvollsten ist, zu beschützen.“\n“Obwohl wir bereits verstorben sind, sind wir dennoch bereit, für deine Träume zu beten und dir den letzten Segen zu schenken.“"
  },
  Event_80638_Name = {Text = "Hohlmann"},
  Event_80639_ChoiceDesc1 = {
    Text = "[Emotion wählen]Heile Arg1 Leben"
  },
  Event_80639_ChoiceDesc2 = {
    Text = "[Rationalität bewahren]Zufällig 1 Befehlskarte erhält das Gebet: „(EnchantConfig.Arg1)“"
  },
  Event_80639_ChoiceDesc3 = {
    Text = "[Weigere dich zu wählen] Erhalte 25 das schwarze Siegel"
  },
  Event_80639_Desc = {
    Text = "“Wähle, wähle.“\nIn der rasenden Dunkelheit ertönen unzählige Flüstern. \nDiese Stimme ist sanft und hypnotisch, scheint unendliche Magie zu tragen und lässt dich eine Art wahnsinniges Trugbild erleben. \nDein Gehirn gerät in einen Wahnsinn, windet sich aus dem Körper heraus, während dein Herz anscheinend ein gewisses Bewusstsein entwickelt und dich schreiend ruft. \n“Wähle, wähle.“\n“Rationalität oder Emotionalität, du musst eine Wahl treffen.“"
  },
  Event_80639_Name = {
    Text = "Der Preis der Menschlichkeit"
  },
  Event_80641_ChoiceDesc1 = {
    Text = "[Schrei „sie“ an]infiziere „(Skill.Arg1)“, erhalte ein verfluchtes Relikt „(RelicConfig.Arg2)“"
  },
  Event_80641_ChoiceDesc2 = {
    Text = "[Vertreibe „sie“]Infiziere zweimal „(Skill.Arg1)“, erhalte das Silberrelikt „(RelicConfig.Arg2)“ und „(RelicConfig.Arg3)“"
  },
  Event_80641_ChoiceDesc3 = {
    Text = "[ANG auf „sie“]Erhalte das Silberrelikt „(RelicConfig.Arg1)“"
  },
  Event_80641_Desc = {
    Text = "“Kleiner Wilhelm, ein Ungeheuer, schläft auf dem Friedhof, niemand liebt ihn. Geh nicht mit ihm um, sei vorsichtig, dass er dir nicht heimlich schadet.“\nEine Gestalt, deren Gesichtszüge man nicht erkennen kann, verzerrt sich, doch die Stimme klingt wie die eines Kindes. \nSie lachen und singen, mit einem verächtlichen und begierigen Blick auf dich. \nMit Bosheit."
  },
  Event_80641_Name = {
    Text = "“Seine“ Kindheit"
  },
  Event_90571_ChoiceDesc1 = {
    Text = "[Schmecke es]Füge 1 Karte „Spezialmix der Opfergeister“ dem Deck hinzu."
  },
  Event_90571_Desc = {
    Text = "Ein prächtiger Tisch, ein lebhafter Tanzsaal, feines Geschirr, der betörende Duft von Leichnamen...\nOh, ich weiß, dass du es kaum erwarten kannst, aber bitte warte noch einen Moment, mein lieber Gast.\nDieses Getränk, das speziell vom Gastgeber des Festes zubereitet wurde, ist ein Geschenk, das nur für die edlen Gäste bestimmt ist.\nHalte es fest. Nimm einen Schluck. Genieße in seinem Nachgeschmack diese Freude in vollen Zügen!"
  },
  Event_90571_Name = {
    Text = "Vorfeier-Ritual"
  },
  Event_91460_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_91460_Desc = {
    Text = "Du kannst nicht widerstehen, sondern musst es geschehen lassen, dass der Klang eindringt. \nEin scharfes Kreischen zerschneidet dein Gehirn, vergessene Ängste strömen hervor und du spürst seinen Hunger. \nEin schreckliches Kannibalenwesen..."
  },
  Event_91460_Name = {
    Text = "Stumme Beichte"
  },
  Event_91461_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_91461_Desc = {
    Text = "Du hörst auf, dich zurückzuhalten, lässt die Hitze vollständig entfesseln, und alle unausgesprochenen Worte brechen unaufhörlich aus deinem Schädel hervor. \n Du spürst eine wunderbare Inspiration und bist hingerissen von Picmans Talent."
  },
  Event_91461_Name = {
    Text = "Schlafender Vulkan"
  },
  Event_91462_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_91462_Desc = {
    Text = "Die Zunge des Feuers wickelt sich um die Tinte und hinterlässt einen blutigen Fleck. \n In diesem Moment fällst du an der Grenze zwischen Traum und Realität. Du siehst dich selbst zu einem kleinen Mädchen werden, das Doresain an der Hand nimmt und mit ihm tanzt. \n Als du wieder aufwachst und Doresain erneut ansiehst, überkommt dich eine schwere Traurigkeit."
  },
  Event_91462_Name = {
    Text = "Traumoffenbarung"
  },
  Event_91463_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_91463_Desc = {
    Text = "Du stürmst vor, die Flamme verschwindet unter deiner Haut. Das Gemälde wirkt hingegen auf den ersten Blick wie ein gewöhnliches Porträt. \n In deinen Träumen danach siehst du immer wieder dein brennendes Ich, genau richtig gebraten, bis du es eines Tages selbst auf deinen Teller servierst."
  },
  Event_91463_Name = {
    Text = "Brennendes Porträt"
  },
  Event_91464_ChoiceDesc1 = {
    Text = "[Zuhören]Erhalte 30 schwarze Siegel, infiziere „(Skill.Arg2)“, weiter wählen"
  },
  Event_91464_ChoiceDesc2 = {
    Text = "[Ignorieren]Verlassen"
  },
  Event_91464_Desc = {
    Text = "In der lautlosen Kakophonie beginnst du, die Sprache der Krähen zu verstehen..."
  },
  Event_91464_Name = {
    Text = "Stumme Beichte"
  },
  Event_91465_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_91465_Desc = {
    Text = "Du hebst einen Stein auf und weckst die konzentriert nagenden Schattenratten. \n Sie starren dich gierig an. \n Du riechst den feuchten, schmutzigen Geruch, der von ihnen ausgeht, als wäre es ein Omen."
  },
  Event_91465_Name = {
    Text = "Verbanntes Königreich"
  },
  Event_91466_ChoiceDesc1 = {
    Text = "[Zuhören]Erhalte 25 schwarze Siegel, infiziere „(Skill.Arg2)“, weiter wählen"
  },
  Event_91466_ChoiceDesc2 = {
    Text = "[Ignorieren]Verlassen"
  },
  Event_91466_Desc = {
    Text = "Es begrüßt jemanden. Wen begrüßt es? \nNatürlich dich! \nVielleicht betrachtet es dich als köstliches Abendessen für morgen."
  },
  Event_91466_Name = {
    Text = "Stumme Beichte"
  },
  Event_91467_ChoiceDesc1 = {
    Text = "[Handfläche aufschneiden] Wähle 1 von 3 Befehlskarten aus, die das Gebet erhält: „(EnchantConfig.Arg1)\", infiziert „(Skill.Arg2)\""
  },
  Event_91467_ChoiceDesc2 = {
    Text = "[Akzeptiere Wachstum]Erhalte das silberne Relikt “(RelicConfig.Arg1)“, infiziere “(Skill.Arg2)“"
  },
  Event_91467_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte 25 schwarze Siegel"
  },
  Event_91467_Desc = {
    Text = "Der Schmetterling kommt nicht geflogen, sondern wächst langsam aus deiner Handfläche. \n Zunächst dachtest du, es sei nur Schweiß, doch zwischen deinen Fingern siehst du, wie eine schwarze Flüssigkeit wie Blutgefäße zurückfließt und sich zu kalten, pulsierenden Flügeln verfestigt. \n Bei jedem Flügelschlag entstehen Wellen in deinem Blut."
  },
  Event_91467_Name = {
    Text = "Parasit der Oberschicht"
  },
  Event_91468_ChoiceDesc1 = {
    Text = "[Porträt befreien] Wähle 1 von 3 Befehlskarten aus, um das Gebet zu erhalten: „(EnchantConfig.Arg1)\", infiziere „(Skill.Arg2)\""
  },
  Event_91468_ChoiceDesc2 = {
    Text = "[Leere akzeptieren] Wähle 1 von 3 Befehlskarten aus, um das Gebet zu erhalten: „(EnchantConfig.Arg1)\", infiziere „(Skill.Arg2)\""
  },
  Event_91468_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte 25 schwarze Siegel"
  },
  Event_91468_Desc = {
    Text = "Du stehst vor Pickmans Geschenk. \n Es ist ein Porträt, das mit Blut gemalt wurde, während die schwarze Flamme ruhig brennt. \n Durch die leeren Augenhöhlen der Person im Bild siehst du – \n deine Erinnerungen toben und brennen, sich dehnen, verzerren, leuchten, als würde ein unsichtbares Feuer die Gänge in deinem Kopf lecken. Im Dämmerzustand hörst du eine Stimme. \n “Es ist Zeit, in den Topf zu kommen, die Temperatur ist genau richtig.“ \n Das ist genau das Bild deiner eigenen Erinnerungen, in dem du in den Flammen kämpfst und dich verformst."
  },
  Event_91468_Name = {
    Text = "Brennendes Porträt"
  },
  Event_91469_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_91469_Desc = {
    Text = "Du lehnst das Annehmen ab und beobachtest ruhig, wie es zittert, bis es schließlich still wird. \nSchon seit vielen Jahren hast du gelernt, gegen den Wahnsinn anzukämpfen."
  },
  Event_91469_Name = {
    Text = "Verpasster Anruf"
  },
  Event_91470_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_91470_Desc = {
    Text = "Du trittst einen Schritt zurück und lässt die Leinwand in den Flammen brennen. \n Du siehst, wie du durch das Feuer appetitlich goldbraun gegrillt wirst, das Fett zischt und knistert, als könnte man durch die Leinwand den Duft von Fleisch riechen. \n Ist das die Versuchung, die Doresain empfindet?"
  },
  Event_91470_Name = {
    Text = "Brennendes Porträt"
  },
  Event_91471_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_91471_Desc = {
    Text = "Mit einer fast verfluchenden Neugier oder dem verzweifelten Mut, das Unbekannte zu bekämpfen, suchst du in den Schatten der Vergangenheit nach Erleuchtung. \n Du siehst ein Mädchen, das mit einem groß gewachsenen, schemenhaften Mann tanzt, und ein unbeschreibliches Glück erfüllt dein Herz."
  },
  Event_91471_Name = {
    Text = "Schatten der Vergangenheit"
  },
  Event_91472_ChoiceDesc1 = {
    Text = "[Aufzeichnung beenden]2 Karten löschen"
  },
  Event_91472_ChoiceDesc2 = {
    Text = "[Weiter schreiben]Erhalte ein verfluchtes Relikt „(RelicConfig.Arg1)“, infiziere „(Skill.Arg2)“"
  },
  Event_91472_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte Arg1 schwarze Siegel"
  },
  Event_91472_Desc = {
    Text = "Du hast dich endlich vor dem Markt der Leichenschänder befreit und suchst dir wie gewohnt eine ruhige Ecke, um deine Aufzeichnungen zu beginnen. \n Die Schreibmaschine vibriert plötzlich wütend, die Tasten bewegen sich von selbst, schwarzer Schleim spritzt aus den Ritzen und benetzt deinen Verstand an den Fingerspitzen. \n Du siehst, wie sich auf dem Papier allmählich der Schatten eines Schmetterlings abzeichnet..."
  },
  Event_91472_Name = {
    Text = "Schatten von Schmetterlingen"
  },
  Event_91473_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_91473_Desc = {
    Text = "Seltsamerweise, obwohl es eine Sprache ist, die du nie gelernt hast, hast du das Gefühl, ihren Sinn zu verstehen. \n Die Verse sind voller Sehnsucht nach deinen Angehörigen, diese Sehnsucht überwindet Leben und Tod und wird in deinen Träumen übermittelt. \n Am Ende des Gedichts kannst du undeutlich die Schrift erkennen – \n es ist “Selina“."
  },
  Event_91473_Name = {
    Text = "Traumoffenbarung"
  },
  Event_91474_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_91474_Desc = {
    Text = "Du schneidest schmerzhaft die Haut deiner Handfläche auf und verbrennst das neu gewachsene Fleischflügelchen mit Flammen. \n Schwarze Flüssigkeit dampft auf, der Schmetterling zerbricht. \n Alles wird sauber und spurlos, doch du hast immer das Gefühl, ein schwaches Flattern in deiner Handfläche zu hören, wie ein Gedanken, der nicht ganz ausgebrütet wurde und weiterhin langsam in deinen Blutgefäßen atmet. \n Doresain äußert sich dazu nicht, sondern verlangt nur nach dem Blut, das du hinterlassen hast."
  },
  Event_91474_Name = {
    Text = "Parasit der Oberschicht"
  },
  Event_91475_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_91475_Desc = {
    Text = "Du weißt, dass fanatische Inspiration immer wieder zu Katastrophen führt, also verschließt du alles mit Vernunft."
  },
  Event_91475_Name = {
    Text = "Schlafender Vulkan"
  },
  Event_91476_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_91476_Desc = {
    Text = "Du starrst in das Auge und versuchst, die Botschaft zu verstehen, die es vermittelt. \n Obwohl du bereits viele Kämpfe erlebt hast, ist es diesmal Goliath... die Angst schnürt dir das Herz zu. \n “Fast normal ist die stillste Form vor dem Eintritt der Katastrophe.“"
  },
  Event_91476_Name = {
    Text = "Fast normal"
  },
  Event_91477_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_91477_Desc = {
    Text = "Du schließt die Augen und trittst in die Weite der Wildnis. \nDu spürst das verborgene Verlangen und die Vorzeichen, doch niemals wirst du sie mit eigenen Händen zum Schweigen bringen können. \nDu blickst auf die namenlosen Grabsteine um dich herum – vielleicht ist dies dein Schicksal."
  },
  Event_91477_Name = {Text = "Rabenfest"},
  Event_91478_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_91478_Desc = {
    Text = "Du hebst langsam den Kopf, und in diesem Moment durchdringt Licht deine Pupillen, und die Hitze blüht in deinem Gehirn als leere Blume auf. \n Die Sterne der Nekropolis sind nicht anders als anderswo, und selbst die scheinbar ewigen Ghulen können nur unter den Sternen leben und sind nicht frei."
  },
  Event_91478_Name = {
    Text = "Nacht der Sterne"
  },
  Event_91479_ChoiceDesc1 = {
    Text = "[In die Flammen werfen]1 Karte löschen"
  },
  Event_91479_ChoiceDesc2 = {
    Text = "[Versuch der Deutung]Erhalte „(RelicConfig.Arg1)“, infiziere „(Skill.Arg2)“"
  },
  Event_91479_Desc = {
    Text = "Dein Bewusstsein schwebt in dem grenzenlosen schwarzen Nebel, durchstreift die geistigen Bilder zahlreicher Lebender und Verstorbener. \n Im Traum gibt eine mysteriöse Schreibmaschine eine fremde Gedichtzeile von sich. Wessen Geschichte ist das wieder? \n Sie ist auf Papier unbekannter Herkunft eingraviert, die verzerrten Buchstaben scheinen von der Hand eines nüchternen Betrunkenen geschrieben zu sein. \n Du wirst von einem unaussprechlichen Drang im Traum getrieben, nimmst das Papier in die Hand, während die Tinte zwischen dem Licht und Schatten des Feuers springt."
  },
  Event_91479_Name = {
    Text = "Traumoffenbarung"
  },
  Event_91480_ChoiceDesc1 = {
    Text = "[Beitreten]Infektion „(Skill.Arg1)“, zufällig 1 Karte erhält das Gebet: „(EnchantConfig.Arg2)“"
  },
  Event_91480_ChoiceDesc2 = {
    Text = "[Vertreiben]Infiziere „(Skill.Arg1)“, zufällig erhält 1 Karte das Gebet: „(EnchantConfig.Arg2)“"
  },
  Event_91480_ChoiceDesc3 = {
    Text = "[Ignorieren]Wähle eine von 3 Befehlskarten und erhalte ein Orison: „(EnchantConfig.Arg1)“"
  },
  Event_91480_Desc = {
    Text = "Du hörst das schwache Hornsignal der Knochenschnecken aus der Ferne. \n Die Ratten schießen aus dem schwarzen Schlamm hervor und nagen an den namenlosen Leibern, die auf dem ausgetrockneten Flussbett liegen. \n Sie bilden einen Kreis, dessen Mittelpunkt der bereits hohle Leichnam ist, während der Umfang ein neues Königreich ist, dessen Gesetz das Vergessen ist. \n Und du stehst am Eingang dieses Königreichs."
  },
  Event_91480_Name = {
    Text = "Verbanntes Königreich"
  },
  Event_91481_ChoiceDesc1 = {
    Text = "[Hinblicken]Erhalte das Silberrelikt „(RelicConfig.Arg1)“"
  },
  Event_91481_ChoiceDesc2 = {
    Text = "[Kopf senken und verlassen]Erhalte 75 schwarze Siegel, infiziere“(Skill.Arg2)“"
  },
  Event_91481_Desc = {
    Text = "Krähen kreisen am Himmel wie eine zögernde Säge, die immer wieder das Rückgrat des Himmels zerschneidet. \nSie fliegen tief um dich herum, als hätten sie deinen Tod vorausgesehen, und warten geduldig auf den Beginn des Festmahls."
  },
  Event_91481_Name = {Text = "Rabenfest"},
  Event_91482_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_91482_Desc = {
    Text = "Du lässt es weiter schreiben, mit deinem Puls, deinem Schmerz, deiner Vergangenheit und deinen Vermutungen. \nDer Schmetterling bricht die Fesselung des Papiers, und dein Geist wird frei. \nDu beginnst dir vorzustellen, wie glücklich du im Vergnügungspark bist. Du hast Doresain nicht erzählt, dass du Vergnügungsparks wirklich magst, selbst wenn es ein Friedhofsvergnügungspark ist... \nDas sollte... nicht zu makaber sein, oder?"
  },
  Event_91482_Name = {
    Text = "Schatten von Schmetterlingen"
  },
  Event_91483_ChoiceDesc1 = {
    Text = "[Erneut beobachten]Wähle eine von drei Befehlskarten und erhalte ein Gebet: „(EnchantConfig.Arg1)“"
  },
  Event_91483_Desc = {
    Text = "Das einst klare Abendessen verwandelte sich in ein blutiges Festmahl. Du erinnerst dich an die Zutaten auf dem Herd – der faulige Geruch reizt deine Nase. \n Angst packt dein Herz. Du musst eine Entscheidung treffen."
  },
  Event_91483_Name = {
    Text = "Schatten der Vergangenheit"
  },
  Event_91484_ChoiceDesc1 = {
    Text = "[Ignoriere das Klingeln]Erhalte 3-wählen-1 fortgeschrittenes Gebet"
  },
  Event_91484_ChoiceDesc2 = {
    Text = "[Hörer abheben]Erhalte das goldene Relikt „(RelicConfig.Arg1)“, infiziere „(Skill.Arg2)“"
  },
  Event_91484_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte 50 schwarze Siegel"
  },
  Event_91484_Desc = {
    Text = "Es hätte nicht läuten sollen – das Telefon, eingekringelt hinter der Leinwand. \n Das Kabel des Hörers ist um den massiven Körper gewickelt, wie eine verrostete Nabelschnur, die scheinbar aus deinem Gehirn herausragt. \n Du versuchst, die Frequenz der Vibrationen genau zu erkennen, das unheimliche Geräusch ähnelt Pickmans surrealer Kunst."
  },
  Event_91484_Name = {
    Text = "Verpasster Anruf"
  },
  Event_91485_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_91485_Desc = {
    Text = "Du hebst das kalte Gehirn hoch, und im nächsten Moment gleitet es lautlos durch deine Finger und verwandelt sich in fließendes Wasser. \n Die Waage gerät sofort aus dem Gleichgewicht, das Herz fällt schnell wie eine verdorbene Frucht zusammen und schmilzt zu einem stillen, schwarzen Wasserpfütze. \n Alle Hungergefühle verschwinden, du erlangst Ruhe, Reue und einen kurzen Moment der Klarheit."
  },
  Event_91485_Name = {
    Text = "Hunger Games"
  },
  Event_91486_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_91486_Desc = {
    Text = "Kein Laut, keine Antwort. Vielleicht nur ein Scherz? \nAls du den Hörer gerade ablegst, fließt plötzlich ein schweres Gefühl in deinen Körper zurück."
  },
  Event_91486_Name = {
    Text = "Verpasster Anruf"
  },
  Event_91487_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_91487_Desc = {
    Text = "Die Krähe verschwindet. \nDoch du siehst dich selbst in einem anderen nächtlichen Spiegel stehen und die Krähe anstarren. \nSie schreit immer noch lautlos, als ob sie auf deine Antwort wartete."
  },
  Event_91487_Name = {
    Text = "Stumme Beichte"
  },
  Event_91488_ChoiceDesc1 = {
    Text = "[Erneut beobachten]Wähle eine von drei Befehlskarten und erhalte ein Gebet: „(EnchantConfig.Arg1)“"
  },
  Event_91488_ChoiceDesc2 = {
    Text = "[Widerstand aufgeben]Infiziere „(Skill.Arg1)“, tausche das erhaltene Orison aus Option 1, kann noch einmal verwendet werden"
  },
  Event_91488_Desc = {
    Text = [[
Du wendest entschlossen deinen Blick ab, doch die Bilder erscheinen wie Schatten vor deinen Augen ...
Es ist ein trauriger Tanz zu zweit.]]
  },
  Event_91488_Name = {
    Text = "Schatten der Vergangenheit"
  },
  Event_91489_ChoiceDesc1 = {
    Text = "[Genießen]Wähle eine aus 3 Befehlskarten und erhalte ein Gebet: „(EnchantConfig.Arg1)“"
  },
  Event_91489_ChoiceDesc2 = {
    Text = "[Ablehnen]Infiziere „(Skill.Arg1)“, drucke neu, maximal 2 Mal durchführen"
  },
  Event_91489_Desc = {
    Text = "Das hat Durschein euch als Ergebnis seiner mühsamen Ermittlungen sorgfältig vorbereitet.\nGewürzlos, aber dennoch ohne Verwesungsgeruch – wie Durschein sagte, das beste Zutat.\nDas Festmahl ist für dich angerichtet, und das Gehirn liegt stumm auf dem Teller.\n“Möchtest du probieren?“"
  },
  Event_91489_Name = {
    Text = "Genießen von köstlichen Gerichten"
  },
  Event_91490_ChoiceDesc1 = {
    Text = "[Zuhören]Erhalte 40 schwarze Siegel, infiziere „(Skill.Arg2)“, weiter wählen"
  },
  Event_91490_ChoiceDesc2 = {
    Text = "[Ignoriere]erhalte 25 das schwarze Siegel, verlasse"
  },
  Event_91490_Desc = {
    Text = "Das ist eine Krähe. \nSie steht auf einem Schädel, öffnet den Schnabel, gibt jedoch keinen Laut von sich."
  },
  Event_91490_Name = {
    Text = "Stumme Beichte"
  },
  Event_91491_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_91491_Desc = {
    Text = "Langsam streckst du deine Hand nach dem noch warmen Herzen aus, es schlägt und zieht sich zusammen, bis es sich in einen duftenden heißen Dampf verwandelt. \nDie Waage bebt heftig, das Gehirn fällt in die endlose Dunkelheit. \nEin Gefühl der Sättigung ersetzt den Hunger, du verstehst Leidenschaft, Schmerz und wahre Erinnerungen."
  },
  Event_91491_Name = {
    Text = "Hunger Games"
  },
  Event_91492_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_91492_Desc = {
    Text = "Du hebst den Kopf und empfängst das lautlose Drehen, wie ein Pilger des alten Opfers. \n Sie genießen fröhlich dein Fleisch und Blut, du fühlst Schmerz, aber auch Klarheit. \n Du siehst dein verlorenes Ich, die Teile, die nicht gestorben sind, werden endlich fortgebracht. \n Als das Bewusstsein zurückkehrt, stellst du fest, dass du wohlbehalten bist."
  },
  Event_91492_Name = {Text = "Rabenfest"},
  Event_91493_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_91493_Desc = {
    Text = "Du verschließt das Schlüsselloch mit dem Zement deiner Erinnerungen und Emotionen, die Wahrheit kann dich nicht mehr verführen. \n Als Durschein dich so angespannt sieht, leckt er sich über die Lippen. \n “Möchtest du es noch einmal probieren? Das ist eine speziell für den ehrwürdigen Schutzherrn zubereitete Gehirnlappen-Mozzarella.“"
  },
  Event_91493_Name = {Text = "Apokalypse"},
  Event_91494_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_91494_Desc = {
    Text = "Eigentlich warst du schon immer neugierig auf die Erfahrung eines Ghuls.\n„Also bist du in die Ratten hineingegangen und hast dich ihnen angeschlossen –“\nDu musst zugeben, dass die Ankunft der Seefahrer deinen Geist etwas verwirrt hat."
  },
  Event_91494_Name = {
    Text = "Verbanntes Königreich"
  },
  Event_91495_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_91495_Desc = {
    Text = "Du willst dich nicht mit Korruption und Chaos befassen. \nDu hast dich längst daran gewöhnt, dass alles im Verfall ist, als wäre es normal."
  },
  Event_91495_Name = {
    Text = "Verbanntes Königreich"
  },
  Event_91496_ChoiceDesc1 = {
    Text = "[Genießen]Wähle eine aus 3 Befehlskarten und erhalte ein Gebet: „(EnchantConfig.Arg1)“"
  },
  Event_91496_ChoiceDesc2 = {
    Text = "[Ablehnen]infiziert „(Skill.Arg1)“, erneut zufällig drucken"
  },
  Event_91496_Desc = {
    Text = "Durschein schneidet dir elegant ein Stück «Gehirn» ab.\nDieser süße Geschmack ...\nDiese weiche, zarte Konsistenz ...\nDu möchtest unbedingt noch einen Bissen probieren."
  },
  Event_91496_Name = {
    Text = "Genießen von köstlichen Gerichten"
  },
  Event_91497_ChoiceDesc1 = {
    Text = "[Ich träume]erhalte ein Silberrelikt „(RelicConfig.Arg1)“"
  },
  Event_91497_ChoiceDesc2 = {
    Text = "[Das ist nicht normal]Erhalte das goldene Relikt „(RelicConfig.Arg1)“, infiziere „(Skill.Arg2)“"
  },
  Event_91497_Desc = {
    Text = "Der glatte Grabstein spiegelt ein sich langsam verzerrendes Auge wider. \n Es scheint, als trage es ein Bild, das mit dem bloßen Auge nicht erfasst werden kann, eine Erinnerung, die nicht dir gehört, aber tief in den Falten deiner Augen verwurzelt ist. \n Du versuchst zu blinzeln und mit deinem Finger darüber zu streichen, doch dieses Auge gehört nicht mehr dir, es beginnt kaleidoskopartige Szenen zu reflektieren."
  },
  Event_91497_Name = {
    Text = "Fast normal"
  },
  Event_91498_ChoiceDesc1 = {
    Text = "[Weiter beobachten]Wähle eine von drei Befehlskarten aus und erhalte das Orison: „(EnchantConfig.Arg1)“"
  },
  Event_91498_ChoiceDesc2 = {
    Text = "[Blick abwenden]Infiziere „(Skill.Arg1)“, tausche das erhaltene Orison aus Option 1, kann zweimal verwendet werden"
  },
  Event_91498_Desc = {
    Text = "In der feuchten Ecke der Burg entdeckst du die Filmrolle. \n Die Bilder erscheinen wie Schatten, die im Fluss der Zeit ertrinken, sie erstarren in langsamen Standbildern, dehnen sich manchmal zu unerklärlichen Ungeheuern und kollabieren dann wieder zu flackernden Sternen. \n Du bist darin vertieft, ein Schwindelgefühl erinnert dich an das Verstrichen der Zeit."
  },
  Event_91498_Name = {
    Text = "Schatten der Vergangenheit"
  },
  Event_91499_ChoiceDesc1 = {
    Text = "[Sterne anstarren]Erhalte ein goldenes Relikt „(RelicConfig.Arg1)“, infiziere „(Skill.Arg2)“"
  },
  Event_91499_ChoiceDesc2 = {
    Text = "[Augen schließen]Zufälliges Erwachen von 2 Erwachten, Infektion zweimal“(Skill.Arg1)“"
  },
  Event_91499_ChoiceDesc3 = {
    Text = "[Verlassen]Erhalte 50 schwarze Siegel"
  },
  Event_91499_Desc = {
    Text = "Du stehst auf dem menschenleeren Friedhof, die Sterne lassen die Nacht hell wie den Tag erscheinen.\nDie Lichtkugeln, die in der Tiefsee der Zeit treiben, sprechen nicht, doch in der langen, traumähnlichen Drehung fokussieren sie langsam.\nSie blicken auf den vergessenen Einsamen Stern.\nEr blickt auf dich, auf alles, was tot ist und auf die Ewigkeit."
  },
  Event_91499_Name = {
    Text = "Nacht der Sterne"
  },
  Event_91500_ChoiceDesc1 = {
    Text = "[Zuhören]Erhalte 20 schwarze Siegel, infiziere „(Skill.Arg2)“"
  },
  Event_91500_ChoiceDesc2 = {
    Text = "[Ignorieren]Verlassen"
  },
  Event_91500_Desc = {
    Text = "Du blickst ihm direkt in die Augen. \nIn der völligen Dunkelheit siehst du ein gieriges Feuer."
  },
  Event_91500_Name = {
    Text = "Stumme Beichte"
  },
  Event_91501_ChoiceDesc1 = {
    Text = "[Öffne das Schlüsselloch]Erhalte ein verfluchtes Relikt „(RelicConfig.Arg1)“, infiziere „(Skill.Arg2)“"
  },
  Event_91501_ChoiceDesc2 = {
    Text = "[Schlüsselloch versiegeln] Eine zufällige Karte erhält das Gebet: [(EnchantConfig.Arg1)]"
  },
  Event_91501_Desc = {
    Text = "Als du Durschein das Gehirnlappen überreicht, wehrst du dich mehrmals, kannst aber letztendlich der Versuchung des Wissens nicht widerstehen. \nDas Wissen kommt nicht langsam, sondern strömt plötzlich herein. \nDein Gehirn beginnt zu pochen, das Denken dehnt sich wie ein gärendes Brot aus. Als du schließlich zusammenbrichst, zieht der Schmerz sich wie eine Flut zurück, und dein Bewusstsein scheint eine Leere zu hinterlassen, einen sauberen, alten Schlüsselloch. \nSo sieht also das Wissen aus! Du spürst eine noch nie dagewesene Weisheit. \nVielleicht... kannst du noch mehr erhalten?"
  },
  Event_91501_Name = {Text = "Apokalypse"},
  Event_91502_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_91502_Desc = {
    Text = "Du hebst die Klinge des verbliebenen Bewusstseins und drückst sie in das Schlüsselloch. \n Du weißt nicht, was ein Schlüssel ist, versuchst es nur mit Besessenheit. In diesem Moment verbrennt dein Geist vollständig und hinterlässt nur eine Art unmenschlicher Logik, die im leeren Schlüsselloch flüstert. \n Ist das die Erleuchtung? Aufgeregt teilst du es mit Doresain. \n “Möchtest du noch einen Versuch? Das ist eine speziell für den Schutzherrn zubereitete Gehirnblätter-Mozzarella.“"
  },
  Event_91502_Name = {Text = "Apokalypse"},
  Event_91503_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_91503_Desc = {
    Text = "Du zündest es weder an noch unterdrückst du es. \n In einem subtilen Zustand des Beobachters betrachtest du die sprudelnden Gedanken als Teil des Wetterwechsels und lässt sie ihren unbekannten Ausgang selbst finden. \n In dem Bild aus Blut und Fleisch erlebst du die ewige Kunst."
  },
  Event_91503_Name = {
    Text = "Schlafender Vulkan"
  },
  Event_91504_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_91504_Desc = {
    Text = "Die Tasten hörten abrupt auf, der Schmetterlingsschatten verschwand im Nu. \n Ist das eine Halluzination? Du hast das Gefühl, etwas verloren zu haben. \n Vielleicht solltest du Doresain zuhören und im Gedächtnis-Konservenladen etwas Gehirnblätter kaufen. \n “Nein, was denke ich da?“"
  },
  Event_91504_Name = {
    Text = "Schatten von Schmetterlingen"
  },
  Event_91505_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_91505_Desc = {
    Text = "Du kämpfst nicht mehr, lässt die Flügel und die schwarze Flüssigkeit durch deine Handflächen dringen. \n Du bist sein Gefäß geworden, und es denkt weiter in dir. \n Der Schmetterling wird immer größer, und schließlich kannst du das Gewicht nicht mehr ertragen. \n Daraufhin schneidet Doresain mit einem Essmesser die Verbindung zwischen dir und dem Schmetterling durch. Sein aufgeregter Blick zeigt deutlich, dass er... \n du hast seinen Antrag abgelehnt."
  },
  Event_91505_Name = {
    Text = "Parasit der Oberschicht"
  },
  Event_91506_ChoiceDesc1 = {
    Text = "[Zuhören]Erhalte 35 schwarze Siegel, infiziere „(Skill.Arg2)“, weiter wählen"
  },
  Event_91506_ChoiceDesc2 = {
    Text = "[Ignorieren]Verlassen"
  },
  Event_91506_Desc = {
    Text = "Du hattest gedacht, es sei stumm, bis dein Bewusstsein plötzlich kippte, als würden unzählige Krähenköpfe in deinem Kopf schreien.\nDu kniest auf den Boden, die Welt dreht sich vor deinen Augen."
  },
  Event_91506_Name = {
    Text = "Stumme Beichte"
  },
  Event_91507_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_91507_Desc = {
    Text = "Du schließt die Augen und trittst in den endlosen, sanften Staubnebel ein, während die Nebel dich umarmen und du deine Form verlierst. Eine Existenz, die stabiler ist als der Körper, sedimentiert in dir. \n In dieser Nacht drehen sich die Sterne weiter, wie gewohnt hell. \n Was bedeutet der Sternenhimmel für die Unsterblichen? Vielleicht solltest du Doresain fragen."
  },
  Event_91507_Name = {
    Text = "Nacht der Sterne"
  },
  Event_91508_ChoiceDesc1 = {
    Text = "[Genießen]Wähle eine aus 3 Befehlskarten und erhalte ein Gebet: „(EnchantConfig.Arg1)“"
  },
  Event_91508_Desc = {
    Text = "Ah, es ist Käse. \n Du bist erleichtert, aber gleichzeitig ein wenig enttäuscht."
  },
  Event_91508_Name = {
    Text = "Genießen von köstlichen Gerichten"
  },
  Event_91509_ChoiceDesc1 = {
    Text = "[Entzünde] infiziere «(Skill.Arg1)», erhalte das silberne Relikt «(RelicConfig.Arg2)»"
  },
  Event_91509_ChoiceDesc2 = {
    Text = "[Warte]infiziere „(Skill.Arg1)“, erhalte das silberne Relikt „(RelicConfig.Arg2)“"
  },
  Event_91509_ChoiceDesc3 = {
    Text = "[Versiegeln]Erhalte 25 schwarze Siegel"
  },
  Event_91509_Desc = {
    Text = "Du starrst auf Picmans Gemälde, und der ekelhafte Geruch von Verwesung versetzt dich in Schwindel. \nGedanken steigen langsam aus deinem Kopf auf, zunächst nur Hitze, dann Dunst, und später –"
  },
  Event_91509_Name = {
    Text = "Schlafender Vulkan"
  },
  Event_91510_ChoiceDesc1 = {
    Text = "[Berühre das Gehirn]Zufällig 1 Befehlskarte erhält das Gebet: „(EnchantConfig.Arg1)“"
  },
  Event_91510_ChoiceDesc2 = {
    Text = "[Herz berühren]Erhöhe Arg1 Punkte maximale Gesundheit, infiziere „(Skill.Arg2)“"
  },
  Event_91510_Desc = {
    Text = "Du trittst in den grauen Saal ein, in dem niemand flüstert, eine Waage erscheint im schwarzen Nebel. \n Links liegt ein ruhiges Gehirn wie ein See, silberne Ritzen blitzen schwach; rechts befindet sich ein glühendes, dampfendes Herz. \n Plötzlich nimmst du einen Duft wahr, das Verlangen wächst unaufhörlich, die Vernunft wird von seiner grenzenlosen Dunkelheit erdrückt. \n Du streckst die Hand aus."
  },
  Event_91510_Name = {
    Text = "Hunger Games"
  },
  Event_91511_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_91511_Desc = {
    Text = "Das muss ein Traum sein. Du redest dir das immer wieder ein. \n Ohne es zu merken, bist du tatsächlich in den Schlaf gefallen. \n Vielleicht weil du in letzter Zeit zu viel kommuniziert hast, hast du tatsächlich von Doresain geträumt - dass du ihn aktiv bittest, dein Fleisch und Blut zu essen? Was für eine Horrorgeschichte?"
  },
  Event_91511_Name = {
    Text = "Fast normal"
  },
  Event_91660_ChoiceDesc1 = {
    Text = "[Einen anderen Weg finden] Wähle 1 von 3 Befehlskarten aus, um ein Gebet zu erhalten: [(EnchantConfig.Arg1)]"
  },
  Event_91660_ChoiceDesc2 = {
    Text = "[Lass es bestehen]Erhalte 3 zufällige Befehlskarten und erhalte das Gotteszeichen: „(EnchantConfig.Arg1)“, Infektion „(Skill.Arg2)“"
  },
  Event_91660_Desc = {
    Text = "“Um die Seele zu treiben, musst du die Toten bis zum Ende führen.“\nMit Doresains Worten hast du eine Offenbarung. \nEs ist nicht Wissen, noch ist es Erinnerung - es ist mehr wie ein Gewicht, das aus deinen Augenhöhlen strömt und wie eine Flut in dein Gehirn einfließt. \nDeine Emotionen scheinen nicht mehr zu dieser Zeit und an diesem Ort zu gehören, sie ziehen sich zurück und zeigen eine Lücke im Universum, die vernachlässigt wurde. \nAlles, was du wahrnehmen kannst, hört dort auf, als hättest du das Ende eines Weges erreicht."
  },
  Event_91660_Name = {Text = "Seelenende"},
  Event_91661_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_91661_Desc = {
    Text = "Du lässt deine Seele weit entfernen. \nAm Rand des „Ichs“ hörst du das Flüstern der Toten. \nDoch beim Versuch, genauer zuzuhören, verschwindet alles."
  },
  Event_91661_Name = {Text = "Seelenende"},
  Event_91662_ChoiceDesc1 = {
    Text = "[Verlassen]"
  },
  Event_91662_Desc = {
    Text = "Du umhüllst dein Bewusstsein, um unbekannte Verlockungen abzuschirmen.\nDu verlierst dich am Ende deiner Seele und siehst nur noch dich selbst.\nTatsächlich kannst du als lebender Mensch nicht die Fähigkeiten eines Ghuls besitzen."
  },
  Event_91662_Name = {Text = "Seelenende"}
})
return Text_Event
