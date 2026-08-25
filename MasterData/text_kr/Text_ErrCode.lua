__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_ErrCode = readonly({
  ErrCode_CMD_UNDEFINED_Desc = {
    Text = "명령어가 존재하지 않습니다"
  },
  ErrCode_ERR_ACTIVITY_FINISH_Desc = {
    Text = "이벤트 종료"
  },
  ErrCode_ERR_ACTIVITY_LOGINDAILY_Desc = {
    Text = "로그인 일수가 부족해 보상을 수령할 수 없습니다"
  },
  ErrCode_ERR_ACTIVITY_NOT_CONDITION_Desc = {
    Text = "이벤트에 참가하기 위한 조건을 충족하지 못했습니다"
  },
  ErrCode_ERR_ACTIVITY_NOT_FIND_Desc = {
    Text = "존재하지 않는 이벤트"
  },
  ErrCode_ERR_ACTIVITY_NOT_HANDLE_CLASS_Desc = {
    Text = "이벤트 미개발"
  },
  ErrCode_ERR_ACTIVITY_NOT_OPEN_Desc = {
    Text = "이벤트 미개방"
  },
  ErrCode_ERR_ACTIVITY_TASK_NOT_FINISH_Desc = {
    Text = "이벤트 미션 미완성"
  },
  ErrCode_ERR_ACTIVITY_TRIALSTAGE_FAIL_Desc = {
    Text = "시연 이벤트에서 미완료된 스테이지는 보상을 수령할 수 없습니다"
  },
  ErrCode_ERR_ACTIVITY_TRIAL_NOT_STAGE_Desc = {
    Text = "시연 이벤트에서 해당 스테이지를 찾을 수 없습니다"
  },
  ErrCode_ERR_ASSISTED_ONCE_Desc = {
    Text = "이 이벤트에서 해당 수호자가 이미 한 번 조력을 제공했습니다"
  },
  ErrCode_ERR_ASSIST_NEED_FOLLOW_EACHOTHER_Desc = {
    Text = "해당 이벤트는 수호자가 조력을 제공할 수 있어, 맞팔로우한 수호자가 필요합니다."
  },
  ErrCode_ERR_ASSIST_STAR_LIMIT_Desc = {
    Text = "일반 수호자의 조력 사용 한도에 도달했습니다. 일반 조력 목록을 조정해 주세요."
  },
  ErrCode_ERR_AWAKER_NOT_ARRIVED_LEVEL_Desc = {
    Text = "스킬 업그레이드 조건에 미치지 못했습니다"
  },
  ErrCode_ERR_AWAKER_NOT_BREAKLEVEL_Desc = {
    Text = "깨어남체 승격 레벨 부족"
  },
  ErrCode_ERR_AWAKER_START_DROP_DATE_Desc = {
    Text = "깨어남체가 아직 개방되지 않았습니다"
  },
  ErrCode_ERR_AWAKER_USED_Desc = {
    Text = "깨어남체가 이미 사용되었습니다"
  },
  ErrCode_ERR_AlREADY_BAN_Desc = {
    Text = "중복 블랙리스트 추가 불가"
  },
  ErrCode_ERR_BANNED_Desc = {
    Text = "수호자 님께서 상대방에 의해 블랙리스트에 올라, 작동할 수 없습니다."
  },
  ErrCode_ERR_BANNED_FOLLOW_LIKE_Desc = {
    Text = "당신은 상대방의 블랙리스트에 포함되어 팔로우하거나 좋아요를 누르는 것이 불가능합니다"
  },
  ErrCode_ERR_BAN_FOLLOW_LIKE_Desc = {
    Text = "당신은 상대방을 블랙리스트에 추가하여 좋아요와 팔로잉을 할 수 없습니다"
  },
  ErrCode_ERR_BAN_NUM_LIMIT_Desc = {
    Text = "블랙리스트 인원 수가 최대치에 도달했습니다"
  },
  ErrCode_ERR_BATTLE_CREATE_FAILED_Desc = {
    Text = "전투 생성 실타래패"
  },
  ErrCode_ERR_BP_BUYLEVEL_NOT_ENOUGH_Desc = {
    Text = "패스 레벨 구매에 필요한 재화가 부족합니다"
  },
  ErrCode_ERR_BP_FAIL_Desc = {
    Text = "작업 실타래패"
  },
  ErrCode_ERR_BP_NOT_CONFIG_PRIZE_Desc = {
    Text = "패스에 구매 특권 가격이 설정되지 않습니다"
  },
  ErrCode_ERR_BP_PRIVILEGELEVEL_MAX_Desc = {
    Text = "패스 특권 레벨이 최대치에 도달하여 다시 구매할 수 없습니다"
  },
  ErrCode_ERR_BP_PRIVILEGE_LEVEL_NOT_ENOUGH_Desc = {
    Text = "특권 레벨이 부족하여 수령할 수 없습니다"
  },
  ErrCode_ERR_BP_REWARD_NOT_EXISTS_Desc = {
    Text = "보상이 존재하지 않습니다"
  },
  ErrCode_ERR_BP_REWARD_RECEIVED_Desc = {
    Text = "보상 수령 완료"
  },
  ErrCode_ERR_BUY_TICKET_NO_MONEY_Desc = {
    Text = "은심 원액 부족"
  },
  ErrCode_ERR_BUY_TICKET_NO_TIMES_Desc = {
    Text = "구매 횟수가 부족합니다"
  },
  ErrCode_ERR_CANT_ENCHANCE_RELIC_Desc = {
    Text = "유물은 강화를 지원하지 않습니다"
  },
  ErrCode_ERR_CARD_MAX_LEVEL_Desc = {
    Text = "해당 카드는 최대 레벨에 도달하여 강화할 수 없습니다."
  },
  ErrCode_ERR_CARD_NOT_UPDRADE_Desc = {
    Text = "해당 카드는 강화할 수 없습니다"
  },
  ErrCode_ERR_CARD_REVIEW_CONTAINS_BLOCKED_WORD_Desc = {
    Text = "차폐 문자가 포함되어 있습니다"
  },
  ErrCode_ERR_CARD_REVIEW_DUPLICATE_COMMENT_Desc = {
    Text = "코멘트 반복 작성"
  },
  ErrCode_ERR_CARD_REVIEW_DUPLICATE_DELETE_Desc = {
    Text = "반복 삭제"
  },
  ErrCode_ERR_CARD_REVIEW_DUPLICATE_LIKE_Desc = {
    Text = "좋아요 반복"
  },
  ErrCode_ERR_CARD_REVIEW_DUPLICATE_UNLIKE_Desc = {
    Text = "좋아요 취소 반복"
  },
  ErrCode_ERR_CARD_REVIEW_LENGTH_EXCEEDED_Desc = {
    Text = "길이가 제한을 초과했습니다"
  },
  ErrCode_ERR_CARD_REVIEW_LIKE_ALREADY_DELETED_Desc = {
    Text = "좋아요 및 코멘트가 삭제되었습니다"
  },
  ErrCode_ERR_CARD_REVIEW_TIMEOUT_Desc = {
    Text = "코멘트 시간 초과"
  },
  ErrCode_ERR_CARD_UPGRADE_NOT_NUMBER_Desc = {
    Text = "전용 카드 업그레이드, 제한 없음"
  },
  ErrCode_ERR_CHALLENGE_NOT_FIND_PLOT_Desc = {
    Text = "던전 도전의 스토리 라인을 찾을 수 없습니다."
  },
  ErrCode_ERR_CHALLENGE_NOT_FIND_TASK_Desc = {
    Text = "던전 도전의 스토리 라인 미션을 찾을 수 없습니다"
  },
  ErrCode_ERR_CHALLENGE_NOT_IN_STAGEGROUP_Desc = {
    Text = "환몽 심잠 레벨 데이터 업데이트 중입니다. 잠시 후 다시 시도해 주세요."
  },
  ErrCode_ERR_CHALLENGE_TASK_FINISH_Desc = {
    Text = "도전 과제가 완료되어, 보상을 다시 수령할 수 없습니다."
  },
  ErrCode_ERR_CHALLENGE_TASK_RUNING_Desc = {
    Text = "도전 과제가 아직 완료되지 않아, 보상을 수령할 수 없습니다."
  },
  ErrCode_ERR_CHAPTER_PRIZE_CONDITION_Desc = {
    Text = "챕터 보상을 위한 pt가 부족합니다"
  },
  ErrCode_ERR_CHAPTER_PRIZE_FINISH_Desc = {
    Text = "챕터 보상 수령 완료"
  },
  ErrCode_ERR_CHOOSE_GEAR_NOT_FIND_Desc = {
    Text = "현재 노드를 찾을 수 없습니다"
  },
  ErrCode_ERR_CHREATE_ROLE_Desc = {
    Text = "캐릭터 닉네임 중복"
  },
  ErrCode_ERR_CLIENT_DATA_Desc = {
    Text = "클라이언트에 전달된 데이터 에러"
  },
  ErrCode_ERR_CLOSE_GEAR_NOT_FIND_Desc = {
    Text = "현재 노드를 찾을 수 없습니다"
  },
  ErrCode_ERR_CONFIG_Desc = {
    Text = "설정표 오류"
  },
  ErrCode_ERR_COURSE_CREDIT_NOT_ENOUGH_Desc = {
    Text = "보상을 수령할 수 없습니다"
  },
  ErrCode_ERR_COURSE_MODULE_NOT_FINISH_Desc = {
    Text = "보상 수령 조건을 충족하지 않았습니다"
  },
  ErrCode_ERR_COURSE_NOT_BARRIES_DATA_Desc = {
    Text = "레벨에 과제 점수가 없습니다"
  },
  ErrCode_ERR_COURSE_NOT_FIND_COPIES_Desc = {
    Text = "해당 던전에는 과제 점수가 없습니다."
  },
  ErrCode_ERR_COURSE_NOT_FIND_MODULE_Desc = {
    Text = "과제 모듈을 찾지 못했습니다."
  },
  ErrCode_ERR_COURSE_NOT_FIND_TASK_Desc = {
    Text = "미션을 찾지 못했습니다"
  },
  ErrCode_ERR_COURSE_NOT_FIND_UNIT_Desc = {
    Text = "과제별 과제 데이터를 찾을 수 없습니다"
  },
  ErrCode_ERR_COURSE_PRIZE_Desc = {
    Text = "유닛이 제출되어, 다시 제출할 필요가 없습니다."
  },
  ErrCode_ERR_COURSE_TASK_CONDITION_NOT_FINISH_Desc = {
    Text = "미션 중 하위 미션이 아직 완료되지 않았습니다"
  },
  ErrCode_ERR_COURSE_TASK_FINISH_Desc = {
    Text = "미션이 완료되었습니다"
  },
  ErrCode_ERR_COURSE_UNIT_NOT_FINISH_Desc = {
    Text = "유닛의 모든 미션이 완료되지 않아, 제출이 불가능합니다."
  },
  ErrCode_ERR_CREATE_ROLE_CLOSE_Desc = {
    Text = "현재 새로운 수호자 등록이 중지되었습니다"
  },
  ErrCode_ERR_CREATE_ROLE_Desc = {
    Text = "존재하지 않는 캐릭터입니다, 생성이 필요합니다"
  },
  ErrCode_ERR_CUSTOM_CMD_USE_LIMIT_Desc = {
    Text = "자정 명령 사용 횟수가 최대치에 도달했습니다"
  },
  ErrCode_ERR_ENCHANCE_RELIC_EXIST_Desc = {
    Text = "유물 강화됨"
  },
  ErrCode_ERR_ENERGY_STORE_MAX_Desc = {
    Text = "린피테이프가 충분하므로 추가 보충이 필요하지 않습니다"
  },
  ErrCode_ERR_ENHANCE_RELIC_Desc = {
    Text = "현재 제사를 진행할 수 없습니다"
  },
  ErrCode_ERR_EQUIP_NOT_FIND_Desc = {
    Text = "장식품이 존재하지 않습니다"
  },
  ErrCode_ERR_EVENT_AREA_NOT_MATCH_Desc = {
    Text = "이벤트 영역 오류"
  },
  ErrCode_ERR_EVENT_CHOOSE_CARD_DATA_Desc = {
    Text = "이벤트 선택 카드가 존재하지 않습니다"
  },
  ErrCode_ERR_EVENT_CHOOSE_CARD_NUM_MAX_Desc = {
    Text = "이벤트 선택 카드 수량이 너무 많습니다"
  },
  ErrCode_ERR_EVENT_CHOOSE_RELIC_DATA_Desc = {
    Text = "이벤트 선택 유물 없음"
  },
  ErrCode_ERR_EVENT_CHOOSE_RELIC_NUM_MAX_Desc = {
    Text = "이벤트 선택 유물 수량 너무 많음"
  },
  ErrCode_ERR_EVENT_CONFIG_NOTYPE_Desc = {
    Text = "던전 이벤트 설정표에서 타입이 잘못 기입되었습니다"
  },
  ErrCode_ERR_EVENT_DATA_Desc = {
    Text = "이벤트 데이터 오류"
  },
  ErrCode_ERR_EVENT_DROP_CARD_NO_REFRESH_NUM_Desc = {
    Text = "전투 드롭 갱신 카드 횟수가 없습니다"
  },
  ErrCode_ERR_EVENT_DROP_RELIC_NO_REFRESH_NUM_Desc = {
    Text = "전투에서 드롭되는 유물은 갱신 횟수가 없습니다."
  },
  ErrCode_ERR_EVENT_FINISH_Desc = {
    Text = "던전 이벤트를 이미 완료하였습니다"
  },
  ErrCode_ERR_EVENT_NOT_FIND_Desc = {
    Text = "던전 이벤트가 존재하지 않습니다"
  },
  ErrCode_ERR_EVENT_NOT_MONEY_ENOUGT_Desc = {
    Text = "밀은이 부족하여 구매할 수 없습니다."
  },
  ErrCode_ERR_EVENT_NOT_NODE_Desc = {
    Text = "이벤트가 해당 노드를 찾지 못했습니다"
  },
  ErrCode_ERR_EVENT_RANDOM_POND_Desc = {
    Text = "이벤트 랜덤 풀에 데이터가 존재하지 않습니다"
  },
  ErrCode_ERR_EVENT_REST_FUNCLOCK_Desc = {
    Text = "연락처 기능이 잠겨 있습니다"
  },
  ErrCode_ERR_EVENT_REST_FUNC_SELECT_Desc = {
    Text = "캠프는 이미 선택된 기능으로, 다시 선택할 수 없습니다."
  },
  ErrCode_ERR_EVENT_REST_NOT_USENUM_Desc = {
    Text = "캠프 기능의 사용 횟수가 남아 있지 않습니다"
  },
  ErrCode_ERR_EVENT_SHOP_NOT_REFRESH_NUM_Desc = {
    Text = "이벤트 상점 갱신 횟수가 없습니다"
  },
  ErrCode_ERR_EVENT_SHOP_NOT_REMOVECARD_Desc = {
    Text = "이벤트 상점에서 카드 삭제 횟수가 모두 사용되었습니다"
  },
  ErrCode_ERR_EVENT__CHOOSE_CARD_NUM_Desc = {
    Text = "이벤트 선택 카드 수량이 부족합니다"
  },
  ErrCode_ERR_EVENT__CHOOSE_RELIC_NUM_Desc = {
    Text = "이벤트 선택 유물 수량 부족"
  },
  ErrCode_ERR_EXCLUSIVECARD_CARD_CONFIG_NOT_FOUND_Desc = {
    Text = "지정 전용 카드 정보를 찾을 수 없습니다."
  },
  ErrCode_ERR_EXCLUSIVECARD_ROLE_NOT_FOUND_Desc = {
    Text = "업그레이드 경로에 캐릭터 ID가 설정되지 않았습니다"
  },
  ErrCode_ERR_EXCLUSIVE_CARD_INVALID_Desc = {
    Text = "지정 전용 카드 미개방"
  },
  ErrCode_ERR_EXCLUSIVE_CARD_NOT_CHANGE_Desc = {
    Text = "전용 카드가 변경되지 않아 전환할 수 없습니다"
  },
  ErrCode_ERR_EXCLUSIVE_CARD_NOT_SWITCH_Desc = {
    Text = "전용 카드 전환 실타래패"
  },
  ErrCode_ERR_EXCLUSIVE_CARD_NOT_UPGRADE_SWITCH_Desc = {
    Text = "전용 카드가 업그레이드되지 않아 전환할 수 없습니다"
  },
  ErrCode_ERR_EXCLUSIVE_CARD_UUID_NOT_FOUND_Desc = {
    Text = "해당 전용 카드 UUID를 찾을 수 없습니다"
  },
  ErrCode_ERR_EXPIRED_SUPPORTLIST_Desc = {
    Text = "소환 전투 깨어남체가 만료되었습니다. 소환 목록을 새로 고치고 다시 선택하세요."
  },
  ErrCode_ERR_FACTORY_COMPOSE_ITEM_LOCK_Desc = {
    Text = "합성 아이템 미개방"
  },
  ErrCode_ERR_FACTORY_COMPOSE_NOT_CURRENCY_Desc = {
    Text = "아이템 합성에 필요한 재화가 부족합니다"
  },
  ErrCode_ERR_FACTORY_COMPOSE_NOT_ITEMS_Desc = {
    Text = "합성에 필요한 다른 아이템이 부족합니다"
  },
  ErrCode_ERR_FACTORY_EXIST_Desc = {
    Text = "건물이 이미 존재하여 재건설할 수 없습니다"
  },
  ErrCode_ERR_FACTORY_HAVE_ACTOR_Desc = {
    Text = "위치에 이미 깨어남체가 있어 입주할 수 없습니다"
  },
  ErrCode_ERR_FACTORY_MAX_LEVEL_Desc = {
    Text = "건물이 최대 레벨에 도달하였습니다"
  },
  ErrCode_ERR_FACTORY_NOT_EXIST_Desc = {
    Text = "건물 없음"
  },
  ErrCode_ERR_FACTORY_UPGRADE_CONDITION_Desc = {
    Text = "건물 업그레이드/건설 조건 미달"
  },
  ErrCode_ERR_FACTORY_UPGRADE_ITEMS_Desc = {
    Text = "업그레이드/건설에 필요한 아이템이 부족합니다"
  },
  ErrCode_ERR_GAIN_BATTLE_PRIZE_Desc = {
    Text = "현재 노드에는 수령할 보상이 없습니다"
  },
  ErrCode_ERR_GAMECOPY_CHALLENGETIMES_NOT_ENOUGH_Desc = {
    Text = "도전 횟수가 없습니다"
  },
  ErrCode_ERR_GAMECOPY_ENERGY_NOT_ENOUGH_Desc = {
    Text = "현재 체력이 너무 낮아 약화 상태에 있습니다."
  },
  ErrCode_ERR_GAMECOPY_MOPPING_LOCK_Desc = {
    Text = "던전 탐색 레벨이 2레벨에 도달하면 해제됩니다"
  },
  ErrCode_ERR_GAMECOPY_NOF_FINISH_Desc = {
    Text = "한번의 탐색을 성공적으로 완료한 후 즉시 추가 탐색이 가능합니다"
  },
  ErrCode_ERR_GAMECOPY_NOT_Desc = {
    Text = "던전 오류"
  },
  ErrCode_ERR_GAMECOPY_NOT_FIND_Desc = {
    Text = "던전을 찾을 수 없습니다"
  },
  ErrCode_ERR_GEAR_BLOCK_Desc = {
    Text = "노드 미개방"
  },
  ErrCode_ERR_GEAR_FINISH_Desc = {
    Text = "노드가 완료되었습니다"
  },
  ErrCode_ERR_GEAR_NOT_FINISH_Desc = {
    Text = "노드가 완성되지 않았습니다"
  },
  ErrCode_ERR_GEAR_NOT_NEIGHBORING_Desc = {
    Text = "노드가 인접하지 않음"
  },
  ErrCode_ERR_GEAR_SHOP_NOT_NUM_Desc = {
    Text = "상점 갱신 횟수가 부족합니다"
  },
  ErrCode_ERR_HOME_PLAYERLEVEL_LOCK_Desc = {
    Text = "깨어남자 조사 등급이 부족합니다"
  },
  ErrCode_ERR_ILLEGAL_CHARACTER_Desc = {
    Text = "요약에 비속어나 민감한 문자가 포함되어 있습니다. 다시 입력해 주세요."
  },
  ErrCode_ERR_INOTHERBATTLE_Desc = {
    Text = "상대방이 조사 중이거나 다른 활동을 하고 있습니다"
  },
  ErrCode_ERR_INVALID_INDEX_Desc = {
    Text = "잘못된 인덱스 값"
  },
  ErrCode_ERR_INVITE_EACH_Desc = {
    Text = "당신은 상대방의 초대자로 알려져 있습니다"
  },
  ErrCode_ERR_INVITE_REPEAT_Desc = {
    Text = "이미 초대한 수호자입니다"
  },
  ErrCode_ERR_IN_COPIES_Desc = {
    Text = "던전 상태 오류, 다시 로그인해 주세요"
  },
  ErrCode_ERR_ITEM_BAG_FULL_Desc = {
    Text = "가방이 가득 찼습니다"
  },
  ErrCode_ERR_ITEM_CHARGES_USEDUP_Desc = {
    Text = "오늘 최대 구매 횟수에 도달했습니다"
  },
  ErrCode_ERR_ITEM_HAS_BEEN_EQUIP_Desc = {
    Text = "아이템이 장비되었습니다"
  },
  ErrCode_ERR_ITEM_HAS_LOCKED_Desc = {
    Text = "아이템이 잠겼습니다"
  },
  ErrCode_ERR_ITEM_HAS_UNLOCKED_Desc = {
    Text = "아이템이 잠겨 있지 않습니다"
  },
  ErrCode_ERR_ITEM_MAX_STAGE_Desc = {
    Text = "아이템이 최대 등급에 도달했습니다"
  },
  ErrCode_ERR_ITEM_NOT_ENOUGH_Desc = {
    Text = "아이템 부족"
  },
  ErrCode_ERR_ITEM_NOT_FIND_Desc = {
    Text = "아이템을 찾을 수 없습니다"
  },
  ErrCode_ERR_ITEM_NOT_MATCH_Desc = {
    Text = "아이템이 일치하지 않습니다"
  },
  ErrCode_ERR_ITEM_NOT_USE_Desc = {
    Text = "아이템을 사용할 수 없습니다"
  },
  ErrCode_ERR_ITEM_REPEAT_Desc = {
    Text = "도구 중복"
  },
  ErrCode_ERR_ITEM_START_DROP_DATE_Desc = {
    Text = "명륜이나 열쇠 지령이 아직 해제될 시간이 아닙니다"
  },
  ErrCode_ERR_ITEM_SUB_NUM_FAULT_Desc = {
    Text = "아이템 사용 수량 오류"
  },
  ErrCode_ERR_ITEM_UNUSABLE_Desc = {
    Text = "아이템 사용 불가"
  },
  ErrCode_ERR_LAST_GEAR_NOT_FIND_Desc = {
    Text = "이전 트리거 노드를 찾을 수 없습니다."
  },
  ErrCode_ERR_LEAVE_NOT_CONDITION_Desc = {
    Text = "현재 수집된 에너지는 포털을 활성화하기에 충분하지 않습니다. 포털을 활성화하려면 에너지 {s1}pt가 필요합니다."
  },
  ErrCode_ERR_LEVEL_MAX_Desc = {
    Text = "최대 레벨에 도달했습니다"
  },
  ErrCode_ERR_LOCKED_Desc = {Text = "미개방"},
  ErrCode_ERR_LOCK_COPIESAREA_Desc = {
    Text = "던전 지역이 해제되지 않았습니다"
  },
  ErrCode_ERR_LOCK_COPIESPLOTMOPPING_Desc = {
    Text = "스토리 라인 스캔이 아직 해제되지 않았습니다"
  },
  ErrCode_ERR_LOCK_COPIES_Desc = {
    Text = "선택한 던전이 아직 해제되지 않았습니다"
  },
  ErrCode_ERR_LOCK_SROTYLINE_Desc = {
    Text = "선택한 스토리 라인은 아직 해제되지 않았습니다"
  },
  ErrCode_ERR_LOGIN_SERVER_Desc = {
    Text = "로그인 서버 오류"
  },
  ErrCode_ERR_MAIL_ITEM_GAIN_Desc = {
    Text = "첨부파일 수령 완료"
  },
  ErrCode_ERR_MAIL_NOT_FIND_Desc = {
    Text = "우편이 존재하지 않습니다"
  },
  ErrCode_ERR_MATCH_FAIL_Desc = {
    Text = "매칭 실타래패"
  },
  ErrCode_ERR_MAXSUMMONLIMIT_Desc = {
    Text = "최대 깨어남 가능 횟수에 도달했습니다!"
  },
  ErrCode_ERR_MONEYCHALLENGE_NOT_CHALLENGE_Desc = {
    Text = "선택한 골드 던전은 도전할 수 없습니다"
  },
  ErrCode_ERR_MONEYCHALLENGE_NOT_CHOOSE_ROUSE_Desc = {
    Text = "출전할 깨어남체를 선택해 주세요"
  },
  ErrCode_ERR_MONEYCHALLENGE_NOT_CONDITION_Desc = {
    Text = "선택한 골드 던전이 아직 미개방되었습니다. 지정된 조사 던전을 먼저 완료해 주세요!"
  },
  ErrCode_ERR_NAME_CHANGE_COOLTIME_Desc = {
    Text = "이름 변경 대기 시간이 아직 끝나지 않았습니다, 잠시 기다려 주세요."
  },
  ErrCode_ERR_NAME_ILLEGAL_CHARACTER_Desc = {
    Text = "이름에 금지된 단어가 포함되어 있습니다, 다시 입력해주세요."
  },
  ErrCode_ERR_NAME_NOT_LENGTH_Desc = {
    Text = "이름 길이가 올바르지 않습니다, 2~4자 내로 입력해주세요."
  },
  ErrCode_ERR_NOTE_LENGTH_LIMIT_Desc = {
    Text = "입력한 문자가 너무 길어요"
  },
  ErrCode_ERR_NOTE_LENGTH_SHORT_Desc = {
    Text = "입력 문자가 너무 짧습니다"
  },
  ErrCode_ERR_NOT_ENOUGH_INTEGRAL_Desc = {
    Text = "충분한 포인트가 없습니다"
  },
  ErrCode_ERR_NOT_HAVE_ITEM_Desc = {
    Text = "해당 아이템을 보유하지 않았습니다"
  },
  ErrCode_ERR_NOT_MOVE_Desc = {
    Text = "이동 불가"
  },
  ErrCode_ERR_NOT_OPEN_Desc = {
    Text = "기능이 아직 해제되지 않았습니다"
  },
  ErrCode_ERR_NOT_PRIZE_CONDITION_Desc = {
    Text = "보상 조건을 충족하지 못하여 수령할 수 없습니다"
  },
  ErrCode_ERR_NO_AWAKER_DETAIL_Desc = {
    Text = "개인 정보 업데이트 중입니다. 잠시 후 다시 확인해 주세요."
  },
  ErrCode_ERR_NO_FRIEND_GAME_Desc = {
    Text = "현재 진행 중인 친선 경기가 없습니다."
  },
  ErrCode_ERR_NO_TRINKET_Desc = {
    Text = "현재 사용 가능하지 않은 미스터리가 없습니다"
  },
  ErrCode_ERR_NPC_DATA_Desc = {
    Text = "NPC 데이터 오류"
  },
  ErrCode_ERR_NPC_FINISH_Desc = {
    Text = "NPC가 이미 제거되었습니다"
  },
  ErrCode_ERR_NPC_NOT_FIND_Desc = {
    Text = "NPC가 존재하지 않습니다"
  },
  ErrCode_ERR_OFFLINE_Desc = {
    Text = "상대방이 현재 오프라인입니다"
  },
  ErrCode_ERR_PLAYERLEVEL_NOT_ENOUGH_Desc = {
    Text = "수호자 조사 등급이 부족합니다"
  },
  ErrCode_ERR_PLOTMOP_STARLIMIT_Desc = {
    Text = "스토리 라인의 레벨이 부족하여 스캔이 불가능합니다"
  },
  ErrCode_ERR_PLOTSAY_NOT_END_Desc = {
    Text = "스토리 대화 이벤트를 찾을 수 없습니다"
  },
  ErrCode_ERR_PLOT_BUY_TIMES_NOT_ENOUGH_Desc = {
    Text = "스토리 라인 도전 구매 횟수 부족"
  },
  ErrCode_ERR_PRIZE_GAIN_Desc = {
    Text = "보상 수령 완료"
  },
  ErrCode_ERR_PRIZE_NOT_FIND_Desc = {
    Text = "해당 보상은 존재하지 않습니다"
  },
  ErrCode_ERR_PUTENCHANT_FAIL_Desc = {
    Text = "계령 장착 실타래패"
  },
  ErrCode_ERR_PVPCOLLECT_NOT_FIND_Desc = {
    Text = "PVP 컬렉션 추가 미획득"
  },
  ErrCode_ERR_PVPTEAM_NEED_KEEPERSKILL_Desc = {
    Text = "페이즈 체스 파티 상장 열쇠 지령 부족"
  },
  ErrCode_ERR_PVPTEAM_NEED_WEAPON_Desc = {
    Text = "페이즈 체스 파티 상장 명륜 부족"
  },
  ErrCode_ERR_PVP_DRAFT_LOCK_Desc = {
    Text = "순차 선택 모드 해제 조건 미충족"
  },
  ErrCode_ERR_PVP_NOT_COOLTIME_Desc = {
    Text = "도전 쿨다운 중"
  },
  ErrCode_ERR_PVP_NOT_COUNT_Desc = {
    Text = "도전 횟수가 없습니다"
  },
  ErrCode_ERR_PVP_NOT_FIND_OTHER_Desc = {
    Text = "도전할 상대방이 없습니다"
  },
  ErrCode_ERR_PVP_NOT_FIND_ROUSE_Desc = {
    Text = "출전할 깨어남체를 선택해 주세요"
  },
  ErrCode_ERR_PVP_OverWinTime_Desc = {
    Text = "양측 중 한 팀이 이미 두 번의 승리를 거둬 더 이상 진행할 수 없습니다"
  },
  ErrCode_ERR_PVP_QUIT_Desc = {
    Text = "상대방이 게임을 종료했습니다"
  },
  ErrCode_ERR_PVP_ROOM_NOT_EXIST_Desc = {
    Text = "비공개 대전이 존재하지 않거나 이미 만료되었습니다"
  },
  ErrCode_ERR_RANK_OUT_OF_RANGE_Desc = {
    Text = "현재 2000위 이외의 순위 정보는 조회할 수 없습니다."
  },
  ErrCode_ERR_RECHARGE_NOT_CONFIG_Desc = {
    Text = "결제 설정 테이블에 해당 설정이 없습니다"
  },
  ErrCode_ERR_RECHARGE_NOT_FREE_Desc = {
    Text = "무료 충전은 1회만 가능합니다"
  },
  ErrCode_ERR_REFRESH_NUM_LIMIT_Desc = {
    Text = "상품 갱신 횟수가 최대 횟수에 도달했습니다"
  },
  ErrCode_ERR_RELATION_Desc = {
    Text = "상대방과 맞팔로우하지 않은 상태"
  },
  ErrCode_ERR_RELIC_FULL_Desc = {
    Text = "유물이 가득 찼습니다"
  },
  ErrCode_ERR_REQUEST_CD_Desc = {
    Text = "요청이 너무 자주 발생했습니다. 잠시 후에 다시 시도해 주세요."
  },
  ErrCode_ERR_ROLE_ADVANCE_NOT_ITEM_Desc = {
    Text = "엘리트화에 필요한 재료 수량이 부족합니다"
  },
  ErrCode_ERR_ROLE_ADVANCE_NOT_MONEY_Desc = {
    Text = "깨어남체 업그레이드에 필요한 재화가 부족합니다"
  },
  ErrCode_ERR_ROLE_DATA_Desc = {
    Text = "캐릭터 데이터 오류"
  },
  ErrCode_ERR_ROLE_ENERGY_FULL_Desc = {
    Text = "깨어남체 강림도가 가득 차, 계속 업그레이드시킬 수 없습니다"
  },
  ErrCode_ERR_ROLE_LEVEl_NOENOUGH_Desc = {
    Text = "깨어남체 레벨이 부족합니다"
  },
  ErrCode_ERR_ROLE_MAX_LEVEL_Desc = {
    Text = "깨어남체가 최고 레벨에 도달해 더 이상 업그레이드할 수 없습니다"
  },
  ErrCode_ERR_ROLE_MONEY_NOT_ENOUGH_Desc = {
    Text = "재화가 부족합니다"
  },
  ErrCode_ERR_ROLE_NOT_ADVANCE_Desc = {
    Text = "깨어남체가 최고 단계로 승격되었습니다"
  },
  ErrCode_ERR_ROLE_NOT_ARRIVED_MAXLEVEL_Desc = {
    Text = "최고 등급에 도달하지 않아 더 이상 업그레이드할 수 없습니다"
  },
  ErrCode_ERR_ROLE_NOT_FIND_Desc = {
    Text = "깨어남체 데이터를 찾을 수 없습니다"
  },
  ErrCode_ERR_ROLE_NOT_SKILL_Desc = {
    Text = "깨어남체에 스킬이 존재하지 않습니다"
  },
  ErrCode_ERR_ROLE_NOT_SLOTDATA_Desc = {
    Text = "슬롯 정보가 없습니다"
  },
  ErrCode_ERR_ROLE_POTENCY_MAX_Desc = {
    Text = "깨어남체 잠재력이 최고 레벨에 도달했습니다"
  },
  ErrCode_ERR_ROLE_POTENCY_UPGRADE_NOT_ITEM_Desc = {
    Text = "깨어남체 잠재력 업그레이드에 필요한 아이템이 부족합니다"
  },
  ErrCode_ERR_ROLE_SKILL_LOCKED_Desc = {
    Text = "깨어남체의 스킬이 아직 해제되지 않았습니다"
  },
  ErrCode_ERR_ROLE_SKILL_MAX_Desc = {
    Text = "스킬 최대 레벨 도달"
  },
  ErrCode_ERR_ROLE_SKILL_UPGRADE_NOT_ITEM_Desc = {
    Text = "스킬 업그레이드에 필요한 아이템이 부족합니다"
  },
  ErrCode_ERR_ROLE_SKILL_UPGRADE_NOT_MONEY_Desc = {
    Text = "스킬 업그레이드에 필요한 재화가 부족합니다"
  },
  ErrCode_ERR_ROLE_SLOT_MAX_LEVEL_Desc = {
    Text = "최대 레벨에 도달했습니다"
  },
  ErrCode_ERR_ROLE_SLOT_UPGRADE_NOT_NUMBER_Desc = {
    Text = "수동 업그레이드 슬롯 횟수가 남아 있지 않습니다"
  },
  ErrCode_ERR_ROLE_STAGE_Desc = {
    Text = "이미 업그레이드하여, 재진급할 수 없습니다."
  },
  ErrCode_ERR_ROLE_UPLEVEL_NOT_ITEM_Desc = {
    Text = "깨어남체 업그레이드에 필요한 아이템이 부족합니다"
  },
  ErrCode_ERR_ROLE_UPLEVEL_NOT_MONEY_Desc = {
    Text = "깨어남체 업그레이드에 필요한 재화가 부족합니다"
  },
  ErrCode_ERR_SCHOOL_NOT_MATCH_Desc = {
    Text = "영역이 조건을 충족하지 않습니다"
  },
  ErrCode_ERR_SCHOOL_TOWN_AWAKER_REQUIREMENT_Desc = {
    Text = "영역탑 출전의 깨어남체가 영역 요구사항을 충족하지 않습니다"
  },
  ErrCode_ERR_SCHOOL_TOWN_BATCH_MATCH_Desc = {
    Text = "들어간 스테이지가 현재 시작 스테이지 목록에 없습니다"
  },
  ErrCode_ERR_SCHOOL_TOWN_SAME_AWAKER_Desc = {
    Text = "영역탑에서는 동일한 깨어남체를 출전할 수 없습니다"
  },
  ErrCode_ERR_SENIORMONEY_NOT_ENOUGH_Desc = {
    Text = "은심이 부족합니다"
  },
  ErrCode_ERR_SERVER_CLOSED_Desc = {
    Text = "캠퍼스를 열심히 가꾸고 있습니다, 점검이 끝날 때까지 기다려주세요."
  },
  ErrCode_ERR_SERVER_NOT_START_Desc = {
    Text = "서비스 미가동"
  },
  ErrCode_ERR_SHOP_BUY_Desc = {
    Text = "상품 구매 완료"
  },
  ErrCode_ERR_SHOP_CUSTOM_CMD_Desc = {
    Text = "현재 감지할 수 없습니다"
  },
  ErrCode_ERR_SHOP_GOODS_EXPIRE_Desc = {
    Text = "상품이 만료되어 교환이 불가능합니다"
  },
  ErrCode_ERR_SHOP_GOODS_NOT_ENGHOU_Desc = {
    Text = "판매 중인 상품의 재고가 없습니다"
  },
  ErrCode_ERR_SHOP_NOT_DATA_Desc = {
    Text = "상점 데이터 없음"
  },
  ErrCode_ERR_SHOP_NOT_Desc = {
    Text = "이 타입의 상점이 없습니다"
  },
  ErrCode_ERR_SHOP_NOT_GOODS_Desc = {
    Text = "해당 상품은 판매하지 않습니다"
  },
  ErrCode_ERR_SHOP_NOT_GOODS_SELL_Desc = {
    Text = "상점에서 해당 상품을 판매하지 않습니다"
  },
  ErrCode_ERR_SHOP_NOT_REFRESH_NUM_Desc = {
    Text = "갱신 횟수 없음"
  },
  ErrCode_ERR_SHOP_NOT_SELL_Desc = {
    Text = "상점에 해당 상품이 없습니다"
  },
  ErrCode_ERR_SHOP_REFRESH_Desc = {
    Text = "현재의 상점 노드와 달라 갱신할 수 없습니다"
  },
  ErrCode_ERR_SOCIAL_NO_ROLE_Desc = {
    Text = "해당 수호자가 존재하지 않습니다"
  },
  ErrCode_ERR_STAGE_GROUP_BAN_BY_TASK_Desc = {
    Text = "해당 원초적 시야의 모든 분신이 이미 킬되었습니다"
  },
  ErrCode_ERR_STAGE_GROUP_TYPE_BAN_BY_DAILY_WIN_COUNT_Desc = {
    Text = "레벨 종류 일일 도전 횟수가 한도에 도달했습니다"
  },
  ErrCode_ERR_SUMMON_CLICKTOOFAST_Desc = {
    Text = "터치가 너무 자주 이루어졌습니다, 잠시 후에 다시 시도해 주세요"
  },
  ErrCode_ERR_SUMMON_NOT_OPEN_Desc = {
    Text = "깨어남 기능 미개방"
  },
  ErrCode_ERR_TALENT_ACTIVE_CONDITION_Desc = {
    Text = "활성화 조건 부족"
  },
  ErrCode_ERR_TALENT_ACTIVE_Desc = {
    Text = "공명이 활성화되어, 재활성화할 필요가 없습니다."
  },
  ErrCode_ERR_TALENT_INIT_STATE_NOT_RESET_Desc = {
    Text = "공명 초기 상태에서는 초기화할 수 없습니다"
  },
  ErrCode_ERR_TALENT_ITEM_NOT_ENOUGH_Desc = {
    Text = "공명 재료가 부족합니다"
  },
  ErrCode_ERR_TALENT_MAX_LEVEL_Desc = {
    Text = "공명점이 최대 레벨에 도달하였습니다"
  },
  ErrCode_ERR_TALENT_NOT_COPIES_Desc = {
    Text = "던전에서 공명을 발견하지 못했습니다"
  },
  ErrCode_ERR_TALENT_NOT_FIND_Desc = {
    Text = "공명 데이터가 발견되지 않았습니다"
  },
  ErrCode_ERR_TALENT_NOT_FIND_LEVEL_Desc = {
    Text = "공명점 레벨 관련 데이터가 발견되지 않았습니다"
  },
  ErrCode_ERR_TALENT_NOT_RESET_NUM_Desc = {
    Text = "초기화 횟수가 존재하지 않습니다"
  },
  ErrCode_ERR_TALENT_UNLOCK_Desc = {
    Text = "깨어남체 생산 효과가 해제되어, 재해금할 필요가 없습니다"
  },
  ErrCode_ERR_TASKMODULE_PRIZE_NOT_GAIN_Desc = {
    Text = "보상 수령 완료"
  },
  ErrCode_ERR_TASK_APPOINT_TASK_FINISH_Desc = {
    Text = "위임된 미션이 완료되어 다시할 수 없습니다"
  },
  ErrCode_ERR_TASK_DELEGATE_NOT_COND_Desc = {
    Text = "위임 조건 부족"
  },
  ErrCode_ERR_TASK_FINISH_Desc = {
    Text = "미션이 완료되었습니다"
  },
  ErrCode_ERR_TASK_NOT_FIND_Desc = {
    Text = "미션을 찾을 수 없습니다"
  },
  ErrCode_ERR_TASK_NOT_GAINPRIZE_Desc = {
    Text = "미션을 완료하지 않아 보상을 수령할 수 없습니다"
  },
  ErrCode_ERR_TEAM_NAME_ILLEGLE_Desc = {
    Text = "파티 이름에는 중국어나 영어 문자 이외의 문자를 포함할 수 없습니다"
  },
  ErrCode_ERR_TEAM_NAME_TOO_LONG_Desc = {
    Text = "파티 이름 길이는 8자 미만으로 설정할 수 있습니다"
  },
  ErrCode_ERR_TEAM_NEED_4_AWAKER_Desc = {
    Text = "파티에서 깨어남체 수가 4명이 충족되어야 카드를 닫을 수 있습니다"
  },
  ErrCode_ERR_TEAM_NO_TEAM_Desc = {
    Text = "파티 구성을 찾을 수 없습니다"
  },
  ErrCode_ERR_TEAM_NO_WEAPON_SLOT_Desc = {
    Text = "파티 깨어남체에 명륜이 설정되지 않았습니다"
  },
  ErrCode_ERR_TEAM_SCHOOLMIX_Desc = {
    Text = "파티 내 깨어남체에 영역 충돌이 발생하여 조정이 필요합니다"
  },
  ErrCode_ERR_TEAM_WEAPON_NOT_EXISTS_Desc = {
    Text = "명륜이 존재하지 않습니다"
  },
  ErrCode_ERR_TICKET_NOT_ENOUGH_Desc = {
    Text = "인증 정보가 부족합니다"
  },
  ErrCode_ERR_TOKEN_Desc = {
    Text = "로그인 Token 오류"
  },
  ErrCode_ERR_TRIGGER_NOT_FIND_Desc = {
    Text = "현재 트리거 노드를 찾을 수 없습니다"
  },
  ErrCode_ERR_TRINKET_NOT_TRAINING_Desc = {
    Text = "장식품이 전사할 수 없어 속성을 대체할 수 없습니다"
  },
  ErrCode_ERR_UNATTEN_FIRST_Desc = {
    Text = "먼저 상대방의 팔로우를 취소한 후 블랙리스트에 추가할 수 있습니다"
  },
  ErrCode_ERR_UNIT_USED_ONCE_Desc = {
    Text = "깨어남체, 명륜 또는 계령은 금일 해당 게임 모드에서 이미 사용되었습니다"
  },
  ErrCode_ERR_UNLOCK_SUB_PLOT_AVAILABLE_Desc = {
    Text = "해제 실타래패: 서브 퀘스트 사용 가능"
  },
  ErrCode_ERR_UNLOCK_SUB_PLOT_NOT_OPEN_Desc = {
    Text = "서브 스토리 해제 실타래패: 서브 스토리 미개방"
  },
  ErrCode_ERR_UNLOCK_SUB_PLOT_NO_UNLOCKITEM_Desc = {
    Text = "해제 실타래패: 해제할 필요가 없는 아이템"
  },
  ErrCode_ERR_UNLOCK_SUB_PLOT_UNLOCKED_Desc = {
    Text = "해제 실타래패: 이미 해제됨"
  },
  ErrCode_ERR_VERSION_TOO_OLD_Desc = {
    Text = "버전 정보가 일치하지 않습니다, 최신 클라이언트로 업데이트해 주세요. 이미 업데이트가 끝난 경우 서버 점검 종료를 기다려주세요."
  },
  ErrCode_FAILED_Desc = {
    Text = "실타래패"
  },
  ErrCode_IS_CREATE_ROLE_Desc = {
    Text = "이미 있는 캐릭터는 다시 생성할 필요가 없습니다"
  },
  ErrCode_SUCCESS_Desc = {
    Text = "작업 성공"
  }
})
return Text_ErrCode
