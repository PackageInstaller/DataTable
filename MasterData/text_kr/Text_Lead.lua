__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_Lead = readonly({
  Lead_1_DefaultName = {
    Text = "실타래베스터"
  },
  Lead_1_brotherorsister1 = {
    Text = "형(오빠)"
  },
  Lead_1_brotherorsister2 = {Text = "동생"},
  Lead_1_heorshe = {Text = "그"},
  Lead_1_himorher = {Text = "그"},
  Lead_1_hisorher = {Text = "그의"},
  Lead_1_lordorlady = {Text = "도련님"},
  Lead_1_sirormadam = {Text = "선생님"},
  Lead_2_DefaultName = {
    Text = "레오노라"
  },
  Lead_2_brotherorsister1 = {
    Text = "누나(언니)"
  },
  Lead_2_brotherorsister2 = {Text = "여동생"},
  Lead_2_heorshe = {Text = "그녀"},
  Lead_2_himorher = {Text = "그녀"},
  Lead_2_hisorher = {Text = "그녀의"},
  Lead_2_lordorlady = {Text = "가정부"},
  Lead_2_sirormadam = {Text = "아가씨"}
})
return Text_Lead
