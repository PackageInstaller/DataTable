__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_Setup = readonly({
  Setup_117381_SetupTitle = {
    Text = "ตรวจสอบสัญลักษณ์ข้อความ"
  },
  Setup_132685_SetupDesc = {
    Text = "ดูว่าเรื่องราวใดบ้างที่ได้รับการแปลโดยมนุษย์ภายใต้การตั้งค่าภาษาปัจจุบัน"
  },
  Setup_132685_SetupTitle = {
    Text = "แสดงสัญลักษณ์บทที่แปลอย่างเป็นทางการแล้วของ「สืบสวนปฏิบัติการ」"
  },
  Setup_134015_SetupTitle = {
    Text = "เปลี่ยนแอนิเมชันพื้นหลังหน้าเข้าสู่ระบบ"
  },
  Setup_148459_SetupDesc = {
    Text = "เมื่ออัตราการประสานเพิ่มขึ้นถึงระดับ 20 ผู้ปลุกตื่นนี้จะแสดงรูปลักษณ์การ์ดพิเศษในการต่อสู้「การสืบสวน」หรือ「การเล่นหมากรุกเฟส」."
  },
  Setup_148459_SetupTitle = {
    Text = "ผล「ประกายเจิดจ้า」"
  },
  Setup_18433_SetupTitle = {
    Text = "ข้อความเกม"
  },
  Setup_18434_SetupTitle = {
    Text = "การลดรอยหยัก"
  },
  Setup_18436_SetupTitle = {
    Text = "รายละเอียดกราฟิก"
  },
  Setup_18438_SetupTitle = {
    Text = "การเลื่อนสีแดงและน้ำเงิน"
  },
  Setup_18439_SetupTitle = {
    Text = "เงาฉาย"
  },
  Setup_18441_SetupTitle = {
    Text = "ลิงฟีไทเต็มอีกครั้ง"
  },
  Setup_18443_SetupTitle = {
    Text = "คลั่งไคล้ถึงขีดสุดและการใช้กุญแจลับยืนยัน"
  },
  Setup_18444_SetupTitle = {
    Text = "คุณภาพภาพ"
  },
  Setup_18445_SetupTitle = {
    Text = "ระยะชัดลึก"
  },
  Setup_18448_SetupTitle = {
    Text = "เอฟเฟกต์ฉาก"
  },
  Setup_18449_SetupTitle = {
    Text = "ศูนย์ผู้ใช้"
  },
  Setup_18453_SetupTitle = {
    Text = "เสียง"
  },
  Setup_18454_SetupTitle = {
    Text = "ดนตรี"
  },
  Setup_18455_SetupTitle = {
    Text = "การมอบหมายได้เสร็จแล้ว"
  },
  Setup_18458_SetupTitle = {
    Text = "แสงจริง"
  },
  Setup_18459_SetupTitle = {
    Text = "เอฟเฟกต์เสียง"
  },
  Setup_18460_SetupTitle = {
    Text = "ข้อกำหนดและเงื่อนไขการใช้งาน"
  },
  Setup_18461_SetupTitle = {
    Text = "ตัดขอบเบลอ"
  },
  Setup_18462_SetupTitle = {
    Text = "ความดัง"
  },
  Setup_18463_SetupTitle = {
    Text = "รหัสแลกของรางวัล"
  },
  Setup_18466_SetupTitle = {
    Text = "คุณภาพของเอฟเฟกต์"
  },
  Setup_18469_SetupDesc = {
    Text = "30 fps ประหยัดพลังงานมากกว่า 60 fps ลื่นไหลมากกว่า."
  },
  Setup_18469_SetupTitle = {
    Text = "อัตราเฟรมเป้าหมาย"
  },
  Setup_21931_SetupTitle = {
    Text = "ติดต่อฝ่ายบริการลูกค้า"
  },
  Setup_24952_SetupDesc = {
    Text = "เมื่อเปิดใช้งานแล้ว หน้าหลักและการสอบสวนดำเนินการจะได้รับผลกระทบจากเซ็นเซอร์ตรวจจับแรงโน้มถ่วง"
  },
  Setup_24952_SetupTitle = {
    Text = "ไจโรสโคป"
  },
  Setup_54468_SetupTitle = {
    Text = "การตั้งค่าภาพ"
  },
  Setup_54469_SetupTitle = {
    Text = "ความละเอียด"
  },
  Setup_54664_SetupTitle = {
    Text = "แสดงปุ่มลัด"
  },
  Setup_54673_SetupTitle = {
    Text = "เลือกไพ่ในมือ 8"
  },
  Setup_54674_SetupTitle = {
    Text = "เลือก 9 ไพ่ในมือ"
  },
  Setup_54675_SetupTitle = {
    Text = "เลือกการ์ดมือ 2"
  },
  Setup_54676_SetupTitle = {
    Text = "เลือกไพ่ในมือ 3 ใบ"
  },
  Setup_54677_SetupTitle = {
    Text = "ใช้กุญแจลับ"
  },
  Setup_54678_SetupTitle = {
    Text = "6 เลือกไพ่ในมือ"
  },
  Setup_54679_SetupTitle = {
    Text = "เลือกการ์ดในมือ 7"
  },
  Setup_54680_SetupTitle = {
    Text = "เลือกการ์ดในมือ 4"
  },
  Setup_54681_SetupTitle = {
    Text = "เลือกไพ่ในมือ 5"
  },
  Setup_54682_SetupTitle = {
    Text = "ความคลั่งถึงขีดสุด1"
  },
  Setup_54683_SetupTitle = {
    Text = "ความคลั่งระเบิด 2"
  },
  Setup_54684_SetupTitle = {
    Text = "คลั่งไคล้ถึงขีดสุด 3"
  },
  Setup_54685_SetupTitle = {
    Text = "ความคลั่งถึงขีดสุด 4"
  },
  Setup_54686_SetupTitle = {
    Text = "ดูกองจั่ว"
  },
  Setup_54687_SetupTitle = {
    Text = "เลือกไพ่ในมือ ๒๐"
  },
  Setup_54688_SetupTitle = {
    Text = "สิ้นสุดเทิร์น"
  },
  Setup_54689_SetupTitle = {
    Text = "เลือกไพ่ในมือ 1"
  },
  Setup_54690_SetupTitle = {
    Text = "ตั้งค่า / ยกเลิก"
  },
  Setup_54691_SetupTitle = {
    Text = "เปิดใช้งานความสามารถขอบเขต1"
  },
  Setup_54692_SetupTitle = {
    Text = "เลือกไพ่ในมือ จำนวน 10"
  },
  Setup_54693_SetupTitle = {
    Text = "เลือกไพ่ในมือ 11"
  },
  Setup_54694_SetupTitle = {
    Text = "เลือกไพ่ในมือ ๑๒"
  },
  Setup_54695_SetupTitle = {
    Text = "เลือกไพ่ในมือ13"
  },
  Setup_54696_SetupTitle = {
    Text = "เลือกไพ่ในมือจำนวน 14"
  },
  Setup_54697_SetupTitle = {
    Text = "เลือกไพ่ในมือ ๑๕"
  },
  Setup_54698_SetupTitle = {
    Text = "เลือกไพ่ในมือ๑๖"
  },
  Setup_54699_SetupTitle = {
    Text = "เลือกไพ่ในมือ ๑๗"
  },
  Setup_54700_SetupTitle = {
    Text = "เลือกการ์ดในมือ18"
  },
  Setup_54701_SetupTitle = {
    Text = "เลือกไพ่ในมือ 19"
  },
  Setup_55509_SetupTitle = {
    Text = "ออกจากเกม"
  },
  Setup_70541_SetupTitle = {
    Text = "เล่นเบื้องหลัง"
  },
  Setup_72153_SetupTitle = {
    Text = "ใช้ความสามารถขอบเขต 2"
  },
  Setup_94404_SetupTitle = {
    Text = "ยืนยันการออกไพ่"
  },
  Setup_94405_SetupTitle = {
    Text = "การ์ดใบก่อนหน้า"
  },
  Setup_94406_SetupTitle = {
    Text = "การ์ดใบถัดไป"
  },
  Setup_94566_SetupTitle = {
    Text = "พื้นหลังการต่อสู้แบบไดนามิก"
  }
})
return Text_Setup
