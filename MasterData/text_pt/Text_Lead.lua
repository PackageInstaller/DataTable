__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_Lead = readonly({
  Lead_1_DefaultName = {Text = "Sylvester"},
  Lead_1_brotherorsister1 = {Text = "Irmão"},
  Lead_1_brotherorsister2 = {Text = "Irmão"},
  Lead_1_heorshe = {Text = "Ele"},
  Lead_1_himorher = {Text = "Ele"},
  Lead_1_hisorher = {Text = "Dele"},
  Lead_1_lordorlady = {
    Text = "Jovem mestre"
  },
  Lead_1_sirormadam = {Text = "Senhor"},
  Lead_2_DefaultName = {Text = "Leonora"},
  Lead_2_brotherorsister1 = {Text = "Irmã"},
  Lead_2_brotherorsister2 = {Text = "Irmã"},
  Lead_2_heorshe = {Text = "Ela"},
  Lead_2_himorher = {Text = "Ela"},
  Lead_2_hisorher = {Text = "Ela"},
  Lead_2_lordorlady = {Text = "Senhorita"},
  Lead_2_sirormadam = {Text = "Senhorita"}
})
return Text_Lead
