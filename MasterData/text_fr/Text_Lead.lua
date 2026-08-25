__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_Lead = readonly({
  Lead_1_DefaultName = {Text = "Sylvester"},
  Lead_1_brotherorsister1 = {Text = "Frère"},
  Lead_1_brotherorsister2 = {Text = "Frère"},
  Lead_1_heorshe = {Text = "Il"},
  Lead_1_himorher = {Text = "Il"},
  Lead_1_hisorher = {Text = "Le sien"},
  Lead_1_lordorlady = {
    Text = "Le jeune maître"
  },
  Lead_1_sirormadam = {Text = "Monsieur"},
  Lead_2_DefaultName = {Text = "Leonora"},
  Lead_2_brotherorsister1 = {
    Text = "Grande sœur"
  },
  Lead_2_brotherorsister2 = {
    Text = "Petite sœur"
  },
  Lead_2_heorshe = {Text = "Elle"},
  Lead_2_himorher = {Text = "Elle"},
  Lead_2_hisorher = {Text = "Elle"},
  Lead_2_lordorlady = {
    Text = "Mademoiselle"
  },
  Lead_2_sirormadam = {
    Text = "Mademoiselle"
  }
})
return Text_Lead
