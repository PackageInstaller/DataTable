__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_Lead = readonly({
  Lead_1_DefaultName = {Text = "Sylvester"},
  Lead_1_brotherorsister1 = {Text = "Fratello."},
  Lead_1_brotherorsister2 = {
    Text = "Fratello minore"
  },
  Lead_1_heorshe = {Text = "Lui"},
  Lead_1_himorher = {Text = "Lui"},
  Lead_1_hisorher = {Text = "Il suo"},
  Lead_1_lordorlady = {
    Text = "Giovane Padrone"
  },
  Lead_1_sirormadam = {Text = "Signore"},
  Lead_2_DefaultName = {Text = "Leonora"},
  Lead_2_brotherorsister1 = {Text = "Sorella!"},
  Lead_2_brotherorsister2 = {
    Text = "Sorella minore"
  },
  Lead_2_heorshe = {Text = "Lei"},
  Lead_2_himorher = {Text = "Lei"},
  Lead_2_hisorher = {Text = "Il suo"},
  Lead_2_lordorlady = {Text = "Signorina"},
  Lead_2_sirormadam = {Text = "Signorina"}
})
return Text_Lead
