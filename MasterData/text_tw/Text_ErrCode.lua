__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_ErrCode = readonly({
  ErrCode_ERR_ACTIVITY_FINISH_Desc = {
    Text = "活動已結束"
  },
  ErrCode_ERR_ACTIVITY_LOGINDAILY_Desc = {
    Text = "登入天數不足,不能領取獎勵"
  },
  ErrCode_ERR_ACTIVITY_NOT_CONDITION_Desc = {
    Text = "參加活動,條件不滿足"
  },
  ErrCode_ERR_ACTIVITY_NOT_FIND_Desc = {
    Text = "不存在此活動"
  },
  ErrCode_ERR_ACTIVITY_NOT_HANDLE_CLASS_Desc = {
    Text = "活動未開發"
  },
  ErrCode_ERR_ACTIVITY_NOT_OPEN_Desc = {
    Text = "活動尚未開啟"
  },
  ErrCode_ERR_ACTIVITY_TASK_NOT_FINISH_Desc = {
    Text = "活動任務未完成"
  },
  ErrCode_ERR_ACTIVITY_TRIALSTAGE_FAIL_Desc = {
    Text = "試玩活動,未完成關卡不能領取獎勵"
  },
  ErrCode_ERR_ACTIVITY_TRIAL_NOT_STAGE_Desc = {
    Text = "試玩活動中,未找到此關卡"
  },
  ErrCode_ERR_ASSISTED_ONCE_Desc = {
    Text = "本活動該守密人已為你提供過一次助戰"
  },
  ErrCode_ERR_ASSIST_NEED_FOLLOW_EACHOTHER_Desc = {
    Text = "本活動需要互相關注的守密人才能提供助戰"
  },
  ErrCode_ERR_ASSIST_STAR_LIMIT_Desc = {
    Text = "常用助戰守密人已達上限，請調整常用助戰清單"
  },
  ErrCode_ERR_AWAKER_NOT_ARRIVED_LEVEL_Desc = {
    Text = "技能升級未到達設置的條件"
  },
  ErrCode_ERR_AWAKER_NOT_BREAKLEVEL_Desc = {
    Text = "喚醒體升格等級不足"
  },
  ErrCode_ERR_AWAKER_START_DROP_DATE_Desc = {
    Text = "喚醒體還未到開放時間"
  },
  ErrCode_ERR_AWAKER_USED_Desc = {
    Text = "喚醒體已被使用過"
  },
  ErrCode_ERR_AlREADY_BAN_Desc = {
    Text = "不可重複拉黑"
  },
  ErrCode_ERR_BANNED_Desc = {
    Text = "你已被對方列入黑名單，無法操作"
  },
  ErrCode_ERR_BANNED_FOLLOW_LIKE_Desc = {
    Text = "你已被對方列入黑名單，無法關注和點贊"
  },
  ErrCode_ERR_BAN_FOLLOW_LIKE_Desc = {
    Text = "你已將對方列入黑名單，無法點贊和關注"
  },
  ErrCode_ERR_BAN_NUM_LIMIT_Desc = {
    Text = "拉黑人數達到上限"
  },
  ErrCode_ERR_BATTLE_CREATE_FAILED_Desc = {
    Text = "戰鬥創建失敗"
  },
  ErrCode_ERR_BP_BUYLEVEL_NOT_ENOUGH_Desc = {
    Text = "購買通行證等級需要的貨幣不足"
  },
  ErrCode_ERR_BP_FAIL_Desc = {
    Text = "操作失敗"
  },
  ErrCode_ERR_BP_NOT_CONFIG_PRIZE_Desc = {
    Text = "通行證未配置購買特權價格"
  },
  ErrCode_ERR_BP_PRIVILEGELEVEL_MAX_Desc = {
    Text = "通行證特權等級已滿,無法再次購買"
  },
  ErrCode_ERR_BP_PRIVILEGE_LEVEL_NOT_ENOUGH_Desc = {
    Text = "特權等級不足，無法領取"
  },
  ErrCode_ERR_BP_REWARD_NOT_EXISTS_Desc = {
    Text = "獎勵不存在"
  },
  ErrCode_ERR_BP_REWARD_RECEIVED_Desc = {
    Text = "獎勵已領取"
  },
  ErrCode_ERR_BUY_TICKET_NO_MONEY_Desc = {
    Text = "銀芯源液不足"
  },
  ErrCode_ERR_BUY_TICKET_NO_TIMES_Desc = {
    Text = "憑證購買次數不足"
  },
  ErrCode_ERR_CANT_ENCHANCE_RELIC_Desc = {
    Text = "造物不支持強化"
  },
  ErrCode_ERR_CARD_MAX_LEVEL_Desc = {
    Text = "此卡已達最大等級，不能強化"
  },
  ErrCode_ERR_CARD_NOT_UPDRADE_Desc = {
    Text = "此卡不能強化"
  },
  ErrCode_ERR_CARD_REVIEW_DUPLICATE_COMMENT_Desc = {
    Text = "重複發表評論"
  },
  ErrCode_ERR_CARD_REVIEW_DUPLICATE_DELETE_Desc = {
    Text = "重複刪除"
  },
  ErrCode_ERR_CARD_REVIEW_DUPLICATE_LIKE_Desc = {
    Text = "重複點贊"
  },
  ErrCode_ERR_CARD_REVIEW_DUPLICATE_UNLIKE_Desc = {
    Text = "重複取消點贊"
  },
  ErrCode_ERR_CARD_REVIEW_LENGTH_EXCEEDED_Desc = {
    Text = "長度超過限制"
  },
  ErrCode_ERR_CARD_REVIEW_LIKE_ALREADY_DELETED_Desc = {
    Text = "點贊評論已刪除"
  },
  ErrCode_ERR_CARD_REVIEW_TIMEOUT_Desc = {
    Text = "評論超時"
  },
  ErrCode_ERR_CARD_UPGRADE_NOT_NUMBER_Desc = {
    Text = "專屬卡升級，沒有次數"
  },
  ErrCode_ERR_CHALLENGE_NOT_FIND_PLOT_Desc = {
    Text = "未找到副本挑戰的劇情線"
  },
  ErrCode_ERR_CHALLENGE_NOT_FIND_TASK_Desc = {
    Text = "未找到副本挑戰的劇情線任務"
  },
  ErrCode_ERR_CHALLENGE_NOT_IN_STAGEGROUP_Desc = {
    Text = "幻夢深潛關卡資料更新中，請稍後重試。"
  },
  ErrCode_ERR_CHALLENGE_TASK_FINISH_Desc = {
    Text = "挑戰任務已完成,無法再次領取獎勵"
  },
  ErrCode_ERR_CHALLENGE_TASK_RUNING_Desc = {
    Text = "挑戰任務尚未完成,無法領取獎勵"
  },
  ErrCode_ERR_CHAPTER_PRIZE_CONDITION_Desc = {
    Text = "章節獎勵未達到積分"
  },
  ErrCode_ERR_CHAPTER_PRIZE_FINISH_Desc = {
    Text = "章節獎勵已領取"
  },
  ErrCode_ERR_CHOOSE_GEAR_NOT_FIND_Desc = {
    Text = "選擇當前節點未找到"
  },
  ErrCode_ERR_CHREATE_ROLE_Desc = {
    Text = "角色名字重複"
  },
  ErrCode_ERR_CLIENT_DATA_Desc = {
    Text = "用戶端傳入資料錯誤"
  },
  ErrCode_ERR_CLOSE_GEAR_NOT_FIND_Desc = {
    Text = "關閉當前節點未找到"
  },
  ErrCode_ERR_CONFIG_Desc = {
    Text = "配置表錯誤"
  },
  ErrCode_ERR_COURSE_CREDIT_NOT_ENOUGH_Desc = {
    Text = "無法領取獎勵"
  },
  ErrCode_ERR_COURSE_MODULE_NOT_FINISH_Desc = {
    Text = "獎勵尚未達到領取條件"
  },
  ErrCode_ERR_COURSE_NOT_BARRIES_DATA_Desc = {
    Text = "關卡沒有課題分資料"
  },
  ErrCode_ERR_COURSE_NOT_FIND_COPIES_Desc = {
    Text = "沒有此副本的課題分"
  },
  ErrCode_ERR_COURSE_NOT_FIND_MODULE_Desc = {
    Text = "課題分沒找到模組"
  },
  ErrCode_ERR_COURSE_NOT_FIND_TASK_Desc = {
    Text = "尚未找到任務"
  },
  ErrCode_ERR_COURSE_NOT_FIND_UNIT_Desc = {
    Text = "沒找到課題分單元資料"
  },
  ErrCode_ERR_COURSE_PRIZE_Desc = {
    Text = "單元已提交，無需再次提交"
  },
  ErrCode_ERR_COURSE_TASK_CONDITION_NOT_FINISH_Desc = {
    Text = "任務中的子任務未完成"
  },
  ErrCode_ERR_COURSE_TASK_FINISH_Desc = {
    Text = "任務已完成"
  },
  ErrCode_ERR_COURSE_UNIT_NOT_FINISH_Desc = {
    Text = "單元下的任務尚未全部完成，無法提交"
  },
  ErrCode_ERR_CREATE_ROLE_CLOSE_Desc = {
    Text = "當前已暫停新守密人註冊"
  },
  ErrCode_ERR_CREATE_ROLE_Desc = {
    Text = "沒有角色，需要創建"
  },
  ErrCode_ERR_CUSTOM_CMD_USE_LIMIT_Desc = {
    Text = "自訂指令使用次數達到上限"
  },
  ErrCode_ERR_ENCHANCE_RELIC_EXIST_Desc = {
    Text = "造物已強化"
  },
  ErrCode_ERR_ENERGY_STORE_MAX_Desc = {
    Text = "靈啡肽已充足，無需補充"
  },
  ErrCode_ERR_ENHANCE_RELIC_Desc = {
    Text = "當前無法進行祭祀"
  },
  ErrCode_ERR_EQUIP_NOT_FIND_Desc = {
    Text = "飾品不存在"
  },
  ErrCode_ERR_EVENT_AREA_NOT_MATCH_Desc = {
    Text = "事件區域錯誤"
  },
  ErrCode_ERR_EVENT_CHOOSE_CARD_DATA_Desc = {
    Text = "事件選擇卡牌不存在"
  },
  ErrCode_ERR_EVENT_CHOOSE_CARD_NUM_MAX_Desc = {
    Text = "事件選擇卡牌數量太多"
  },
  ErrCode_ERR_EVENT_CHOOSE_RELIC_DATA_Desc = {
    Text = "事件選擇造物不存在"
  },
  ErrCode_ERR_EVENT_CHOOSE_RELIC_NUM_MAX_Desc = {
    Text = "事件選擇造物數量太多"
  },
  ErrCode_ERR_EVENT_CONFIG_NOTYPE_Desc = {
    Text = "副本事件配置表中類型填寫錯誤"
  },
  ErrCode_ERR_EVENT_DATA_Desc = {
    Text = "事件資料錯誤"
  },
  ErrCode_ERR_EVENT_DROP_CARD_NO_REFRESH_NUM_Desc = {
    Text = "戰鬥掉落刷新卡牌沒有次數"
  },
  ErrCode_ERR_EVENT_DROP_RELIC_NO_REFRESH_NUM_Desc = {
    Text = "戰鬥掉落刷新造物沒有次數"
  },
  ErrCode_ERR_EVENT_NOT_MONEY_ENOUGT_Desc = {
    Text = "密銀不足無法購買"
  },
  ErrCode_ERR_EVENT_NOT_NODE_Desc = {
    Text = "事件沒找到此節點"
  },
  ErrCode_ERR_EVENT_RANDOM_POND_Desc = {
    Text = "事件隨機池沒有資料"
  },
  ErrCode_ERR_EVENT_REST_FUNCLOCK_Desc = {
    Text = "聯絡點功能被鎖"
  },
  ErrCode_ERR_EVENT_REST_FUNC_SELECT_Desc = {
    Text = "營地已選擇了功能無法再次選擇"
  },
  ErrCode_ERR_EVENT_REST_NOT_USENUM_Desc = {
    Text = "營地功能已沒有使用次數"
  },
  ErrCode_ERR_EVENT_SHOP_NOT_REFRESH_NUM_Desc = {
    Text = "事件商店刷新沒有次數"
  },
  ErrCode_ERR_EVENT_SHOP_NOT_REMOVECARD_Desc = {
    Text = "事件商店刪除卡牌次數已用完"
  },
  ErrCode_ERR_EVENT__CHOOSE_CARD_NUM_Desc = {
    Text = "事件選擇卡牌數量不足"
  },
  ErrCode_ERR_EVENT__CHOOSE_RELIC_NUM_Desc = {
    Text = "事件選擇造物數量不足"
  },
  ErrCode_ERR_EXCLUSIVECARD_CARD_CONFIG_NOT_FOUND_Desc = {
    Text = "找不到指定專屬卡資訊"
  },
  ErrCode_ERR_EXCLUSIVECARD_ROLE_NOT_FOUND_Desc = {
    Text = "升級路線沒有配置角色id"
  },
  ErrCode_ERR_EXCLUSIVE_CARD_INVALID_Desc = {
    Text = "指定專屬卡未解鎖"
  },
  ErrCode_ERR_EXCLUSIVE_CARD_NOT_CHANGE_Desc = {
    Text = "專屬卡沒有變化無法切換"
  },
  ErrCode_ERR_EXCLUSIVE_CARD_NOT_SWITCH_Desc = {
    Text = "專屬卡切換失敗"
  },
  ErrCode_ERR_EXCLUSIVE_CARD_NOT_UPGRADE_SWITCH_Desc = {
    Text = "專屬卡沒有升級無法切換"
  },
  ErrCode_ERR_EXCLUSIVE_CARD_UUID_NOT_FOUND_Desc = {
    Text = "找不到該專屬卡uuid"
  },
  ErrCode_ERR_EXPIRED_SUPPORTLIST_Desc = {
    Text = "助戰喚醒體已失效，請刷新助戰清單重新選擇助戰喚醒體。"
  },
  ErrCode_ERR_FACTORY_COMPOSE_ITEM_LOCK_Desc = {
    Text = "合成道具未解鎖"
  },
  ErrCode_ERR_FACTORY_COMPOSE_NOT_CURRENCY_Desc = {
    Text = "合成道具需要的貨幣不足"
  },
  ErrCode_ERR_FACTORY_EXIST_Desc = {
    Text = "建築已存在不能再次建設"
  },
  ErrCode_ERR_FACTORY_HAVE_ACTOR_Desc = {
    Text = "位置已存在喚醒體,無法入駐"
  },
  ErrCode_ERR_FACTORY_MAX_LEVEL_Desc = {
    Text = "建築已到達最大等級"
  },
  ErrCode_ERR_FACTORY_NOT_EXIST_Desc = {
    Text = "建築不存在"
  },
  ErrCode_ERR_FACTORY_UPGRADE_CONDITION_Desc = {
    Text = "升級/建設建築條件不足"
  },
  ErrCode_ERR_FACTORY_UPGRADE_ITEMS_Desc = {
    Text = "升級/建設所需要的的道具不足"
  },
  ErrCode_ERR_GAIN_BATTLE_PRIZE_Desc = {
    Text = "當前節點沒有獎勵可領取"
  },
  ErrCode_ERR_GAMECOPY_CHALLENGETIMES_NOT_ENOUGH_Desc = {
    Text = "沒有挑戰次數"
  },
  ErrCode_ERR_GAMECOPY_ENERGY_NOT_ENOUGH_Desc = {
    Text = "當前體力過低，你已經處於虛弱狀態。"
  },
  ErrCode_ERR_GAMECOPY_MOPPING_LOCK_Desc = {
    Text = "副本探索等級達到2級解鎖"
  },
  ErrCode_ERR_GAMECOPY_NOF_FINISH_Desc = {
    Text = "成功完成一次探索後可暫態探索"
  },
  ErrCode_ERR_GAMECOPY_NOT_Desc = {
    Text = "副本錯誤"
  },
  ErrCode_ERR_GAMECOPY_NOT_FIND_Desc = {
    Text = "沒有找到副本"
  },
  ErrCode_ERR_GEAR_BLOCK_Desc = {
    Text = "節點未解鎖"
  },
  ErrCode_ERR_GEAR_FINISH_Desc = {
    Text = "節點已完成"
  },
  ErrCode_ERR_GEAR_NOT_FINISH_Desc = {
    Text = "節點未完成"
  },
  ErrCode_ERR_GEAR_NOT_NEIGHBORING_Desc = {
    Text = "節點不相鄰"
  },
  ErrCode_ERR_GEAR_SHOP_NOT_NUM_Desc = {
    Text = "商店刷新次數不足"
  },
  ErrCode_ERR_HOME_PLAYERLEVEL_LOCK_Desc = {
    Text = "玩家等級不足"
  },
  ErrCode_ERR_ILLEGAL_CHARACTER_Desc = {
    Text = "簡介包含非法字元,請重新輸入"
  },
  ErrCode_ERR_INOTHERBATTLE_Desc = {
    Text = "對方正在調查或其他玩法中"
  },
  ErrCode_ERR_INVALID_INDEX_Desc = {
    Text = "錯誤的索引值"
  },
  ErrCode_ERR_INVITE_EACH_Desc = {
    Text = "您已是對方的邀請人"
  },
  ErrCode_ERR_INVITE_REPEAT_Desc = {
    Text = "已有邀請人"
  },
  ErrCode_ERR_IN_COPIES_Desc = {
    Text = "副本狀態錯誤，請重新登錄"
  },
  ErrCode_ERR_ITEM_BAG_FULL_Desc = {
    Text = "背包已滿"
  },
  ErrCode_ERR_ITEM_CHARGES_USEDUP_Desc = {
    Text = "今日購買次數已達上限"
  },
  ErrCode_ERR_ITEM_HAS_BEEN_EQUIP_Desc = {
    Text = "道具已被裝備"
  },
  ErrCode_ERR_ITEM_HAS_LOCKED_Desc = {
    Text = "道具已鎖定"
  },
  ErrCode_ERR_ITEM_HAS_UNLOCKED_Desc = {
    Text = "道具未鎖定"
  },
  ErrCode_ERR_ITEM_MAX_STAGE_Desc = {
    Text = "道具已達最大等階"
  },
  ErrCode_ERR_ITEM_NOT_USE_Desc = {
    Text = "道具無法使用"
  },
  ErrCode_ERR_ITEM_REPEAT_Desc = {
    Text = "道具重複"
  },
  ErrCode_ERR_ITEM_START_DROP_DATE_Desc = {
    Text = "命輪或鑰令還未到開放時間"
  },
  ErrCode_ERR_ITEM_SUB_NUM_FAULT_Desc = {
    Text = "物品使用數量錯誤"
  },
  ErrCode_ERR_LAST_GEAR_NOT_FIND_Desc = {
    Text = "上一觸發節點未找到"
  },
  ErrCode_ERR_LEAVE_NOT_CONDITION_Desc = {
    Text = "當前收集的能量不足以啟動傳送門，啟動傳送門需要{s1}點能量。"
  },
  ErrCode_ERR_LEVEL_MAX_Desc = {
    Text = "已到達最大等級"
  },
  ErrCode_ERR_LOCKED_Desc = {Text = "未解鎖"},
  ErrCode_ERR_LOCK_COPIESAREA_Desc = {
    Text = "副本區域尚未解鎖"
  },
  ErrCode_ERR_LOCK_COPIESPLOTMOPPING_Desc = {
    Text = "劇情線掃蕩尚未解鎖"
  },
  ErrCode_ERR_LOCK_COPIES_Desc = {
    Text = "選擇的副本尚未解鎖"
  },
  ErrCode_ERR_LOCK_SROTYLINE_Desc = {
    Text = "選擇的劇情線尚未解鎖"
  },
  ErrCode_ERR_LOGIN_SERVER_Desc = {
    Text = "登錄伺服器錯誤"
  },
  ErrCode_ERR_MAIL_ITEM_GAIN_Desc = {
    Text = "附件已領取"
  },
  ErrCode_ERR_MAIL_NOT_FIND_Desc = {
    Text = "郵件不存在"
  },
  ErrCode_ERR_MATCH_FAIL_Desc = {
    Text = "匹配失敗"
  },
  ErrCode_ERR_MAXSUMMONLIMIT_Desc = {
    Text = "已達最大可喚醒次數！"
  },
  ErrCode_ERR_MONEYCHALLENGE_NOT_CHALLENGE_Desc = {
    Text = "指定金幣本無法挑戰-"
  },
  ErrCode_ERR_MONEYCHALLENGE_NOT_CHOOSE_ROUSE_Desc = {
    Text = "請選擇上陣的喚醒體"
  },
  ErrCode_ERR_MONEYCHALLENGE_NOT_CONDITION_Desc = {
    Text = "指定金幣本未解鎖-請完成指定的調查副本"
  },
  ErrCode_ERR_NAME_CHANGE_COOLTIME_Desc = {
    Text = "再次改名時間未到，請等待"
  },
  ErrCode_ERR_NAME_ILLEGAL_CHARACTER_Desc = {
    Text = "名字中包含非法字符，請重新輸入"
  },
  ErrCode_ERR_NAME_NOT_LENGTH_Desc = {
    Text = "名字長度不合法，必須2-4字符"
  },
  ErrCode_ERR_NOTE_LENGTH_LIMIT_Desc = {
    Text = "輸入字元過長"
  },
  ErrCode_ERR_NOTE_LENGTH_SHORT_Desc = {
    Text = "輸入字元過短"
  },
  ErrCode_ERR_NOT_ENOUGH_INTEGRAL_Desc = {
    Text = "沒有足夠的積分"
  },
  ErrCode_ERR_NOT_HAVE_ITEM_Desc = {
    Text = "您沒有此道具"
  },
  ErrCode_ERR_NOT_MOVE_Desc = {
    Text = "不可移動"
  },
  ErrCode_ERR_NOT_OPEN_Desc = {
    Text = "功能尚未開放"
  },
  ErrCode_ERR_NOT_PRIZE_CONDITION_Desc = {
    Text = "獎勵未滿足條件,無法領取"
  },
  ErrCode_ERR_NO_AWAKER_DETAIL_Desc = {
    Text = "個人資料更新中，請稍後再查看。"
  },
  ErrCode_ERR_NO_FRIEND_GAME_Desc = {
    Text = "當前沒有進行中的友誼賽"
  },
  ErrCode_ERR_NO_TRINKET_Desc = {
    Text = "當前沒有閒置密契"
  },
  ErrCode_ERR_NPC_DATA_Desc = {
    Text = "NPC資料錯誤"
  },
  ErrCode_ERR_NPC_FINISH_Desc = {
    Text = "Npc已觸發過"
  },
  ErrCode_ERR_OFFLINE_Desc = {
    Text = "對方當前不在線"
  },
  ErrCode_ERR_PLAYERLEVEL_NOT_ENOUGH_Desc = {
    Text = "玩家等級不足"
  },
  ErrCode_ERR_PLOTMOP_STARLIMIT_Desc = {
    Text = "劇情線星級不足，無法掃蕩"
  },
  ErrCode_ERR_PLOTSAY_NOT_END_Desc = {
    Text = "沒有找到劇情對話事件"
  },
  ErrCode_ERR_PLOT_BUY_TIMES_NOT_ENOUGH_Desc = {
    Text = "劇情線挑戰購買次數不足"
  },
  ErrCode_ERR_PRIZE_GAIN_Desc = {
    Text = "獎勵已領取"
  },
  ErrCode_ERR_PRIZE_NOT_FIND_Desc = {
    Text = "沒有此獎勵"
  },
  ErrCode_ERR_PUTENCHANT_FAIL_Desc = {
    Text = "鑲嵌符文失敗"
  },
  ErrCode_ERR_PVPCOLLECT_NOT_FIND_Desc = {
    Text = "未獲得PVP收藏"
  },
  ErrCode_ERR_PVPTEAM_NEED_KEEPERSKILL_Desc = {
    Text = "相位對弈隊伍上陣鑰令不足"
  },
  ErrCode_ERR_PVPTEAM_NEED_WEAPON_Desc = {
    Text = "相位對弈隊伍上陣命輪不足"
  },
  ErrCode_ERR_PVP_DRAFT_LOCK_Desc = {
    Text = "未達到輪選模式開啟條件"
  },
  ErrCode_ERR_PVP_NOT_COOLTIME_Desc = {
    Text = "挑戰冷卻中"
  },
  ErrCode_ERR_PVP_NOT_COUNT_Desc = {
    Text = "沒有挑戰次數"
  },
  ErrCode_ERR_PVP_NOT_FIND_OTHER_Desc = {
    Text = "沒有挑戰對手"
  },
  ErrCode_ERR_PVP_NOT_FIND_ROUSE_Desc = {
    Text = "請選擇上陣的喚醒體"
  },
  ErrCode_ERR_PVP_OverWinTime_Desc = {
    Text = "雙方其中有一人已達兩次勝場，無法再來一局"
  },
  ErrCode_ERR_PVP_QUIT_Desc = {
    Text = "對手已退出"
  },
  ErrCode_ERR_PVP_ROOM_NOT_EXIST_Desc = {
    Text = "密碼對戰 不存在 或 已過時"
  },
  ErrCode_ERR_RANK_OUT_OF_RANGE_Desc = {
    Text = "暫不支援查看 2000 名以外的排行資訊。"
  },
  ErrCode_ERR_RECHARGE_NOT_CONFIG_Desc = {
    Text = "儲值配置表中沒有此配置"
  },
  ErrCode_ERR_RECHARGE_NOT_FREE_Desc = {
    Text = "已免費儲值過無法再次儲值"
  },
  ErrCode_ERR_REFRESH_NUM_LIMIT_Desc = {
    Text = "商品刷新次數達到上限"
  },
  ErrCode_ERR_RELATION_Desc = {
    Text = "與對方不是互相關注狀態"
  },
  ErrCode_ERR_RELIC_FULL_Desc = {
    Text = "遺物已滿"
  },
  ErrCode_ERR_REQUEST_CD_Desc = {
    Text = "請求過於頻繁，請稍候嘗試"
  },
  ErrCode_ERR_ROLE_ADVANCE_NOT_ITEM_Desc = {
    Text = "精英化所需材料數量不足"
  },
  ErrCode_ERR_ROLE_ADVANCE_NOT_MONEY_Desc = {
    Text = "喚醒體升級消耗的貨幣不足"
  },
  ErrCode_ERR_ROLE_DATA_Desc = {
    Text = "角色資料錯誤"
  },
  ErrCode_ERR_ROLE_ENERGY_FULL_Desc = {
    Text = "喚醒體降臨度已滿，無法繼續提升"
  },
  ErrCode_ERR_ROLE_LEVEl_NOENOUGH_Desc = {
    Text = "喚醒體等級不足"
  },
  ErrCode_ERR_ROLE_MAX_LEVEL_Desc = {
    Text = "喚醒體已到達最高等級無法升級"
  },
  ErrCode_ERR_ROLE_MONEY_NOT_ENOUGH_Desc = {
    Text = "貨幣不足"
  },
  ErrCode_ERR_ROLE_NOT_ADVANCE_Desc = {
    Text = "喚醒體已升格到最高階"
  },
  ErrCode_ERR_ROLE_NOT_ARRIVED_MAXLEVEL_Desc = {
    Text = "沒有到達最高等級，無法進階"
  },
  ErrCode_ERR_ROLE_NOT_FIND_Desc = {
    Text = "沒有找到喚醒體資料"
  },
  ErrCode_ERR_ROLE_NOT_SKILL_Desc = {
    Text = "喚醒體沒有技能"
  },
  ErrCode_ERR_ROLE_NOT_SLOTDATA_Desc = {
    Text = "沒有槽位資訊"
  },
  ErrCode_ERR_ROLE_POTENCY_MAX_Desc = {
    Text = "喚醒體潛力已到達最高等級"
  },
  ErrCode_ERR_ROLE_POTENCY_UPGRADE_NOT_ITEM_Desc = {
    Text = "喚醒體潛力升級道具不足"
  },
  ErrCode_ERR_ROLE_SKILL_LOCKED_Desc = {
    Text = "喚醒體尚未解鎖技能"
  },
  ErrCode_ERR_ROLE_SKILL_MAX_Desc = {
    Text = "技能已達到最大等級"
  },
  ErrCode_ERR_ROLE_SKILL_UPGRADE_NOT_ITEM_Desc = {
    Text = "技能升級道具不足"
  },
  ErrCode_ERR_ROLE_SKILL_UPGRADE_NOT_MONEY_Desc = {
    Text = "技能升級貨幣不足"
  },
  ErrCode_ERR_ROLE_SLOT_MAX_LEVEL_Desc = {
    Text = "已到達最大等級"
  },
  ErrCode_ERR_ROLE_SLOT_UPGRADE_NOT_NUMBER_Desc = {
    Text = "已沒有手動升級槽位次數"
  },
  ErrCode_ERR_ROLE_STAGE_Desc = {
    Text = "已進階，不能再次進階"
  },
  ErrCode_ERR_ROLE_UPLEVEL_NOT_ITEM_Desc = {
    Text = "喚醒體升級消耗的道具不足"
  },
  ErrCode_ERR_ROLE_UPLEVEL_NOT_MONEY_Desc = {
    Text = "喚醒體升級消耗的貨幣不足"
  },
  ErrCode_ERR_SCHOOL_NOT_MATCH_Desc = {
    Text = "界域不滿足條件"
  },
  ErrCode_ERR_SCHOOL_TOWN_AWAKER_REQUIREMENT_Desc = {
    Text = "界域塔出戰的喚醒體不滿足界域要求"
  },
  ErrCode_ERR_SCHOOL_TOWN_BATCH_MATCH_Desc = {
    Text = "進入的關卡不在當前開啟的關卡中"
  },
  ErrCode_ERR_SCHOOL_TOWN_SAME_AWAKER_Desc = {
    Text = "界域塔不可攜帶相同的喚醒體出戰"
  },
  ErrCode_ERR_SENIORMONEY_NOT_ENOUGH_Desc = {
    Text = "銀芯不足"
  },
  ErrCode_ERR_SERVER_CLOSED_Desc = {
    Text = "校園維護中，請靜候修整完成"
  },
  ErrCode_ERR_SERVER_NOT_START_Desc = {
    Text = "服務未啟動"
  },
  ErrCode_ERR_SHOP_BUY_Desc = {
    Text = "商品已購買"
  },
  ErrCode_ERR_SHOP_CUSTOM_CMD_Desc = {
    Text = "當前無法進行感應"
  },
  ErrCode_ERR_SHOP_GOODS_EXPIRE_Desc = {
    Text = "商品已過期，不可兌換"
  },
  ErrCode_ERR_SHOP_GOODS_NOT_ENGHOU_Desc = {
    Text = "出售的商品已沒有庫存"
  },
  ErrCode_ERR_SHOP_NOT_DATA_Desc = {
    Text = "沒有商店資料"
  },
  ErrCode_ERR_SHOP_NOT_Desc = {
    Text = "沒有此類型商店"
  },
  ErrCode_ERR_SHOP_NOT_GOODS_Desc = {
    Text = "沒有此商品出售"
  },
  ErrCode_ERR_SHOP_NOT_GOODS_SELL_Desc = {
    Text = "商店沒此商品出售"
  },
  ErrCode_ERR_SHOP_NOT_REFRESH_NUM_Desc = {
    Text = "沒有刷新次數"
  },
  ErrCode_ERR_SHOP_NOT_SELL_Desc = {
    Text = "商店中沒有此商品"
  },
  ErrCode_ERR_SHOP_REFRESH_Desc = {
    Text = "當前不是商店節點無法刷新"
  },
  ErrCode_ERR_SOCIAL_NO_ROLE_Desc = {
    Text = "該玩家不存在"
  },
  ErrCode_ERR_STAGE_GROUP_BAN_BY_TASK_Desc = {
    Text = "該原初之視的所有分身均已被擊殺"
  },
  ErrCode_ERR_STAGE_GROUP_TYPE_BAN_BY_DAILY_WIN_COUNT_Desc = {
    Text = "關卡類型每日挑戰次數達到上限"
  },
  ErrCode_ERR_SUMMON_CLICKTOOFAST_Desc = {
    Text = "點擊過於頻繁，請稍候嘗試"
  },
  ErrCode_ERR_SUMMON_NOT_OPEN_Desc = {
    Text = "喚醒功能未開啟"
  },
  ErrCode_ERR_TALENT_ACTIVE_CONDITION_Desc = {
    Text = "啟動條件不足"
  },
  ErrCode_ERR_TALENT_ACTIVE_Desc = {
    Text = "共鳴已啟動無需再次啟動"
  },
  ErrCode_ERR_TALENT_INIT_STATE_NOT_RESET_Desc = {
    Text = "共鳴初始狀態不能重置"
  },
  ErrCode_ERR_TALENT_ITEM_NOT_ENOUGH_Desc = {
    Text = "共鳴材料不足。"
  },
  ErrCode_ERR_TALENT_MAX_LEVEL_Desc = {
    Text = "共鳴點已到達最大等級"
  },
  ErrCode_ERR_TALENT_NOT_COPIES_Desc = {
    Text = "副本中未發現共鳴"
  },
  ErrCode_ERR_TALENT_NOT_FIND_Desc = {
    Text = "沒有發現共鳴資料"
  },
  ErrCode_ERR_TALENT_NOT_FIND_LEVEL_Desc = {
    Text = "未發現共鳴點等級相關資料"
  },
  ErrCode_ERR_TALENT_NOT_RESET_NUM_Desc = {
    Text = "沒有重置次數"
  },
  ErrCode_ERR_TALENT_UNLOCK_Desc = {
    Text = "喚醒體生產效果已解鎖,無需再次解鎖"
  },
  ErrCode_ERR_TASKMODULE_PRIZE_NOT_GAIN_Desc = {
    Text = "獎勵已領取"
  },
  ErrCode_ERR_TASK_APPOINT_TASK_FINISH_Desc = {
    Text = "委派任務已完成,不可召回"
  },
  ErrCode_ERR_TASK_DELEGATE_NOT_COND_Desc = {
    Text = "委派條件不足"
  },
  ErrCode_ERR_TASK_FINISH_Desc = {
    Text = "任務已完成"
  },
  ErrCode_ERR_TASK_NOT_FIND_Desc = {
    Text = "未找到任務"
  },
  ErrCode_ERR_TASK_NOT_GAINPRIZE_Desc = {
    Text = "任務尚未完成,無法領取獎勵"
  },
  ErrCode_ERR_TEAM_NAME_ILLEGLE_Desc = {
    Text = "隊伍名中不可包含非中文或英文字元"
  },
  ErrCode_ERR_TEAM_NAME_TOO_LONG_Desc = {
    Text = "隊伍名長度不可大於8個字元"
  },
  ErrCode_ERR_TEAM_NEED_4_AWAKER_Desc = {
    Text = "隊伍中喚醒體數量需要滿足四個才可進入關卡"
  },
  ErrCode_ERR_TEAM_NO_TEAM_Desc = {
    Text = "找不到隊伍配置"
  },
  ErrCode_ERR_TEAM_NO_WEAPON_SLOT_Desc = {
    Text = "隊伍喚醒體沒有設置命輪"
  },
  ErrCode_ERR_TEAM_SCHOOLMIX_Desc = {
    Text = "隊伍中喚醒體存在界域衝突，請進行調整"
  },
  ErrCode_ERR_TEAM_WEAPON_NOT_EXISTS_Desc = {
    Text = "命輪不存在"
  },
  ErrCode_ERR_TICKET_NOT_ENOUGH_Desc = {
    Text = "憑證不足"
  },
  ErrCode_ERR_TOKEN_Desc = {
    Text = "登錄Token錯誤"
  },
  ErrCode_ERR_TRIGGER_NOT_FIND_Desc = {
    Text = "當前觸發節點未找到"
  },
  ErrCode_ERR_TRINKET_NOT_TRAINING_Desc = {
    Text = "飾品沒轉錄,無法替換屬性"
  },
  ErrCode_ERR_UNATTEN_FIRST_Desc = {
    Text = "先取消關注對方才可拉黑"
  },
  ErrCode_ERR_UNIT_USED_ONCE_Desc = {
    Text = "喚醒體、命輪或鑰令今日在本玩法中已使用過"
  },
  ErrCode_ERR_UNLOCK_SUB_PLOT_AVAILABLE_Desc = {
    Text = "解鎖支線失敗：支線可用"
  },
  ErrCode_ERR_UNLOCK_SUB_PLOT_NOT_OPEN_Desc = {
    Text = "解鎖支線失敗：支線未開啟"
  },
  ErrCode_ERR_UNLOCK_SUB_PLOT_NO_UNLOCKITEM_Desc = {
    Text = "解鎖支線失敗：無需解鎖物品"
  },
  ErrCode_ERR_UNLOCK_SUB_PLOT_UNLOCKED_Desc = {
    Text = "解鎖支線失敗：支線已解鎖"
  },
  ErrCode_ERR_VERSION_TOO_OLD_Desc = {
    Text = "版本號不符，請更新最新用戶端；如已更新請靜待校園維護完成"
  },
  ErrCode_FAILED_Desc = {Text = "失敗"},
  ErrCode_IS_CREATE_ROLE_Desc = {
    Text = "已有角色不需要再次創建"
  }
})
return Text_ErrCode
