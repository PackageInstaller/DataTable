__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_MapNode = readonly({
  MapNode_100547_Desc = {
    Text = "Descrizione del mercante."
  },
  MapNode_100547_Name = {Text = "Mercante"},
  MapNode_116362_Desc = {
    Text = "Descrizione del Riposo."
  },
  MapNode_116362_Name = {Text = "Riposo"},
  MapNode_116363_Desc = {
    Text = "Descrizione ambigua."
  },
  MapNode_116363_Name = {
    Text = "Sconosciuto"
  },
  MapNode_116365_Desc = {
    Text = "Descrizione del nemico."
  },
  MapNode_116365_Name = {Text = "Nemico"},
  MapNode_116366_Desc = {
    Text = "Descrizione dell'Élite."
  },
  MapNode_116366_Name = {Text = "Élite"},
  MapNode_116367_Desc = {
    Text = "Descrizione del tesoro."
  },
  MapNode_116367_Name = {
    Text = "Tesoro segreto"
  }
})
return Text_MapNode
