__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_CommonID = readonly({
  CommonID_Account_Desc = {
    Text = "アカウント"
  },
  CommonID_AchieveCommemorativeData_Dmg_Desc = {
    Text = "最大ダメージ"
  },
  CommonID_AchieveCommemorativeData_Poison_Desc = {
    Text = "最高階数"
  },
  CommonID_AchieveCommemorativeData_Time_Desc = {
    Text = "完了時間"
  },
  CommonID_AchieveType0_Desc = {
    Text = "すべて達成"
  },
  CommonID_AchieveType1_Desc = {
    Text = "成長物語"
  },
  CommonID_AchieveType2_Desc = {Text = "調査印"},
  CommonID_AchieveType3_Desc = {
    Text = "作戦記録"
  },
  CommonID_AchieveType4_Desc = {
    Text = "秘密の生涯"
  },
  CommonID_Add_State_Desc = {
    Text = "状態追加"
  },
  CommonID_All_Desc = {Text = "すべて"},
  CommonID_AnyAvgFirstTrigger_Desc = {
    Text = "任務完了条件：任意のストーリーイベントを発生させる"
  },
  CommonID_AnyEntryInGroupUnlock_Desc = {
    Text = "任務完了条件：グループ内の任意の図鑑項目を解放"
  },
  CommonID_AnyEventFirstTrigger_Desc = {
    Text = "任務完了条件：任意の事件を発生させる"
  },
  CommonID_AnyItemFirstGet_Desc = {
    Text = "任務完了条件：任意のアイテムを獲得"
  },
  CommonID_AnyNodeTypeFirstTrigger_Desc = {
    Text = "任務完了条件：任意のイベント分岐を発生させる"
  },
  CommonID_AnyRelicFirstGet_Desc = {
    Text = "任務完了条件：任意の低級遺物を獲得"
  },
  CommonID_AnyStageFirstClear_Desc = {
    Text = "任務完了条件：リスト中の任意のステージを初クリア"
  },
  CommonID_AppointTaskRewardAdd_Desc = {
    Text = "派遣報酬増加"
  },
  CommonID_Attr_Promote_Desc = {
    Text = "能力向上"
  },
  CommonID_AwakerDied_Desc = {
    Text = "覚醒体が死亡"
  },
  CommonID_AwakerMonster_Desc = {
    Text = "覚醒体ボス"
  },
  CommonID_BN_Desc = {
    Text = "ベンガル語（alpha）"
  },
  CommonID_BanBattlePos_Desc = {
    Text = "出撃不可"
  },
  CommonID_Battle_Desc = {Text = "戦闘"},
  CommonID_Blue_Desc = {Text = "青藍"},
  CommonID_Boss_Desc = {Text = "ボス"},
  CommonID_BundleShortcutKey_Desc = {
    Text = "キー設定"
  },
  CommonID_CN_Desc = {
    Text = "簡体字中国語"
  },
  CommonID_CardBorder_Desc = {
    Text = "カードの外観"
  },
  CommonID_CardSlots_LevelUp_Desc = {
    Text = "スロット強化"
  },
  CommonID_Card_AdvancedImagery_Desc = {
    Text = "詳細なイメージ"
  },
  CommonID_Card_AttachPost_Desc = {Text = "追撃"},
  CommonID_Card_Awake_Desc = {
    Text = "霊知覚醒"
  },
  CommonID_Card_Curse_Desc = {
    Text = "症状カード"
  },
  CommonID_Card_Defend_Desc = {
    Text = "防御カード"
  },
  CommonID_Card_Developing_Desc = {Text = "開発中"},
  CommonID_Card_Extend_Desc = {
    Text = "派生カード"
  },
  CommonID_Card_Fraud_Desc = {Text = "詐欺"},
  CommonID_Card_Imagery_Desc = {
    Text = "イメージ"
  },
  CommonID_Card_KeeperSkill_Desc = {
    Text = "キーオーダーカード"
  },
  CommonID_Card_Potion_Desc = {
    Text = "ポーションカード"
  },
  CommonID_Card_Skill_Desc = {
    Text = "スキルカード"
  },
  CommonID_Card_State_Desc = {
    Text = "状態カード"
  },
  CommonID_Card_Strike_Desc = {
    Text = "攻撃カード"
  },
  CommonID_Card_Weapon_Desc = {
    Text = "命輪カード"
  },
  CommonID_CastSkillLevel_Desc = {
    Text = "スキルレベル"
  },
  CommonID_Challenge_Desc = {Text = "調査"},
  CommonID_Change_Skill_Desc = {
    Text = "スキル交換"
  },
  CommonID_Chinese_Desc = {Text = "中国語"},
  CommonID_ChooseHandCard_Desc = {
    Text = "手札を選択"
  },
  CommonID_ClickToQuit_Desc = {
    Text = "タップで終了"
  },
  CommonID_ClickToView_Desc = {Text = "確認"},
  CommonID_Click_Desc = {Text = "移動"},
  CommonID_Close_Desc = {Text = "オフ"},
  CommonID_ComingSoon_Desc = {
    Text = "乞うご期待"
  },
  CommonID_CommonAttr_Desc = {
    Text = "共通能力ボーナス"
  },
  CommonID_Common_Desc = {Text = "通常"},
  CommonID_ContinuousSound_Desc = {
    Text = "連続再生"
  },
  CommonID_CopperAchieve_Desc = {Text = "銅"},
  CommonID_CountingStart_Desc = {
    Text = "自分のターン中にカウントダウンが開始"
  },
  CommonID_Custom_Desc = {
    Text = "カスタム"
  },
  CommonID_DE_Desc = {
    Text = "ドイツ語(alpha)"
  },
  CommonID_DPS_Desc = {Text = "攻撃型"},
  CommonID_DepressionHit_Desc = {
    Text = "被ダメージ時抑鬱"
  },
  CommonID_DisableKeeperSkill_Desc = {
    Text = "主人公スキルを無効化"
  },
  CommonID_DisableTrinketSuitEffect_Desc = {
    Text = "密契を無効化"
  },
  CommonID_DisableWeapon_Desc = {
    Text = "命輪を無効化"
  },
  CommonID_DropdownList_Desc = {
    Text = "ドロップダウンリスト"
  },
  CommonID_EN_Desc = {
    Text = "英語(beta)"
  },
  CommonID_ES_Desc = {
    Text = "スペイン語(alpha)"
  },
  CommonID_Elite_Desc = {Text = "精鋭"},
  CommonID_EmojiType_10_Desc = {
    Text = "ちびちびミサゴ"
  },
  CommonID_EmojiType_11_Desc = {
    Text = "逆転回合"
  },
  CommonID_EmojiType_12_Desc = {
    Text = "いつものミサゴ"
  },
  CommonID_EmojiType_13_Desc = {
    Text = "たのしいミサゴ"
  },
  CommonID_EmojiType_14_Desc = {
    Text = "不機嫌ミサゴ"
  },
  CommonID_EmojiType_15_Desc = {
    Text = "学園生活編"
  },
  CommonID_EmojiType_16_Desc = {
    Text = "平和な一日"
  },
  CommonID_EmojiType_17_Desc = {
    Text = "放課後編"
  },
  CommonID_EmojiType_18_Desc = {
    Text = "ラブミサゴ"
  },
  CommonID_EmojiType_19_Desc = {
    Text = "ミサゴの休日"
  },
  CommonID_EmojiType_1_Desc = {
    Text = "やわらかミサゴ"
  },
  CommonID_EmojiType_20_Desc = {
    Text = "冬のミサゴ"
  },
  CommonID_EmojiType_21_Desc = {
    Text = "冬の祝宴"
  },
  CommonID_EmojiType_22_Desc = {
    Text = "キャンパスこぼれ話"
  },
  CommonID_EmojiType_23_Desc = {
    Text = "ミサゴ調査員"
  },
  CommonID_EmojiType_24_Desc = {
    Text = "ミサゴ幕間劇"
  },
  CommonID_EmojiType_25_Desc = {
    Text = "沙耶の唄"
  },
  CommonID_EmojiType_2_Desc = {
    Text = "前夜の集い"
  },
  CommonID_EmojiType_3_Desc = {
    Text = "日常百景"
  },
  CommonID_EmojiType_5_Desc = {
    Text = "通信中ミサゴ"
  },
  CommonID_EmojiType_6_Desc = {
    Text = "きらきらミサゴ"
  },
  CommonID_EmojiType_7_Desc = {
    Text = "発狂ミサゴ"
  },
  CommonID_EmojiType_8_Desc = {
    Text = "のんびりミサゴ"
  },
  CommonID_EmojiType_9_Desc = {
    Text = "かしこいミサゴ"
  },
  CommonID_Entrance_Desc = {
    Text = "ポップアップ入口"
  },
  CommonID_FALSE_Desc = {Text = "いいえ"},
  CommonID_FR_Desc = {
    Text = "フランス語(alpha)"
  },
  CommonID_Forged_Desc = {Text = "強化"},
  CommonID_FreeBattlePos_Desc = {
    Text = "自由編成で出撃"
  },
  CommonID_FullScreen_Desc = {Text = "全画面"},
  CommonID_Gender_Boy_Desc = {Text = "男性"},
  CommonID_Gender_Girl_Desc = {Text = "女性"},
  CommonID_GetLikeLevel_Desc = {Text = "関数"},
  CommonID_GmaeVoice_Desc = {
    Text = "ゲーム音"
  },
  CommonID_Hall_Desc = {Text = "ロビー"},
  CommonID_HarvestAdd_Desc = {
    Text = "拠点報酬増加"
  },
  CommonID_HaveAwaker_Desc = {
    Text = "任務完了条件：リスト中のいずれかの覚醒体を所有"
  },
  CommonID_HeadType_1_Desc = {
    Text = "銀の鍵の名のもとに"
  },
  CommonID_HeadType_2_Desc = {
    Text = "ゆるゆる肖像"
  },
  CommonID_HeadType_3_Desc = {
    Text = "色褪せぬ昨日"
  },
  CommonID_HeadType_4_Desc = {
    Text = "記念切手"
  },
  CommonID_Holy_Desc = {Text = "聖化"},
  CommonID_ID_Desc = {
    Text = "インドネシア語(alpha)"
  },
  CommonID_IT_Desc = {
    Text = "イタリア語（alpha）"
  },
  CommonID_Image_Desc = {Text = "画像"},
  CommonID_Intent_AttackBuff_Desc = {
    Text = "敵行動予測: 攻撃と強化"
  },
  CommonID_Intent_AttackDebuffD09Skill2_Desc = {
    Text = "敵行動予測: 攻撃と弱体化"
  },
  CommonID_Intent_AttackDebuff_Desc = {
    Text = "敵行動予測: 攻撃と弱体化"
  },
  CommonID_Intent_AttackDefence_Desc = {
    Text = "敵行動予測: 攻撃と防御"
  },
  CommonID_Intent_Attack_Desc = {
    Text = "敵行動予測: 攻撃"
  },
  CommonID_Intent_Buff_Desc = {
    Text = "敵行動予測: 強化"
  },
  CommonID_Intent_Burst2_Desc = {
    Text = "敵行動予測: 狂気（攻撃なし）"
  },
  CommonID_Intent_Burst3_Desc = {
    Text = "敵行動予測: 超狂気"
  },
  CommonID_Intent_Burst4_Desc = {
    Text = "敵行動予測: 終結の解放"
  },
  CommonID_Intent_Burst_Desc = {
    Text = "敵行動予測: 狂気"
  },
  CommonID_Intent_DCB022Buff_Desc = {
    Text = "敵行動予測: 強化"
  },
  CommonID_Intent_DCB024Buff_Desc = {
    Text = "敵行動予測: 強化"
  },
  CommonID_Intent_Debuff_Desc = {
    Text = "敵行動予測: 弱体化"
  },
  CommonID_Intent_DefenceBuff_Desc = {
    Text = "敵行動予測: 防御と強化"
  },
  CommonID_Intent_DefenceDebuff_Desc = {
    Text = "敵行動予測: 防御と弱体化"
  },
  CommonID_Intent_Defence_Desc = {
    Text = "敵行動予測: 防御"
  },
  CommonID_Intent_Dizzy_Desc = {
    Text = "敵行動予測: 眩暈"
  },
  CommonID_Intent_HeavyAttackDCB02_Desc = {
    Text = "敵行動予測: 再攻撃"
  },
  CommonID_Intent_HeavyAttack_Desc = {
    Text = "敵行動予測: 強攻撃"
  },
  CommonID_Intent_StrongBuff_Desc = {
    Text = "敵行動予測: 強力な強化"
  },
  CommonID_Intent_StrongDebuff_Desc = {
    Text = "敵行動予測: 強力な弱体化"
  },
  CommonID_Intent_Unknown1_Desc = {
    Text = "敵行動予測: 不明"
  },
  CommonID_Intent_Unknown2_Desc = {
    Text = "敵行動予測: 不明"
  },
  CommonID_Intent_Unknown3_Desc = {
    Text = "敵行動予測: 不明"
  },
  CommonID_Intent_Unknown4_Desc = {
    Text = "敵行動予測: 不明"
  },
  CommonID_Intent_Unknown5_Desc = {
    Text = "敵行動予測: 不明"
  },
  CommonID_Intent_Unknown6_Desc = {
    Text = "敵行動予測: 不明"
  },
  CommonID_Intent_Unknown_Desc = {
    Text = "敵行動予測: 不明"
  },
  CommonID_ItemManagement_Desc = {
    Text = "アイテム"
  },
  CommonID_JP_Desc = {
    Text = "日本語(alpha)"
  },
  CommonID_KR_Desc = {
    Text = "韓国語(alpha)"
  },
  CommonID_Keeper_Skill_Desc = {
    Text = "主人公スキル"
  },
  CommonID_KeyType_5_Desc = {
    Text = "超次元界域"
  },
  CommonID_Key_Desc = {
    Text = "入力キー"
  },
  CommonID_Language_Desc = {Text = "言語"},
  CommonID_LevelLimit_Promote_Desc = {
    Text = "レベル上限アップ"
  },
  CommonID_Management_Desc = {Text = "管理"},
  CommonID_ManiaHit_Desc = {
    Text = "被ダメージ時狂躁"
  },
  CommonID_MasterVolume_Desc = {
    Text = "全体調整"
  },
  CommonID_MaterialsReturn_Desc = {
    Text = "消費資源返還"
  },
  CommonID_MessagePush_Desc = {
    Text = "メッセージ通知"
  },
  CommonID_Modify_Desc = {
    Text = "クリックして変更"
  },
  CommonID_MonsterGrade1_Desc = {
    Text = "下級の敵"
  },
  CommonID_MonsterGrade2_Desc = {
    Text = "中級の敵"
  },
  CommonID_MotherTreeMonster_Desc = {
    Text = "豊穣母樹"
  },
  CommonID_MultiplierXP_Desc = {
    Text = "経験値倍増"
  },
  CommonID_Mute_Desc = {
    Text = "ミュート"
  },
  CommonID_NotAwakerMonster_Desc = {
    Text = "非覚醒体ボス"
  },
  CommonID_Open_Desc = {Text = "オン"},
  CommonID_OperationImpossible_Desc = {
    Text = "プレイヤーがさまざまな理由（行動力不足、自分のターンでない、封印や石化など）により、操作（カード使用、狂気解放）に失敗した場合"
  },
  CommonID_OperationStop_Desc = {
    Text = "自分のターンでの思考時間累計が最大値に達した場合"
  },
  CommonID_PT_Desc = {
    Text = "ポルトガル語(alpha)"
  },
  CommonID_PVP_Desc = {Text = "対人戦"},
  CommonID_PassiveSkill_Desc = {
    Text = "パッシブスキル"
  },
  CommonID_PersonalProfile_Desc = {
    Text = "プロフィール"
  },
  CommonID_PlayerEnter_Desc = {
    Text = "ゲーム開始時、カード選択完了後"
  },
  CommonID_PlayerFiles_Desc = {
    Text = "守秘者ファイル"
  },
  CommonID_Potency_Desc = {
    Text = "霊知啓発"
  },
  CommonID_Privacy_Desc = {
    Text = "プライバシー"
  },
  CommonID_Purple_Desc = {
    Text = "時の振り子"
  },
  CommonID_RU_Desc = {
    Text = "ロシア語(alpha)"
  },
  CommonID_RedGlow_Desc = {
    Text = "赤色エフェクト"
  },
  CommonID_Red_Desc = {Text = "呪い"},
  CommonID_Redeem_Desc = {Text = "交換"},
  CommonID_ReletedAwakerInEnemies_Desc = {
    Text = "敵陣営と自陣営の覚醒体の間で、関係性のある会話が発生"
  },
  CommonID_Relic_Desc = {
    Text = "低級遺物"
  },
  CommonID_Repair_Desc = {Text = "修復"},
  CommonID_ResNeedReduce_Desc = {
    Text = "必要資源が減少"
  },
  CommonID_SUP_Desc = {Text = "支援型"},
  CommonID_SellCard_Desc = {
    Text = "カード売却"
  },
  CommonID_ShortcutKey_Desc = {
    Text = "ショートカットキー"
  },
  CommonID_SilverAchieve_Desc = {Text = "銀"},
  CommonID_SkillReady_Desc = {
    Text = "狂気解放が使用可能になった瞬間"
  },
  CommonID_Skill_LevelUp_Desc = {
    Text = "スキル強化"
  },
  CommonID_Slider_Desc = {
    Text = "数値スライダー"
  },
  CommonID_SlotCardLevel_Desc = {
    Text = "基本スロットレベル"
  },
  CommonID_SoundBalance_Desc = {
    Text = "音声バランス"
  },
  CommonID_SpecificCommunicateTrig_Desc = {
    Text = "任務完了条件：指定された通信機の会話を発生済み"
  },
  CommonID_StageDropAdd_Desc = {
    Text = "ダンジョン報酬増加"
  },
  CommonID_Switch_Desc = {
    Text = "スイッチ"
  },
  CommonID_System_Desc = {
    Text = "システム"
  },
  CommonID_TH_Desc = {
    Text = "タイ語(alpha)"
  },
  CommonID_TRUE_Desc = {Text = "はい"},
  CommonID_TR_Desc = {
    Text = "トルコ語（alpha）"
  },
  CommonID_TW_Desc = {
    Text = "繁体字中国語"
  },
  CommonID_TaskCount_Desc = {
    Text = "カウント"
  },
  CommonID_TaskInProgress_Desc = {Text = "進行中"},
  CommonID_TaweiMonster_Desc = {
    Text = "昏きタヴィ"
  },
  CommonID_Through1_Desc = {
    Text = "パッシブスキル1"
  },
  CommonID_Through2_Desc = {
    Text = "パッシブスキル2"
  },
  CommonID_Tips_Desc = {Text = "ヒント"},
  CommonID_TranslationLabel_Desc = {
    Text = "公式翻訳ラベル"
  },
  CommonID_Ulti_Skill_Desc = {
    Text = "狂気解放"
  },
  CommonID_UtlSkill_Promote_Desc = {
    Text = "極限解放"
  },
  CommonID_VN_Desc = {
    Text = "ベトナム語(alpha)"
  },
  CommonID_VeryHigh_Desc = {
    Text = "非常に高い"
  },
  CommonID_VeryLow_Desc = {
    Text = "非常に低い"
  },
  CommonID_View_Desc = {Text = "確認"},
  CommonID_Voice_Desc = {Text = "音声"},
  CommonID_Web_Desc = {
    Text = "ウェブページ移動"
  },
  CommonID_White_Desc = {Text = "白銀"},
  CommonID_WindowNotFocusVoice_Desc = {
    Text = "ウィンドウ非アクティブ時の効果音"
  },
  CommonID_Window_Desc = {
    Text = "ウィンドウ"
  },
  CommonID_YellowGlow_Desc = {
    Text = "黄色エフェクト"
  }
})
return Text_CommonID
