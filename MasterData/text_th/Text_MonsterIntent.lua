__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_MonsterIntent = readonly({
  ["MonsterIntent_怪物意图不明_Name"] = {
    Text = "ไม่ชัดเจน"
  },
  ["MonsterIntent_怪物意图不明_TipId"] = {
    Text = "ไม่สามารถตรวจสอบการเคลื่อนไหวในรอบถัดไปได้"
  },
  ["MonsterIntent_怪物意图不明呢喃1_Name"] = {
    Text = "ไม่ชัดเจน"
  },
  ["MonsterIntent_怪物意图不明呢喃1_TipId"] = {
    Text = "ไม่สามารถตรวจสอบการเคลื่อนไหวในรอบถัดไปได้"
  },
  ["MonsterIntent_怪物意图不明呢喃2_Name"] = {
    Text = "ไม่ชัดเจน"
  },
  ["MonsterIntent_怪物意图不明呢喃2_TipId"] = {
    Text = "ไม่สามารถตรวจสอบการเคลื่อนไหวในรอบถัดไปได้"
  },
  ["MonsterIntent_怪物意图不明呢喃3_Name"] = {
    Text = "ไม่ชัดเจน"
  },
  ["MonsterIntent_怪物意图不明呢喃3_TipId"] = {
    Text = "ไม่สามารถตรวจสอบการเคลื่อนไหวในรอบถัดไปได้"
  },
  ["MonsterIntent_怪物意图不明呢喃4_Name"] = {
    Text = "ไม่ชัดเจน"
  },
  ["MonsterIntent_怪物意图不明呢喃4_TipId"] = {
    Text = "ไม่สามารถตรวจสอบการเคลื่อนไหวในรอบถัดไปได้"
  },
  ["MonsterIntent_怪物意图不明呢喃5_Name"] = {
    Text = "ไม่ชัดเจน"
  },
  ["MonsterIntent_怪物意图不明呢喃5_TipId"] = {
    Text = "ไม่สามารถตรวจสอบการเคลื่อนไหวในรอบถัดไปได้"
  },
  ["MonsterIntent_怪物意图不明呢喃6_Name"] = {
    Text = "ไม่ชัดเจน"
  },
  ["MonsterIntent_怪物意图不明呢喃6_TipId"] = {
    Text = "ไม่สามารถตรวจสอบการเคลื่อนไหวในรอบถัดไปได้"
  },
  ["MonsterIntent_怪物意图人面犬重攻击_Name"] = {Text = "ตี"},
  ["MonsterIntent_怪物意图人面犬重攻击_TipId"] = {
    Text = "จะสร้างความเสียหายให้กับฝ่ายเรา {s1} แต้ม。"
  },
  ["MonsterIntent_怪物意图削弱_Name"] = {
    Text = "ทำให้อ่อนแอ"
  },
  ["MonsterIntent_怪物意图削弱_TipId"] = {
    Text = "จะส่งผลลบต่อฝ่ายเรา"
  },
  ["MonsterIntent_怪物意图强力削弱_Name"] = {
    Text = "ทำให้อ่อนแอ"
  },
  ["MonsterIntent_怪物意图强力削弱_TipId"] = {
    Text = "จะสร้างผลลบอย่างรุนแรงมากต่อฝ่ายเรา"
  },
  ["MonsterIntent_怪物意图强力强化_Name"] = {
    Text = "เสริมสร้าง"
  },
  ["MonsterIntent_怪物意图强力强化_TipId"] = {
    Text = "จะทำการเสริมสร้าง."
  },
  ["MonsterIntent_怪物意图强化DCB02_2_Name"] = {
    Text = "เสริมสร้าง"
  },
  ["MonsterIntent_怪物意图强化DCB02_2_TipId"] = {
    Text = "จะทำการเสริมสร้าง."
  },
  ["MonsterIntent_怪物意图强化DCB02_4_Name"] = {
    Text = "เสริมสร้าง"
  },
  ["MonsterIntent_怪物意图强化DCB02_4_TipId"] = {
    Text = "จะทำการเสริมสร้าง."
  },
  ["MonsterIntent_怪物意图强化_Name"] = {
    Text = "เสริมสร้าง"
  },
  ["MonsterIntent_怪物意图强化_TipId"] = {
    Text = "จะทำการเสริมสร้าง."
  },
  ["MonsterIntent_怪物意图攻击_Name"] = {Text = "ตี"},
  ["MonsterIntent_怪物意图攻击_TipId"] = {
    Text = "จะสร้างความเสียหายให้กับฝ่ายเรา {s1} แต้ม。"
  },
  ["MonsterIntent_怪物意图攻击和削弱_Name"] = {
    Text = "โจมตี & อ่อนแอ"
  },
  ["MonsterIntent_怪物意图攻击和削弱_TipId"] = {
    Text = "จะสร้างความเสียหาย {s1} หน่วยให้กับฝ่ายเรา และใส่ผลลบให้ฝ่ายเรา"
  },
  ["MonsterIntent_怪物意图攻击和削弱卡茜亚隔空取物_Name"] = {
    Text = "โจมตี & อ่อนแอ"
  },
  ["MonsterIntent_怪物意图攻击和削弱卡茜亚隔空取物_TipId"] = {
    Text = "จะสร้างความเสียหาย {s1} หน่วยให้กับฝ่ายเรา และใส่ผลลบให้ฝ่ายเรา"
  },
  ["MonsterIntent_怪物意图攻击和强化_Name"] = {
    Text = "โจมตี และ เสริมสร้าง"
  },
  ["MonsterIntent_怪物意图攻击和强化_TipId"] = {
    Text = "จะสร้างความเสียหาย {s1} ให้กับฝ่ายเรา และทำการเสริมสร้าง。"
  },
  ["MonsterIntent_怪物意图攻击和防御_Name"] = {
    Text = "โจมตี&การป้องกัน"
  },
  ["MonsterIntent_怪物意图攻击和防御_TipId"] = {
    Text = "จะสร้างความเสียหายจำนวน {s1} หน่วยให้กับฝ่ายเรา และเพิ่มโล่ป้องกัน。"
  },
  ["MonsterIntent_怪物意图狂气_Name"] = {
    Text = "ระเบิดพลัง"
  },
  ["MonsterIntent_怪物意图狂气_TipId"] = {
    Text = "ในรอบถัดไปจะเกิดคลั่งไคล้ถึงขีดสุด"
  },
  ["MonsterIntent_怪物意图狂气非攻击_Name"] = {
    Text = "ระเบิดพลัง"
  },
  ["MonsterIntent_怪物意图狂气非攻击_TipId"] = {
    Text = "ในรอบถัดไปจะเกิดคลั่งไคล้ถึงขีดสุด"
  },
  ["MonsterIntent_怪物意图眩晕_Name"] = {
    Text = "สตั้น"
  },
  ["MonsterIntent_怪物意图眩晕_TipId"] = {
    Text = "อยู่ในสถานะมึนงง ไม่สามารถดำเนินการได้"
  },
  ["MonsterIntent_怪物意图超级狂气_Name"] = {
    Text = "ระเบิดพลัง"
  },
  ["MonsterIntent_怪物意图超级狂气_TipId"] = {
    Text = "ในรอบถัดไปจะเกิดคลั่งไคล้ถึงขีดสุด"
  },
  ["MonsterIntent_怪物意图释放终结_Name"] = {
    Text = "ระเบิดพลัง"
  },
  ["MonsterIntent_怪物意图释放终结_TipId"] = {
    Text = "ตาถัดไปจะเป็นการสิ้นสุดเทิร์นของผู้เล่น"
  },
  ["MonsterIntent_怪物意图重攻击_Name"] = {Text = "ตี"},
  ["MonsterIntent_怪物意图重攻击_TipId"] = {
    Text = "จะสร้างความเสียหายให้กับฝ่ายเรา {s1} แต้ม。"
  },
  ["MonsterIntent_怪物意图防御_Name"] = {
    Text = "การป้องกัน"
  },
  ["MonsterIntent_怪物意图防御_TipId"] = {
    Text = "จะเพิ่มโล่。"
  },
  ["MonsterIntent_怪物意图防御和削弱_Name"] = {
    Text = "การป้องกัน&การอ่อนแอ"
  },
  ["MonsterIntent_怪物意图防御和削弱_TipId"] = {
    Text = "จะเพิ่มโล่และเพิ่มผลลบให้กับฝ่ายเรา。"
  },
  ["MonsterIntent_怪物意图防御和强化_Name"] = {
    Text = "การป้องกัน&เสริมสร้าง"
  },
  ["MonsterIntent_怪物意图防御和强化_TipId"] = {
    Text = "จะเพิ่มโล่และทำการเสริมสร้าง。"
  }
})
return Text_MonsterIntent
