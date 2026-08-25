__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_Lead = readonly({
  Lead_1_DefaultName = {Text = "Tây Vitt"},
  Lead_1_brotherorsister1 = {Text = "Anh trai"},
  Lead_1_brotherorsister2 = {Text = "Em trai"},
  Lead_1_heorshe = {Text = "Hắn"},
  Lead_1_himorher = {Text = "Hắn"},
  Lead_1_hisorher = {
    Text = "Của anh ấy"
  },
  Lead_1_lordorlady = {
    Text = "Cậu chủ"
  },
  Lead_1_sirormadam = {Text = "Ông"},
  Lead_2_DefaultName = {
    Text = "Liêu No La"
  },
  Lead_2_brotherorsister1 = {Text = "Chị"},
  Lead_2_brotherorsister2 = {Text = "Em gái"},
  Lead_2_heorshe = {Text = "Cô ấy"},
  Lead_2_himorher = {Text = "Cô ấy"},
  Lead_2_hisorher = {Text = "Cô ấy"},
  Lead_2_lordorlady = {
    Text = "Thiếu nữ"
  },
  Lead_2_sirormadam = {
    Text = "Thiếu nữ"
  }
})
return Text_Lead
