__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_ServerList = readonly({
  ServerList_10_ServerName = {
    Text = "ส่วนบุคคล-JYB(ปัญหาเสถียรภาพ)"
  },
  ServerList_11_ServerName = {
    Text = "เซิร์ฟเวอร์รายสัปดาห์ - ระบบภายใน"
  },
  ServerList_12_ServerName = {
    Text = "เซิร์ฟเวอร์ส่วนตัว-Wu(ผันผวน)"
  },
  ServerList_13_ServerName = {
    Text = "ส่วนบุคคล-ZZH(ผันผวน)"
  },
  ServerList_14_ServerName = {
    Text = "เซิร์ฟเวอร์ส่วนตัว-ZYT(ไม่น่าเชื่อถือ)"
  },
  ServerList_15_ServerName = {
    Text = "เซิร์ฟเวอร์ส่วนตัว-CHK (ไม่เสถียร)"
  },
  ServerList_17_ServerName = {
    Text = "เซิร์ฟเวอร์ส่วนตัว-WL (ไม่นิ่ง)"
  },
  ServerList_18_ServerName = {
    Text = "เซิร์ฟเวอร์ส่วนตัว-YL(ไม่มั่นคง)"
  },
  ServerList_19_ServerName = {
    Text = "เซิร์ฟเวอร์ส่วนตัว-TZX(อาจมีปัญหา)"
  },
  ServerList_1_ServerName = {
    Text = "หอประชุมหลังแรก"
  },
  ServerList_20_ServerName = {
    Text = "ส่วนตัว-BEAU"
  },
  ServerList_21_ServerName = {
    Text = "ชุดส่วนตัว-BJJ"
  },
  ServerList_22_ServerName = {
    Text = "เซิร์ฟเวอร์ส่วนตัว-YCM(ไม่เสถียร)"
  },
  ServerList_23_ServerName = {
    Text = "เซิร์ฟเวอร์ส่วนตัว-TL (อาจไม่เสถียร)"
  },
  ServerList_24_ServerName = {
    Text = "ผู้ใช้-LY-Local"
  },
  ServerList_25_ServerName = {
    Text = "เซิร์ฟเวอร์ส่วนตัว-LY-Remote"
  },
  ServerList_26_ServerName = {
    Text = "เซิร์ฟเวอร์ส่วนตัว-LZP (ไม่เสถียร)"
  },
  ServerList_27_ServerName = {
    Text = "ตู้ส่วนบุคคล-CSC2"
  },
  ServerList_28_ServerName = {
    Text = "เซิร์ฟเวอร์ส่วนตัว-ZD"
  },
  ServerList_29_ServerName = {
    Text = "ส่วนบุคคล-ZKN"
  },
  ServerList_2_ServerName = {
    Text = "เวอร์ชันประจำสัปดาห์ เซิร์ฟเวอร์ต่างประเทศ"
  },
  ServerList_30_ServerName = {
    Text = "เซิร์ฟเวอร์ส่วนตัว-LHH1"
  },
  ServerList_31_ServerName = {
    Text = "ชุดส่วนตัว-hf"
  },
  ServerList_32_ServerName = {
    Text = "เซิร์ฟเวอร์ส่วนตัว-hyf"
  },
  ServerList_33_ServerName = {
    Text = "Liym-ของส่วนตัว"
  },
  ServerList_34_ServerName = {
    Text = "เซิร์ฟเวอร์ส่วนบุคคล-lzz"
  },
  ServerList_35_ServerName = {
    Text = "บริการส่วนตัว-jhl"
  },
  ServerList_36_ServerName = {
    Text = "เซิร์ฟเวอร์เฉพาะ UX"
  },
  ServerList_37_ServerName = {
    Text = "เซิร์ฟเวอร์พิเศษ-เซิร์ฟเวอร์ทดสอบ"
  },
  ServerList_38_ServerName = {
    Text = "การทดสอบภายใน (release)"
  },
  ServerList_39_ServerName = {
    Text = "การทดสอบ-เซิร์ฟเวอร์พัฒนา(candidate)"
  },
  ServerList_3_ServerName = {
    Text = "เซิร์ฟเวอร์ทดสอบ (อัปเดตตามความต้องการ)"
  },
  ServerList_40_ServerName = {
    Text = "ส่วนบุคคล - yzx"
  },
  ServerList_41_ServerName = {
    Text = "เซิร์ฟเวอร์ส่วนตัว-test"
  },
  ServerList_42_ServerName = {
    Text = "Personal Service-bwg"
  },
  ServerList_43_ServerName = {
    Text = "เซิร์ฟเวอร์ QA ทั้งหมดสำหรับเครือข่ายภายใน"
  },
  ServerList_44_ServerName = {
    Text = "เซิร์ฟเวอร์ส่วนตัว-ซือฮวา"
  },
  ServerList_45_ServerName = {
    Text = "เซิร์ฟเวอร์พิเศษ-เวอร์ชันนอกประเทศ (2 สัปดาห์)"
  },
  ServerList_4_ServerName = {
    Text = "เซิร์ฟเวอร์ QA1 (ไม่เสถียร)"
  },
  ServerList_5_ServerName = {
    Text = "เซิร์ฟเวอร์ QA2 (เก็บไว้)"
  },
  ServerList_6_ServerName = {
    Text = "เซิร์ฟเวอร์ QA6 (เก็บไว้)"
  },
  ServerList_7_ServerName = {
    Text = "เซิร์ฟเวอร์พัฒนา (อัปเดตได้ทุกเมื่อ)"
  },
  ServerList_8_ServerName = {
    Text = "การทดสอบแพลตฟอร์มกลาง - Yuan Yang (หยวนหยาง) (ไม่เสถียร)"
  },
  ServerList_9_ServerName = {
    Text = "เซิร์ฟเวอร์ส่วนตัว-LHH(ไม่เสถียร)"
  }
})
return Text_ServerList
