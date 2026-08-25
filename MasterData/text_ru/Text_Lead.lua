__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_Lead = readonly({
  Lead_1_DefaultName = {
    Text = "Сильвестр"
  },
  Lead_1_brotherorsister1 = {Text = "Брат"},
  Lead_1_brotherorsister2 = {Text = "Брат"},
  Lead_1_heorshe = {Text = "Он"},
  Lead_1_himorher = {Text = "Он"},
  Lead_1_hisorher = {Text = "Его"},
  Lead_1_lordorlady = {
    Text = "Молодой господин"
  },
  Lead_1_sirormadam = {
    Text = "Господин"
  },
  Lead_2_DefaultName = {
    Text = "Леонора"
  },
  Lead_2_brotherorsister1 = {
    Text = "Сестра"
  },
  Lead_2_brotherorsister2 = {
    Text = "Сестра"
  },
  Lead_2_heorshe = {Text = "Она"},
  Lead_2_himorher = {Text = "Она"},
  Lead_2_hisorher = {Text = "Её"},
  Lead_2_lordorlady = {
    Text = "Девушка"
  },
  Lead_2_sirormadam = {
    Text = "Девушка"
  }
})
return Text_Lead
