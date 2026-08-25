__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_Lead = readonly({
  Lead_1_DefaultName = {
    Text = "ซิลเวสเตอร์"
  },
  Lead_1_brotherorsister1 = {Text = "พี่"},
  Lead_1_brotherorsister2 = {
    Text = "น้องชาย"
  },
  Lead_1_heorshe = {Text = "เขา"},
  Lead_1_himorher = {Text = "เขา"},
  Lead_1_hisorher = {
    Text = "ของเขา"
  },
  Lead_1_lordorlady = {
    Text = "คุณชาย"
  },
  Lead_1_sirormadam = {Text = "คุณ"},
  Lead_2_DefaultName = {
    Text = "ลีโอนอร่า"
  },
  Lead_2_brotherorsister1 = {
    Text = "พี่สาว"
  },
  Lead_2_brotherorsister2 = {
    Text = "น้องสาว"
  },
  Lead_2_heorshe = {Text = "เธอ"},
  Lead_2_himorher = {Text = "เธอ"},
  Lead_2_hisorher = {
    Text = "ของเธอ"
  },
  Lead_2_lordorlady = {
    Text = "คุณหนู"
  },
  Lead_2_sirormadam = {
    Text = "คุณหนู"
  }
})
return Text_Lead
