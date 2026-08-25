__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_Lead = readonly({
  Lead_1_DefaultName = {Text = "Sylvester"},
  Lead_1_brotherorsister1 = {Text = "Kardeşim."},
  Lead_1_brotherorsister2 = {
    Text = "Küçük Erkek Kardeş"
  },
  Lead_1_heorshe = {Text = "O"},
  Lead_1_himorher = {Text = "O"},
  Lead_1_hisorher = {Text = "Onun"},
  Lead_1_lordorlady = {
    Text = "Genç Efendi"
  },
  Lead_1_sirormadam = {Text = "Bayım"},
  Lead_2_DefaultName = {Text = "Leonora"},
  Lead_2_brotherorsister1 = {Text = "Abla!"},
  Lead_2_brotherorsister2 = {
    Text = "Küçük Kız Kardeş"
  },
  Lead_2_heorshe = {Text = "O"},
  Lead_2_himorher = {Text = "O"},
  Lead_2_hisorher = {Text = "Onun"},
  Lead_2_lordorlady = {Text = "Bayan"},
  Lead_2_sirormadam = {Text = "Bayan"}
})
return Text_Lead
