__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_ActorAttrType = readonly({
  ActorAttrType_121209_AttributeDesc = {
    Text = "ระดับความรู้ต้องห้ามจะเท่ากับระดับของผู้พิทักษ์ความลับ ซึ่งกำหนดผลของความลึกซึ้งในการวิจัย 3 ประเภทด้านล่าง หากระดับเฉลี่ยของผู้ตื่นรู้ในทีมมากกว่าหรือเท่ากับระดับของผู้พิทักษ์ความลับ ระดับความรู้ต้องห้ามจะใช้ค่าเฉลี่ยของระดับเฉลี่ยผู้ตื่นรู้ในทีมและระดับผู้พิทักษ์ความลับ\nความลึกซึ้งในการวิจัยสิ่งมีชีวิต: <Blue:{s1}>\n·กำหนดความแรงของผลที่แปลงค่าพลังชีวิตของผู้ตื่นรู้ทุก 100 หน่วยเป็นพลังชีวิตของทีม\nความลึกซึ้งในการวิจัยวัตถุ: <Blue:{s2}>\n·กำหนดความแรงของผลประเภทพลัง, ความเสียหายหนวด, โล่, ฟื้นฟูพลังชีวิต, ลดพลัง ที่เกิดจากสิ่งสร้าง, ตราจารึก, กุญแจคำสั่ง\nความลึกซึ้งในการวิจัยจิตสำนึก: <Blue:{s3}>\n·กำหนดความแรงของผลประเภทพิษคงที่, โต้กลับคงที่, ความเสียหายคงที่, เลือดไหลคงที่ ที่เกิดจากสิ่งสร้าง, ตราจารึก, กุญแจคำสั่ง\n"
  },
  ActorAttrType_121209_Text = {
    Text = "ระดับความรู้ต้องห้าม"
  },
  ActorAttrType_18103_Text = {
    Text = "โล่ตัวละคร"
  },
  ActorAttrType_18104_Text = {
    Text = "การปรับค่าเปอร์เซ็นต์ความเสียหายของไพ่ตี"
  },
  ActorAttrType_18105_AttributeUpText = {
    Text = "ความเสียหายจากการโจมตีคริติคอล+{s1}"
  },
  ActorAttrType_18105_Text = {
    Text = "ดาเมจคริติคอล"
  },
  ActorAttrType_18106_Text = {
    Text = "โล่เพิ่มขึ้น"
  },
  ActorAttrType_18107_AttributeUpText = {
    Text = "โจมตี+{s1}"
  },
  ActorAttrType_18107_Text = {
    Text = "โจมตี"
  },
  ActorAttrType_18108_Text = {Text = "CON"},
  ActorAttrType_18109_Text = {
    Text = "การปรับค่าเปอร์เซ็นต์ความเสียหายของการ์ด"
  },
  ActorAttrType_18110_Text = {
    Text = "การปรับค่าเปอร์เซ็นต์ความเปราะบาง"
  },
  ActorAttrType_18111_Text = {
    Text = "การปรับค่าร้อยละของโล่ที่ได้รับ"
  },
  ActorAttrType_18112_AttributeUpText = {
    Text = "การป้องกัน+{s1}"
  },
  ActorAttrType_18112_Text = {
    Text = "การป้องกันเพิ่มขึ้น"
  },
  ActorAttrType_18113_AttributeDesc = {
    Text = "ประสิทธิภาพการเติมพลังคลั่งของร่างกายที่ปลุก"
  },
  ActorAttrType_18113_Text = {
    Text = "ความคลั่งในช่วงเปิดเกม"
  },
  ActorAttrType_18114_AttributeDesc = {
    Text = "ค่าพลังชีวิตยิ่งสูง พลังชีวิตสูงสุดของผู้ปลุกตื่นก็จะยิ่งสูงขึ้น \n ระดับการสอบสวนของผู้พิทักษ์ยิ่งสูงขึ้น อิทธิพลของค่าพลังชีวิตต่อพลังชีวิตสูงสุดของผู้ปลุกตื่นก็จะยิ่งแข็งแกร่งขึ้น。"
  },
  ActorAttrType_18114_AttributeUpText = {
    Text = "พลังกาย+{s1}"
  },
  ActorAttrType_18114_Text = {Text = "CON"},
  ActorAttrType_18115_AttributeDesc = {
    Text = "หลังจากร่างกายที่ตื่นขึ้นปลดปล่อยต้นกำเนิดและการปรากฏตัวแล้ว ค่าความคลั่งที่ได้รับคืน"
  },
  ActorAttrType_18115_AttributeUpText = {
    Text = "ลดการบริโภคความคลั่ง +{s1}"
  },
  ActorAttrType_18115_Text = {
    Text = "ลดการใช้ความคลั่ง"
  },
  ActorAttrType_18116_AttributeDesc = {
    Text = "ค่าพลังยิ่งสูง พลังชีวิตสูงสุดของผู้ปลุกตื่นก็ยิ่งสูงขึ้นเท่านั้น \n ระดับการสอบสวนของผู้พิทักษ์ยิ่งสูงขึ้น ผลกระทบของค่าพลังต่อพลังชีวิตสูงสุดของผู้ปลุกตื่นก็ยิ่งมีมากขึ้น。"
  },
  ActorAttrType_18116_AttributeUpText = {
    Text = "พลังกาย+{s1}"
  },
  ActorAttrType_18116_Text = {
    Text = "การเพิ่มค่าร่างกาย"
  },
  ActorAttrType_18117_Text = {
    Text = "ความเสียหายจากหนวด"
  },
  ActorAttrType_18118_Text = {
    Text = "อัลตร้าสล็อต"
  },
  ActorAttrType_18119_Text = {
    Text = "การปรับแก้ไขเปอร์เซ็นต์ความเสียหายที่รับ"
  },
  ActorAttrType_18120_AttributeDesc = {
    Text = "ความคลั่งสูงสุดที่ผู้ปลุกตื่นสะสมได้ และความคลั่งที่ใช้ในการปล่อยระเบิดพลังคลั่ง เท่ากับความคลั่งพื้นฐาน."
  },
  ActorAttrType_18120_AttributeUpText = {
    Text = "ขีดจำกัดความคลั่งสูงสุด+{s1}"
  },
  ActorAttrType_18120_Text = {
    Text = "ความคลั่งพื้นฐาน"
  },
  ActorAttrType_18121_AttributeDesc = {
    Text = "ระดับทักษะ 2"
  },
  ActorAttrType_18121_AttributeUpText = {
    Text = "ทักษะ2ระดับ+{s1}"
  },
  ActorAttrType_18121_Text = {
    Text = "ระดับทักษะ 2"
  },
  ActorAttrType_18122_AttributeDesc = {
    Text = "ระดับการป้องกัน"
  },
  ActorAttrType_18122_AttributeUpText = {
    Text = "ระดับป้องกัน+{s1}"
  },
  ActorAttrType_18122_Text = {
    Text = "ระดับการป้องกัน"
  },
  ActorAttrType_18123_Text = {
    Text = "การปรับค่าคงที่ของจำนวนครั้งที่ก่อให้เกิดความเสียหาย"
  },
  ActorAttrType_18124_Text = {
    Text = "ทำให้ค่าคงที่ของโล่ถูกปรับปรุง"
  },
  ActorAttrType_18125_Text = {
    Text = "การปรับค่าโล่แบบคงที่ที่ได้รับ"
  },
  ActorAttrType_18126_AttributeDesc = {
    Text = "ความชำนาญดินแดนของทีมเท่ากับผลรวมของความชำนาญดินแดนของผู้ปลุกตื่นในทีม ความชำนาญดินแดนสามารถเพิ่มผลของพรสวรรค์ดินแดนของทีมได้ หากทีมปัจจุบันเป็น「บริสุทธิ์แห่งทะเลลึก/บริสุทธิ์แห่งเนื้อและเลือด/บริสุทธิ์แห่งอัลตร้า」 ผลของความชำนาญดินแดนจะเพิ่มขึ้นเป็นสองเท่า.\n·<Blue:เคออส> ในทีมดินแดนสำหรับทุก 1 คะแนนความชำนาญดินแดน เมื่อปล่อยคำสั่งกุญแจ ผู้ปลุกตื่นทั้งหมดจะได้รับความคลั่งเพิ่มอีก <Blue:0.05> คะแนน.\n·<Blue:เอควอ> ในทีมดินแดนสำหรับทุก 1 คะแนนความชำนาญดินแดน เมื่อปล่อยระเบิดพลัง จะมีโอกาส <Blue:0.25％> ที่จะได้รับการรวมตัวของหนวดสัมผัสเพิ่มอีก 1 ชั้น(หากโอกาสเกิน 100% สามารถได้รับหลายชั้น) เมื่อเปลี่ยนเป็น「คลื่นสงบ」 โล่ที่ได้รับจะเพิ่มขึ้น <Blue:0.01％> ของชีวิตสูงสุด ใน「คลื่นโกรธ」ความเสียหายจากหนวดที่เกิดจากการโจมตีที่ใช้สกิลจะเพิ่มขึ้น <Blue:0.02%> ของความเสียหายหนวด.\n·<Blue:เนื้อและเลือด> ในทีมดินแดนสำหรับทุก 1 คะแนนความชำนาญดินแดน ในแต่ละรอบเมื่อเกิดการกลืนกินครั้งแรกจะได้รับโล่ที่มีค่าชีวิตสูงสุด <Blue:0.01%> และพละกำลังชั่วคราว <Blue:0.005%>(เพิ่มขึ้นตามการสูญเสียชีวิต สูงสุดไม่เกิน 100％).\n·<Blue:อัลตร้า> ในทีมดินแดนสำหรับทุก 1 คะแนนความชำนาญดินแดน เมื่อเริ่มต้นรอบจะมีโอกาส <Blue:0.125%> ที่จะได้รับการ์ด「แรงบัลดาลใจ」 1 ใบ(หากโอกาสเกิน 100% สามารถได้รับหลายใบ)."
  },
  ActorAttrType_18126_AttributeUpText = {
    Text = "ขอบเขตความชำนาญ+{s1}"
  },
  ActorAttrType_18126_Text = {
    Text = "ความชำนาญดินแดน"
  },
  ActorAttrType_18127_Text = {Text = "HP"},
  ActorAttrType_18128_AttributeUpText = {
    Text = "โจมตี+{s1}"
  },
  ActorAttrType_18128_Text = {
    Text = "การโจมตีเพิ่มขึ้น"
  },
  ActorAttrType_18129_AttributeDesc = {
    Text = "ยิ่งความเสียหายพื้นฐานสูงขึ้นเท่าไหร่ ร่างกายที่ตื่นขึ้นก็จะสร้างความเสียหายมากขึ้นเท่านั้น"
  },
  ActorAttrType_18129_AttributeUpText = {
    Text = "ความเสียหายพื้นฐาน +{s1}"
  },
  ActorAttrType_18129_Text = {
    Text = "ความเสียหายพื้นฐาน"
  },
  ActorAttrType_18130_Text = {
    Text = "ระดับ"
  },
  ActorAttrType_18131_AttributeDesc = {
    Text = "เมื่อสิ้นสุดรอบ ค่าความคลั่งที่ตอบกลับโดยอัตโนมัติของผู้ปลุกตื่น (ในโหมดหัวข้อ จะเป็นค่าความคลั่งที่ตอบกลับหลังจากที่ผู้ปลุกตื่นทำการกระทำแต่ละครั้ง)"
  },
  ActorAttrType_18131_AttributeUpText = {
    Text = "ความคลั่งตอบกลับอัตโนมัติ เพิ่ม {s1}"
  },
  ActorAttrType_18131_Text = {
    Text = "การตอบกลับอัตโนมัติความคลั่ง"
  },
  ActorAttrType_18132_Text = {
    Text = "ปลดระดับวิญญาณ"
  },
  ActorAttrType_18133_Text = {
    Text = "การปรับค่าเปอร์เซ็นต์ความคลั่งที่ได้รับ"
  },
  ActorAttrType_18134_Text = {
    Text = "ขีดจำกัดการหลอมรวมของตัวอ่อน"
  },
  ActorAttrType_18135_Text = {
    Text = "ตัวละครปัจจุบันกับความคลั่ง"
  },
  ActorAttrType_18136_Text = {
    Text = "การปรับค่าความเสียหายที่รับอย่างคงที่"
  },
  ActorAttrType_18137_AttributeDesc = {
    Text = "เมื่อร่างกายที่ตื่นขึ้นใช้งานโล่และผลการฟื้นฟู จะเพิ่มสัดส่วนของค่าโล่และค่าการฟื้นฟู"
  },
  ActorAttrType_18137_AttributeUpText = {
    Text = "โล่และประสิทธิภาพสูง+{s1}"
  },
  ActorAttrType_18137_Text = {
    Text = "โล่และการรักษาประสิทธิภาพสูง"
  },
  ActorAttrType_18138_Text = {
    Text = "การรักษาเพิ่มขึ้น"
  },
  ActorAttrType_18139_AttributeDesc = {
    Text = "เมื่อเล่นการ์ดคำสั่งหรือวิญญาณตื่นรู้ ทุกๆ 1 อริธเมทิกาที่ใช้ไปจะได้รับพลังงานกุญแจเงิน {s1} จุด. เมื่อค่าคุณสมบัตินี้เพิ่มขึ้น พลังงานกุญแจเงินที่เพิ่มขึ้นเพิ่มเติมจะค่อยๆ ลดลง."
  },
  ActorAttrType_18139_AttributeUpText = {
    Text = "การชาร์จกุญแจเงิน+{s1}"
  },
  ActorAttrType_18139_Text = {
    Text = "ระดับชาร์จกุญแจเงิน"
  },
  ActorAttrType_18140_Text = {
    Text = "จำนวนการต่อต้านความตาย"
  },
  ActorAttrType_18141_AttributeDesc = {
    Text = "ระดับการตี"
  },
  ActorAttrType_18141_AttributeUpText = {
    Text = "ระดับการโจมตี+{s1}"
  },
  ActorAttrType_18141_Text = {
    Text = "ระดับการตี"
  },
  ActorAttrType_18142_AttributeDesc = {
    Text = "เปอร์เซ็นต์เพิ่มความเสียหายพื้นฐานที่เกิดจากผู้ปลุกตื่นทั้งหมด, การใช้พิษค่าคงที่และการโต้กลับค่าคงที่, ความเสียหายจากหนวดสัมผัสเริ่มต้นในดินแดนเอควอ。"
  },
  ActorAttrType_18142_AttributeUpText = {
    Text = "ความเสียหายประสิทธิภาพสูง + {s1}"
  },
  ActorAttrType_18142_Text = {Text = "DMG Amp."},
  ActorAttrType_18143_Text = {
    Text = "การปรับอัตราความเสียหายจากการระบายความคลั่ง"
  },
  ActorAttrType_18144_AttributeDesc = {
    Text = "เมื่อร่างกายที่ตื่นขึ้นสร้างความเสียหาย มีโอกาสต้านทานการโจมตีคริติคอล"
  },
  ActorAttrType_18144_AttributeUpText = {
    Text = "ต้านทานคริติคอล+{s1}"
  },
  ActorAttrType_18144_Text = {
    Text = "ต้านทานคริติคอล"
  },
  ActorAttrType_18145_AttributeDesc = {
    Text = "ระดับต้นกำเนิด"
  },
  ActorAttrType_18145_AttributeUpText = {
    Text = "ต้นกำเนิดการปรากฏตัวเลเวล+{s1}"
  },
  ActorAttrType_18145_Text = {
    Text = "ระดับต้นกำเนิด"
  },
  ActorAttrType_18146_Text = {
    Text = "การปรับค่ารักษาที่คงที่"
  },
  ActorAttrType_18147_AttributeUpText = {
    Text = "อัตราคราฟต์โชค+{s1}"
  },
  ActorAttrType_18147_Text = {
    Text = "อัตราการแกะสลักโชคดี"
  },
  ActorAttrType_18148_Text = {
    Text = "ทำให้ค่าการรักษาที่คงที่ถูกปรับ"
  },
  ActorAttrType_18149_Text = {
    Text = "การเพิ่มค่าร่างกาย"
  },
  ActorAttrType_18150_Text = {
    Text = "การปรับค่าเปอร์เซ็นต์ความอ่อนแอ"
  },
  ActorAttrType_18151_AttributeDesc = {
    Text = "การต่อต้านความตายของทีมเท่ากับผลรวมของการต่อต้านความตายของผู้ปลุกตื่นในทีม \n เมื่อได้รับความเสียหายที่ร้ายแรงในระหว่างการต่อสู้ มีโอกาสเก็บรักษาชีวิต 1 หน่วย เมื่อทริกเกอร์ จะได้รับพลังการคำนวณเพิ่มอีก 2 หน่วยและจั่วไพ่ 2 ใบ การต่อต้านความตายในปัจจุบันและต่อไปจะลดลงครึ่งหนึ่ง และจะมีผลจนกว่าจะสิ้นสุดการสอบสวน。"
  },
  ActorAttrType_18151_AttributeUpText = {
    Text = "การต่อต้านความตาย+{s1}"
  },
  ActorAttrType_18151_Text = {
    Text = "การต่อต้านความตาย"
  },
  ActorAttrType_18152_Text = {
    Text = "ทำให้เกิดการปรับค่าเปอร์เซ็นต์ความคลั่ง"
  },
  ActorAttrType_18154_Text = {
    Text = "ลิมิตหนวดสัมผัส"
  },
  ActorAttrType_18155_AttributeDesc = {
    Text = "เพิ่มเปอร์เซ็นต์การดร็อปรอยดำของศัตรูหลังชัยชนะในการต่อสู้。"
  },
  ActorAttrType_18155_AttributeUpText = {
    Text = "รอยดำหล่น+{s1}"
  },
  ActorAttrType_18155_Text = {
    Text = "อัตราดรอปผนึกขี้ผึ้งสีนิล"
  },
  ActorAttrType_18156_Text = {
    Text = "รับการปรับค่าคงที่ของความคลั่ง"
  },
  ActorAttrType_18157_Text = {
    Text = "เจตนาซ่อนเร้น"
  },
  ActorAttrType_18158_Text = {
    Text = "การปรับค่าความเสียหายที่เป็นค่าคงที่"
  },
  ActorAttrType_18159_AttributeUpText = {
    Text = "คริติคอล+{s1}"
  },
  ActorAttrType_18159_Text = {
    Text = "อัตราคริติคอล"
  },
  ActorAttrType_18160_AttributeDesc = {
    Text = "ระดับทักษะ 1"
  },
  ActorAttrType_18160_AttributeUpText = {
    Text = "ทักษะ1ระดับ+{s1}"
  },
  ActorAttrType_18160_Text = {
    Text = "ระดับทักษะ 1"
  },
  ActorAttrType_18161_Text = {
    Text = "ระดับ"
  },
  ActorAttrType_18162_Text = {
    Text = "ความเสียหายเพิ่มขึ้น"
  },
  ActorAttrType_18163_Text = {
    Text = "จำนวนหนวดสัมผัส"
  },
  ActorAttrType_18164_Text = {
    Text = "ตัวปรับค่าร้อยละการรักษาที่ได้รับ"
  },
  ActorAttrType_18165_Text = {
    Text = "แต้มอริธเมทิกาสูงสุด"
  },
  ActorAttrType_18166_Text = {
    Text = "การปรับเปอร์เซ็นต์ความเสียหายเพิ่ม"
  },
  ActorAttrType_18167_AttributeUpText = {
    Text = "การป้องกัน+{s1}"
  },
  ActorAttrType_18167_Text = {
    Text = "การป้องกัน"
  },
  ActorAttrType_18168_AttributeDesc = {
    Text = "ระดับการตื่นรู้แห่งวิญญาณ"
  },
  ActorAttrType_18168_AttributeUpText = {
    Text = "การตื่นแห่งวิญญาณ ระดับ+{s1}"
  },
  ActorAttrType_18168_Text = {
    Text = "ระดับการตื่นรู้แห่งวิญญาณ"
  },
  ActorAttrType_21322_Text = {
    Text = "ฟื้นฟูพลังงานกุญแจเงิน"
  },
  ActorAttrType_22207_AttributeDesc = {
    Text = "ทุกครั้งที่ปล่อยระเบิดพลังจะได้รับ {s1} จุดอาลีมัส เมื่อคุณสมบัตินี้เพิ่มขึ้น ผลบวกเพิ่มเติมจะค่อยๆ ลดลง。"
  },
  ActorAttrType_22207_AttributeUpText = {
    Text = "ระดับพลังความคลั่งที่เติม+{s1}"
  },
  ActorAttrType_22207_Text = {
    Text = "ระดับการชาร์จความคลั่ง"
  },
  ActorAttrType_22214_Text = {
    Text = "การชาร์จความคลั่ง"
  }
})
return Text_ActorAttrType
