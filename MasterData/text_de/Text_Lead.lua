__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_Lead = readonly({
  Lead_1_DefaultName = {Text = "Sylvester"},
  Lead_1_brotherorsister1 = {Text = "Bruder"},
  Lead_1_brotherorsister2 = {Text = "Bruder"},
  Lead_1_heorshe = {Text = "Er"},
  Lead_1_himorher = {Text = "Er"},
  Lead_1_hisorher = {Text = "Sein"},
  Lead_1_lordorlady = {
    Text = "Junger Herr"
  },
  Lead_1_sirormadam = {Text = "Herr"},
  Lead_2_DefaultName = {Text = "Leonora"},
  Lead_2_brotherorsister1 = {Text = "Schwester"},
  Lead_2_brotherorsister2 = {Text = "Schwester"},
  Lead_2_heorshe = {Text = "Sie"},
  Lead_2_himorher = {Text = "Sie"},
  Lead_2_hisorher = {Text = "Ihre"},
  Lead_2_lordorlady = {Text = "Fräulein"},
  Lead_2_sirormadam = {Text = "Fräulein"}
})
return Text_Lead
