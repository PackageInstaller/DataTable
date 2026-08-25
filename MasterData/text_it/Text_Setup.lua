__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_Setup = readonly({
  Setup_117381_SetupTitle = {
    Text = "(For Translators) Toggle Text Key"
  },
  Setup_126062_SetupTitle = {Text = "Profilo"},
  Setup_132685_SetupDesc = {
    Text = "Scopri quali capitoli sono stati tradotti da persone nella tua lingua attuale!"
  },
  Setup_132685_SetupTitle = {
    Text = "Mostra indicatore per i capitoli di Indagine con traduzione ufficiale completata"
  },
  Setup_134015_SetupTitle = {
    Text = "Cambia sfondo di accesso"
  },
  Setup_148459_SetupDesc = {
    Text = "Raggiungendo il Livello di Affinità 20, questo Risvegliatore mostrerà un aspetto speciale della carta nelle battaglie di Operazione e Traphase."
  },
  Setup_148459_SetupTitle = {
    Text = "Effetto \"Scintilla\""
  },
  Setup_18433_SetupTitle = {
    Text = "Testo di Gioco"
  },
  Setup_18434_SetupTitle = {
    Text = "Anti-Aliasing"
  },
  Setup_18436_SetupTitle = {
    Text = "Qualità di Rendering"
  },
  Setup_18438_SetupTitle = {
    Text = "Spostamento Rosso-Blu"
  },
  Setup_18439_SetupTitle = {Text = "Proiezione"},
  Setup_18441_SetupTitle = {
    Text = "Menofina Ripristinata"
  },
  Setup_18443_SetupTitle = {
    Text = "Conferma Esaltazione e Posse"
  },
  Setup_18444_SetupTitle = {
    Text = "Qualità dell'Immagine"
  },
  Setup_18445_SetupTitle = {
    Text = "Profondità di Campo"
  },
  Setup_18448_SetupTitle = {
    Text = "Effetti di Scena"
  },
  Setup_18449_SetupTitle = {
    Text = "Centro Utente"
  },
  Setup_18453_SetupTitle = {Text = "Voce"},
  Setup_18454_SetupTitle = {Text = "Musica"},
  Setup_18455_SetupTitle = {
    Text = "Incarico Completato"
  },
  Setup_18458_SetupTitle = {
    Text = "Illuminazione in Tempo Reale"
  },
  Setup_18459_SetupTitle = {
    Text = "Effetti Sonori"
  },
  Setup_18460_SetupTitle = {
    Text = "Accordo Utente"
  },
  Setup_18461_SetupTitle = {
    Text = "Rifinitura Bordi Sfocati"
  },
  Setup_18462_SetupTitle = {Text = "Volume"},
  Setup_18463_SetupTitle = {
    Text = "Codice di Redenzione"
  },
  Setup_18466_SetupTitle = {
    Text = "Qualità Effetti Speciali"
  },
  Setup_18469_SetupDesc = {
    Text = "30 FPS è più efficiente dal punto di vista energetico, mentre 60 FPS offre maggiore fluidità."
  },
  Setup_18469_SetupTitle = {
    Text = "Frequenza di Fotogrammi Target"
  },
  Setup_21931_SetupTitle = {
    Text = "Contatta il Supporto"
  },
  Setup_24952_SetupDesc = {
    Text = "Una volta attivata, l'interfaccia principale, l'interfaccia di Indagine e altre saranno influenzate dal giroscopio."
  },
  Setup_24952_SetupTitle = {Text = "Giroscopio"},
  Setup_54468_SetupTitle = {
    Text = "Impostazioni Grafiche"
  },
  Setup_54469_SetupTitle = {
    Text = "Risoluzione"
  },
  Setup_54664_SetupTitle = {
    Text = "Mostra Scorciatoie"
  },
  Setup_54673_SetupTitle = {
    Text = "Seleziona Carta 8"
  },
  Setup_54674_SetupTitle = {
    Text = "Seleziona Carta 9"
  },
  Setup_54675_SetupTitle = {
    Text = "Seleziona Carta 2"
  },
  Setup_54676_SetupTitle = {
    Text = "Seleziona Carta 3"
  },
  Setup_54677_SetupTitle = {Text = "Posse"},
  Setup_54678_SetupTitle = {
    Text = "Seleziona Carta 6"
  },
  Setup_54679_SetupTitle = {
    Text = "Seleziona Carta 7"
  },
  Setup_54680_SetupTitle = {
    Text = "Seleziona Carta 4"
  },
  Setup_54681_SetupTitle = {
    Text = "Seleziona Carta 5"
  },
  Setup_54682_SetupTitle = {
    Text = "Esaltazione 1"
  },
  Setup_54683_SetupTitle = {
    Text = "Esaltazione 2"
  },
  Setup_54684_SetupTitle = {
    Text = "Esaltazione 3"
  },
  Setup_54685_SetupTitle = {
    Text = "Esaltazione 4"
  },
  Setup_54686_SetupTitle = {
    Text = "Visualizza Mazzo di Pesca"
  },
  Setup_54687_SetupTitle = {
    Text = "Seleziona Carta 20"
  },
  Setup_54688_SetupTitle = {Text = "Fine Turno"},
  Setup_54689_SetupTitle = {
    Text = "Seleziona Carta 1"
  },
  Setup_54690_SetupTitle = {
    Text = "Annulla e Impostazioni"
  },
  Setup_54691_SetupTitle = {
    Text = "Abilità del Reame 1"
  },
  Setup_54692_SetupTitle = {
    Text = "Seleziona Carta 10"
  },
  Setup_54693_SetupTitle = {
    Text = "Seleziona Carta 11"
  },
  Setup_54694_SetupTitle = {
    Text = "Seleziona Carta 12"
  },
  Setup_54695_SetupTitle = {
    Text = "Seleziona Carta 13"
  },
  Setup_54696_SetupTitle = {
    Text = "Seleziona Carta 14"
  },
  Setup_54697_SetupTitle = {
    Text = "Seleziona Carta 15"
  },
  Setup_54698_SetupTitle = {
    Text = "Seleziona Carta 16"
  },
  Setup_54699_SetupTitle = {
    Text = "Seleziona Carta 17"
  },
  Setup_54700_SetupTitle = {
    Text = "Seleziona Carta 18"
  },
  Setup_54701_SetupTitle = {
    Text = "Seleziona Carta 19"
  },
  Setup_55509_SetupTitle = {
    Text = "Esci dal Gioco"
  },
  Setup_70541_SetupTitle = {
    Text = "Riproduzione in sottofondo"
  },
  Setup_72153_SetupTitle = {
    Text = "Abilità del Reame 2"
  },
  Setup_94404_SetupTitle = {
    Text = "Gioca Carta"
  },
  Setup_94405_SetupTitle = {
    Text = "Carta Precedente"
  },
  Setup_94406_SetupTitle = {
    Text = "Carta Successiva"
  },
  Setup_94566_SetupTitle = {
    Text = "Sfondo Dinamico di Battaglia"
  }
})
return Text_Setup
