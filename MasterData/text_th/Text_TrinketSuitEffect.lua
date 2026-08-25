__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_TrinketSuitEffect = readonly({
  TrinketSuitEffect_18335_Name = {
    Text = "การสดุดีเดือนเมษายน"
  },
  TrinketSuitEffect_18335_SuitEffectDesc_1 = {
    Text = "ความเสียหายจากการโจมตีคริติคอล +7.2%"
  },
  TrinketSuitEffect_18335_SuitEffectDesc_2 = {
    Text = "<TeamUnique: ทีมเดียว>：เมื่อเริ่มต้นรอบ หากชีวิตของศัตรูทั้งหมดมากกว่า 75% อัตราการคริติคอลชั่วคราวและดาเมจคริติคอลของผู้สวมใส่จะเพิ่มขึ้น +35%."
  },
  TrinketSuitEffect_18336_Name = {
    Text = "บทกวีวงกลม (ยังไม่สมบูรณ์)"
  },
  TrinketSuitEffect_18336_SuitEffectDesc_1 = {
    Text = "การต่อต้านความตาย +16.8%"
  },
  TrinketSuitEffect_18336_SuitEffectDesc_2 = {
    Text = "เมื่อเริ่มต้นเทิร์นคู่ ลดค่าใช้พลังการคำนวณ 1 หน่วยในไพ่มือแบบสุ่ม。"
  },
  TrinketSuitEffect_18337_Name = {
    Text = "เส้นทางกลับสู่ทะเล"
  },
  TrinketSuitEffect_18337_SuitEffectDesc_1 = {
    Text = "ขอบเขตความชำนาญ +12"
  },
  TrinketSuitEffect_18337_SuitEffectDesc_2 = {
    Text = "<TeamUnique: ทีมเดียว>：เมื่อเริ่มต้นการต่อสู้ จะได้รับพละกำลังเท่ากับ 12% ของ ATK ของผู้สวมใส่ หากดินแดนในปัจจุบันคือเอควอ ผลจะเปลี่ยนเป็น\"เมื่อเริ่มต้นรอบ มีโอกาส(50+0.25*ความชำนาญดินแดนของทีม)% ที่จะได้รับ 1 ระดับของการรวมตัวของหนวดสัมผัส หากเกิน 100% จะสามารถได้รับหลายระดับ และโอกาสจะคูณเป็นสองเท่าในระหว่างการต่อสู้กับผู้นำ."
  },
  TrinketSuitEffect_18338_Name = {
    Text = "กระต่ายถูกสาป"
  },
  TrinketSuitEffect_18338_SuitEffectDesc_1 = {
    Text = "ขอบเขตความชำนาญ +12"
  },
  TrinketSuitEffect_18338_SuitEffectDesc_2 = {
    Text = "ผู้ใช้เพิ่มโล่และการฟื้นฟูชีวิตขึ้น 12%"
  },
  TrinketSuitEffect_18339_Name = {
    Text = "แอนตินอมี"
  },
  TrinketSuitEffect_18339_SuitEffectDesc_1 = {
    Text = "การชาร์จกุญแจเงิน เพิ่ม 7.2"
  },
  TrinketSuitEffect_18339_SuitEffectDesc_2 = {
    Text = "<TeamUnique: ทีมเดียว>：อาลีมัสพื้นฐานของผู้สวมใส่เพิ่มขึ้น 20 คะแนน อัตราคริติคอล ดาเมจคริติคอล โล่ และการฟื้นฟูเลือดของการ์ดคำสั่งของผู้สวมใส่เพิ่มขึ้น 20%."
  },
  TrinketSuitEffect_18340_Name = {
    Text = "รูปแบบอินทรีย์"
  },
  TrinketSuitEffect_18340_SuitEffectDesc_1 = {
    Text = "รอยดำ ดร็อป +3.6%"
  },
  TrinketSuitEffect_18340_SuitEffectDesc_2 = {
    Text = "<TeamUnique: ทีมเดียว>.เมื่อเริ่มต้นการสำรวจ การต่อต้านความตายจะถูกลดลงสูงสุด 100% ทุกครั้งที่ลดลง 1% ในการต่อต้านความตาย จะทำให้ผู้สวมใส่สร้างอาลีมัสเพิ่มขึ้น 0.15%."
  },
  TrinketSuitEffect_18341_Name = {
    Text = "การเต้นสีสคาร์เลต"
  },
  TrinketSuitEffect_18341_SuitEffectDesc_1 = {
    Text = "ความเสียหายจากการโจมตีคริติคอล +7.2%"
  },
  TrinketSuitEffect_18341_SuitEffectDesc_2 = {
    Text = "หลังจากปลดล็อกกุญแจลับแล้ว ผู้ใช้งานจะได้รับอัตราการโจมตีคริติคอลชั่วคราว 30%。"
  },
  TrinketSuitEffect_18342_Name = {
    Text = "มาตรฐานพิธีศักดิ์สิทธิ์ SSR"
  },
  TrinketSuitEffect_18342_SuitEffectDesc_1 = {
    Text = "การต่อต้านความตาย +16.8%"
  },
  TrinketSuitEffect_18342_SuitEffectDesc_2 = {
    Text = "ผู้ใช้เพิ่มความเสียหาย, การรักษา และโล่ขึ้น 15%。"
  },
  TrinketSuitEffect_18343_Name = {
    Text = "พิธีศักดิ์สิทธิ์มาตรฐาน R"
  },
  TrinketSuitEffect_18343_SuitEffectDesc_1 = {
    Text = "การต่อต้านความตาย +16.8%"
  },
  TrinketSuitEffect_18343_SuitEffectDesc_2 = {
    Text = "ผู้ใช้เพิ่มความเสียหาย, การรักษา และโล่ขึ้น 15%。"
  },
  TrinketSuitEffect_18344_Name = {
    Text = "การลงมาของเครื่องจักร"
  },
  TrinketSuitEffect_18344_SuitEffectDesc_1 = {
    Text = "ขอบเขตความชำนาญ +12"
  },
  TrinketSuitEffect_18344_SuitEffectDesc_2 = {
    Text = "ในรอบแรกของแต่ละการต่อสู้ จะได้รับพลังการคำนวณ 1 หน่วย ในการต่อสู้กับผู้นำ ทุก 4 รอบจะได้รับพลังการคำนวณเพิ่มเติม 1 หน่วย"
  },
  TrinketSuitEffect_18345_Name = {
    Text = "พิธีการสังเคราะห์แสง"
  },
  TrinketSuitEffect_18345_SuitEffectDesc_1 = {
    Text = "ความเสียหาย +7.2%"
  },
  TrinketSuitEffect_18345_SuitEffectDesc_2 = {
    Text = "<TeamUnique: ทีมเดียว>：เมื่อการ์ดคำสั่งของผู้สวมใส่เข้าสู่มิติพิเศษ จะทำให้การหลอมรวมตัวอ่อน +25～50 ยิ่งชีวิตต่ำลง จะได้รับการหลอมรวมตัวอ่อนมากขึ้น"
  },
  TrinketSuitEffect_18346_Name = {
    Text = "การวิวัฒนาการต่อเนื่อง"
  },
  TrinketSuitEffect_18346_SuitEffectDesc_1 = {
    Text = "ระดับการฟื้นฟูความคลั่ง +2.4"
  },
  TrinketSuitEffect_18346_SuitEffectDesc_2 = {
    Text = "<TeamUnique: ทีมเดียว>：เมื่อเริ่มต้นการสำรวจ ผู้สวมใส่จะได้รับอาลีมัส 35 คะแนน หลังจากผู้สวมใส่ใช้ระเบิดพลัง จะได้รับอาลีมัส 2 คะแนนเมื่อจบเทิร์นในระหว่างการต่อสู้ครั้งนี้ ผลนี้สามารถสะสมได้สูงสุด 3 ครั้ง."
  },
  TrinketSuitEffect_18347_Name = {
    Text = "การดูดซับชีวิต"
  },
  TrinketSuitEffect_18347_SuitEffectDesc_1 = {
    Text = "การชาร์จกุญแจเงิน เพิ่ม 7.2"
  },
  TrinketSuitEffect_18347_SuitEffectDesc_2 = {
    Text = "<TeamUnique: ทีมเดียว>：เมื่อสิ้นสุดเทิร์น จะได้รับพลังงานกุญแจเงินเท่ากับฟื้นฟูพลังงานกุญแจเงินของผู้สวมใส่ 200% หากดินแดนปัจจุบันเป็น「เนื้อและเลือด」 ผลจะเปลี่ยนเป็นทุกๆ 5 หน่วยฟื้นฟูพลังงานกุญแจเงิน จะทำให้หลอมรวมตัวอ่อนเพิ่มขึ้น +1."
  },
  TrinketSuitEffect_18348_Name = {
    Text = "ความฝันในการใช้เป็นยา"
  },
  TrinketSuitEffect_18348_SuitEffectDesc_1 = {
    Text = "ความเสียหาย +4.8%"
  },
  TrinketSuitEffect_18348_SuitEffectDesc_2 = {
    Text = "<TeamUnique: ทีมเดียว>.ได้รับรอยดำ –8 เมื่อสิ้นสุดการต่อสู้ และในขณะที่เริ่มต้นการต่อสู้ จะสับไพ่สำเนาต้นฉบับของการ์ดคำสั่งที่ไม่ใช่การตีและการป้องกันของผู้สวมใส่เข้าสู่กองไพ่ที่สุ่ม โดยแต่ละประเภทไม่เกิน 1 ใบ."
  },
  TrinketSuitEffect_18349_Name = {
    Text = "สไลม์หวาน"
  },
  TrinketSuitEffect_18349_SuitEffectDesc_1 = {
    Text = "การต่อต้านความตาย +25.2%"
  },
  TrinketSuitEffect_18349_SuitEffectDesc_2 = {
    Text = "<TeamUnique: ทีมเดียว>：หากใน 1 รอบได้ใช้「ทำลายล้าง」และสลับท่าทางหนวดสัมผัส ผู้สวมใส่จะเพิ่มโล่ การฟื้นฟูเลือด และดาเมจสุดท้ายในรอบนี้ขึ้น +25% คูลดาวน์ 3 รอบ."
  },
  TrinketSuitEffect_18350_Name = {
    Text = "แมวเธียร์เตอร์ (ยังไม่เสร็จ)"
  },
  TrinketSuitEffect_18350_SuitEffectDesc_1 = {
    Text = "การต่อต้านความตาย +16.8%"
  },
  TrinketSuitEffect_18350_SuitEffectDesc_2 = {
    Text = "ผู้ใช้จะสร้างความเสียหายแบบคริติคอลอย่างแน่นอนต่อศัตรูที่มีชีวิตมากกว่า 75%。"
  },
  TrinketSuitEffect_18351_Name = {
    Text = "วงแหวนของห้อง 36 ห้อง"
  },
  TrinketSuitEffect_18351_SuitEffectDesc_1 = {
    Text = "ระดับการฟื้นฟูความคลั่ง +2.4"
  },
  TrinketSuitEffect_18351_SuitEffectDesc_2 = {
    Text = "<TeamUnique: ทีมเดียว>.ขีดจำกัดพลังงานกุญแจเงินและการใช้พลังงานกุญแจสำหรับคำสั่งกุญแจ +200 อัตราคริติคอลของการระเบิดพลังของผู้สวมใส่ ดาเมจคริติคอล โล่ และการฟื้นฟูเลือดเพิ่มขึ้น 30%."
  },
  TrinketSuitEffect_18352_Name = {
    Text = "ทวินส์บิดเบี้ยว·ขาว"
  },
  TrinketSuitEffect_18352_SuitEffectDesc_1 = {
    Text = "การต่อต้านความตาย +16.8%"
  },
  TrinketSuitEffect_18352_SuitEffectDesc_2 = {
    Text = "เมื่อเริ่มต้นรอบที่เป็นจำนวนคู่ ให้เพิ่ม「การป้องกัน」ของผู้ถืออุปกรณ์ที่มีสุญญตาและใช้ลงในมือ。"
  },
  TrinketSuitEffect_18353_Name = {
    Text = "สคาร์เลตอีมบรейซ"
  },
  TrinketSuitEffect_18353_SuitEffectDesc_1 = {
    Text = "อัตราการโจมตีคริติคอล +4.8%"
  },
  TrinketSuitEffect_18353_SuitEffectDesc_2 = {
    Text = "ผู้สวมใส่จะได้รับพลังงานกุญแจเงิน 35 คะแนนเมื่อสร้างความเสียหาย หากสร้างความเสียหายคริติคอล จะได้รับพลังงานกุญแจเงิน 70 คะแนน ต่อรอบสามารถทริกเกอร์ได้สูงสุด 3 ครั้ง。"
  },
  TrinketSuitEffect_18354_Name = {
    Text = "มาตรฐานพิธีศักดิ์สิทธิ์SR"
  },
  TrinketSuitEffect_18354_SuitEffectDesc_1 = {
    Text = "การต่อต้านความตาย +16.8%"
  },
  TrinketSuitEffect_18354_SuitEffectDesc_2 = {
    Text = "ผู้ใช้เพิ่มความเสียหาย, การรักษา และโล่ขึ้น 15%。"
  },
  TrinketSuitEffect_18355_Name = {
    Text = "ไร้ตำหนิ"
  },
  TrinketSuitEffect_18355_SuitEffectDesc_1 = {
    Text = "การชาร์จกุญแจเงิน เพิ่ม 7.2"
  },
  TrinketSuitEffect_18355_SuitEffectDesc_2 = {
    Text = "<TeamUnique: ทีมเดียว>：หลังจากปลดล็อกกุญแจลับแล้ว จะฟื้นฟูชีวิตเท่ากับ 12% ของค่าพลัง CON ของผู้สวมใส่ โดยผลจะเพิ่มขึ้นตามสัดส่วนของชีวิตที่สูญเสีย สูงสุดไม่เกิน 24% ของค่าพลัง CON ของผู้สวมใส่."
  },
  TrinketSuitEffect_18356_Name = {
    Text = "หมาป่าทุ่งร้าง"
  },
  TrinketSuitEffect_18356_SuitEffectDesc_1 = {
    Text = "ความเสียหาย +4.8%"
  },
  TrinketSuitEffect_18356_SuitEffectDesc_2 = {
    Text = "ผู้สวมใส่เพิ่มความเสียหายพื้นฐาน 20％ และความเสียหายที่ก่อให้เกิดของ<IntoxicationIconKeywords:พิษ> และ<RetaliateIconKeywords:การโต้กลับ> เพิ่มขึ้น 10%。"
  },
  TrinketSuitEffect_18357_Name = {
    Text = "งานฉลองที่ห่างไกล"
  },
  TrinketSuitEffect_18357_SuitEffectDesc_1 = {
    Text = "รอยดำ ดร็อป +3.6%"
  },
  TrinketSuitEffect_18357_SuitEffectDesc_2 = {
    Text = "เมื่อเริ่มการสำรวจ จะได้รับ 10 รอยดำ ผู้ที่สวมใส่「การป้องกัน」จะเพิ่มโล่ขึ้น 60%。"
  },
  TrinketSuitEffect_18358_Name = {
    Text = "ทวินส์บิดเบือน·ดำ"
  },
  TrinketSuitEffect_18358_SuitEffectDesc_1 = {
    Text = "อัตราการโจมตีคริติคอล +4.8%"
  },
  TrinketSuitEffect_18358_SuitEffectDesc_2 = {
    Text = "เมื่อเริ่มต้นรอบเลขคี่ ให้เพิ่ม「ตี」ของผู้สวมใส่ที่มีสุญญตาและใช้ลงในมือ。"
  },
  TrinketSuitEffect_18359_Name = {
    Text = "ตัวอ่อนของสาวน้อย"
  },
  TrinketSuitEffect_18359_SuitEffectDesc_1 = {
    Text = "อัตราการโจมตีคริติคอล +7.2%"
  },
  TrinketSuitEffect_18359_SuitEffectDesc_2 = {
    Text = "<TeamUnique: ทีมเดียว>：ผู้สวมใส่จะได้รับดาเมจคริติคอลชั่วคราว 8% สำหรับทุกหนวดสัมผัส 1 เส้น หลังจากใช้ตัวอ่อนเป็นครั้งแรกในแต่ละรอบ สูงสุด 80%."
  },
  TrinketSuitEffect_18360_Name = {
    Text = "กระซิบของที่ฝังศพ"
  },
  TrinketSuitEffect_18360_SuitEffectDesc_1 = {
    Text = "การต่อต้านความตาย +16.8%"
  },
  TrinketSuitEffect_18360_SuitEffectDesc_2 = {
    Text = "เมื่อเริ่มต้นระดับ <DeathResistanceIconKeywords:การต่อต้านความตาย> จะเพิ่มขึ้น 25%。เมื่อเกิดการต่อต้านความตาย ผู้สวมใส่จะได้รับ 50 คะแนนอาลีมัส。"
  },
  TrinketSuitEffect_99234_Name = {
    Text = "สารอินทรีย์ที่เน่าเปื่อย"
  },
  TrinketSuitEffect_99234_SuitEffectDesc_1 = {
    Text = "ข้อความชั่วคราว"
  },
  TrinketSuitEffect_99234_SuitEffectDesc_2 = {
    Text = "ข้อความชั่วคราว"
  },
  TrinketSuitEffect_99235_Name = {
    Text = "การบินขึ้น"
  },
  TrinketSuitEffect_99235_SuitEffectDesc_1 = {
    Text = "ข้อความชั่วคราว"
  },
  TrinketSuitEffect_99235_SuitEffectDesc_2 = {
    Text = "ข้อความชั่วคราว"
  },
  TrinketSuitEffect_99236_Name = {
    Text = "สติ๊กส์"
  },
  TrinketSuitEffect_99236_SuitEffectDesc_1 = {
    Text = "ข้อความชั่วคราว"
  },
  TrinketSuitEffect_99236_SuitEffectDesc_2 = {
    Text = "ข้อความชั่วคราว"
  }
})
return Text_TrinketSuitEffect
