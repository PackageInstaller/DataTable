__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_Lead = readonly({
  Lead_1_DefaultName = {Text = "Sylvester"},
  Lead_1_brotherorsister1 = {Text = "Hermano"},
  Lead_1_brotherorsister2 = {Text = "Hermano"},
  Lead_1_heorshe = {Text = "Él"},
  Lead_1_himorher = {Text = "Él"},
  Lead_1_hisorher = {Text = "Suyo"},
  Lead_1_lordorlady = {Text = "Joven amo"},
  Lead_1_sirormadam = {Text = "Señor"},
  Lead_2_DefaultName = {Text = "Leonora"},
  Lead_2_brotherorsister1 = {Text = "Hermana"},
  Lead_2_brotherorsister2 = {Text = "Hermana"},
  Lead_2_heorshe = {Text = "Ella"},
  Lead_2_himorher = {Text = "Ella"},
  Lead_2_hisorher = {Text = "Su"},
  Lead_2_lordorlady = {Text = "Señorita"},
  Lead_2_sirormadam = {Text = "Señorita"}
})
return Text_Lead
