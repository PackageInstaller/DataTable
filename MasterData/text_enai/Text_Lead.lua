__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_Lead = readonly({
  Lead_1_DefaultName = {Text = "Sylvester"},
  Lead_1_brotherorsister1 = {
    Text = "Older Brother"
  },
  Lead_1_brotherorsister2 = {
    Text = "Younger Brother"
  },
  Lead_1_heorshe = {Text = "He"},
  Lead_1_himorher = {Text = "He"},
  Lead_1_hisorher = {Text = "His"},
  Lead_1_lordorlady = {
    Text = "Young Master"
  },
  Lead_1_sirormadam = {Text = "Sir"},
  Lead_2_DefaultName = {Text = "Leonora"},
  Lead_2_brotherorsister1 = {
    Text = "Older Sister"
  },
  Lead_2_brotherorsister2 = {
    Text = "Younger Sister"
  },
  Lead_2_heorshe = {Text = "She"},
  Lead_2_himorher = {Text = "She"},
  Lead_2_hisorher = {Text = "Her"},
  Lead_2_lordorlady = {Text = "Miss"},
  Lead_2_sirormadam = {Text = "Miss"}
})
return Text_Lead
