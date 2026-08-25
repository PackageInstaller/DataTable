__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_CommonID = readonly({
  CommonID_Account_Desc = {
    Text = "บัญชี"
  },
  CommonID_AchieveCommemorativeData_Dmg_Desc = {
    Text = "ความเสียหายสูงสุด"
  },
  CommonID_AchieveCommemorativeData_Poison_Desc = {
    Text = "ชั้นสูงสุด"
  },
  CommonID_AchieveCommemorativeData_Time_Desc = {
    Text = "เวลาที่เสร็จสิ้น"
  },
  CommonID_AchieveType0_Desc = {
    Text = "ความสำเร็จทั้งหมด"
  },
  CommonID_AchieveType1_Desc = {
    Text = "เรื่องราวการเติบโต"
  },
  CommonID_AchieveType2_Desc = {
    Text = "สอบสวนตรา"
  },
  CommonID_AchieveType3_Desc = {
    Text = "Log การต่อสู้"
  },
  CommonID_AchieveType4_Desc = {
    Text = "ชีวิตที่ปกปิดความลับ"
  },
  CommonID_Add_State_Desc = {
    Text = "เพิ่มสถานะ"
  },
  CommonID_All_Desc = {
    Text = "ทั้งหมด"
  },
  CommonID_AnyAvgFirstTrigger_Desc = {
    Text = "เงื่อนไขการเสร็จสิ้นภารกิจ: เปิดโหนดเนื้อเรื่องใดๆ แล้ว"
  },
  CommonID_AnyEntryInGroupUnlock_Desc = {
    Text = "เงื่อนไขการเสร็จสิ้นภารกิจ: ปลดล็อกรายการใดรายการหนึ่งในกลุ่มสมุดภาพ"
  },
  CommonID_AnyEventFirstTrigger_Desc = {
    Text = "เงื่อนไขการเสร็จสิ้นภารกิจ：เคยเปิดใช้งานเหตุการณ์ใดๆ ก็ตาม"
  },
  CommonID_AnyItemFirstGet_Desc = {
    Text = "เงื่อนไขการเสร็จสิ้นภารกิจ：ได้รับไอเทมใดๆ หนึ่งชิ้น"
  },
  CommonID_AnyNodeTypeFirstTrigger_Desc = {
    Text = "เงื่อนไขการเสร็จสิ้นภารกิจ: เปิดใช้งานโหนดประเภทใดก็ได้"
  },
  CommonID_AnyRelicFirstGet_Desc = {
    Text = "เงื่อนไขการเสร็จสิ้นภารกิจ: ได้รับสิ่งสร้างใด ๆ หนึ่งชิ้น"
  },
  CommonID_AnyStageFirstClear_Desc = {
    Text = "เงื่อนไขการเสร็จสิ้นภารกิจ: ผ่านด่านใดด่านหนึ่งในรายการเป็นครั้งแรก"
  },
  CommonID_AppointTaskRewardAdd_Desc = {
    Text = "มอบหมายเพิ่มเติมรางวัล"
  },
  CommonID_Attr_Promote_Desc = {
    Text = "เพิ่มคุณสมบัติ"
  },
  CommonID_AwakerDied_Desc = {
    Text = "การตายของผู้ปลุกเสก"
  },
  CommonID_AwakerMonster_Desc = {
    Text = "หัวหน้าผู้ถูกปลุก"
  },
  CommonID_BN_Desc = {
    Text = "เบงกาลี (alpha)"
  },
  CommonID_BanBattlePos_Desc = {
    Text = "ลงสนามไม่ได้"
  },
  CommonID_Battle_Desc = {
    Text = "การต่อสู้"
  },
  CommonID_Blue_Desc = {
    Text = "สีน้ำเงิน"
  },
  CommonID_Boss_Desc = {
    Text = "ผู้นำ"
  },
  CommonID_BundleShortcutKey_Desc = {
    Text = "การผูกปุ่ม"
  },
  CommonID_CN_Desc = {
    Text = "ภาษาไทย"
  },
  CommonID_CardBorder_Desc = {
    Text = "รูปลักษณ์การ์ด"
  },
  CommonID_CardSlots_LevelUp_Desc = {
    Text = "ช่องสำหรับอัปเกรด"
  },
  CommonID_Card_AdvancedImagery_Desc = {
    Text = "ภาพลักษณ์ระดับสูง"
  },
  CommonID_Card_AttachPost_Desc = {
    Text = "โจมตีไล่ล่า"
  },
  CommonID_Card_Awake_Desc = {
    Text = "วิญญาณตื่นรู้"
  },
  CommonID_Card_Curse_Desc = {
    Text = "การ์ดอาการ"
  },
  CommonID_Card_Defend_Desc = {
    Text = "การ์ดการป้องกัน"
  },
  CommonID_Card_Developing_Desc = {
    Text = "กำลังพัฒนา"
  },
  CommonID_Card_Extend_Desc = {
    Text = "การ์ดต่อยอด"
  },
  CommonID_Card_Fraud_Desc = {
    Text = "การฉ้อโกง"
  },
  CommonID_Card_Imagery_Desc = {
    Text = "สัญลักษณ์"
  },
  CommonID_Card_KeeperSkill_Desc = {
    Text = "บัตรกุญแจลับ"
  },
  CommonID_Card_Potion_Desc = {
    Text = "การ์ดยา"
  },
  CommonID_Card_Skill_Desc = {
    Text = "การ์ดทักษะ"
  },
  CommonID_Card_State_Desc = {
    Text = "การ์ดสถานะ"
  },
  CommonID_Card_Strike_Desc = {
    Text = "การ์ดโจมตี"
  },
  CommonID_Card_Weapon_Desc = {
    Text = "การ์ดวงล้อมชีวิต"
  },
  CommonID_CastSkillLevel_Desc = {
    Text = "ระดับความสามารถการร่ายเวท"
  },
  CommonID_Challenge_Desc = {
    Text = "การสืบสวน"
  },
  CommonID_Change_Skill_Desc = {
    Text = "เปลี่ยนทักษะ"
  },
  CommonID_Chinese_Desc = {
    Text = "ภาษาจีน"
  },
  CommonID_ChooseHandCard_Desc = {
    Text = "เลือกไพ่"
  },
  CommonID_ClickToQuit_Desc = {
    Text = "คลิกออก"
  },
  CommonID_ClickToView_Desc = {
    Text = "คลิกเพื่อดู"
  },
  CommonID_Click_Desc = {
    Text = "คลิกเพื่อเปลี่ยน"
  },
  CommonID_Close_Desc = {Text = "ปิด"},
  CommonID_ComingSoon_Desc = {
    Text = "โปรดรอคอย"
  },
  CommonID_CommonAttr_Desc = {
    Text = "การเพิ่มค่าสถานะทั่วไป"
  },
  CommonID_Common_Desc = {
    Text = "ธรรมดา"
  },
  CommonID_ContinuousSound_Desc = {
    Text = "เล่นต่อเนื่อง"
  },
  CommonID_CopperAchieve_Desc = {
    Text = "ทองแดง"
  },
  CommonID_CountingStart_Desc = {
    Text = "การนับถอยหลังในรอบของทีมเราเริ่มขึ้น"
  },
  CommonID_Custom_Desc = {
    Text = "กำหนดเอง"
  },
  CommonID_DE_Desc = {
    Text = "ภาษาเยอรมัน (alpha)"
  },
  CommonID_DPS_Desc = {
    Text = "สายสร้างความเสียหาย"
  },
  CommonID_DepressionHit_Desc = {
    Text = "ซึมเศร้าหลังโดน"
  },
  CommonID_DisableKeeperSkill_Desc = {
    Text = "ระงับทักษะของตัวละครหลัก"
  },
  CommonID_DisableTrinketSuitEffect_Desc = {
    Text = "ปิดการใช้งานพันธสัญญา"
  },
  CommonID_DisableWeapon_Desc = {
    Text = "ปิดการใช้งานวงล้อแห่งโชคชะตา"
  },
  CommonID_Display_Desc = {Text = "ภาพ"},
  CommonID_DropdownList_Desc = {
    Text = "เมนูแบบเลื่อนลง"
  },
  CommonID_EN_Desc = {
    Text = "ภาษาอังกฤษ (GPT beta)"
  },
  CommonID_ES_Desc = {
    Text = "ภาษาสเปน (alpha)"
  },
  CommonID_Elite_Desc = {
    Text = "เอลิท"
  },
  CommonID_EmojiType_10_Desc = {
    Text = "มิซากะน้อย"
  },
  CommonID_EmojiType_11_Desc = {
    Text = "เทิร์นพลิกเกม"
  },
  CommonID_EmojiType_12_Desc = {
    Text = "มิซากะในชีวิตประจำวัน"
  },
  CommonID_EmojiType_13_Desc = {
    Text = "มิซากะที่มีความสุข"
  },
  CommonID_EmojiType_14_Desc = {
    Text = "เศร้ามิซากะ"
  },
  CommonID_EmojiType_15_Desc = {
    Text = "ชีวิตในโรงเรียน"
  },
  CommonID_EmojiType_16_Desc = {
    Text = "วันสงบ"
  },
  CommonID_EmojiType_17_Desc = {
    Text = "เวลาว่าง"
  },
  CommonID_EmojiType_18_Desc = {
    Text = "เปรียบเทียบหัวใจมิซากะ"
  },
  CommonID_EmojiType_19_Desc = {
    Text = "มิซากะ วันหยุด"
  },
  CommonID_EmojiType_1_Desc = {
    Text = "มิซากะนุ่มๆ"
  },
  CommonID_EmojiType_20_Desc = {
    Text = "ดงดูมิสซาก"
  },
  CommonID_EmojiType_21_Desc = {
    Text = "ปาร์ตี้ขนมปังขิง"
  },
  CommonID_EmojiType_22_Desc = {
    Text = "เรื่องน่าสนใจในโรงเรียน"
  },
  CommonID_EmojiType_23_Desc = {
    Text = "นักสืบมิซากะ"
  },
  CommonID_EmojiType_24_Desc = {
    Text = "มิซากะ ละครระหว่างการแสดง"
  },
  CommonID_EmojiType_25_Desc = {
    Text = "เพลงของซายะ"
  },
  CommonID_EmojiType_2_Desc = {
    Text = "คืนก่อนของ Tuántuán"
  },
  CommonID_EmojiType_3_Desc = {
    Text = "รูปลักษณ์ของโลกมนุษย์"
  },
  CommonID_EmojiType_4_Desc = {
    Text = "ลืมQก่อนรุ่งสาง"
  },
  CommonID_EmojiType_5_Desc = {
    Text = "การสื่อสารเฟส"
  },
  CommonID_EmojiType_6_Desc = {
    Text = "มิซากะผู้เปล่งประกาย"
  },
  CommonID_EmojiType_7_Desc = {
    Text = "มิซากะบ้าคลั่ง"
  },
  CommonID_EmojiType_8_Desc = {
    Text = "มิซากะที่ผ่อนคลาย"
  },
  CommonID_EmojiType_9_Desc = {
    Text = "ปัญญาแห่งมิซากะ"
  },
  CommonID_Enchant_Desc = {
    Text = "ตราประทับ"
  },
  CommonID_Entrance_Desc = {
    Text = "เข้าสู่ป๊อปอัป"
  },
  CommonID_FALSE_Desc = {Text = "ไม่"},
  CommonID_FR_Desc = {
    Text = "ภาษาฝรั่งเศส (alpha)"
  },
  CommonID_Forged_Desc = {
    Text = "เสริมสร้าง"
  },
  CommonID_FreeBattlePos_Desc = {
    Text = "การลงสนามอย่างอิสระ"
  },
  CommonID_FullScreen_Desc = {
    Text = "แบบเต็มจอ"
  },
  CommonID_Gender_Boy_Desc = {Text = "ชาย"},
  CommonID_Gender_Girl_Desc = {
    Text = "หญิง"
  },
  CommonID_GetLikeLevel_Desc = {
    Text = "ฟังก์ชัน"
  },
  CommonID_GmaeVoice_Desc = {
    Text = "เสียงในเกม"
  },
  CommonID_GoldAchieve_Desc = {Text = "ทอง"},
  CommonID_Hall_Desc = {
    Text = "ห้องโถง"
  },
  CommonID_HarvestAdd_Desc = {
    Text = "โบนัสพิเศษสำหรับฐานที่มั่น"
  },
  CommonID_HaveAwaker_Desc = {
    Text = "เงื่อนไขการเสร็จสิ้นภารกิจ：มีหนึ่งในร่างกายที่ตื่นขึ้นจากรายการ"
  },
  CommonID_HeadType_1_Desc = {
    Text = "ในนามของกุญแจเงิน"
  },
  CommonID_HeadType_2_Desc = {
    Text = "เอกสารพรตโป๊ะ"
  },
  CommonID_HeadType_3_Desc = {
    Text = "เมื่อวานที่ไม่เคยจางหาย"
  },
  CommonID_HeadType_4_Desc = {
    Text = "แสตมป์สะสม"
  },
  CommonID_High_Desc = {Text = "สูง"},
  CommonID_Holy_Desc = {
    Text = "การทรงพระเจริญ"
  },
  CommonID_ID_Desc = {
    Text = "ภาษาอินโดนีเซีย (alpha)"
  },
  CommonID_IT_Desc = {
    Text = "อิตาลี (alpha)"
  },
  CommonID_Image_Desc = {Text = "ภาพ"},
  CommonID_Intent_AttackBuff_Desc = {
    Text = "เจตนาของมอนสเตอร์คือโจมตีและเพิ่มพลัง"
  },
  CommonID_Intent_AttackDebuffD09Skill2_Desc = {
    Text = "เจตนาโจมตีและลดพลัง"
  },
  CommonID_Intent_AttackDebuff_Desc = {
    Text = "เจตนาโจมตีและลดพลัง"
  },
  CommonID_Intent_AttackDefence_Desc = {
    Text = "เจตนาของมอนสเตอร์คือการโจมตีและการป้องกัน"
  },
  CommonID_Intent_Attack_Desc = {
    Text = "มอนสเตอร์ตั้งใจโจมตี"
  },
  CommonID_Intent_Buff_Desc = {
    Text = "มอนสเตอร์ตั้งใจเสริมสร้าง"
  },
  CommonID_Intent_Burst2_Desc = {
    Text = "เจตนามอนสเตอร์ความคลั่งไม่ได้โจมตี"
  },
  CommonID_Intent_Burst3_Desc = {
    Text = "เจตนาของมอนสเตอร์คลั่งพลังสูง"
  },
  CommonID_Intent_Burst4_Desc = {
    Text = "มอนสเตอร์มีเจตนาใช้ท่าไม้ตาย"
  },
  CommonID_Intent_Burst_Desc = {
    Text = "เจตนาของมอนสเตอร์ที่คลั่ง"
  },
  CommonID_Intent_DCB022Buff_Desc = {
    Text = "มอนสเตอร์ตั้งใจเสริมสร้าง"
  },
  CommonID_Intent_DCB024Buff_Desc = {
    Text = "มอนสเตอร์ตั้งใจเสริมสร้าง"
  },
  CommonID_Intent_Debuff_Desc = {
    Text = "ความตั้งใจของมอนสเตอร์ลดทอนลง"
  },
  CommonID_Intent_DefenceBuff_Desc = {
    Text = "มอนสเตอร์ตั้งใจจะป้องกันและเสริมสร้าง"
  },
  CommonID_Intent_DefenceDebuff_Desc = {
    Text = "เจตนาการป้องกันและลดทอน"
  },
  CommonID_Intent_Defence_Desc = {
    Text = "เจตนาของมอนสเตอร์ในการป้องกัน"
  },
  CommonID_Intent_Dizzy_Desc = {
    Text = "มอนสเตอร์ต้องการสตั๊น"
  },
  CommonID_Intent_HeavyAttackDCB02_Desc = {
    Text = "เจตนาโจมตีรุนแรง"
  },
  CommonID_Intent_HeavyAttack_Desc = {
    Text = "เจตนาโจมตีรุนแรง"
  },
  CommonID_Intent_StrongBuff_Desc = {
    Text = "เจตนามอนสเตอร์เสริมพลังมหาศาล"
  },
  CommonID_Intent_StrongDebuff_Desc = {
    Text = "เจตนาของมอนสเตอร์อ่อนแอลง"
  },
  CommonID_Intent_Unknown1_Desc = {
    Text = "เจตนาของมอนสเตอร์ไม่ชัดเจน"
  },
  CommonID_Intent_Unknown2_Desc = {
    Text = "เจตนาของมอนสเตอร์ไม่ชัดเจน"
  },
  CommonID_Intent_Unknown3_Desc = {
    Text = "เจตนาของมอนสเตอร์ไม่ชัดเจน"
  },
  CommonID_Intent_Unknown4_Desc = {
    Text = "เจตนาของมอนสเตอร์ไม่ชัดเจน"
  },
  CommonID_Intent_Unknown5_Desc = {
    Text = "เจตนาของมอนสเตอร์ไม่ชัดเจน"
  },
  CommonID_Intent_Unknown6_Desc = {
    Text = "เจตนาของมอนสเตอร์ไม่ชัดเจน"
  },
  CommonID_Intent_Unknown_Desc = {
    Text = "เจตนาของมอนสเตอร์ไม่ชัดเจน"
  },
  CommonID_ItemManagement_Desc = {
    Text = "ไอเทม"
  },
  CommonID_JP_Desc = {
    Text = "ภาษาญี่ปุ่น (alpha)"
  },
  CommonID_KR_Desc = {
    Text = "ภาษาเกาหลี (alpha)"
  },
  CommonID_Keeper_Skill_Desc = {
    Text = "ทักษะของตัวเอก"
  },
  CommonID_KeyType_1_Desc = {
    Text = "บทลืม"
  },
  CommonID_KeyType_2_Desc = {
    Text = "เขตเคออส"
  },
  CommonID_KeyType_3_Desc = {
    Text = "อาณาจักรทะเลลึก"
  },
  CommonID_KeyType_4_Desc = {
    Text = "อาณาจักรคาโร"
  },
  CommonID_KeyType_5_Desc = {
    Text = "ดินแดนอัลตร้า"
  },
  CommonID_Key_Desc = {
    Text = "ปุ่ม"
  },
  CommonID_Language_Desc = {
    Text = "ภาษา"
  },
  CommonID_LevelLimit_Promote_Desc = {
    Text = "เพิ่มขีดจำกัดเลเวล"
  },
  CommonID_Low_Desc = {Text = "ต่ำ"},
  CommonID_Management_Desc = {
    Text = "ไปที่การจัดการ"
  },
  CommonID_ManiaHit_Desc = {
    Text = "คลั่งเมื่อโดนตี"
  },
  CommonID_MasterVolume_Desc = {
    Text = "การควบคุมทั้งหมด"
  },
  CommonID_MaterialsReturn_Desc = {
    Text = "คืนทรัพยากรใช้"
  },
  CommonID_MessagePush_Desc = {
    Text = "การส่งข้อความอัตโนมัติ"
  },
  CommonID_Middle_Desc = {
    Text = "กลาง"
  },
  CommonID_Modify_Desc = {
    Text = "คลิกเพื่อแก้ไข"
  },
  CommonID_MonsterGrade1_Desc = {
    Text = "มอนสเตอร์กลุ่มแรก"
  },
  CommonID_MonsterGrade2_Desc = {
    Text = "มอนสเตอร์ระดับสอง (ชั้นสอง)"
  },
  CommonID_MotherTreeMonster_Desc = {
    Text = "ต้นไม้แม่"
  },
  CommonID_MultiplierXP_Desc = {
    Text = "ประสบการณ์หลายเท่า"
  },
  CommonID_Mute_Desc = {
    Text = "ปิดเสียง"
  },
  CommonID_NotAwakerMonster_Desc = {
    Text = "หัวหน้าที่ไม่ใช่ร่างกายที่ตื่นขึ้น"
  },
  CommonID_Open_Desc = {
    Text = "เปิด"
  },
  CommonID_OperationImpossible_Desc = {
    Text = "ผู้เล่นไม่สามารถทำการกระทำได้สำเร็จ (เล่นการ์ด, การระเบิดของความบ้าคลั่ง) เนื่องจากเหตุผลต่างๆ (เช่น ค่าคอมพิวเตอร์ไม่พอ, ไม่ใช่รอบของตนเอง, ถูกผนึกหรือถูกปูน)"
  },
  CommonID_OperationStop_Desc = {
    Text = "เวลาคิดในรอบของทีมเราสะสมถึงค่าตามสูงสุด (กำหนดในตารางค่าคงที่)"
  },
  CommonID_Orange_Desc = {
    Text = "ทองคำ"
  },
  CommonID_PT_Desc = {
    Text = "ภาษาโปรตุเกส (alpha)"
  },
  CommonID_PVP_Desc = {
    Text = "การเล่นหมากรุกเฟส"
  },
  CommonID_PassiveSkill_Desc = {
    Text = "ทักษะแบบพาสซีฟ"
  },
  CommonID_PersonalProfile_Desc = {
    Text = "ประวัติส่วนตัว"
  },
  CommonID_PlayerEnter_Desc = {
    Text = "เกมเริ่มต้น หลังจากผู้เล่นเลือกการ์ดแล้ว"
  },
  CommonID_PlayerFiles_Desc = {
    Text = "แฟ้มของผู้พิทักษ์"
  },
  CommonID_Potency_Desc = {
    Text = "การตื่นพลัง"
  },
  CommonID_Privacy_Desc = {
    Text = "ความเป็นส่วนตัว"
  },
  CommonID_Purple_Desc = {
    Text = "ตุ้มนาฬิกาเวลา"
  },
  CommonID_RU_Desc = {
    Text = "รัสเซีย (alpha)"
  },
  CommonID_RedGlow_Desc = {
    Text = "เอฟเฟกต์แสงสีแดง"
  },
  CommonID_Red_Desc = {
    Text = "สาปแช่ง"
  },
  CommonID_Redeem_Desc = {
    Text = "ไปแลก"
  },
  CommonID_ReletedAwakerInEnemies_Desc = {
    Text = "การสนทนาระหว่างร่างผู้ปลุกเสกในฝ่ายตรงข้ามและร่างผู้ปลุกเสกฝ่ายเรา"
  },
  CommonID_Relic_Desc = {
    Text = "เรลิก"
  },
  CommonID_Repair_Desc = {
    Text = "ไปซ่อมแซม"
  },
  CommonID_ResNeedReduce_Desc = {
    Text = "ลดความต้องการทรัพยากร"
  },
  CommonID_SUP_Desc = {
    Text = "สายสนับสนุน"
  },
  CommonID_SellCard_Desc = {
    Text = "ขายการ์ดเกม"
  },
  CommonID_ShortcutKey_Desc = {
    Text = "ปุ่มลัด"
  },
  CommonID_SilverAchieve_Desc = {
    Text = "เงิน"
  },
  CommonID_Sin_Desc = {
    Text = "บาปดั้งเดิม"
  },
  CommonID_SkillReady_Desc = {
    Text = "เมื่ออาลีมัสเต็มแล้วและคลิกเพื่อเกิดอาลีมัสระเบิดในทันที"
  },
  CommonID_Skill_LevelUp_Desc = {
    Text = "อัปเกรดทักษะ"
  },
  CommonID_Slider_Desc = {
    Text = "แถบเลื่อนค่า"
  },
  CommonID_SlotCardLevel_Desc = {
    Text = "ระดับของสล็อตต้นฉบับ"
  },
  CommonID_SoundBalance_Desc = {
    Text = "การปรับสมดุลเสียง"
  },
  CommonID_SpecificCommunicateTrig_Desc = {
    Text = "เงื่อนไขการเสร็จสิ้นภารกิจ: ได้ดำเนินการบทสนทนาที่กำหนดในเครื่องสื่อสารแล้ว"
  },
  CommonID_StageDropAdd_Desc = {
    Text = "ดันเจี้ยนเพิ่มผลผลิต"
  },
  CommonID_Switch_Desc = {
    Text = "สวิตช์"
  },
  CommonID_System_Desc = {
    Text = "ระบบ"
  },
  CommonID_TH_Desc = {
    Text = "ภาษาไทย (alpha)"
  },
  CommonID_TRUE_Desc = {Text = "ใช่"},
  CommonID_TR_Desc = {
    Text = "ตุรกี (alpha)"
  },
  CommonID_TW_Desc = {
    Text = "ภาษาจีนดั้งเดิม"
  },
  CommonID_T_Desc = {
    Text = "สายป้องกัน"
  },
  CommonID_TaskCount_Desc = {
    Text = "การนับ"
  },
  CommonID_TaskInProgress_Desc = {
    Text = "กำลังดำเนินการ"
  },
  CommonID_TaweiMonster_Desc = {
    Text = "ทาวีลึกลับ"
  },
  CommonID_Through1_Desc = {
    Text = "ทักษะพาสซีฟ1"
  },
  CommonID_Through2_Desc = {
    Text = "ทักษะเชิงรับ 2"
  },
  CommonID_Tips_Desc = {
    Text = "คำแนะนำ"
  },
  CommonID_TranslationLabel_Desc = {
    Text = "ป้ายกำกับการแปลอย่างเป็นทางการ"
  },
  CommonID_Ulti_Skill_Desc = {
    Text = "ระเบิดพลัง"
  },
  CommonID_UtlSkill_Promote_Desc = {
    Text = "เกินขีดจำกัดคลั่งไคล้ถึงขีดสุด"
  },
  CommonID_VN_Desc = {
    Text = "ภาษาเวียดนาม (alpha)"
  },
  CommonID_VeryHigh_Desc = {
    Text = "สูงมาก"
  },
  CommonID_VeryLow_Desc = {
    Text = "ต่ำมาก"
  },
  CommonID_View_Desc = {
    Text = "ไปตรวจสอบ"
  },
  CommonID_Voice_Desc = {
    Text = "เสียง"
  },
  CommonID_Web_Desc = {
    Text = "การเปลี่ยนเส้นทางเว็บ"
  },
  CommonID_White_Desc = {
    Text = "เงิน"
  },
  CommonID_WindowNotFocusVoice_Desc = {
    Text = "เสียงเมื่อหน้าต่างไม่ได้โฟกัส"
  },
  CommonID_Window_Desc = {
    Text = "หน้าต่าง"
  },
  CommonID_YellowGlow_Desc = {
    Text = "เอฟเฟกต์แสงสีเหลือง"
  }
})
return Text_CommonID
