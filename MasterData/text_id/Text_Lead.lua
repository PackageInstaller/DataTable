__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_Lead = readonly({
  Lead_1_DefaultName = {Text = "Sylvester"},
  Lead_1_brotherorsister1 = {Text = "Kakak"},
  Lead_1_brotherorsister2 = {Text = "Adik"},
  Lead_1_heorshe = {Text = "Dia"},
  Lead_1_himorher = {Text = "Dia"},
  Lead_1_hisorher = {Text = "Punya dia"},
  Lead_1_lordorlady = {Text = "Tuan Muda"},
  Lead_1_sirormadam = {Text = "Tuan"},
  Lead_2_DefaultName = {Text = "Leonora"},
  Lead_2_brotherorsister1 = {Text = "Kakak"},
  Lead_2_brotherorsister2 = {
    Text = "Adik perempuan"
  },
  Lead_2_heorshe = {Text = "Dia"},
  Lead_2_himorher = {Text = "Dia"},
  Lead_2_hisorher = {Text = "Dia"},
  Lead_2_lordorlady = {Text = "Nona"},
  Lead_2_sirormadam = {Text = "Nona"}
})
return Text_Lead
