__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_ErrCode = readonly({
  ErrCode_CMD_UNDEFINED_Desc = {
    Text = "คำสั่งไม่มี"
  },
  ErrCode_ERR_ACTIVITY_FINISH_Desc = {
    Text = "กิจกรรมได้สิ้นสุดลงแล้ว"
  },
  ErrCode_ERR_ACTIVITY_LOGINDAILY_Desc = {
    Text = "จำนวนวันล็อกอินไม่เพียงพอ ไม่สามารถรับรางวัลได้"
  },
  ErrCode_ERR_ACTIVITY_NOT_CONDITION_Desc = {
    Text = "เข้าร่วมกิจกรรม, เงื่อนไขไม่เป็นไปตามที่กำหนด"
  },
  ErrCode_ERR_ACTIVITY_NOT_FIND_Desc = {
    Text = "ไม่มีกิจกรรมนี้"
  },
  ErrCode_ERR_ACTIVITY_NOT_HANDLE_CLASS_Desc = {
    Text = "กิจกรรมยังไม่ได้พัฒนา"
  },
  ErrCode_ERR_ACTIVITY_NOT_OPEN_Desc = {
    Text = "กิจกรรมยังไม่เปิด"
  },
  ErrCode_ERR_ACTIVITY_TASK_NOT_FINISH_Desc = {
    Text = "ภารกิจกิจกรรมยังไม่เสร็จ"
  },
  ErrCode_ERR_ACTIVITY_TRIALSTAGE_FAIL_Desc = {
    Text = "กิจกรรมทดลองเล่น ต้องผ่านด่านก่อนจึงจะได้รับรางวัล"
  },
  ErrCode_ERR_ACTIVITY_TRIAL_NOT_STAGE_Desc = {
    Text = "ในโหมดทดลอง ไม่พบด่านนี้"
  },
  ErrCode_ERR_ASSISTED_ONCE_Desc = {
    Text = "กิจกรรมนี้ ผู้พิทักษ์ได้ช่วยคุณแล้วหนึ่งครั้ง"
  },
  ErrCode_ERR_ASSIST_NEED_FOLLOW_EACHOTHER_Desc = {
    Text = "กิจกรรมนี้ต้องการผู้พิทักษ์ที่ติดตามซึ่งกันและกันเพื่อให้การสนับสนุน"
  },
  ErrCode_ERR_ASSIST_STAR_LIMIT_Desc = {
    Text = "ผู้พิทักษ์ความช่วยเหลือทั่วไปถึงขีดจำกัดแล้ว，กรุณาปรับรายการความช่วยเหลือทั่วไป"
  },
  ErrCode_ERR_AWAKER_NOT_ARRIVED_LEVEL_Desc = {
    Text = "การอัพเกรดทักษะไม่ถึงเงื่อนไขที่ตั้งไว้"
  },
  ErrCode_ERR_AWAKER_NOT_BREAKLEVEL_Desc = {
    Text = "ระดับการเลื่อนขั้นของร่างกายที่ถูกปลุกไม่เพียงพอ"
  },
  ErrCode_ERR_AWAKER_START_DROP_DATE_Desc = {
    Text = "ยังไม่ถึงเวลาปลดล็อก"
  },
  ErrCode_ERR_AWAKER_USED_Desc = {
    Text = "ร่างกายที่ตื่นขึ้นถูกใช้งานแล้ว"
  },
  ErrCode_ERR_AlREADY_BAN_Desc = {
    Text = "ไม่สามารถบล็อกซ้ำได้"
  },
  ErrCode_ERR_BANNED_Desc = {
    Text = "คุณถูกระบุในบัญชีดำของอีกฝ่าย ไม่สามารถดำเนินการได้"
  },
  ErrCode_ERR_BANNED_FOLLOW_LIKE_Desc = {
    Text = "คุณได้ถูกบล็อกโดยฝ่ายตรงข้าม ไม่สามารถติดตามหรือกดถูกใจได้"
  },
  ErrCode_ERR_BAN_FOLLOW_LIKE_Desc = {
    Text = "คุณได้ปิดกั้นผู้ใช้นี้แล้ว ไม่สามารถกดไลค์หรือติดตามได้"
  },
  ErrCode_ERR_BAN_NUM_LIMIT_Desc = {
    Text = "จำนวนคนที่ถูกบล็อกเต็มแล้ว"
  },
  ErrCode_ERR_BATTLE_CREATE_FAILED_Desc = {
    Text = "การสร้างการต่อสู้ล้มเหลว"
  },
  ErrCode_ERR_BP_BUYLEVEL_NOT_ENOUGH_Desc = {
    Text = "เงินไม่เพียงพอสำหรับการซื้อระดับตั๋ว"
  },
  ErrCode_ERR_BP_FAIL_Desc = {
    Text = "การดำเนินการล้มเหลว"
  },
  ErrCode_ERR_BP_NOT_CONFIG_PRIZE_Desc = {
    Text = "บัตรผ่านยังไม่มีราคาสำหรับการซื้อ"
  },
  ErrCode_ERR_BP_PRIVILEGELEVEL_MAX_Desc = {
    Text = "ระดับสิทธิพิเศษของบัตรผ่านเต็มแล้ว ไม่สามารถซื้ออีกครั้ง"
  },
  ErrCode_ERR_BP_PRIVILEGE_LEVEL_NOT_ENOUGH_Desc = {
    Text = "เนื่องจากระดับสิทธิ์ของคุณไม่เพียงพอ จึงไม่สามารถรับได้"
  },
  ErrCode_ERR_BP_REWARD_NOT_EXISTS_Desc = {
    Text = "รางวัลไม่มีอยู่"
  },
  ErrCode_ERR_BP_REWARD_RECEIVED_Desc = {
    Text = "รับรางวัลแล้ว"
  },
  ErrCode_ERR_BUY_TICKET_NO_MONEY_Desc = {
    Text = "ของเหลวเงินใจไม่เพียงพอ"
  },
  ErrCode_ERR_BUY_TICKET_NO_TIMES_Desc = {
    Text = "จำนวนครั้งในการซื้อตั๋วไม่เพียงพอ"
  },
  ErrCode_ERR_CANT_ENCHANCE_RELIC_Desc = {
    Text = "สิ่งสร้างไม่สนับสนุนการเพิ่มพลัง"
  },
  ErrCode_ERR_CARD_MAX_LEVEL_Desc = {
    Text = "การ์ดใบนี้ได้ถึงระดับสูงสุดแล้ว，ไม่สามารถเสริมสร้างได้"
  },
  ErrCode_ERR_CARD_NOT_UPDRADE_Desc = {
    Text = "การ์ดนี้ไม่สามารถปรับปรุงได้"
  },
  ErrCode_ERR_CARD_REVIEW_CONTAINS_BLOCKED_WORD_Desc = {
    Text = "รวมถึงคำที่ปิดบัง"
  },
  ErrCode_ERR_CARD_REVIEW_DUPLICATE_COMMENT_Desc = {
    Text = "ทำซ้ำแสดงความคิดเห็น"
  },
  ErrCode_ERR_CARD_REVIEW_DUPLICATE_DELETE_Desc = {
    Text = "ทำซ้ำการลบ"
  },
  ErrCode_ERR_CARD_REVIEW_DUPLICATE_LIKE_Desc = {
    Text = "ทำซ้ำการถูกใจ"
  },
  ErrCode_ERR_CARD_REVIEW_DUPLICATE_UNLIKE_Desc = {
    Text = "ทำซ้ำการยกเลิกการถูกใจ"
  },
  ErrCode_ERR_CARD_REVIEW_LENGTH_EXCEEDED_Desc = {
    Text = "ความยาวเกินขีดจำกัด"
  },
  ErrCode_ERR_CARD_REVIEW_LIKE_ALREADY_DELETED_Desc = {
    Text = "ความคิดเห็นถูกลบออกแล้ว"
  },
  ErrCode_ERR_CARD_REVIEW_TIMEOUT_Desc = {
    Text = "ความคิดเห็นหมดเวลา"
  },
  ErrCode_ERR_CARD_UPGRADE_NOT_NUMBER_Desc = {
    Text = "การอัปเกรดการ์ดเฉพาะ ไม่มีข้อจำกัดจำนวนครั้ง"
  },
  ErrCode_ERR_CHALLENGE_NOT_FIND_PLOT_Desc = {
    Text = "ไม่พบเนื้อเรื่องดันเจี้ยนท้าทาย"
  },
  ErrCode_ERR_CHALLENGE_NOT_FIND_TASK_Desc = {
    Text = "ยังไม่พบภารกิจเนื้อเรื่องของดันเจี้ยน"
  },
  ErrCode_ERR_CHALLENGE_NOT_IN_STAGEGROUP_Desc = {
    Text = "กำลังอัปเดตข้อมูลระดับความฝันลึก กรุณาลองอีกครั้งในภายหลัง."
  },
  ErrCode_ERR_CHALLENGE_TASK_FINISH_Desc = {
    Text = "ภารกิจท้าทายได้เสร็จสิ้นแล้ว ไม่สามารถรับรางวัลอีกครั้งได้"
  },
  ErrCode_ERR_CHALLENGE_TASK_RUNING_Desc = {
    Text = "ภารกิจท้าทายยังไม่เสร็จสิ้น ยังไม่สามารถรับของรางวัลได้"
  },
  ErrCode_ERR_CHAPTER_PRIZE_CONDITION_Desc = {
    Text = "คะแนนไม่เพียงพอสำหรับรางวัลของบท"
  },
  ErrCode_ERR_CHAPTER_PRIZE_FINISH_Desc = {
    Text = "รางวัลของบทได้รับเรียบร้อยแล้ว"
  },
  ErrCode_ERR_CHOOSE_GEAR_NOT_FIND_Desc = {
    Text = "ไม่พบตำแหน่งปัจจุบันที่เลือก"
  },
  ErrCode_ERR_CHREATE_ROLE_Desc = {
    Text = "ชื่อตัวละครซ้ำ"
  },
  ErrCode_ERR_CLIENT_DATA_Desc = {
    Text = "ข้อผิดพลาดในการส่งข้อมูลของแอปพลิเคชัน"
  },
  ErrCode_ERR_CLOSE_GEAR_NOT_FIND_Desc = {
    Text = "ไม่พบโหนดปัจจุบันที่ต้องการปิด"
  },
  ErrCode_ERR_CONFIG_Desc = {
    Text = "ข้อผิดพลาดตารางตั้งค่า"
  },
  ErrCode_ERR_COURSE_CREDIT_NOT_ENOUGH_Desc = {
    Text = "ไม่สามารถรับรางวัลได้"
  },
  ErrCode_ERR_COURSE_MODULE_NOT_FINISH_Desc = {
    Text = "ยังไม่ถึงเงื่อนไขในการรับรางวัล"
  },
  ErrCode_ERR_COURSE_NOT_BARRIES_DATA_Desc = {
    Text = "ไม่มีข้อมูลคะแนนในด่าน"
  },
  ErrCode_ERR_COURSE_NOT_FIND_COPIES_Desc = {
    Text = "ดันเจี้ยนนี้ไม่มีคะแนนภารกิจ"
  },
  ErrCode_ERR_COURSE_NOT_FIND_MODULE_Desc = {
    Text = "ไม่พบโมดูลคะแนนวิชา"
  },
  ErrCode_ERR_COURSE_NOT_FIND_TASK_Desc = {
    Text = "ยังไม่พบภารกิจ"
  },
  ErrCode_ERR_COURSE_NOT_FIND_UNIT_Desc = {
    Text = "ไม่พบข้อมูลหมวดหมู่ย่อยของหัวข้อ"
  },
  ErrCode_ERR_COURSE_PRIZE_Desc = {
    Text = "หน่วยได้ถูกส่งแล้ว ไม่ต้องส่งอีกครั้ง"
  },
  ErrCode_ERR_COURSE_TASK_CONDITION_NOT_FINISH_Desc = {
    Text = "ภารกิจย่อยในภารกิจหลักยังไม่เสร็จ"
  },
  ErrCode_ERR_COURSE_TASK_FINISH_Desc = {
    Text = "สำเร็จแล้ว"
  },
  ErrCode_ERR_COURSE_UNIT_NOT_FINISH_Desc = {
    Text = "ภารกิจภายใต้ยูนิตยังไม่เสร็จสมบูรณ์ ไม่สามารถส่งได้"
  },
  ErrCode_ERR_CREATE_ROLE_CLOSE_Desc = {
    Text = "ขณะนี้ได้หยุดชั่วคราวการลงทะเบียนผู้พิทักษ์รายใหม่"
  },
  ErrCode_ERR_CREATE_ROLE_Desc = {
    Text = "ไม่มีตัวละคร，จำเป็นต้องสร้าง"
  },
  ErrCode_ERR_CUSTOM_CMD_USE_LIMIT_Desc = {
    Text = "การใช้งานคำสั่งที่กำหนดเองครบจำนวนครั้งสูงสุดแล้ว"
  },
  ErrCode_ERR_ENCHANCE_RELIC_EXIST_Desc = {
    Text = "สิ่งสร้างได้รับการปรับปรุง"
  },
  ErrCode_ERR_ENERGY_STORE_MAX_Desc = {
    Text = "ลิงฟีไทมีปริมาณเพียงพอ ไม่จำเป็นต้องเติม"
  },
  ErrCode_ERR_ENHANCE_RELIC_Desc = {
    Text = "ขณะนี้ไม่สามารถทำการบูชาได้"
  },
  ErrCode_ERR_EQUIP_NOT_FIND_Desc = {
    Text = "ของประดับไม่มีอยู่"
  },
  ErrCode_ERR_EVENT_AREA_NOT_MATCH_Desc = {
    Text = "ข้อผิดพลาดในพื้นที่"
  },
  ErrCode_ERR_EVENT_CHOOSE_CARD_DATA_Desc = {
    Text = "เหตุการณ์เลือกการ์ดไม่พบ"
  },
  ErrCode_ERR_EVENT_CHOOSE_CARD_NUM_MAX_Desc = {
    Text = "เหตุการณ์เลือกการ์ดมีจำนวนมากมเกินไป"
  },
  ErrCode_ERR_EVENT_CHOOSE_RELIC_DATA_Desc = {
    Text = "ไม่มีเหตุการณ์สำหรับสิ่งสร้างที่เลือก"
  },
  ErrCode_ERR_EVENT_CHOOSE_RELIC_NUM_MAX_Desc = {
    Text = "เหตุการณ์เลือกสิ่งสร้างมีจำนวนมากมายนัก"
  },
  ErrCode_ERR_EVENT_CONFIG_NOTYPE_Desc = {
    Text = "มีข้อผิดพลาดในการระบุประเภทในตารางเหตุการณ์ดันเจี้ยน"
  },
  ErrCode_ERR_EVENT_DATA_Desc = {
    Text = "ข้อมูลของเหตุการณ์ผิดพลาด"
  },
  ErrCode_ERR_EVENT_DROP_CARD_NO_REFRESH_NUM_Desc = {
    Text = "การต่อสู้: การรีเฟรชการ์ดที่ดรอปไม่จำกัดจำนวนครั้ง"
  },
  ErrCode_ERR_EVENT_DROP_RELIC_NO_REFRESH_NUM_Desc = {
    Text = "การต่อสู้ทำให้สิ่งสร้างรีเฟรชโดยไม่จำกัดจำนวนครั้ง"
  },
  ErrCode_ERR_EVENT_FINISH_Desc = {
    Text = "เหตุการณ์ในดันเจี้ยนเสร็จสิ้น"
  },
  ErrCode_ERR_EVENT_NOT_FIND_Desc = {
    Text = "เหตุการณ์ในดันเจี้ยนไม่มี"
  },
  ErrCode_ERR_EVENT_NOT_MONEY_ENOUGT_Desc = {
    Text = "ไม่สามารถซื้อได้เนื่องจากเงินลับไม่เพียงพอ"
  },
  ErrCode_ERR_EVENT_NOT_NODE_Desc = {
    Text = "เหตุการณ์ไม่สามารถหาโหนดนี้ได้"
  },
  ErrCode_ERR_EVENT_RANDOM_POND_Desc = {
    Text = "เหตุการณ์สุ่มไม่มีข้อมูล"
  },
  ErrCode_ERR_EVENT_REST_FUNCLOCK_Desc = {
    Text = "ฟังก์ชันของจุดติดต่อถูกล็อก"
  },
  ErrCode_ERR_EVENT_REST_FUNC_SELECT_Desc = {
    Text = "ไม่สามารถเลือกฟังก์ชันของค่ายได้อีกครั้งหลังจากเลือกแล้ว"
  },
  ErrCode_ERR_EVENT_REST_NOT_USENUM_Desc = {
    Text = "ฟังก์ชันของค่ายไม่มีจำนวนครั้งการใช้งานเหลือแล้ว"
  },
  ErrCode_ERR_EVENT_SHOP_NOT_REFRESH_NUM_Desc = {
    Text = "ไม่มีการจำกัดจำนวนครั้งในการรีเฟรชร้านค้าอีเวนต์"
  },
  ErrCode_ERR_EVENT_SHOP_NOT_REMOVECARD_Desc = {
    Text = "จำนวนครั้งในการลบการ์ดจากร้านเหตุการณ์หมดแล้ว"
  },
  ErrCode_ERR_EVENT__CHOOSE_CARD_NUM_Desc = {
    Text = "จำนวนการ์ดสำหรับเลือกเหตุการณ์ไม่ครบ"
  },
  ErrCode_ERR_EVENT__CHOOSE_RELIC_NUM_Desc = {
    Text = "เหตุการณ์เลือกสิ่งสร้างไม่พอ"
  },
  ErrCode_ERR_EXCLUSIVECARD_CARD_CONFIG_NOT_FOUND_Desc = {
    Text = "ไม่พบข้อมูลการ์ดเฉพาะที่เลือกไว้"
  },
  ErrCode_ERR_EXCLUSIVECARD_ROLE_NOT_FOUND_Desc = {
    Text = "เส้นทางการอัปเกรดยังไม่ได้ระบุ ID ตัวละคร (id)"
  },
  ErrCode_ERR_EXCLUSIVE_CARD_INVALID_Desc = {
    Text = "ยังไม่ได้ปลดล็อกการ์ดเฉพาะที่กำหนด"
  },
  ErrCode_ERR_EXCLUSIVE_CARD_NOT_CHANGE_Desc = {
    Text = "ไม่สามารถเปลี่ยนได้ เนื่องจากไม่มีการอัปเดตในบัตรเฉพาะ"
  },
  ErrCode_ERR_EXCLUSIVE_CARD_NOT_SWITCH_Desc = {
    Text = "การสลับการ์ดพิเศษเฉพาะล้มเหลว"
  },
  ErrCode_ERR_EXCLUSIVE_CARD_NOT_UPGRADE_SWITCH_Desc = {
    Text = "ไม่สามารถเปลี่ยนได้หากยังไม่อัปเกรดการ์ดเฉพาะ"
  },
  ErrCode_ERR_EXCLUSIVE_CARD_UUID_NOT_FOUND_Desc = {
    Text = "หา UUID ของบัตรนี้ไม่เจอ"
  },
  ErrCode_ERR_EXPIRED_SUPPORTLIST_Desc = {
    Text = "ร่างเรียกต่อสู้ได้หมดอายุแล้ว กรุณารีเฟรชรายการเรียกต่อสู้และเลือกใหม่อีกครั้ง."
  },
  ErrCode_ERR_FACTORY_COMPOSE_ITEM_LOCK_Desc = {
    Text = "ไอเทมสังเคราะห์ยังไม่ได้ปลดล็อก"
  },
  ErrCode_ERR_FACTORY_COMPOSE_NOT_CURRENCY_Desc = {
    Text = "สกุลเงินที่ต้องการสำหรับการสร้างไอเทมไม่เพียงพอ"
  },
  ErrCode_ERR_FACTORY_COMPOSE_NOT_ITEMS_Desc = {
    Text = "ไอเทมที่จำเป็นสำหรับการสร้างไอเทมยังไม่เพียงพอ"
  },
  ErrCode_ERR_FACTORY_EXIST_Desc = {
    Text = "อาคารนี้มีอยู่แล้ว สร้างซ้ำไม่ได้"
  },
  ErrCode_ERR_FACTORY_HAVE_ACTOR_Desc = {
    Text = "ตำแหน่งนี้มีสิ่งมีชีวิตที่ตื่นแล้ว ไม่สามารถเข้าประจำได้"
  },
  ErrCode_ERR_FACTORY_MAX_LEVEL_Desc = {
    Text = "อาคารขึ้นไปถึงเลเวลสูงสุดแล้ว"
  },
  ErrCode_ERR_FACTORY_NOT_EXIST_Desc = {
    Text = "อาคารนี้ไม่มี"
  },
  ErrCode_ERR_FACTORY_UPGRADE_CONDITION_Desc = {
    Text = "เงื่อนไขสำหรับการอัปเกรด/สร้างอาคารไม่เพียงพอ"
  },
  ErrCode_ERR_FACTORY_UPGRADE_ITEMS_Desc = {
    Text = "ไอเทมที่จำเป็นสำหรับการอัปเกรด/พัฒนาไม่เพียงพอ"
  },
  ErrCode_ERR_GAIN_BATTLE_PRIZE_Desc = {
    Text = "ไม่มีรางวัลให้รับที่จุดนี้"
  },
  ErrCode_ERR_GAMECOPY_CHALLENGETIMES_NOT_ENOUGH_Desc = {
    Text = "ไม่มีโอกาสท้าทาย"
  },
  ErrCode_ERR_GAMECOPY_ENERGY_NOT_ENOUGH_Desc = {
    Text = "พลังชีวิตปัจจุบันต่ำเกินไป,     คุณได้เข้าสู่สถานะอ่อนแอแล้ว."
  },
  ErrCode_ERR_GAMECOPY_MOPPING_LOCK_Desc = {
    Text = "ปลดล็อคเมื่อการสำรวจดันเจี้ยนถึงเลเวล 2"
  },
  ErrCode_ERR_GAMECOPY_NOF_FINISH_Desc = {
    Text = "หลังจากสำเร็จการสำรวจหนึ่งครั้งสามารถสำรวจแบบทันที"
  },
  ErrCode_ERR_GAMECOPY_NOT_Desc = {
    Text = "ดันเจี้ยนผิดพลาด"
  },
  ErrCode_ERR_GAMECOPY_NOT_FIND_Desc = {
    Text = "ไม่พบดันเจี้ยน"
  },
  ErrCode_ERR_GEAR_BLOCK_Desc = {
    Text = "โหนดยังไม่ได้ปลดล็อก"
  },
  ErrCode_ERR_GEAR_FINISH_Desc = {
    Text = "โหนดสำเร็จ"
  },
  ErrCode_ERR_GEAR_NOT_FINISH_Desc = {
    Text = "โหนดยังไม่เสร็จสิ้น"
  },
  ErrCode_ERR_GEAR_NOT_NEIGHBORING_Desc = {
    Text = "โหนดไม่ติดกัน"
  },
  ErrCode_ERR_GEAR_SHOP_NOT_NUM_Desc = {
    Text = "การอัปเดตร้านค้าไม่เพียงพอ"
  },
  ErrCode_ERR_HOME_PLAYERLEVEL_LOCK_Desc = {
    Text = "ระดับของผู้เล่นไม่เพียงพอ"
  },
  ErrCode_ERR_ILLEGAL_CHARACTER_Desc = {
    Text = "คำอธิบายประกอบมีอักขระที่ไม่ถูกต้อง โปรดลองอีกครั้ง"
  },
  ErrCode_ERR_INOTHERBATTLE_Desc = {
    Text = "คู่กรณีกำลังสอบสวนหรืออยู่ในโหมดอื่น"
  },
  ErrCode_ERR_INVALID_INDEX_Desc = {
    Text = "ค่าดัชนีที่ไม่ถูกต้อง"
  },
  ErrCode_ERR_INVITE_EACH_Desc = {
    Text = "ท่านเป็นผู้เชิญชวนของอีกฝ่ายแล้ว"
  },
  ErrCode_ERR_INVITE_REPEAT_Desc = {
    Text = "มีผู้เชิญแล้ว"
  },
  ErrCode_ERR_IN_COPIES_Desc = {
    Text = "สถานะอินสแตนซ์ผิดพลาด กรุณาเข้าสู่ระบบใหม่"
  },
  ErrCode_ERR_ITEM_BAG_FULL_Desc = {
    Text = "กระเป๋าเต็มแล้ว"
  },
  ErrCode_ERR_ITEM_CHARGES_USEDUP_Desc = {
    Text = "จำนวนการซื้อวันนี้ถึงขีดจำกัดแล้ว"
  },
  ErrCode_ERR_ITEM_HAS_BEEN_EQUIP_Desc = {
    Text = "ไอเทมถูกติดตั้งแล้ว"
  },
  ErrCode_ERR_ITEM_HAS_LOCKED_Desc = {
    Text = "ไอเทมถูกล็อก"
  },
  ErrCode_ERR_ITEM_HAS_UNLOCKED_Desc = {
    Text = "ไอเทมยังไม่ได้รับการล็อค"
  },
  ErrCode_ERR_ITEM_MAX_STAGE_Desc = {
    Text = "ไอเทมถึงขั้นสูงสุดแล้ว"
  },
  ErrCode_ERR_ITEM_NOT_ENOUGH_Desc = {
    Text = "ของไม่เพียงพอ"
  },
  ErrCode_ERR_ITEM_NOT_FIND_Desc = {
    Text = "ไม่พบไอเทม"
  },
  ErrCode_ERR_ITEM_NOT_MATCH_Desc = {
    Text = "ไอเทมไม่ตรงกัน"
  },
  ErrCode_ERR_ITEM_NOT_USE_Desc = {
    Text = "ไอเทมไม่สามารถใช้งานได้"
  },
  ErrCode_ERR_ITEM_REPEAT_Desc = {
    Text = "ไอเทมซ้ำ"
  },
  ErrCode_ERR_ITEM_START_DROP_DATE_Desc = {
    Text = "วงล้อมชีวิตหรือกุญแจลับยังไม่ถึงเวลาที่จะใช้งานได้"
  },
  ErrCode_ERR_ITEM_SUB_NUM_FAULT_Desc = {
    Text = "จำนวนไอเท็มไม่ถูกต้อง"
  },
  ErrCode_ERR_ITEM_UNUSABLE_Desc = {
    Text = "ใช้ไม่ได้"
  },
  ErrCode_ERR_LAST_GEAR_NOT_FIND_Desc = {
    Text = "โหนดทริกเกอร์ล่าสุดที่ผ่านมาไม่พบ"
  },
  ErrCode_ERR_LEAVE_NOT_CONDITION_Desc = {
    Text = "พลังงานที่รวบรวมได้ในขณะนี้ไม่เพียงพอที่จะเปิดใช้งานประตูมิติ การเปิดใช้งานประตูมิติต้องใช้พลังงาน {s1} หน่วย."
  },
  ErrCode_ERR_LEVEL_MAX_Desc = {
    Text = "ถึงระดับสูงสุดแล้ว"
  },
  ErrCode_ERR_LOCKED_Desc = {
    Text = "ยังไม่ได้ปลดล็อก"
  },
  ErrCode_ERR_LOCK_COPIESAREA_Desc = {
    Text = "พื้นที่ดันเจี้ยนยังไม่เปิดใช้งาน"
  },
  ErrCode_ERR_LOCK_COPIESPLOTMOPPING_Desc = {
    Text = "การทำซ้ำเส้นเนื้อเรื่องยังไม่ได้เปิดใช้งาน"
  },
  ErrCode_ERR_LOCK_COPIES_Desc = {
    Text = "ดันเจี้ยนที่เลือกยังไม่ได้รับการปลดล็อก"
  },
  ErrCode_ERR_LOCK_SROTYLINE_Desc = {
    Text = "เนื้อเรื่องที่เลือกยังไม่ได้รับการปลดล็อก"
  },
  ErrCode_ERR_LOGIN_SERVER_Desc = {
    Text = "เกิดข้อผิดพลาดขณะเชื่อมต่อกับเซิร์ฟเวอร์"
  },
  ErrCode_ERR_MAIL_ITEM_GAIN_Desc = {
    Text = "ของรางวัลได้รับแล้ว"
  },
  ErrCode_ERR_MAIL_NOT_FIND_Desc = {
    Text = "อีเมลนี้ไม่มีอยู่"
  },
  ErrCode_ERR_MATCH_FAIL_Desc = {
    Text = "ไม่ตรงกัน"
  },
  ErrCode_ERR_MAXSUMMONLIMIT_Desc = {
    Text = "ถึงจำนวนสูงสุดของการตื่นได้!"
  },
  ErrCode_ERR_MONEYCHALLENGE_NOT_CHALLENGE_Desc = {
    Text = "ไม่สามารถเข้าร่วมเหรียญทองที่กำหนดได้-"
  },
  ErrCode_ERR_MONEYCHALLENGE_NOT_CHOOSE_ROUSE_Desc = {
    Text = "กรุณาเลือกร่างกายที่ตื่นขึ้นสำหรับการต่อสู้"
  },
  ErrCode_ERR_MONEYCHALLENGE_NOT_CONDITION_Desc = {
    Text = "จำนวนหนึ่งยังไม่ถูกปลดล็อก - กรุณาทำภารกิจสอบสวนที่กำหนดให้เสร็จสิ้น"
  },
  ErrCode_ERR_NAME_CHANGE_COOLTIME_Desc = {
    Text = "ยังไม่ถึงเวลาเปลี่ยนชื่อได้อีกครั้ง กรุณาเฝ้ารอ"
  },
  ErrCode_ERR_NAME_ILLEGAL_CHARACTER_Desc = {
    Text = "ชื่อมีอักขระที่ไม่ถูกต้อง กรุณากรอกใหม่อีกครั้ง"
  },
  ErrCode_ERR_NAME_NOT_LENGTH_Desc = {
    Text = "ความยาวของชื่อไม่ถูกต้อง ต้องมี 2-4 ตัวอักษร"
  },
  ErrCode_ERR_NOTE_LENGTH_LIMIT_Desc = {
    Text = "ข้อความยาวเกินไป"
  },
  ErrCode_ERR_NOTE_LENGTH_SHORT_Desc = {
    Text = "ข้อความที่ป้อนสั้นเกินไป"
  },
  ErrCode_ERR_NOT_ENOUGH_INTEGRAL_Desc = {
    Text = "ไม่มีคะแนนเพียงพอ"
  },
  ErrCode_ERR_NOT_HAVE_ITEM_Desc = {
    Text = "คุณไม่มีไอเทม"
  },
  ErrCode_ERR_NOT_MOVE_Desc = {
    Text = "ไม่สามารถเคลื่อนย้ายได้"
  },
  ErrCode_ERR_NOT_OPEN_Desc = {
    Text = "ฟีเจอร์นี้ยังไม่เปิดใช้งาน"
  },
  ErrCode_ERR_NOT_PRIZE_CONDITION_Desc = {
    Text = "รางวัลไม่พร้อม ไม่สามารถรับได้"
  },
  ErrCode_ERR_NO_AWAKER_DETAIL_Desc = {
    Text = "กำลังอัปเดตข้อมูลส่วนตัว กรุณารอสักครู่."
  },
  ErrCode_ERR_NO_FRIEND_GAME_Desc = {
    Text = "ปัจจุบันไม่มีการแข่งขันมิตรภาพในขณะนี้"
  },
  ErrCode_ERR_NO_TRINKET_Desc = {
    Text = "ปัจจุบันไม่มีพิธีลับที่ว่างอยู่"
  },
  ErrCode_ERR_NPC_DATA_Desc = {
    Text = "ข้อมูล NPC ผิดพลาด"
  },
  ErrCode_ERR_NPC_FINISH_Desc = {
    Text = "NPC ได้ถูกทริกเกอร์แล้ว"
  },
  ErrCode_ERR_NPC_NOT_FIND_Desc = {
    Text = "NPCไม่มีอยู่"
  },
  ErrCode_ERR_OFFLINE_Desc = {
    Text = "ฝ่ายตรงข้ามไม่อยู่ออนไลน์ในขณะนี้"
  },
  ErrCode_ERR_PLAYERLEVEL_NOT_ENOUGH_Desc = {
    Text = "ระดับของผู้เล่นไม่เพียงพอ"
  },
  ErrCode_ERR_PLOTMOP_STARLIMIT_Desc = {
    Text = "เนื้อเรื่องยังไม่ถึงจำนวนดาวที่กำหนด ไม่สามารถใช้งานฟังก์ชันกวาดล้างได้"
  },
  ErrCode_ERR_PLOTSAY_NOT_END_Desc = {
    Text = "ไม่พบเหตุการณ์ในเนื้อเรื่องเกี่ยวกับบทสนทนา"
  },
  ErrCode_ERR_PLOT_BUY_TIMES_NOT_ENOUGH_Desc = {
    Text = "จำนวนครั้งซื้อท้าทายเนื้อเรื่องไม่พอ"
  },
  ErrCode_ERR_PRIZE_GAIN_Desc = {
    Text = "รับรางวัลแล้ว"
  },
  ErrCode_ERR_PRIZE_NOT_FIND_Desc = {
    Text = "ไม่มีรางวัลนี้"
  },
  ErrCode_ERR_PUTENCHANT_FAIL_Desc = {
    Text = "การฝังรูนล้มเหลว"
  },
  ErrCode_ERR_PVPCOLLECT_NOT_FIND_Desc = {
    Text = "ยังไม่มีคอลเลกชัน PVP"
  },
  ErrCode_ERR_PVPTEAM_NEED_KEEPERSKILL_Desc = {
    Text = "ทีมการเล่นหมากรุกเฟสขาดแคลนกุญแจลับ"
  },
  ErrCode_ERR_PVPTEAM_NEED_WEAPON_Desc = {
    Text = "ทีมการเล่นหมากรุกเฟสขาดวงล้อมชีวิต"
  },
  ErrCode_ERR_PVP_DRAFT_LOCK_Desc = {
    Text = "ไม่ถึงเงื่อนไขในการเปิดโหมดหมุน"
  },
  ErrCode_ERR_PVP_NOT_COOLTIME_Desc = {
    Text = "ท้าทายอยู่ในช่วงเวลาพัก"
  },
  ErrCode_ERR_PVP_NOT_COUNT_Desc = {
    Text = "ไม่มีโอกาสท้าทาย"
  },
  ErrCode_ERR_PVP_NOT_FIND_OTHER_Desc = {
    Text = "ไม่มีคู่ต่อสู้"
  },
  ErrCode_ERR_PVP_NOT_FIND_ROUSE_Desc = {
    Text = "กรุณาเลือกร่างกายที่ตื่นขึ้นสำหรับการต่อสู้"
  },
  ErrCode_ERR_PVP_OverWinTime_Desc = {
    Text = "ในสองฝ่าย มีฝ่ายหนึ่งได้ชนะสองครั้งแล้ว ไม่สามารถเริ่มเกมใหม่ได้"
  },
  ErrCode_ERR_PVP_QUIT_Desc = {
    Text = "คู่ต่อสู้ได้ออกแล้ว"
  },
  ErrCode_ERR_PVP_ROOM_NOT_EXIST_Desc = {
    Text = "การต่อสู้ด้วยรหัสไม่อยู่หรือหมดอายุ"
  },
  ErrCode_ERR_RANK_OUT_OF_RANGE_Desc = {
    Text = "ยังไม่รองรับการดูข้อมูลอันดับที่เกิน 2000 อันดับ"
  },
  ErrCode_ERR_RECHARGE_NOT_CONFIG_Desc = {
    Text = "ไม่มีการตั้งค่านี้ในตารางการเติมเงิน"
  },
  ErrCode_ERR_RECHARGE_NOT_FREE_Desc = {
    Text = "ไม่สามารถเติมเงินฟรีซ้ำได้"
  },
  ErrCode_ERR_REFRESH_NUM_LIMIT_Desc = {
    Text = "การรีเฟรชสินค้าถึงขีดจำกัด"
  },
  ErrCode_ERR_RELATION_Desc = {
    Text = "ไม่ได้อยู่ในสถานะติดตามซึ่งกันและกัน"
  },
  ErrCode_ERR_RELIC_FULL_Desc = {
    Text = "ไอเท็มสะสมเต็มแล้ว"
  },
  ErrCode_ERR_REQUEST_CD_Desc = {
    Text = "คำขอถี่เกินไป ช่วยลองอีกครั้งในภายหลัง"
  },
  ErrCode_ERR_ROLE_ADVANCE_NOT_ITEM_Desc = {
    Text = "จำนวนวัสดุที่ต้องการสำหรับการเลื่อนขั้นสู่ระดับเอลิทไม่เพียงพอ"
  },
  ErrCode_ERR_ROLE_ADVANCE_NOT_MONEY_Desc = {
    Text = "เงินไม่พอสำหรับการอัปเกรดร่างกายที่ตื่นขึ้น"
  },
  ErrCode_ERR_ROLE_DATA_Desc = {
    Text = "ข้อมูลตัวละครมีข้อผิดพลาด"
  },
  ErrCode_ERR_ROLE_ENERGY_FULL_Desc = {
    Text = "ร่างกายที่ตื่นขึ้นเต็มขั้นแล้ว ไม่สามารถเพิ่มขึ้นอีกต่อไป"
  },
  ErrCode_ERR_ROLE_LEVEl_NOENOUGH_Desc = {
    Text = "ระดับการปลุกไม่เพียงพอ"
  },
  ErrCode_ERR_ROLE_MAX_LEVEL_Desc = {
    Text = "ร่างกายที่ถูกปลุกได้ถึงระดับสูงสุดแล้ว ไม่สามารถอัพเกรดเพิ่มเติมได้"
  },
  ErrCode_ERR_ROLE_MONEY_NOT_ENOUGH_Desc = {
    Text = "เงินไม่พอ"
  },
  ErrCode_ERR_ROLE_NOT_ADVANCE_Desc = {
    Text = "ร่างตื่นได้เลื่อนขั้นสู่ระดับสูงสุด"
  },
  ErrCode_ERR_ROLE_NOT_ARRIVED_MAXLEVEL_Desc = {
    Text = "ยังไม่ถึงระดับสูงสุด ไม่สามารถเลื่อนขั้นได้"
  },
  ErrCode_ERR_ROLE_NOT_FIND_Desc = {
    Text = "ไม่พบข้อมูลร่างกายที่ปลุก"
  },
  ErrCode_ERR_ROLE_NOT_SKILL_Desc = {
    Text = "ร่างกายที่ตื่นขึ้นไม่มีความสามารถพิเศษ"
  },
  ErrCode_ERR_ROLE_NOT_SLOTDATA_Desc = {
    Text = "ไม่มีข้อมูลช่องใส่"
  },
  ErrCode_ERR_ROLE_POTENCY_MAX_Desc = {
    Text = "ร่างกายที่ตื่นขึ้นถึงระดับสูงสุดแล้ว"
  },
  ErrCode_ERR_ROLE_POTENCY_UPGRADE_NOT_ITEM_Desc = {
    Text = "ไอเทมสำหรับอัปเกรดศักยภาพร่างกายที่ตื่นไม่เพียงพอ"
  },
  ErrCode_ERR_ROLE_SKILL_LOCKED_Desc = {
    Text = "ร่างกายที่ตื่นขึ้นยังไม่สามารถใช้งานทักษะได้"
  },
  ErrCode_ERR_ROLE_SKILL_MAX_Desc = {
    Text = "ทักษะได้เพิ่มขึ้นถึงระดับสูงสุดแล้ว"
  },
  ErrCode_ERR_ROLE_SKILL_UPGRADE_NOT_ITEM_Desc = {
    Text = "ไอเทมอัปเกรดทักษะไม่เพียงพอ"
  },
  ErrCode_ERR_ROLE_SKILL_UPGRADE_NOT_MONEY_Desc = {
    Text = "ทักษะไม่พอสำหรับการอัพเกรด"
  },
  ErrCode_ERR_ROLE_SLOT_MAX_LEVEL_Desc = {
    Text = "ถึงระดับสูงสุดแล้ว"
  },
  ErrCode_ERR_ROLE_SLOT_UPGRADE_NOT_NUMBER_Desc = {
    Text = "ไม่มีจำนวนครั้งที่สามารถอัพเกรดช่องได้ด้วยตนเอง"
  },
  ErrCode_ERR_ROLE_STAGE_Desc = {
    Text = "เลื่อนขั้นแล้ว ไม่สามารถเลื่อนขั้นอีกได้."
  },
  ErrCode_ERR_ROLE_UPLEVEL_NOT_ITEM_Desc = {
    Text = "ไอเทมที่ใช้สำหรับการอัปเกรดร่างกายที่ตื่นขึ้นไม่พอ"
  },
  ErrCode_ERR_ROLE_UPLEVEL_NOT_MONEY_Desc = {
    Text = "เงินไม่พอสำหรับการอัปเกรดร่างกายที่ตื่นขึ้น"
  },
  ErrCode_ERR_SCHOOL_NOT_MATCH_Desc = {
    Text = "ขอบเขตไม่ตรงตามเงื่อนไข"
  },
  ErrCode_ERR_SCHOOL_TOWN_AWAKER_REQUIREMENT_Desc = {
    Text = "ร่างกายที่ตื่นขึ้นในหอคอยขอบเขตไม่ตรงกับเงื่อนไขของขอบเขต"
  },
  ErrCode_ERR_SCHOOL_TOWN_BATCH_MATCH_Desc = {
    Text = "ด่านที่เข้าอยู่ไม่ได้เปิดใช้งานในขณะนี้"
  },
  ErrCode_ERR_SCHOOL_TOWN_SAME_AWAKER_Desc = {
    Text = "ในหอคอยขอบเขตไม่สามารถนำร่างกายที่ตื่นขึ้นแบบเดียวกันออกสู้ได้"
  },
  ErrCode_ERR_SENIORMONEY_NOT_ENOUGH_Desc = {
    Text = "เงินใจไม่พอ"
  },
  ErrCode_ERR_SERVER_CLOSED_Desc = {
    Text = "กำลังปรับปรุงพื้นที่โรงเรียน กรุณารอจนกว่าจะเสร็จสิ้น"
  },
  ErrCode_ERR_SERVER_NOT_START_Desc = {
    Text = "บริการยังไม่ได้เริ่มทำงาน"
  },
  ErrCode_ERR_SHOP_BUY_Desc = {
    Text = "สินค้าถูกซื้อเรียบร้อยแล้ว"
  },
  ErrCode_ERR_SHOP_CUSTOM_CMD_Desc = {
    Text = "ขณะนี้ไม่สามารถทำการรับรู้ได้"
  },
  ErrCode_ERR_SHOP_GOODS_EXPIRE_Desc = {
    Text = "สินค้าหมดอายุแล้ว ไม่สามารถแลกได้"
  },
  ErrCode_ERR_SHOP_GOODS_NOT_ENGHOU_Desc = {
    Text = "สินค้าที่วางขายไม่มีในสต็อกแล้ว"
  },
  ErrCode_ERR_SHOP_NOT_DATA_Desc = {
    Text = "ไม่มีข้อมูลร้านค้า"
  },
  ErrCode_ERR_SHOP_NOT_Desc = {
    Text = "ไม่มีร้านค้าประเภทนี้"
  },
  ErrCode_ERR_SHOP_NOT_GOODS_Desc = {
    Text = "ไม่มีสินค้านี้วางขาย"
  },
  ErrCode_ERR_SHOP_NOT_GOODS_SELL_Desc = {
    Text = "ในร้านไม่มีสินค้านี้ให้ขาย"
  },
  ErrCode_ERR_SHOP_NOT_REFRESH_NUM_Desc = {
    Text = "ไม่มีจำนวนการรีเฟรช"
  },
  ErrCode_ERR_SHOP_NOT_SELL_Desc = {
    Text = "สินค้านี้ไม่มีในร้าน"
  },
  ErrCode_ERR_SHOP_REFRESH_Desc = {
    Text = "ขณะนี้ไม่ใช่โหนดร้านค้า ไม่สามารถรีเฟรชได้"
  },
  ErrCode_ERR_SOCIAL_NO_ROLE_Desc = {
    Text = "ผู้เล่นนี้ไม่มีอยู่"
  },
  ErrCode_ERR_STAGE_GROUP_BAN_BY_TASK_Desc = {
    Text = "อวตารทั้งหมดของสายตาดั้งเดิมได้ถูกกำจัดไปแล้ว"
  },
  ErrCode_ERR_STAGE_GROUP_TYPE_BAN_BY_DAILY_WIN_COUNT_Desc = {
    Text = "จำนวนครั้งในการท้าทายประเภทด่านประจำวันถึงขีดจำกัด"
  },
  ErrCode_ERR_SUMMON_CLICKTOOFAST_Desc = {
    Text = "คลิกถี่เกินไป, กรุณาลองอีกครั้งในภายหลัง"
  },
  ErrCode_ERR_SUMMON_NOT_OPEN_Desc = {
    Text = "ฟังก์ชันปลุกยังไม่ได้เปิดใช้งาน"
  },
  ErrCode_ERR_TALENT_ACTIVE_CONDITION_Desc = {
    Text = "เงื่อนไขการเปิดใช้งานไม่เพียงพอ"
  },
  ErrCode_ERR_TALENT_ACTIVE_Desc = {
    Text = "พลังสะท้อนได้ถูกเปิดใช้งานแล้ว ไม่ต้องเปิดใช้ซ้ำ"
  },
  ErrCode_ERR_TALENT_INIT_STATE_NOT_RESET_Desc = {
    Text = "สถานะพื้นฐานของการสะท้อนไม่สามารถรีเซ็ตได้"
  },
  ErrCode_ERR_TALENT_ITEM_NOT_ENOUGH_Desc = {
    Text = "วัสดุไม่เพียงพอ"
  },
  ErrCode_ERR_TALENT_MAX_LEVEL_Desc = {
    Text = "การสะท้อนถึงระดับสูงสุดแล้ว"
  },
  ErrCode_ERR_TALENT_NOT_COPIES_Desc = {
    Text = "ไม่พบการเรโซแนนซ์ในดันเจี้ยน"
  },
  ErrCode_ERR_TALENT_NOT_FIND_Desc = {
    Text = "ไม่พบข้อมูลการประสานเสียง"
  },
  ErrCode_ERR_TALENT_NOT_FIND_LEVEL_Desc = {
    Text = "ไม่พบข้อมูลระดับที่เกี่ยวข้องกับจุดเชื่อมโยง"
  },
  ErrCode_ERR_TALENT_NOT_RESET_NUM_Desc = {
    Text = "ไม่มีจำนวนครั้งในการรีเซ็ต"
  },
  ErrCode_ERR_TALENT_UNLOCK_Desc = {
    Text = "ผลการปลุกร่างกายได้ถูกปลดล็อกแล้ว ไม่จำเป็นต้องปลดล็อกซ้ำ"
  },
  ErrCode_ERR_TASKMODULE_PRIZE_NOT_GAIN_Desc = {
    Text = "รับรางวัลแล้ว"
  },
  ErrCode_ERR_TASK_APPOINT_TASK_FINISH_Desc = {
    Text = "ภารกิจที่มอบหมายเสร็จสิ้นแล้ว ไม่สามารถเรียกคืนได้"
  },
  ErrCode_ERR_TASK_DELEGATE_NOT_COND_Desc = {
    Text = "เงื่อนไขการมอบหมายไม่เพียงพอ"
  },
  ErrCode_ERR_TASK_FINISH_Desc = {
    Text = "สำเร็จแล้ว"
  },
  ErrCode_ERR_TASK_NOT_FIND_Desc = {
    Text = "ไม่พบภารกิจ"
  },
  ErrCode_ERR_TASK_NOT_GAINPRIZE_Desc = {
    Text = "ภารกิจยังไม่เสร็จสิ้น ยังไม่สามารถรับรางวัลได้"
  },
  ErrCode_ERR_TEAM_NAME_ILLEGLE_Desc = {
    Text = "ชื่อทีมต้องประกอบด้วยเฉพาะอักขระภาษาจีนและภาษาอังกฤษเท่านั้น"
  },
  ErrCode_ERR_TEAM_NAME_TOO_LONG_Desc = {
    Text = "ชื่อทีมต้องไม่ยาวเกิน 8 ตัวอักษร"
  },
  ErrCode_ERR_TEAM_NEED_4_AWAKER_Desc = {
    Text = "ในทีมจำเป็นต้องมีจำนวนร่างกายที่ตื่นขึ้น 4 ตัว, จึงจะสามารถเข้าสู่ด่านได้"
  },
  ErrCode_ERR_TEAM_NO_TEAM_Desc = {
    Text = "ไม่พบค่ากำหนดทีม"
  },
  ErrCode_ERR_TEAM_NO_WEAPON_SLOT_Desc = {
    Text = "ทีมยังไม่ได้ตั้งค่าวงล้อมชีวิตสำหรับร่างกายที่ตื่นขึ้น"
  },
  ErrCode_ERR_TEAM_SCHOOLMIX_Desc = {
    Text = "การจัดทีมดันเจี้ยนสอบสวนผิดพลาด"
  },
  ErrCode_ERR_TEAM_WEAPON_NOT_EXISTS_Desc = {
    Text = "วงล้อมชีวิตไม่มีอยู่"
  },
  ErrCode_ERR_TICKET_NOT_ENOUGH_Desc = {
    Text = "เอกสารไม่เพียงพอ"
  },
  ErrCode_ERR_TOKEN_Desc = {
    Text = "เกิดข้อผิดพลาดในโทเค็นการเข้าสู่ระบบ"
  },
  ErrCode_ERR_TRIGGER_NOT_FIND_Desc = {
    Text = "ไม่พบโหนดทริกเกอร์ปัจจุบัน"
  },
  ErrCode_ERR_TRINKET_NOT_TRAINING_Desc = {
    Text = "ของตกแต่งไม่ได้ถูกโอนข้อมูล ไม่สามารถเปลี่ยนคุณสมบัติได้"
  },
  ErrCode_ERR_UNATTEN_FIRST_Desc = {
    Text = "คุณต้องยกเลิกการติดตามก่อน แล้วจึงจะสามารถบล็อกได้"
  },
  ErrCode_ERR_UNIT_USED_ONCE_Desc = {
    Text = "ร่างกายที่ปลุก, วงล้อมชีวิต หรือ กุญแจลับ ได้ใช้งานในโหมดนี้ไปแล้ววันนี้"
  },
  ErrCode_ERR_UNLOCK_SUB_PLOT_AVAILABLE_Desc = {
    Text = "การปลดล็อกภารกิจย่อยล้มเหลว: ภารกิจย่อยสามารถใช้งานได้แล้ว"
  },
  ErrCode_ERR_UNLOCK_SUB_PLOT_NOT_OPEN_Desc = {
    Text = "ปลดล็อกเควสย่อยล้มเหลว：เควสย่อยยังไม่ได้เปิดใช้งาน"
  },
  ErrCode_ERR_UNLOCK_SUB_PLOT_NO_UNLOCKITEM_Desc = {
    Text = "ปลดล็อกเควสเสริมไม่สำเร็จ: ไม่มีไอเทมที่ต้องปลดล็อก"
  },
  ErrCode_ERR_UNLOCK_SUB_PLOT_UNLOCKED_Desc = {
    Text = "ปลดล็อกเควสย่อยล้มเหลว：เควสย่อยได้รับการปลดล็อกแล้ว"
  },
  ErrCode_ERR_VERSION_TOO_OLD_Desc = {
    Text = "หมายเลขเวอร์ชันไม่ตรงกัน กรุณาอัปเดตไคลเอนต์เวอร์ชันล่าสุด หากอัปเดตแล้วกรุณารอจนกว่าการบำรุงรักษาในโรงเรียนจะเสร็จสิ้น"
  },
  ErrCode_FAILED_Desc = {
    Text = "ล้มเหลว"
  },
  ErrCode_IS_CREATE_ROLE_Desc = {
    Text = "ตัวละครที่มีอยู่แล้วไม่ต้องสร้างใหม่อีก"
  },
  ErrCode_SUCCESS_Desc = {
    Text = "ดำเนินการสำเร็จ"
  }
})
return Text_ErrCode
