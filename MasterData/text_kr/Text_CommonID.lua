__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_CommonID = readonly({
  CommonID_Account_Desc = {Text = "계정"},
  CommonID_AchieveCommemorativeData_Dmg_Desc = {
    Text = "최고 피해량"
  },
  CommonID_AchieveCommemorativeData_Poison_Desc = {
    Text = "최고 층수"
  },
  CommonID_AchieveCommemorativeData_Time_Desc = {
    Text = "완료 시간"
  },
  CommonID_AchieveType0_Desc = {
    Text = "모든 업적"
  },
  CommonID_AchieveType1_Desc = {
    Text = "성장 기록"
  },
  CommonID_AchieveType2_Desc = {
    Text = "조사 인장"
  },
  CommonID_AchieveType3_Desc = {
    Text = "전투 기록"
  },
  CommonID_AchieveType4_Desc = {
    Text = "수호자 생활"
  },
  CommonID_Add_State_Desc = {
    Text = "상태 추가"
  },
  CommonID_All_Desc = {Text = "전체"},
  CommonID_AnyAvgFirstTrigger_Desc = {
    Text = "미션 완료 조건: 임의의 스토리 노드에 도착하기"
  },
  CommonID_AnyEntryInGroupUnlock_Desc = {
    Text = "미션 완료 조건: 그룹 내 임의의 도감 항목을 해제하기"
  },
  CommonID_AnyEventFirstTrigger_Desc = {
    Text = "미션 완료 조건: 임의의 사건을 발동하기"
  },
  CommonID_AnyItemFirstGet_Desc = {
    Text = "미션 완료 조건: 임의의 아이템 획득하기"
  },
  CommonID_AnyNodeTypeFirstTrigger_Desc = {
    Text = "미션 완료 조건: 임의의 노드를 발동한 경우"
  },
  CommonID_AnyRelicFirstGet_Desc = {
    Text = "미션 완료 조건: 임의의 유물을 획득하기"
  },
  CommonID_AnyStageFirstClear_Desc = {
    Text = "미션 완료 조건: 목록에 있는 임의의 스테이지를 최초로 완료하기"
  },
  CommonID_AppointTaskRewardAdd_Desc = {
    Text = "파견 보상 증가"
  },
  CommonID_Attr_Promote_Desc = {
    Text = "속성 향상"
  },
  CommonID_AwakerDied_Desc = {
    Text = "깨어남체 사망"
  },
  CommonID_AwakerMonster_Desc = {
    Text = "깨어남체 보스"
  },
  CommonID_BN_Desc = {
    Text = "벵골어 (alpha)"
  },
  CommonID_BanBattlePos_Desc = {
    Text = "출전 불가"
  },
  CommonID_Battle_Desc = {Text = "전투"},
  CommonID_Blue_Desc = {Text = "청색"},
  CommonID_Boss_Desc = {Text = "보스"},
  CommonID_BundleShortcutKey_Desc = {
    Text = "키 바인딩"
  },
  CommonID_CN_Desc = {
    Text = "중국어 간체"
  },
  CommonID_CardBorder_Desc = {
    Text = "카드 외관"
  },
  CommonID_CardSlots_LevelUp_Desc = {
    Text = "슬롯 업그레이드"
  },
  CommonID_Card_AdvancedImagery_Desc = {
    Text = "고급 이미지"
  },
  CommonID_Card_AttachPost_Desc = {Text = "추격"},
  CommonID_Card_Awake_Desc = {
    Text = "영지 깨어남"
  },
  CommonID_Card_Curse_Desc = {
    Text = "증상 카드"
  },
  CommonID_Card_Defend_Desc = {
    Text = "방어 카드"
  },
  CommonID_Card_Developing_Desc = {Text = "개발 중"},
  CommonID_Card_Extend_Desc = {
    Text = "파생 카드"
  },
  CommonID_Card_Fraud_Desc = {Text = "사기"},
  CommonID_Card_Imagery_Desc = {Text = "이미지"},
  CommonID_Card_KeeperSkill_Desc = {
    Text = "은열쇠 카드"
  },
  CommonID_Card_Potion_Desc = {
    Text = "물약 카드"
  },
  CommonID_Card_Skill_Desc = {
    Text = "스킬 카드"
  },
  CommonID_Card_State_Desc = {
    Text = "상태 카드"
  },
  CommonID_Card_Strike_Desc = {
    Text = "타격 카드"
  },
  CommonID_Card_Weapon_Desc = {
    Text = "명륜 카드"
  },
  CommonID_CastSkillLevel_Desc = {
    Text = "스킬 레벨"
  },
  CommonID_Challenge_Desc = {Text = "조사"},
  CommonID_Change_Skill_Desc = {
    Text = "스킬 교체"
  },
  CommonID_Chinese_Desc = {Text = "한자"},
  CommonID_ChooseHandCard_Desc = {
    Text = "카드 선택"
  },
  CommonID_ClickToQuit_Desc = {
    Text = "터치하여 종료"
  },
  CommonID_ClickToView_Desc = {
    Text = "터치하여 확인"
  },
  CommonID_Click_Desc = {
    Text = "터치하여 이동"
  },
  CommonID_Close_Desc = {Text = "닫기"},
  CommonID_ComingSoon_Desc = {
    Text = "기대해 주세요"
  },
  CommonID_CommonAttr_Desc = {
    Text = "일반 속성 계수"
  },
  CommonID_Common_Desc = {Text = "보통"},
  CommonID_ContinuousSound_Desc = {
    Text = "계속 재생"
  },
  CommonID_CopperAchieve_Desc = {Text = "동"},
  CommonID_CountingStart_Desc = {
    Text = "아군 턴의 카운트다운이 시작됩니다"
  },
  CommonID_Custom_Desc = {Text = "커스텀"},
  CommonID_DE_Desc = {
    Text = "독일어 (alpha)"
  },
  CommonID_DPS_Desc = {Text = "공격형"},
  CommonID_DepressionHit_Desc = {
    Text = "우울 피격"
  },
  CommonID_DisableKeeperSkill_Desc = {
    Text = "주인공 스킬 사용 불가"
  },
  CommonID_DisableTrinketSuitEffect_Desc = {
    Text = "비밀 계약 사용 불가"
  },
  CommonID_DisableWeapon_Desc = {
    Text = "명륜 사용 불가"
  },
  CommonID_Display_Desc = {Text = "화면"},
  CommonID_DropdownList_Desc = {
    Text = "드롭다운 목록"
  },
  CommonID_EN_Desc = {Text = "영어"},
  CommonID_ES_Desc = {
    Text = "스페인어 (alpha)"
  },
  CommonID_Elite_Desc = {Text = "엘리트"},
  CommonID_EmojiType_10_Desc = {
    Text = "미니 미사그"
  },
  CommonID_EmojiType_11_Desc = {
    Text = "역전의 턴"
  },
  CommonID_EmojiType_12_Desc = {
    Text = "미사그 일상"
  },
  CommonID_EmojiType_13_Desc = {
    Text = "즐거운 미사그"
  },
  CommonID_EmojiType_14_Desc = {
    Text = "화난 미사그"
  },
  CommonID_EmojiType_15_Desc = {
    Text = "캠퍼스 생활"
  },
  CommonID_EmojiType_16_Desc = {
    Text = "평화로운 하루"
  },
  CommonID_EmojiType_17_Desc = {
    Text = "방과후 활동"
  },
  CommonID_EmojiType_18_Desc = {
    Text = "사랑을 담아"
  },
  CommonID_EmojiType_19_Desc = {
    Text = "미사그의 휴일"
  },
  CommonID_EmojiType_1_Desc = {
    Text = "부드러운 미사그"
  },
  CommonID_EmojiType_20_Desc = {
    Text = "미사그 겨울나기"
  },
  CommonID_EmojiType_21_Desc = {
    Text = "진저브레드 파티"
  },
  CommonID_EmojiType_22_Desc = {
    Text = "캠퍼스 에피소드"
  },
  CommonID_EmojiType_23_Desc = {
    Text = "미사그 조사원"
  },
  CommonID_EmojiType_24_Desc = {
    Text = "미사그 막간극"
  },
  CommonID_EmojiType_25_Desc = {
    Text = "사야의 노래"
  },
  CommonID_EmojiType_2_Desc = {
    Text = "둥글둥글멘스"
  },
  CommonID_EmojiType_3_Desc = {
    Text = "삼라만상"
  },
  CommonID_EmojiType_4_Desc = {Text = "모Q멘스"},
  CommonID_EmojiType_5_Desc = {
    Text = "페이즈 통신"
  },
  CommonID_EmojiType_6_Desc = {
    Text = "빛나는 미사그"
  },
  CommonID_EmojiType_7_Desc = {
    Text = "미친 미사그"
  },
  CommonID_EmojiType_8_Desc = {
    Text = "쉬운 미사그"
  },
  CommonID_EmojiType_9_Desc = {
    Text = "지혜의 미사그"
  },
  CommonID_Enchant_Desc = {Text = "각인"},
  CommonID_Entrance_Desc = {
    Text = "팝업 열기"
  },
  CommonID_FALSE_Desc = {Text = "아니요"},
  CommonID_FR_Desc = {
    Text = "프랑스어 (alpha)"
  },
  CommonID_Forged_Desc = {Text = "강화"},
  CommonID_FreeBattlePos_Desc = {
    Text = "자유 출전"
  },
  CommonID_FullScreen_Desc = {
    Text = "전체 화면"
  },
  CommonID_Gender_Boy_Desc = {Text = "남"},
  CommonID_Gender_Girl_Desc = {Text = "여"},
  CommonID_GetLikeLevel_Desc = {Text = "함수"},
  CommonID_GmaeVoice_Desc = {
    Text = "게임 음향"
  },
  CommonID_GoldAchieve_Desc = {Text = "금"},
  CommonID_Hall_Desc = {Text = "로비"},
  CommonID_HarvestAdd_Desc = {
    Text = "홈 보상 증가"
  },
  CommonID_HaveAwaker_Desc = {
    Text = "미션 완료 조건: 목록에 있는 임의의 깨어남체 보유하기"
  },
  CommonID_HeadType_1_Desc = {
    Text = "은열쇠의 이름으로"
  },
  CommonID_HeadType_2_Desc = {
    Text = "멍한 프로필 사진"
  },
  CommonID_HeadType_3_Desc = {
    Text = "영원히 사라지지 않을 지난날"
  },
  CommonID_HeadType_4_Desc = {
    Text = "우표 컬렉션"
  },
  CommonID_High_Desc = {Text = "높음"},
  CommonID_Holy_Desc = {Text = "신성화"},
  CommonID_ID_Desc = {
    Text = "인도네시아어 (alpha)"
  },
  CommonID_IT_Desc = {
    Text = "이탈리아어 (alpha)"
  },
  CommonID_Image_Desc = {Text = "이미지"},
  CommonID_Intent_AttackBuff_Desc = {
    Text = "적 의도: 공격과 강화"
  },
  CommonID_Intent_AttackDebuffD09Skill2_Desc = {
    Text = "적 의도: 공격과 약화"
  },
  CommonID_Intent_AttackDebuff_Desc = {
    Text = "적 의도: 공격과 약화"
  },
  CommonID_Intent_AttackDefence_Desc = {
    Text = "적 의도: 공격과 방어"
  },
  CommonID_Intent_Attack_Desc = {
    Text = "적 의도: 공격"
  },
  CommonID_Intent_Buff_Desc = {
    Text = "적 의도: 강화"
  },
  CommonID_Intent_Burst2_Desc = {
    Text = "적 의도: 광기(비공격)"
  },
  CommonID_Intent_Burst3_Desc = {
    Text = "적 의도: 초월 광기"
  },
  CommonID_Intent_Burst4_Desc = {
    Text = "적 의도: 최종"
  },
  CommonID_Intent_Burst_Desc = {
    Text = "적 의도: 광기"
  },
  CommonID_Intent_DCB022Buff_Desc = {
    Text = "적 의도: 강화"
  },
  CommonID_Intent_DCB024Buff_Desc = {
    Text = "적 의도: 강화"
  },
  CommonID_Intent_Debuff_Desc = {
    Text = "적 의도: 약화"
  },
  CommonID_Intent_DefenceBuff_Desc = {
    Text = "적 의도: 방어와 강화"
  },
  CommonID_Intent_DefenceDebuff_Desc = {
    Text = "적 의도: 방어와 약화"
  },
  CommonID_Intent_Defence_Desc = {
    Text = "적 의도: 방어"
  },
  CommonID_Intent_Dizzy_Desc = {
    Text = "적 의도: 기절"
  },
  CommonID_Intent_HeavyAttackDCB02_Desc = {
    Text = "적 의도: 강력한 공격"
  },
  CommonID_Intent_HeavyAttack_Desc = {
    Text = "적 의도: 강력한 공격"
  },
  CommonID_Intent_StrongBuff_Desc = {
    Text = "적 의도: 강력한 강화"
  },
  CommonID_Intent_StrongDebuff_Desc = {
    Text = "적 의도: 강력한 약화"
  },
  CommonID_Intent_Unknown1_Desc = {
    Text = "적 의도: 불명"
  },
  CommonID_Intent_Unknown2_Desc = {
    Text = "적 의도: 불명"
  },
  CommonID_Intent_Unknown3_Desc = {
    Text = "적 의도: 불명"
  },
  CommonID_Intent_Unknown4_Desc = {
    Text = "적 의도: 불명"
  },
  CommonID_Intent_Unknown5_Desc = {
    Text = "적 의도: 불명"
  },
  CommonID_Intent_Unknown6_Desc = {
    Text = "적 의도: 불명"
  },
  CommonID_Intent_Unknown_Desc = {
    Text = "적 의도: 불명"
  },
  CommonID_ItemManagement_Desc = {Text = "아이템"},
  CommonID_JP_Desc = {
    Text = "일본어 (alpha)"
  },
  CommonID_KR_Desc = {
    Text = "한국어 (alpha)"
  },
  CommonID_Keeper_Skill_Desc = {
    Text = "수호자 스킬"
  },
  CommonID_KeyType_1_Desc = {Text = "망각편"},
  CommonID_KeyType_2_Desc = {
    Text = "혼돈 영역"
  },
  CommonID_KeyType_3_Desc = {
    Text = "심해 영역"
  },
  CommonID_KeyType_4_Desc = {
    Text = "혈육 영역"
  },
  CommonID_KeyType_5_Desc = {
    Text = "초차원 영역"
  },
  CommonID_Key_Desc = {Text = "조작"},
  CommonID_Language_Desc = {Text = "언어"},
  CommonID_LevelLimit_Promote_Desc = {
    Text = "레벨 한도 증가"
  },
  CommonID_Low_Desc = {Text = "낮음"},
  CommonID_Management_Desc = {
    Text = "관리로 이동"
  },
  CommonID_ManiaHit_Desc = {
    Text = "광란 타격"
  },
  CommonID_MasterVolume_Desc = {
    Text = "전체 제어"
  },
  CommonID_MaterialsReturn_Desc = {
    Text = "소모 재화 반환"
  },
  CommonID_MessagePush_Desc = {
    Text = "메시지 알림"
  },
  CommonID_Middle_Desc = {Text = "중간"},
  CommonID_Modify_Desc = {
    Text = "터치하여 수정"
  },
  CommonID_MonsterGrade1_Desc = {
    Text = "1단계 적"
  },
  CommonID_MonsterGrade2_Desc = {
    Text = "2단계 적"
  },
  CommonID_MotherTreeMonster_Desc = {
    Text = "풍요의 지모수"
  },
  CommonID_MultiplierXP_Desc = {
    Text = "경험치 획득량 증가"
  },
  CommonID_Mute_Desc = {Text = "무음"},
  CommonID_NotAwakerMonster_Desc = {
    Text = "비깨어남체 보스"
  },
  CommonID_Open_Desc = {Text = "열기"},
  CommonID_OperationImpossible_Desc = {
    Text = "플레이어가 다양한 원인(행동력 부족, 자신의 턴이 아님, 봉인 또는 석화 등)으로 인해, 조작에 실타래패했습니다(카드 사용, 광기 폭발)."
  },
  CommonID_OperationStop_Desc = {
    Text = "아군의 턴 동안 고민한 시간이 최대치에 도달했습니다(상수표 참조)"
  },
  CommonID_Orange_Desc = {Text = "황금"},
  CommonID_PT_Desc = {
    Text = "포르투갈어 (alpha)"
  },
  CommonID_PVP_Desc = {
    Text = "페이즈 체스"
  },
  CommonID_PassiveSkill_Desc = {
    Text = "패시브 스킬"
  },
  CommonID_PersonalProfile_Desc = {
    Text = "개인 프로필"
  },
  CommonID_PlayerEnter_Desc = {
    Text = "게임이 시작되고, 플레이어가 카드를 선택한 후"
  },
  CommonID_PlayerFiles_Desc = {
    Text = "수호자 기록"
  },
  CommonID_Potency_Desc = {Text = "계령"},
  CommonID_Privacy_Desc = {
    Text = "프라이버시"
  },
  CommonID_Purple_Desc = {Text = "시계추"},
  CommonID_RU_Desc = {
    Text = "러시아어 (alpha)"
  },
  CommonID_RedGlow_Desc = {
    Text = "붉은 빛 효과"
  },
  CommonID_Red_Desc = {Text = "저주"},
  CommonID_Redeem_Desc = {
    Text = "교환코드 입력"
  },
  CommonID_ReletedAwakerInEnemies_Desc = {
    Text = "상대 진영의 깨어남체와 아군 진영의 깨어남체 간의 상호작용 대화"
  },
  CommonID_Relic_Desc = {Text = "유물"},
  CommonID_Repair_Desc = {
    Text = "수리로 이동"
  },
  CommonID_ResNeedReduce_Desc = {
    Text = "필요 자원 감소"
  },
  CommonID_SUP_Desc = {Text = "보조형"},
  CommonID_SellCard_Desc = {
    Text = "카드 판매"
  },
  CommonID_ShortcutKey_Desc = {Text = "단축키"},
  CommonID_SilverAchieve_Desc = {Text = "은"},
  CommonID_Sin_Desc = {Text = "죄악"},
  CommonID_SkillReady_Desc = {
    Text = "광기 게이지가 가득 차 터치하여 광기 폭발을 발동할 수 있는 순간"
  },
  CommonID_Skill_LevelUp_Desc = {
    Text = "스킬 업그레이드"
  },
  CommonID_Slider_Desc = {
    Text = "값 슬라이더"
  },
  CommonID_SlotCardLevel_Desc = {
    Text = "기본 슬롯 개수"
  },
  CommonID_SoundBalance_Desc = {
    Text = "음향 균형"
  },
  CommonID_SpecificCommunicateTrig_Desc = {
    Text = "미션 완료 조건: 지정된 통신기 대화를 발생시키기"
  },
  CommonID_StageDropAdd_Desc = {
    Text = "비경 보상 증가"
  },
  CommonID_Switch_Desc = {Text = "교체"},
  CommonID_System_Desc = {Text = "시스템"},
  CommonID_TH_Desc = {
    Text = "태국어 (alpha)"
  },
  CommonID_TRUE_Desc = {Text = "네"},
  CommonID_TR_Desc = {
    Text = "튀르키예어 (alpha)"
  },
  CommonID_TW_Desc = {
    Text = "중국어 번체"
  },
  CommonID_T_Desc = {Text = "방어형"},
  CommonID_TaskCount_Desc = {Text = "스택"},
  CommonID_TaskInProgress_Desc = {Text = "진행 중"},
  CommonID_TaweiMonster_Desc = {
    Text = "어둠의 타비"
  },
  CommonID_Through1_Desc = {
    Text = "패시브 스킬 1"
  },
  CommonID_Through2_Desc = {
    Text = "패시브 스킬 2"
  },
  CommonID_Tips_Desc = {Text = "힌트"},
  CommonID_TranslationLabel_Desc = {
    Text = "공식 번역 표시"
  },
  CommonID_Ulti_Skill_Desc = {
    Text = "광기 폭발"
  },
  CommonID_UtlSkill_Promote_Desc = {
    Text = "초월 폭발"
  },
  CommonID_VN_Desc = {
    Text = "베트남어 (alpha)"
  },
  CommonID_VeryHigh_Desc = {
    Text = "매우 높음"
  },
  CommonID_VeryLow_Desc = {
    Text = "매우 낮음"
  },
  CommonID_View_Desc = {
    Text = "확인하러 가기"
  },
  CommonID_Voice_Desc = {Text = "소리"},
  CommonID_Web_Desc = {
    Text = "웹페이지 이동"
  },
  CommonID_White_Desc = {Text = "백은"},
  CommonID_WindowNotFocusVoice_Desc = {
    Text = "창 비활성화 시 사운드"
  },
  CommonID_Window_Desc = {Text = "창"},
  CommonID_YellowGlow_Desc = {
    Text = "노란 빛 효과"
  }
})
return Text_CommonID
