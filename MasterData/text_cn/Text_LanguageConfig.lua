__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_LanguageConfig = readonly({
  LanguageConfig_24Resonance1_1_CN = {
    Text = "随机 2 张指令卡获得刻印：「(EnchantConfig.Arg1)」"
  },
  LanguageConfig_24Resonance1_2_CN = {
    Text = "随机 4 张指令卡获得刻印：「(EnchantConfig.Arg1)」"
  },
  LanguageConfig_24Resonance1_3_CN = {
    Text = "获得3个随机白银造物"
  },
  LanguageConfig_24Resonance1_4_CN = {
    Text = "获得3个随机白银造物或获得1个随机黄金+造物"
  },
  LanguageConfig_2ndAnniversarySenderText_CN = {Text = "拉蒙娜"},
  LanguageConfig_2ndAnniversaryText_CN = {
    Text = "不论你在哪里，%player%。\n弥萨格一直在尝试进行维度链接，或许我们很快就能再见面了。\n朵尔说，她定位到了你所在的维度，我无法形容它令我的心感受到了怎样的狂喜。\n即使我偏好明确、精准、规则分明的事物，只有在这件事上，任何渺茫甚至不切实际的希望都没关系。\n比起长久的等待，我更无法想象永远不会重逢的别离。\n如果这一次没有成功，没关系，下一次，再下一次，或者千千万万次，不论需要多少次，我和弥萨格的所有人，都一定会带你回来。\n虽然如今我们在两个维度，弥萨格依然想办法用银芯科技搜罗了一些令你获得助力的可能，请凝聚我们过去的记忆，创造新的记忆，让这些礼物为你带来帮助吧。\n我们都知道，你一定会回来。\n因为我很擅长等待。"
  },
  LanguageConfig_2ndAnniversaryTitleText_CN = {
    Text = "彼端的眷念"
  },
  LanguageConfig_2ndAnniversary_200DrawsText_CN = {
    Text = "完成活动任务最多可领取「流明之芯」×200！"
  },
  LanguageConfig_AbilityCard_Lock_CN = {
    Text = "能力封印"
  },
  LanguageConfig_AboutToCompose_CN = {
    Text = "即将合成"
  },
  LanguageConfig_AboutToDecompose_CN = {
    Text = "即将分解"
  },
  LanguageConfig_AbyssAllClearanceChallengeScore_CN = {
    Text = "总共通关特训值"
  },
  LanguageConfig_AbyssChallengeAwakerAssistRuleTitle_CN = {
    Text = "助战说明"
  },
  LanguageConfig_AbyssChallengeAwakerAssistRule_CN = {
    Text = "·在「融灾禁区」中可以使用1次助战，助战唤醒体与命轮不会受到限制法则的影响。（守密人可以在融灾禁区的规则说明中查看限制法则的详细说明。）\n·重置带有助战唤醒体的调查队伍时，会返还1次助战次数。"
  },
  LanguageConfig_AbyssChallengeBattleTips_CN = {
    Text = "*通关后，本次出战的唤醒体、命轮和钥令将无法在其他融灾禁区中上场。"
  },
  LanguageConfig_AbyssChallengeEndTips_CN = {Text = "已结束"},
  LanguageConfig_AbyssChallengeHistoricalRecord_CN = {Text = "·额外"},
  LanguageConfig_AbyssChallengeObtainScore_CN = {
    Text = "获得特训值"
  },
  LanguageConfig_AbyssChallengePass_CN = {Text = "已通关"},
  LanguageConfig_AbyssChallengePerfectPass_CN = {
    Text = "完美通关"
  },
  LanguageConfig_AbyssChallengeRankNotOnTheList_CN = {Text = "未上榜"},
  LanguageConfig_AbyssChallengeRankPreviousPeriod_CN = {Text = "上期"},
  LanguageConfig_AbyssChallengeRankThisPeriod_CN = {Text = "本期"},
  LanguageConfig_AbyssChallengeResetTipsDateHour_CN = {
    Text = "{s1}天{s2}小时后重置"
  },
  LanguageConfig_AbyssChallengeResetTipsHourMinute_CN = {
    Text = "{s1}小时{s2}分钟后重置"
  },
  LanguageConfig_AbyssChallengeRevivalCostTips_CN = {
    Text = "应急灵知体不足 3 个，是否花费"
  },
  LanguageConfig_AbyssChallengeRuleDesc_CN = {Text = "-"},
  LanguageConfig_AbyssChallengeRuleTitle_CN = {
    Text = "规则说明"
  },
  LanguageConfig_AbyssChallengeScore_CN = {
    Text = "累计特训值达到"
  },
  LanguageConfig_AbyssChallengeStageClearance_CN = {Text = "通关{s1}"},
  LanguageConfig_AbyssChallengeTipsTitle_CN = {
    Text = "规则说明"
  },
  LanguageConfig_AbyssChallengeTipsV2_CN = {
    Text = "<Title:「融灾禁区」>\n·融灾禁区是一个难度较高的玩法系统。守密人需要灵活搭配多个挑战队伍，尽可能地获取更多的特训值，从而获得更多的奖励。\n\n<Title:「禁区基础规则」>\n·融灾禁区共分为 5 个波次，每个波次中包含难度等级不同的关卡。\n·通关关卡后，可以获得对应数量的特训值，具体可在关卡详情界面中查看。\n·当特训值达到指定要求后，除了可以领取「银芯」和「黑色贡物」外，还可以获得珍稀物资「原初灵核」「精粹原初灵核」！它是产自弥萨格地底黑池的神秘灵核，能帮助唤醒体提升等级上限，最多提升至 90 级！\n·「融灾禁区」会周期性更新关卡内容和奖励，一般情况下，每 14 天更新一次。当期时间结束后，上一期仍在进行中的挑战将立即结束，未领取的奖励将无法获取，守密人记得及时完成和领取喔~\n\n<Title:「禁区特殊规则」>\n·在融灾禁区中有其独特的限制法则：同一唤醒体和钥令、同名命轮无法重复上场，守密人可以根据初始造物、怪物和推荐等级，灵活选择本次挑战的队伍。\n·完成挑战后，若守密人发现有更好的搭配方案，可以使用「重置」功能将对应关卡的挑战队伍进行重置，重置后唤醒体、钥令和命轮都可以重新上场，但通过该关卡获得的特训值也会扣除（不影响奖励状态）。\n·在「融灾禁区」中可以使用 1 次助战，助战唤醒体与命轮不会受到限制法则的影响；重置带有助战唤醒体的挑战队伍时，也会返回 1 次助战次数。\n·挑战过程中可使用「应急灵知体」协助通关，每次使用需要花费 3 个「应急灵知体」。使用后完成的挑战与特训值将被特殊标记，可正常领取特训奖励，但不计入排行榜。\n\n<Title:「额外挑战」>\n·通关任一关卡后，即可解锁该关卡的「额外挑战」，迎接更高难度的考验。\n·额外挑战需要单独编成挑战队伍，且同样受到限制法则影响：同一唤醒体和钥令、同名命轮无法重复上场，助战次数与普通挑战共享（全玩法共 1 次）。\n·通关额外挑战可获得 5 点特训值，计入本期特训值总额，助力领取更多奖励、提升排行榜名次。\n·可使用「重置」功能单独重置额外挑战队伍或普通挑战队伍。\n·若在额外通关后重置普通挑战队伍，额外挑战队伍将转为新的普通挑战队伍，额外挑战进度清空，并扣除额外通关特训值。\n\n<Title:「排行榜」>\n·现在可以查看本期和上期的特训值排行榜，以及其他守密人在融灾禁区中的通关信息，为守密人提供参考情报。\n·排行榜会展示达到本期最高特训值时的特训值与通关信息，重置不会影响排名，也不会影响通关编队信息展示。\n·请注意，使用「应急灵知体」通关挑战获得的特训值将被特殊标记且不会计入排行榜。"
  },
  LanguageConfig_AbyssChallengeTips_CN = {
    Text = "<Title:「融灾禁区」>\n·融灾禁区是一个难度较高的玩法系统。守密人需要灵活搭配多个挑战队伍，尽可能地获取更多的特训值，从而获得更多的奖励。\n\n<Title:「禁区基础规则」>\n·融灾禁区共分为 5 个波次，每个波次中包含难度等级不同的关卡。\n·通关关卡后，可以获得对应数量的特训值，具体可在关卡详情界面中查看。\n·当特训值达到指定要求后，除了可以领取「银芯」和「黑色贡物」外，还可以获得珍稀物资「原初灵核」「精粹原初灵核」！它是产自弥萨格地底黑池的神秘灵核，能帮助唤醒体提升等级上限，最多提升至 90 级！\n·「融灾禁区」会周期性更新关卡内容和奖励，一般情况下，每 14 天更新一次。当期时间结束后，未领取的奖励将无法获取，守密人记得及时完成和领取喔~\n\n<Title:「禁区特殊规则」>\n·在融灾禁区中有其独特的限制法则：同一唤醒体和钥令、同名命轮无法重复上场，守密人可以根据初始造物、怪物和推荐等级，灵活选择本次挑战的队伍。\n·完成挑战后，若守密人发现有更好的搭配方案，可以使用「重置」功能将对应关卡的挑战队伍进行重置，重置后唤醒体、钥令和命轮都可以重新上场，但通过该关卡获得的特训值也会扣除（不影响奖励状态）。\n·在「融灾禁区」中可以使用 1 次助战，助战唤醒体与命轮不会受到限制法则的影响；重置带有助战唤醒体的挑战队伍时，也会返回 1 次助战次数。\n\n<Title:「额外挑战」>\n·通关任一关卡后，即可解锁该关卡的「额外挑战」，迎接更高难度的考验。\n·额外挑战需要单独编成挑战队伍，且同样受到限制法则影响：同一唤醒体和钥令、同名命轮无法重复上场，助战次数与普通挑战共享（全玩法共 1 次）。\n·通关额外挑战可获得 5 点特训值，计入本期特训值总额，助力领取更多奖励、提升排行榜名次。\n·可使用「重置」功能单独重置额外挑战队伍或普通挑战队伍。\n·若在额外通关后重置普通挑战队伍，额外挑战队伍将转为新的普通挑战队伍，额外挑战进度清空，并扣除额外通关特训值。\n\n<Title:「排行榜」>\n·现在可以查看本期和上期的特训值排行榜，以及其他守密人在融灾禁区中的通关信息，为守密人提供参考情报。\n·排行榜会展示达到本期最高特训值时的特训值与通关信息，重置不会影响排名，也不会影响通关编队信息展示。"
  },
  LanguageConfig_AbyssChallengeTitle_CN = {
    Text = "融灾禁区"
  },
  LanguageConfig_AbyssChallengeWeaponCanNotFight_CN = {
    Text = "当前命轮已在其他融灾禁区中使用"
  },
  LanguageConfig_AbyssClearanceChallengeScore_CN = {
    Text = "通关特训值"
  },
  LanguageConfig_AbyssExtraClearanceChallengeScore_CN = {
    Text = "额外通关特训值"
  },
  LanguageConfig_AchievementGet_CN = {
    Text = "达成成就"
  },
  LanguageConfig_AchievementRewards_CN = {
    Text = "成就奖励"
  },
  LanguageConfig_ActivationResonance_Tips_CN = {
    Text = "共鸣点亮提示"
  },
  LanguageConfig_ActiveSkill_CN = {
    Text = "技能激活"
  },
  LanguageConfig_ActivityDescriptionTitle_CN = {
    Text = "活动说明"
  },
  LanguageConfig_ActivityExtraDropTimes_CN = {Text = "不限次"},
  LanguageConfig_ActivityFull_CN = {
    Text = "活性离子已满"
  },
  LanguageConfig_ActivityIsEnd_CN = {
    Text = "活动已结束"
  },
  LanguageConfig_ActivityLoginDays_CN = {
    Text = "登录{s1}天"
  },
  LanguageConfig_ActivityMarkHalfAYear_CN = {Text = "一周年"},
  LanguageConfig_ActivityMarkMouchetteCrossover_CN = {Text = "联动"},
  LanguageConfig_ActivityMarkOneAndAHalfYears_CN = {Text = "1.5周年"},
  LanguageConfig_ActivityMarkReturn_CN = {
    Text = "回归活动"
  },
  LanguageConfig_ActivityMarkTwoYears_CN = {Text = "二周年"},
  LanguageConfig_ActivityResonanceRules_CN = {
    Text = "1、本次限时活动有专属共鸣，可以使用共鸣升级材料激活共鸣效果，共鸣将在调查时提供强力的协助。\n2、在限时活动期间，完成指定任务可以获得共鸣升级材料。\n3、地图内会出现共鸣节点，移动至共鸣节点上将在本次探索获得共鸣效果。"
  },
  LanguageConfig_ActivityRewardNotReceived_CN = {
    Text = "<Receive:可领取>"
  },
  LanguageConfig_ActivityRewardReceived_CN = {
    Text = "<Claimed:已领取>"
  },
  LanguageConfig_ActivityRewardTitle_CN = {
    Text = "成就奖励"
  },
  LanguageConfig_ActivityRewardday_CN = {
    Text = "<DayTime:第{s1}天>"
  },
  LanguageConfig_ActivityShopIsEnd_1_CN = {
    Text = "{s1}天{s2}小时后截止兑换"
  },
  LanguageConfig_ActivityShopIsEnd_2_CN = {
    Text = "{s1}小时{s2}分钟后截止兑换"
  },
  LanguageConfig_ActivitySignReceiveRewardTimeLabel_CN = {
    Text = "剩余唤醒次数："
  },
  LanguageConfig_ActivitySignReceiveTaskTextAndCount_CN = {
    Text = "{s1} <color=#FFFFFF>{s2}</color>"
  },
  LanguageConfig_ActivityStageMadnessChallengeTips_CN = {
    Text = "癫狂难度仅可获得首通奖励"
  },
  LanguageConfig_ActivityStartTrial_CN = {
    Text = "开启试玩"
  },
  LanguageConfig_ActivityTaskGroupOpenCountDownFormat_CN = {
    Text = "距离解锁还有{s1}天{s2}小时{s3}分"
  },
  LanguageConfig_ActivityTaskTotalFinished_CN = {
    Text = "常训任务已完成"
  },
  LanguageConfig_ActivityTaskWeeklyTitle_CN = {
    Text = "每周试炼"
  },
  LanguageConfig_ActivityTimeCountdown_2_CN = {
    Text = "{s1}小时{s2}分钟后结束"
  },
  LanguageConfig_ActivityTimeCountdown_CN = {
    Text = "{s1}天{s2}小时后结束"
  },
  LanguageConfig_ActivityTimeExpired_CN = {Text = "已过期"},
  LanguageConfig_ActivityTimePermanent_CN = {Text = "永久"},
  LanguageConfig_ActorString_Sort_Ascend_CN = {Text = "升序"},
  LanguageConfig_ActorString_Sort_Descend_CN = {Text = "降序"},
  LanguageConfig_Actor_Skill_Upgrade_MaxLeve_CN = {Text = "已满级"},
  LanguageConfig_AffixConnect_CN = {Text = "的"},
  LanguageConfig_AfterTheNth_CN = {
    Text = "第{s1}名后"
  },
  LanguageConfig_AlchemyDecomposeCostItemNotEnoughTip_CN = {
    Text = "分解所需物资不足，无法分解"
  },
  LanguageConfig_AlchemyDecomposeEmptyResultTips_CN = {
    Text = "请输入正确答案"
  },
  LanguageConfig_AlchemyDecomposeItemRuleContent_CN = {
    Text = "1、守密人可以在此进行材料分解，分解后将不可恢复，请守密人谨慎选择。\n2、材料分解的具体产物可在界面中查看。"
  },
  LanguageConfig_AlchemyDecomposeSelectLimitTips_CN = {
    Text = "所选分解道具已达到上限"
  },
  LanguageConfig_AlchemyDecomposeTrinketConfirmTIps_CN = {
    Text = "本次分解物资包含<Blue:已升级的密契>，物资价值较高，确认分解请在输入框中输入<Blue:正确答案>，点击确定后将进行分解。"
  },
  LanguageConfig_AlchemyDecomposeTrinketLockTip_CN = {
    Text = "当前密契已锁定"
  },
  LanguageConfig_AlchemyDecomposeTrinketRuleContent_CN = {
    Text = "1、守密人可以在此进行密契分解，分解后将不可恢复，请守密人谨慎选择。\n2、若本次选择要分解的命轮中包含已强化的密契，分解时需要守密人完成答题才可分解。\n3、当前在任意「编队」或「密契方案」或「助战唤醒体」中使用的密契，不可分解。"
  },
  LanguageConfig_AlchemyDecomposeWeaponConfirmTIps_CN = {
    Text = "本次分解物资包含<Blue:SSR级命轮或已叠位的命轮>，物资价值较高，确认分解请在输入框中输入<Blue:正确答案>，点击确定后将进行分解。"
  },
  LanguageConfig_AlchemyDecomposeWeaponLockTip_CN = {
    Text = "当前命轮已锁定"
  },
  LanguageConfig_AlchemyDecomposeWeaponRuleContent_CN = {
    Text = "1、守密人可以在此进行命轮分解，分解后将不可恢复，请守密人谨慎选择。\n2、若本次选择要分解的命轮中包含SSR级命轮或已叠位的命轮，分解时需要守密人完成答题才可分解。\n3、分解非限定的SSR级命轮可以获得「命途回溯碎片」× 1 和「蔷薇金券」× 2000，若分解限定SSR级命轮则获得的「命途回溯碎片」数量翻倍。\n4、当前在任意「编队」或「助战唤醒体」中使用的命轮，不可分解。"
  },
  LanguageConfig_AlchemyDecomposeWrongResultTips_CN = {
    Text = "答案错误，请重新输入"
  },
  LanguageConfig_AlchemyWorkshop_CN = {Text = "冶炼室"},
  LanguageConfig_AlertBossKilled_CN = {
    Text = "该原初之视的所有分身均已被消灭，无法继续挑战"
  },
  LanguageConfig_AlertForceAssist_CN = {
    Text = "未上场助战唤醒体，无法进入调查"
  },
  LanguageConfig_AllAchievement_CN = {
    Text = "成就/全部成就"
  },
  LanguageConfig_AllAwakerAwaked_CN = {
    Text = "全部唤醒体已觉醒"
  },
  LanguageConfig_AlreadyGot_CN = {Text = "已获得"},
  LanguageConfig_Aoerlagongminglianluo1_CN = {
    Text = "可选择合成献诗。"
  },
  LanguageConfig_Aoerlagongminglianluo2_CN = {
    Text = "可选择升级意象。"
  },
  LanguageConfig_AppointTaskRewardAddTag_CN = {Text = "额外"},
  LanguageConfig_ArchiveCollectionRewardsTitle_CN = {
    Text = "收集奖励"
  },
  LanguageConfig_AssistAwakerSortTypeAttentionTime_CN = {
    Text = "关注时间"
  },
  LanguageConfig_AssistAwakerSortTypeAwakerLevel_CN = {
    Text = "唤醒体等级"
  },
  LanguageConfig_AssistAwakerSortTypeAwakerPotency_CN = {
    Text = "唤醒体启灵"
  },
  LanguageConfig_AssistAwakerSortTypeAwakerSkill_CN = {
    Text = "唤醒体技能"
  },
  LanguageConfig_AssistAwakerSortTypeAwakerTalentLv_CN = {
    Text = "天赋等级"
  },
  LanguageConfig_AssistAwakerSortTypeTrinketCompletion_CN = {
    Text = "密契完成度"
  },
  LanguageConfig_AssistAwakerSortTypeWeaponPotency_CN = {
    Text = "命轮叠位等级"
  },
  LanguageConfig_AssistanceSystemIntroduction_CN = {
    Text = "·守密人可以选择1名唤醒体进行助战，其他已互相关注的守密人可以在融蚀之墟、禁忌纂录和幻梦深潜中使用你的助战唤醒体出战。\n·每次当其他守密人使用你的助战唤醒体调查成功后，你可以获得「蔷薇金券」×1000的奖励，每日最多可获得20次奖励。\n·当蔷薇金券奖励累计到 50 次时，守密人需先领取奖励后才可继续获得助战奖励。"
  },
  LanguageConfig_AssistanceSystemTitle_CN = {
    Text = "助战规则"
  },
  LanguageConfig_AutoBattleClose_CN = {Text = "未开启"},
  LanguageConfig_AutoBattleOpen_CN = {Text = "已开启"},
  LanguageConfig_AutoBattleTxt_CN = {
    Text = "自动战斗"
  },
  LanguageConfig_AutoFightForbid_CN = {
    Text = "本场战斗不支持自动战斗，请用自己的策略通关吧"
  },
  LanguageConfig_AutocConversion_Title_CN = {
    Text = "选择要置换千面印章的材料"
  },
  LanguageConfig_AwakerAchievement_CN = {
    Text = "成就/唤醒体成就"
  },
  LanguageConfig_AwakerAssistRuleTitle_CN = {
    Text = "助战规则"
  },
  LanguageConfig_AwakerAssistRule_CN = {
    Text = "·在进行融蚀之墟、禁忌纂录、幻梦深潜、超验存在等玩法时，可以选择使用1名已互相关注守密人的助战唤醒体进行出战。\n·助战唤醒体需满足当前编队的界域限制，不符合条件的助战唤醒体无法上场，守密人可以返回调整编队后再进行上场。\n·部分活动可能会有额外的特殊助战规则，请查看该活动的「活动说明」进行详细了解。"
  },
  LanguageConfig_AwakerChipChestPreviewTitle_CN = {
    Text = "唤醒体残片预览"
  },
  LanguageConfig_AwakerChipSelectTitle_CN = {
    Text = "选择唤醒体残片"
  },
  LanguageConfig_AwakerChipTypeName_CN = {
    Text = "唤醒体残片"
  },
  LanguageConfig_AwakerColletion_CN = {
    Text = "筛选唤醒体"
  },
  LanguageConfig_AwakerDetailButton_CN = {Text = "详 情"},
  LanguageConfig_AwakerFavorBreakThroughPopTip_CN = {
    Text = "确定使用「同心之证」× 1 进行灵肉同调吗？"
  },
  LanguageConfig_AwakerFavorBreakThroughSuccessSubTip_CN = {
    Text = "<color=#808080>Lv.{s1}/{s2}</color>"
  },
  LanguageConfig_AwakerFavorBreakThroughSuccessTip_CN = {
    Text = "灵肉同调"
  },
  LanguageConfig_AwakerFavorBreakThrough_CN = {
    Text = "灵肉同调"
  },
  LanguageConfig_AwakerFavorImproveActivity_CN = {
    Text = "活动加成"
  },
  LanguageConfig_AwakerFavorImproveAssist_CN = {
    Text = "使用助战"
  },
  LanguageConfig_AwakerFavorImproveBase_CN = {
    Text = "同调率基础奖励"
  },
  LanguageConfig_AwakerFavorImproveFirst_CN = {Text = "首通"},
  LanguageConfig_AwakerFavorImproveResonance_CN = {
    Text = "共鸣加成"
  },
  LanguageConfig_AwakerFavorability_Description_Detail_CN = {
    Text = "<Title:【同调率获取】>\n·通关调查行动、特遣纪录、意识潜游和幻梦深潜等关卡后，上阵唤醒体可以获得同调率。\n·唤醒体出牌越多、消耗算力和狂气越多，获得的同调率越多；关卡推荐等级越高，获得的同调率也越多。\n·守密人银钥能量消耗越多，上阵唤醒体获得的同调率也越多。\n·手动战斗期间获得的同调率为开启「自动战斗」时的 3 倍。\n·使用助战通关关卡后，守密人的上阵唤醒体获得同调率提高 50%。\n·邀请唤醒体进入宿舍后，每 5 分钟可获得 1 点同调率。\n·离线储存超过 300 点后，获取速度降为每 15 分钟 1 点，最多可储存至 3000 点。\n\n<Title:【同调率等级】>\n·收集唤醒体的同调率可以提升同调率等级，等级越高可解锁更多唤醒体的语音和故事，部分等级还可获得「无垢之芯」。\n·唤醒体同调率达到 Lv15 后，可通过「灵肉同调」消耗「同心之证」将等级上限逐级提升至 Lv20，每级可获得「精粹灵核碎片」×5，提升至 Lv20 时还可额外获得「曜闪」。\n·唤醒体同调率达到当前等级上限后将不再继续累积，需先完成灵肉同调才能继续获取。"
  },
  LanguageConfig_AwakerFavorability_Description_Title_CN = {
    Text = "同调率说明"
  },
  LanguageConfig_AwakerFavorability_Str_LvUp_CN = {
    Text = "{s1}的同调率提升至{s2}"
  },
  LanguageConfig_AwakerFormConflict_CN = {
    Text = "无法上阵"
  },
  LanguageConfig_AwakerFragment_CN = {
    Text = "{s1}的碎片"
  },
  LanguageConfig_AwakerHasColletion_CN = {
    Text = "已筛选唤醒体"
  },
  LanguageConfig_AwakerLevelLimitIncreaseTo_CN = {
    Text = "唤醒体等级上限已提升至{s1}级，可继续升级"
  },
  LanguageConfig_AwakerLevelMaxSelectTips_CN = {
    Text = "{s1}已达到启灵等级上限，请更换选择的物品"
  },
  LanguageConfig_AwakerMaxLevelBtnPreview_CN = {
    Text = "{s1}级预览"
  },
  LanguageConfig_AwakerNotObtained_CN = {
    Text = "未获得该唤醒体"
  },
  LanguageConfig_AwakerOverflowCraftLimitTips_CN = {
    Text = "次数来源于历史唤醒体溢出记录。该次数为固定值，使用后不可恢复。"
  },
  LanguageConfig_AwakerPoolGroupBtnTip_1_CN = {
    Text = "点击切换指定唤醒体"
  },
  LanguageConfig_AwakerPoolGroupTitle_1_CN = {
    Text = "三相衡生"
  },
  LanguageConfig_AwakerPoolGroupTitle_8_CN = {
    Text = "往事失落以前"
  },
  LanguageConfig_AwakerPotencyBtnText_CN = {Text = "激活"},
  LanguageConfig_AwakerPreviewTitle_CN = {
    Text = "唤醒体预览"
  },
  LanguageConfig_AwakerRandomChestTipTitle_CN = {
    Text = "随机获得唤醒体"
  },
  LanguageConfig_AwakerRandomSelectTitle_CN = {
    Text = "随机获得唤醒体"
  },
  LanguageConfig_AwakerSelectPreviewDetailTips_CN = {
    Text = "点击唤醒体查看详情"
  },
  LanguageConfig_AwakerSelectTitle_CN = {
    Text = "选择唤醒体"
  },
  LanguageConfig_AwakerSelectUseDetailTips_CN = {
    Text = "长按唤醒体查看详情"
  },
  LanguageConfig_AwakerSkillExaltTips_CN = {
    Text = "消耗狂气: {s1}"
  },
  LanguageConfig_AwakerSkillUpgradeTips_CN = {
    Text = "升格等阶{s1}可继续升级"
  },
  LanguageConfig_AwakerSkillValueTips_CN = {
    Text = "消耗算力: {s1}"
  },
  LanguageConfig_AwakerSkinTypeName_CN = {Text = "幻衣"},
  LanguageConfig_AwakerSkin_CN = {Text = "幻衣"},
  LanguageConfig_AwakerStateInformation_CN = {
    Text = "详细信息"
  },
  LanguageConfig_AwakerStoryAge_CN = {Text = "年龄"},
  LanguageConfig_AwakerStoryBasicI_CN = {
    Text = "基本信息"
  },
  LanguageConfig_AwakerStoryBirth_CN = {Text = "生日"},
  LanguageConfig_AwakerStoryEpithet_CN = {Text = "称号"},
  LanguageConfig_AwakerStoryGender_CN = {Text = "性别"},
  LanguageConfig_AwakerStoryHeight_CN = {Text = "身高"},
  LanguageConfig_AwakerStoryIcon_CN = {Text = "故事"},
  LanguageConfig_AwakerStoryKnowsIndex_CN = {
    Text = "诺斯指数"
  },
  LanguageConfig_AwakerStoryNameEn_CN = {Text = "英文名"},
  LanguageConfig_AwakerStoryName_CN = {Text = "名字"},
  LanguageConfig_AwakerStoryWeight_CN = {Text = "体重"},
  LanguageConfig_AwakerSystemBack_CN = {Text = "back"},
  LanguageConfig_AwakerSystemClose_CN = {Text = "close"},
  LanguageConfig_AwakerTagName_CN = {Text = "特性"},
  LanguageConfig_AwakerTrialActivityTitle_CN = {
    Text = "聚灵演练"
  },
  LanguageConfig_AwakerTrinketStrengthenBtnText_CN = {Text = "强化"},
  LanguageConfig_AwakerTypeName_CN = {Text = "唤醒体"},
  LanguageConfig_AwakerUpgradeBtnText_CN = {Text = "升级"},
  LanguageConfig_AwakerUpgradeButton_CN = {Text = "升 级"},
  LanguageConfig_AwakerUpgradeMaterialCompose_CN = {
    Text = "材料合成"
  },
  LanguageConfig_AwakerUpgradeMaxBtnText_CN = {Text = "已满级"},
  LanguageConfig_AwakerUseTimesLimitTips_CN = {
    Text = "*通关后，本次出战的唤醒体今日将无法在本活动中上场。"
  },
  LanguageConfig_AwakerVoiceIcon_CN = {Text = "语音"},
  LanguageConfig_AwakerWeaponSelectDetail_CN = {
    Text = "查看详情"
  },
  LanguageConfig_Awaker_LevelUp_Success_CN = {
    Text = "升级成功"
  },
  LanguageConfig_Awaker_Select_Get_Tips1_CN = {
    Text = "测试测试选择唤醒体"
  },
  LanguageConfig_Awaker_Select_Get_Tips2_UP_CN = {
    Text = "选择最多 2 个唤醒体"
  },
  LanguageConfig_Awaker_Type_Assist_CN = {Text = "辅助型"},
  LanguageConfig_Awaker_Type_Atk_CN = {Text = "伤害型"},
  LanguageConfig_Awaker_Type_Def_CN = {Text = "防御型"},
  LanguageConfig_AwardNodeGetItemButton_CN = {Text = "确定"},
  LanguageConfig_AwardNodeGetItemTitle_CN = {
    Text = "获得物品"
  },
  LanguageConfig_BPAdvanceBuyConfirmTipBottomDesc_CN = {
    Text = "是否消耗 <Blue:{s1}>源液购买？"
  },
  LanguageConfig_BPAdvanceBuyConfirmTipTopDesc_CN = {
    Text = "购买「核心课题」后会补发本期已领取的「基础活性离子」累积奖励的额外倍率部分。"
  },
  LanguageConfig_BPAwardTab_CN = {Text = "奖励"},
  LanguageConfig_BPBoxTab_CN = {Text = "礼匣"},
  LanguageConfig_BPBuyLevelTxt_CN = {
    Text = "<size=30><color=#ffffff>购买后升至</color></size>%d<size=34><color=#ffffff>级，可以获得以下奖励"
  },
  LanguageConfig_BPChargeSuccessfulTips_CN = {
    Text = "购买成功"
  },
  LanguageConfig_BPChooseColectDirectlyBtn_CN = {
    Text = "直接领取"
  },
  LanguageConfig_BPChooseConfirmBtn_CN = {Text = "确认"},
  LanguageConfig_BPChooseNextBtn_CN = {Text = "下一个"},
  LanguageConfig_BPChooseSelectHint_CN = {
    Text = "请选择您想要的奖励"
  },
  LanguageConfig_BPExpWeeklyLimitTxt_CN = {
    Text = "本周课题经验获取已达到上限"
  },
  LanguageConfig_BPExpireTips_CN = {
    Text = "新学期课题已更新"
  },
  LanguageConfig_BPExtraLvAwardTxt_CN = {
    Text = "额外奖励"
  },
  LanguageConfig_BPLevelLimitTxt_CN = {
    Text = "恭喜你的课题等级已满"
  },
  LanguageConfig_BPMultiChooseLastHint_CN = {
    Text = "已经是最后一个奖励"
  },
  LanguageConfig_BPMultiChooseTitleNum_CN = {
    Text = "（{s1}/{s2}）"
  },
  LanguageConfig_BPMultiChooseTitle_CN = {
    Text = "请选择获得的奖励"
  },
  LanguageConfig_BPNewOpenContent_CN = {
    Text = "新学期课题已开启！\n完成密境课室的日常试训和周常试训，提升课题等级，领取丰厚奖励！"
  },
  LanguageConfig_BPNewOpenTitle_CN = {
    Text = "新课题开启"
  },
  LanguageConfig_BPOpenPreviewTxt_CN = {
    Text = "{s1}天{s2}小时后新课题开启"
  },
  LanguageConfig_BPRuleTxt2_CN = {
    Text = "\n\n<Title:【特殊课题】>\n·本期课题周期为{s1} - {s2}（GMT+8），完成任务获取双倍课题经验，助力课题等级快速提升。"
  },
  LanguageConfig_BPRuleTxt_CN = {
    Text = "<Title:【课题类别】>\n·每期课题中，基础课题默认解锁获取，守密人还可通过解锁高阶课题，获取更丰厚的奖励。\n·通常每期课题会持续 28 天，有时候弥萨格会开启持续时间更短的特殊课题，特殊课题期间获取到的课题经验都会翻倍，助力守密人更快完成当期课题！\n \n·持续 28 天的课题：\n  ·解锁「高阶课题」需要「源液」×680，可立即获得 「银芯」×680。\n  ·解锁「核心课题」需要「源液」×1280，可立即获得「银芯」×1460。\n  ·将「高级课题」升级为「核心课题」需要「源液」×780，可立即获得「银芯」×780。\n \n·特殊课题：\n  ·课题期间获得的「课题经验」翻倍。\n  ·解锁「高阶课题」需要「源液」×680，可立即获得 「银芯」×680。\n  ·解锁「核心课题」需要「源液」×980，可立即获得「银芯」×1070。\n  ·将「高级课题」升级为「核心课题」需要「源液」×390，可立即获得「银芯」×390。\n\n<Title:【核心课题特权】>\n·解锁「核心课题」后，可以在本期课题持续期间获得特权。\n·在「日常试训」的「基础活性离子」累积奖励中获得的「现实起点」、「无垢之芯」、「经验」、「银芯」提升至 3 倍。购买「核心课题」后会补发本期已领取的「基础活性离子」累积奖励的额外倍率部分。\n·可以在战斗中使用「时序逆行」返回经历过的回合。\n·可以在「相位对弈」中限时解锁所有卡牌。\n\n<Title:【课题等级】>\n·守密人可通过完成密境课室的日常试训和周常试训来获取课题经验，提高课题等级，获取丰厚奖励。\n·「日常试训」将在9点刷新，「周常试训」将在每周一9点(GMT+8)刷新。\n·课题等级达到50级后，每提升1级，可获得1份额外奖励。"
  },
  LanguageConfig_BPSingleChooseTitle_CN = {
    Text = "请选择获得的奖励"
  },
  LanguageConfig_BPTaskSubTabDaily_CN = {
    Text = "每日任务"
  },
  LanguageConfig_BPTaskSubTabMonthly_CN = {
    Text = "每周任务"
  },
  LanguageConfig_BPTaskSubTabPeriod_CN = {
    Text = "学期任务"
  },
  LanguageConfig_BPTaskTab_CN = {Text = "任务"},
  LanguageConfig_BPTimeFormat_CN = {
    Text = "本期剩余{s1}"
  },
  LanguageConfig_BackTrack_CN = {Text = "回溯"},
  LanguageConfig_BacktrackAwaker_Rules_CN = {
    Text = "<Title:【养成回溯】>\n·此操作将重置唤醒体的所有升级、升格、技能、灵知深化状态，消耗的材料与金券均会全数返还。\n·唤醒体所有消耗的界域升格素材，返还为等同数量与稀有度的「初阶升格匣子」、「中阶升格匣子」、「高阶升格匣子」，可以选择等同数量与稀有度的任意界域升格素材。\n·唤醒体所有消耗的界域技能素材，返还为等同数量与稀有度的「初阶技能补给」、「中阶技能补给」、「高阶技能补给」，可以选择等同数量与稀有度的任意界域技能素材。\n·唤醒体所有消耗的「幸运糖果」、「蜡像泥胚」、「漆黑锁扣」、「维度结晶」、「虔诚圣心」，返还为30倍数量的「拟态凝晶」。 \n<Title:【启灵回溯】>\n·此操作将重置唤醒体的启灵状态，并重置启灵带来的等级上限，消耗的材料会全数返还。\n·唤醒体所有消耗或未使用的启灵残片，将视获取来源分别返还成不同的道具。\n·由「原型视界」兑换所得的，返还为「原型视界」。\n·由限时唤醒所得的限定唤醒体转化而来的，返还为「灵魂回溯之芯」。\n·「朵尔」「奥吉尔」「萝坦」将会返回「调查徽章」× 2500。\n·「拉蒙娜」「环行·拉蒙娜」将会返回「残片·拉蒙娜」。\n·「艾继丝」「奥瑞塔」「艾瑞卡」将会返回「融蚀之珠」× 8000。\n·通过其他方式所得的，返还为「原质乐园」。\n<Title:【黑池归还】>\n·此操作除了「养成回溯」所有效果之外，还将唤醒体本身也重置，变为未解锁状态。\n·唤醒体所装备的命轮、密契都将卸下，其头像将会变为不可用，如果正在使用会切换为默认头像。\n·唤醒体的升格奖励领取状态、同调率与同调率奖励领取状态均将保留，重新获取该唤醒体时会继承。\n·唤醒体本身将视来源分别返还成不同的道具。由限时唤醒所得的限定唤醒体，返还为「灵魂回溯之芯」；通过其他方式所得的，返还为「原质乐园」。\n<Title:【物品说明】>\n·「初阶升格匣子」：使用时可任选纯白残片、淬制本能、记忆副本、认知模板中其中1个。\n·「中阶升格匣子」：使用时可任选纯白文书、淬制理智、情感副本、精神模板中其中1个。\n·「高阶升格匣子」：使用时可任选纯白秘篇、淬制心灵、意识副本、灵知模板中其中1个。\n·「初阶技能补给」：使用时可任选失色晶蝶、低茎海百合、风干虫蛹、残破矿晶中其中1个。\n·「中阶技能补给」：使用时可任选闪耀晶蝶、高茎海百合、原生虫蛹、陨星碎块中其中1个。\n·「高阶技能补给」：使用时可任选混沌结晶、尤因他百合、芽孢聚合物、尤卡坦之星中其中1个。\n·「原型视界」：使用时可从中任选1个已解锁SSR角色的唤醒体残片。\n·「原质乐园」：使用时可从中任选1个「界域研习」中的唤醒体唤醒。\n·「灵魂回溯之芯」：使用时可从中任选1个「界域研习」、往期角色活动唤醒和当期角色活动唤醒中的唤醒体。"
  },
  LanguageConfig_BacktrackCannotSkipTips_CN = {
    Text = "正在调查中，无法进行跳转。"
  },
  LanguageConfig_BacktrackRedirectHint_CN = {
    Text = "前往解锁"
  },
  LanguageConfig_BacktrackRichText1_CN = {
    Text = "剩余次数 {s1}"
  },
  LanguageConfig_BacktrackRichText2_CN = {
    Text = "剩余次数 <color=#FF0000>{s1}</color>"
  },
  LanguageConfig_BacktrackTimesLeft_CN = {
    Text = "回溯功能将在{s1}后关闭"
  },
  LanguageConfig_BacktrackTips1_CN = {
    Text = "特殊唤醒体仅能进行「养成回溯」"
  },
  LanguageConfig_BacktrackTips2_CN = {
    Text = "「养成回溯」或「启灵回溯」后，无法再进行「黑池归还」"
  },
  LanguageConfig_BacktrackTips3_CN = {
    Text = "特殊唤醒体无法进行「黑池归还」"
  },
  LanguageConfig_BacktrackWeapon_Rules_CN = {
    Text = "<Title:【叠位回溯】>\n·此操作将重置命轮所有叠位状态，消耗的材料会全数返还。\n·通过「循环母版」激活的叠位，返还「循环母版」；通过限时唤醒所得的限定命轮激活的叠位，返还「命途回溯之芯」；通过其他方式激活的叠位，返还为「轮转之书」。\n<Title:【黑池归还】>\n·此操作除了「养成回溯」所有效果之外，还将命轮本身也重置。\n·通过限时唤醒所得的限定命轮，返还「命途回溯之芯」；通过其他方式所得的，返还为「轮转之书」。\n<Title:【物品说明】>\n·以下物品均在物资界面中使用。\n·「循环母版」：可以作为任意一个SSR命轮的叠位素材。\n·「轮转之书」：使用时可从中任选1个「轮转之相」中的SSR命轮获得。\n·「命途回溯之心」：使用时可从中任选1个「轮转之相」、往期命轮活动唤醒和当期命轮活动唤醒中的SSR命轮。"
  },
  LanguageConfig_BagCapacity_CN = {
    Text = "数量 {s1} / {s2}"
  },
  LanguageConfig_BagEmptyTitle_CN = {
    Text = "暂无{s1}道具"
  },
  LanguageConfig_BagItemUseBtnText_CN = {Text = "使用"},
  LanguageConfig_BagKeeperSkillTitle_CN = {Text = "钥令"},
  LanguageConfig_BagMaterialEmptyDesc_CN = {
    Text = "可通过调查和幕间演习获取"
  },
  LanguageConfig_BagMaterialEnTitle_CN = {Text = "Material"},
  LanguageConfig_BagMaterialTitle_CN = {Text = "材料"},
  LanguageConfig_BagSpecialEmptyDesc_CN = {
    Text = "可通过特定途径获取"
  },
  LanguageConfig_BagSpecialEnTitle_CN = {Text = "Special"},
  LanguageConfig_BagSpecialTitle_CN = {Text = "消耗品"},
  LanguageConfig_BagTitle_CN = {Text = "物资"},
  LanguageConfig_BagTrinketEmptyDesc_CN = {
    Text = "可通过禁忌纂录获取"
  },
  LanguageConfig_BagTrinketEnTitle_CN = {Text = "Trinket"},
  LanguageConfig_BagTrinketTitle_CN = {Text = "密契"},
  LanguageConfig_BagWeaponEmptyDesc_CN = {
    Text = "可通过唤醒获取"
  },
  LanguageConfig_BagWeaponEnTitle_CN = {Text = "Weapon"},
  LanguageConfig_BagWeaponTitle_CN = {Text = "命轮"},
  LanguageConfig_BattleAchievement_CN = {
    Text = "成就/战斗成就"
  },
  LanguageConfig_BattleBuff_1_CN = {Text = "攻击力"},
  LanguageConfig_BattleBuff_2_CN = {
    Text = "增加伤害值"
  },
  LanguageConfig_BattleBuff_3_CN = {Text = "防御力"},
  LanguageConfig_BattleBuff_4_CN = {
    Text = "增加护盾力"
  },
  LanguageConfig_BattleBuff_5_CN = {
    Text = "触腕力量"
  },
  LanguageConfig_BattleBuff_6_CN = {
    Text = "增加触腕的伤害值"
  },
  LanguageConfig_BattlePassLeftTimeLess_CN = {
    Text = "{s1}小时{s2}分钟"
  },
  LanguageConfig_BattlePassLeftTimeMore_CN = {
    Text = "{s1}天{s2}小时"
  },
  LanguageConfig_BattlePassLevel_CN = {Text = "%d级"},
  LanguageConfig_BattleSchoolEffectTipsTitle_CN = {
    Text = "界域机制"
  },
  LanguageConfig_BattleSim_Err_NoActor_CN = {
    Text = "角色栏为空，不能进入战斗"
  },
  LanguageConfig_BattleString_01_CN = {
    Text = "剩余回合数：{s1}"
  },
  LanguageConfig_BattleString_02_CN = {
    Text = "算力不足，无法使用指令卡"
  },
  LanguageConfig_BattleTeachingEntryBtnTxt_CN = {
    Text = "开始训练"
  },
  LanguageConfig_BattleTeachingLabel_CN = {
    Text = "实战教学"
  },
  LanguageConfig_BattleTeachingRuleDesc_CN = {
    Text = "1、守密人可以在对应关卡中学习并练习相关的战斗内容。\n2、守密人通关对应实战教学关卡时，可以在「实战教学」中领取奖励。"
  },
  LanguageConfig_BattleWaves_CN = {
    Text = "波次 {s1}/{s2}"
  },
  LanguageConfig_Battle_Begin_Boss_CHN_CN = {
    Text = "最高警报"
  },
  LanguageConfig_Battle_Begin_CHN_CN = {
    Text = "战斗开始"
  },
  LanguageConfig_Battle_Begin_EN_CN = {
    Text = "BATTLE BEGIN"
  },
  LanguageConfig_Battle_Begin_Elite_CHN_CN = {
    Text = "危险警报"
  },
  LanguageConfig_Battle_Boss_Tips_CN = {Text = "BOSS"},
  LanguageConfig_Battle_BoutCount_CN = {
    Text = "总回合数"
  },
  LanguageConfig_Battle_Btn_BeDamageInfo_CN = {
    Text = "敌方伤害总量"
  },
  LanguageConfig_Battle_Btn_GoldInfo_CN = {Text = "黑印"},
  LanguageConfig_Battle_Btn_TurnInfo_CN = {Text = "回合数"},
  LanguageConfig_Battle_CardGroup_CN = {Text = "牌堆"},
  LanguageConfig_Battle_Cards_Number_CN = {
    Text = "{s1}<size=20>    /     {s2}</size>"
  },
  LanguageConfig_Battle_ChooseCardToHand_CN = {
    Text = "选择{s1}张卡加入手卡"
  },
  LanguageConfig_Battle_ChooseCard_CN = {
    Text = "选择指令卡"
  },
  LanguageConfig_Battle_Cooldown_CN = {Text = "冷却中"},
  LanguageConfig_Battle_DeathResist_CN = {
    Text = "死亡抵抗"
  },
  LanguageConfig_Battle_Defeated_Title_CHN_CN = {
    Text = "战斗失败"
  },
  LanguageConfig_Battle_Defeated_Title_EN_CN = {Text = "DEFEATED"},
  LanguageConfig_Battle_DisCardGroup_Str_CN = {
    Text = "弃牌堆({s1})"
  },
  LanguageConfig_Battle_Discard_Title_CN = {Text = "弃卡堆"},
  LanguageConfig_Battle_DrawCardGroup_Str_CN = {
    Text = "抽牌堆({s1})"
  },
  LanguageConfig_Battle_Draw_Title_CN = {Text = "抽卡堆"},
  LanguageConfig_Battle_Elite_Tips_CN = {Text = "高危"},
  LanguageConfig_Battle_EndTurn_CHN_CN = {
    Text = "结束回合"
  },
  LanguageConfig_Battle_EndTurn_EN_CN = {Text = "END TURN"},
  LanguageConfig_Battle_EnemyTurn_Title_CHN_CN = {
    Text = "敌方行动"
  },
  LanguageConfig_Battle_EnemyTurn_Title_EN_CN = {Text = "ENEMY TURN"},
  LanguageConfig_Battle_Exhaust_Title_CN = {Text = "消耗堆"},
  LanguageConfig_Battle_ExtraTurn_Desc_CHN_CN = {
    Text = "超维跃迁！"
  },
  LanguageConfig_Battle_ExtraTurn_Desc_EN_CN = {
    Text = "进入超维状态，激发超维唤醒体的全部潜能"
  },
  LanguageConfig_Battle_ExtraTurn_Title_CHN_CN = {
    Text = "额外回合"
  },
  LanguageConfig_Battle_ExtraTurn_Title_EN_CN = {Text = "EXTRA TURN"},
  LanguageConfig_Battle_Gain_Card_CN = {Text = "获取"},
  LanguageConfig_Battle_Gain_Relic_CN = {Text = "获取"},
  LanguageConfig_Battle_GiveUp_Card_CN = {Text = "放弃"},
  LanguageConfig_Battle_GiveUp_Relic_CN = {Text = "放弃"},
  LanguageConfig_Battle_GiveUp_Stone_CN = {
    Text = "所有战斗放弃获取黑印"
  },
  LanguageConfig_Battle_PlayerTurn_Title_CHN_CN = {
    Text = "我方行动"
  },
  LanguageConfig_Battle_PlayerTurn_Title_EN_CN = {
    Text = "PLAYER TURN"
  },
  LanguageConfig_Battle_RelicList_Title_CN = {
    Text = "持有造物"
  },
  LanguageConfig_Battle_ResonanceBuff_Str_CN = {Text = "共鸣"},
  LanguageConfig_Battle_State_Layer_CN = {Text = "{s1}层"},
  LanguageConfig_Battle_Str_DeathResist_CN = {
    Text = "死亡抵抗！"
  },
  LanguageConfig_Battle_Str_Round_CN = {Text = "回合"},
  LanguageConfig_Battle_Strengthen_Str_CN = {Text = "强化"},
  LanguageConfig_Battle_Threat_Save_CN = {Text = "安全"},
  LanguageConfig_Battle_Threat_Unknown_CN = {Text = "未知"},
  LanguageConfig_Battle_Tips_BeDamageInfo_CN = {
    Text = "本回合敌人即将造成的伤害总量。获得护盾可以抵挡伤害。"
  },
  LanguageConfig_Battle_Tips_Block_CN = {Text = "格挡"},
  LanguageConfig_Battle_Tips_BloodName_CN = {
    Text = "胚胎融合"
  },
  LanguageConfig_Battle_Tips_BloodTips_CN = {
    Text = "·回合开始时<CardKeyWord:胚胎融合> +20（随损失生命提升，最高 40），达到上限时将 1 张<CardKeyWord:「胚胎」>置入手牌。\n·血肉界域的「狂气爆发」会消耗<CardKeyWord:「胚胎」>触发<CardKeyWord:吞噬>效果。"
  },
  LanguageConfig_Battle_Tips_BoutCount_CN = {
    Text = "所有战斗的总回合数。"
  },
  LanguageConfig_Battle_Tips_DeathResist_CN = {
    Text = "在战斗中受到致命伤害时有概率保留 1 点生命。触发后下回合获得 2 点算力和抽 2 张牌，队伍的<CardKeyWord:死亡抵抗>减半，后续获得的<CardKeyWord:死亡抵抗>减半，持续到调查结束。\n若有至少 1 个混沌界域唤醒体，<CardKeyWord:死亡抵抗>初始 +100%。"
  },
  LanguageConfig_Battle_Tips_DimensionName_CN = {
    Text = "超维空间"
  },
  LanguageConfig_Battle_Tips_DimensionTips_CN = {
    Text = "·每回合打出的第 1 张指令卡的临时复制会发动「奇点折跃」进入<CardKeyWord:超维空间>并触发其跃迁效果。\n·当超维空间达到上限时，获得 1 个额外的超维回合，该回合不再通常抽牌，而是将超维空间的卡牌加入手牌。超维回合能触发所有跃迁效果。"
  },
  LanguageConfig_Battle_Tips_EffectEnd_CN = {
    Text = "{s1}效果结束"
  },
  LanguageConfig_Battle_Tips_EnergyInfo_CN = {
    Text = "开场获得能量: [ene_init]\n能量自动回复: [ene_passive]\n能量消耗降低: [ene_return]"
  },
  LanguageConfig_Battle_Tips_GoldInfo_CN = {
    Text = "持有的黑印数量。用于与融痕交易，换取造物和刻印强化战斗能力。击败敌方或是访问事件均可获得黑印。"
  },
  LanguageConfig_Battle_Tips_HpHeal_CN = {
    Text = "每当你的回合开始时，回复等同于该点数的生命。"
  },
  LanguageConfig_Battle_Tips_HpHeal_Title_CN = {
    Text = "生命自动回复"
  },
  LanguageConfig_Battle_Tips_Immune_CN = {Text = "免疫"},
  LanguageConfig_Battle_Tips_LuckyEnchant_CN = {
    Text = "在战斗结束获得刻印或是商店购买刻印时，有概率将其升级为高级刻印。"
  },
  LanguageConfig_Battle_Tips_MonsterDimensionTips_CN = {
    Text = "每回合打出第 1 张指令卡的临时复制会进入敌人的维度裂隙，不同敌人会对裂隙内的卡牌产生不同的影响。"
  },
  LanguageConfig_Battle_Tips_PhiloStoneDropBonusesTips_CN = {
    Text = "百分比提高战斗胜利后敌人掉落的黑印。"
  },
  LanguageConfig_Battle_Tips_PhiloStoneDropBonuses_CN = {
    Text = "黑印掉落加成"
  },
  LanguageConfig_Battle_Tips_TentacleName_CN = {Text = "触腕"},
  LanguageConfig_Battle_Tips_TentacleTips_CN = {
    Text = "战斗开始时生成 1 条触腕，触腕在回合结束时攻击前排敌人。\n每当敌人死亡时触腕伤害永久获得提升。"
  },
  LanguageConfig_Battle_Tips_TurnInfo_CN = {
    Text = "本场战斗经历的回合数。敌人会随着回合数的增加逐渐成长。"
  },
  LanguageConfig_Battle_Transcendent_Title_CN = {
    Text = "发动超维空间"
  },
  LanguageConfig_Battle_Uenergy_Float_CN = {Text = "{s1}狂气"},
  LanguageConfig_Battle_Win_Return_CN = {
    Text = "返回指令卡选择"
  },
  LanguageConfig_Battle_Win_Select1_CN = {
    Text = "已选：0/1"
  },
  LanguageConfig_Battle_Win_Select2_CN = {
    Text = "已选：0/2"
  },
  LanguageConfig_Battle_Win_SelectCard_CN = {
    Text = "选择指令卡"
  },
  LanguageConfig_Battle_Win_SelectRelic_CN = {
    Text = "选择造物"
  },
  LanguageConfig_Battle_Win_Title_CHN_CN = {
    Text = "战斗胜利"
  },
  LanguageConfig_Battle_Win_Title_EN_CN = {Text = "VICTORY"},
  LanguageConfig_Battle_expect_Str_hurt_CN = {
    Text = "怪物回合伤害"
  },
  LanguageConfig_BenyuanDuoerHuodong1_CN = {
    Text = "选择一项未进行的研究。"
  },
  LanguageConfig_BenyuanDuoerHuodong2_CN = {
    Text = "选择 3 张指令卡赋予「合奏」刻印。"
  },
  LanguageConfig_BigMeal_CN = {
    Text = "豪华大餐！"
  },
  LanguageConfig_BigPotencyDesc_CN = {
    Text = "核心启灵（已废弃）"
  },
  LanguageConfig_Billing_Total_Damage_CN = {Text = "总伤害"},
  LanguageConfig_BlackOfferingShopRules_CN = {
    Text = "1、守密人可以通过消耗一定的「黑色供物」兑换商品。\n2、当守密人调查等级提升时，无光兑换商店会随之升级并解锁新内容。\n3、无光兑换商店内的商品每隔一定的时间会自动刷新库存。\n4、守密人可以通过「无光之境」或通过「融灾禁区」来获得「黑色供物」。"
  },
  LanguageConfig_BlackPoolBackTrack_CN = {
    Text = "黑池归还"
  },
  LanguageConfig_Blessing_Select_CN = {
    Text = "仙女赐福，童叟无欺，敬请挑选"
  },
  LanguageConfig_BlockText_CN = {Text = "护盾"},
  LanguageConfig_BloodAbilityCoolDown_CN = {
    Text = "「猩红熔炉」冷却中，无法使用，还需冷却 {s1} 回合"
  },
  LanguageConfig_BonusAffix_A24Activity_CN = {
    Text = "理性加成"
  },
  LanguageConfig_BonusAffix_Activity_CN = {
    Text = "活动加成"
  },
  LanguageConfig_BonusAffix_HamelnActivity_CN = {
    Text = "乐章加成"
  },
  LanguageConfig_BonusAffix_HorlaActivity_CN = {
    Text = "诗文加成"
  },
  LanguageConfig_BonusAffix_MagicStoryActivity_CN = {
    Text = "灵感加成"
  },
  LanguageConfig_BonusAffix_MiryamActivity_CN = {
    Text = "祀物加成"
  },
  LanguageConfig_BonusAffix_MurphyActivity_CN = {
    Text = "胚胎加成"
  },
  LanguageConfig_BonusAffix_OriginDollActivity_CN = {
    Text = "人偶零件加成"
  },
  LanguageConfig_BonusAffix_OriginHelotActivity_CN = {
    Text = "花苞加成"
  },
  LanguageConfig_BonusAffix_RykerActivity_CN = {
    Text = "筹码加成"
  },
  LanguageConfig_BonusAffix_SalvadorActivity_CN = {
    Text = "辉光加成"
  },
  LanguageConfig_BonusAffix_SorelActivity_CN = {
    Text = "羽扇加成"
  },
  LanguageConfig_BonusAffix_TawilActivity_CN = {
    Text = "终末指针加成"
  },
  LanguageConfig_BonusAffix_ThaisActivity_CN = {
    Text = "强欲加成"
  },
  LanguageConfig_BonusAffix_TuluActivity_CN = {
    Text = "绪思加成"
  },
  LanguageConfig_BonusAffix_WandaActivity_CN = {
    Text = "奇珍加成"
  },
  LanguageConfig_BonusCardAwardText_CN = {
    Text = "强欲加成"
  },
  LanguageConfig_BonusCardRateText_CN = {
    Text = "「丰穰种核」获得强欲加成：<NetworkDelayGreen:{s1}>"
  },
  LanguageConfig_BonusCardTipsContent_CN = {
    Text = "1、守密人拥有特定唤醒体或命轮（不要求上阵）可以使「紊乱情欲」关卡任务报酬中的「丰穰种核」获得额外的掉落加成（包括重现），具体加成如下：\n·唤醒体「泰旖丝」：启灵0/1/2/3及以上，加成20%/30%/40%/50%\n·SSR命轮「慈悲的哺育」：叠位0/1/2/3及以上，加成20%/30%/40%/50%\n·SR命轮「灼热的吻别」：叠位0/1/2/3及以上，加成20%/30%/40%/50%\n2、不同唤醒体或命轮的「强欲加成」以叠加的方式结算。"
  },
  LanguageConfig_BonusCardTipsTitle_CN = {
    Text = "强欲加成说明"
  },
  LanguageConfig_BonusRuleContent_A24Activity_CN = {
    Text = "1、守密人拥有特定唤醒体或命轮（不要求上阵）可以使「记忆编码」关卡任务报酬中的「记忆拼图」获得额外的掉落加成（包括重现），具体加成如下：\n·唤醒体「24」：启灵0/1/2/3及以上，加成20%/30%/40%/50%\n·SSR命轮「畸体回噬」：叠位0/1/2/3及以上，加成20%/30%/40%/50%\n·SR命轮「银鳕鱼的决心」：叠位0/1/2/3及以上，加成20%/30%/40%/50%\n2、不同唤醒体或命轮的「理性加成」以叠加的方式结算。"
  },
  LanguageConfig_BonusRuleContent_ArachneActivity_CN = {
    Text = "1、守密人拥有特定唤醒体或命轮（不要求上阵）可以使「木偶的舞台」关卡任务报酬中的「丝绒座票根」获得额外的掉落加成，具体加成如下：\n·唤醒体「阿拉克涅」：启灵0/1/2/3及以上，加成20%/30%/40%/50%。\n·SSR命轮「永世编织之网」：叠位0/1/2/3及以上，加成20%/30%/40%/50%。\n·SR命轮「宿命纺轮」：叠位0/1/2/3及以上，加成20%/30%/40%/50%。\n2、不同唤醒体或命轮的「活动加成」以叠加的方式结算。"
  },
  LanguageConfig_BonusRuleContent_CarabooActivity_CN = {
    Text = "1、守密人拥有特定唤醒体或命轮（不要求上阵）可以使「乌摩钵蒂的宝物」关卡任务报酬中的「红苹果」「金苹果」「糖苹果」获得额外的掉落加成，具体加成如下：\n·唤醒体「卡拉布」：启灵0/1/2/3及以上，加成20%/30%/40%/50%。\n·SSR命轮「蜜果的谎言」：叠位0/1/2/3及以上，加成20%/30%/40%/50%。\n·SR命轮「恬美真相」：叠位0/1/2/3及以上，加成20%/30%/40%/50%。\n2、不同唤醒体或命轮的「活动加成」以叠加的方式结算。"
  },
  LanguageConfig_BonusRuleContent_CastorActivity_CN = {
    Text = "1、守密人拥有特定唤醒体或命轮（不要求上阵）可以使「飞跃青空」关卡任务报酬中的「常识之书」、「数理之书」、「文学之书」获得额外的掉落加成，具体加成如下：\n·唤醒体「卡斯托尔」：启灵0/1/2/3及以上，加成20%/30%/40%/50%。\n·SSR命轮「不可承受的自由」：叠位0/1/2/3及以上，加成20%/30%/40%/50%。\n·SR命轮「孤羽」：叠位0/1/2/3及以上，加成20%/30%/40%/50%。\n2、不同唤醒体或命轮的「活动加成」以叠加的方式结算。"
  },
  LanguageConfig_BonusRuleContent_ClementineActivity_CN = {
    Text = "1、守密人拥有特定唤醒体或命轮（不要求上阵）可以使「恐惧愈疗」关卡任务报酬中的「诊断报告」获得额外的掉落加成（包括重现），具体加成如下：\n·唤醒体「克莱门汀」：启灵0/1/2/3及以上，加成20%/30%/40%/50%\n·SSR命轮「隐没的痛楚」：叠位0/1/2/3及以上，加成20%/30%/40%/50%\n·SR命轮「催眠灵摆」：叠位0/1/2/3及以上，加成20%/30%/40%/50%\n2、不同唤醒体或命轮的「活动加成」以叠加的方式结算。"
  },
  LanguageConfig_BonusRuleContent_DaffodilActivity_CN = {
    Text = "1、守密人拥有特定唤醒体或命轮（不要求上阵）可以使「魔女小店」关卡任务报酬中的「苍白野兽头骨」、「幽影野兽头骨」、「殷红野兽头骨」获得额外的掉落加成（包括重现），具体加成如下：\n·唤醒体「达芙黛尔」：启灵0/1/2/3及以上，加成20%/30%/40%/50%\n·SSR命轮「至为珍贵的藏品」：叠位0/1/2/3及以上，加成20%/30%/40%/50%\n·SR命轮「魔女宽檐帽」：叠位0/1/2/3及以上，加成20%/30%/40%/50%\n2、不同唤醒体或命轮的「活动加成」以叠加的方式结算。"
  },
  LanguageConfig_BonusRuleContent_DoresainActivity_CN = {
    Text = "1、守密人拥有特定唤醒体或命轮（不要求上阵）可以使「噬灵之飨」关卡任务报酬中的「腐坏手骨」获得额外的掉落加成，具体加成如下：\n·唤醒体「杜勒赛因」：启灵0/1/2/3及以上，加成20%/30%/40%/50%。\n·SSR命轮「安息之吻」：叠位0/1/2/3及以上，加成20%/30%/40%/50%。\n·SR命轮「珍馐」：叠位0/1/2/3及以上，加成20%/30%/40%/50%。\n2、不同唤醒体或命轮的「活动加成」以叠加的方式结算。"
  },
  LanguageConfig_BonusRuleContent_GenesisTinctActivity_CN = {
    Text = "1、守密人拥有特定唤醒体或命轮（不要求上阵）可以使「临时文本」关卡任务报酬中的「临时文本」、「临时文本」、「临时文本」获得额外的掉落加成，具体加成如下：\n·唤醒体「暮星·汀克特」：启灵0/1/2/3及以上，加成20%/30%/40%/50%。\n·SSR命轮「临时文本」：叠位0/1/2/3及以上，加成20%/30%/40%/50%。\n·SR命轮「临时文本」：叠位0/1/2/3及以上，加成20%/30%/40%/50%。\n2、不同唤醒体或命轮的「活动加成」以叠加的方式结算。"
  },
  LanguageConfig_BonusRuleContent_HamelnActivity_CN = {
    Text = "1、守密人拥有特定唤醒体或命轮（不要求上阵）可以使「轰鸣之音」关卡任务报酬中的「高亢乐章」获得额外的掉落加成（包括重现），具体加成如下：\n·唤醒体「哈姆林」：启灵0/1/2/3及以上，加成20%/30%/40%/50%\n·SSR命轮「永恒安魂曲」：叠位0/1/2/3及以上，加成20%/30%/40%/50%\n·SR命轮「永不停歇的演奏」：叠位0/1/2/3及以上，加成20%/30%/40%/50%\n2、不同唤醒体或命轮的「乐章加成」以叠加的方式结算。"
  },
  LanguageConfig_BonusRuleContent_HorlaActivity_CN = {
    Text = "1、守密人拥有特定唤醒体或命轮（不要求上阵）可以使「花园往事」关卡任务报酬中的「惆怅的诗文」、「遗憾的诗文」、「欢欣的诗文」获得额外的掉落加成（包括重现），具体加成如下：\n·唤醒体「奥尔拉」：启灵0/1/2/3及以上，加成20%/30%/40%/50%\n·SSR命轮「诗笺的句尾」：叠位0/1/2/3及以上，加成20%/30%/40%/50%\n·SR命轮「往昔的花与诗」：叠位0/1/2/3及以上，加成20%/30%/40%/50%\n2、不同唤醒体或命轮的「诗文加成」以叠加的方式结算。"
  },
  LanguageConfig_BonusRuleContent_KathiguRaActivity_CN = {
    Text = "1、守密人拥有特定唤醒体或命轮（不要求上阵）可以使「烬灭追猎」关卡任务报酬中的「财富之「印」」、「死亡之「印」」、「战争之「印」」获得额外的掉落加成，具体加成如下：\n·唤醒体「凯蒂古拉」：启灵0/1/2/3及以上，加成20%/30%/40%/50%。\n·SSR命轮「琥珀色的死亡」：叠位0/1/2/3及以上，加成20%/30%/40%/50%。\n·SR命轮「迫近的太阳」：叠位0/1/2/3及以上，加成20%/30%/40%/50%。\n2、不同唤醒体或命轮的「活动加成」以叠加的方式结算。"
  },
  LanguageConfig_BonusRuleContent_LotanCetarchon_CN = {
    Text = "1、守密人拥有特定唤醒体或命轮（不要求上阵）可以使「贪戮角逐」关卡任务报酬中的「血色祭品」获得额外的掉落加成，具体加成如下：\n·唤醒体「蚀灭·萝坦」：启灵0/1/2/3及以上，加成20%/30%/40%/50%。\n·SSR命轮「天之陨」：叠位0/1/2/3及以上，加成20%/30%/40%/50%。\n·SR命轮「不灭的饥骨」：叠位0/1/2/3及以上，加成20%/30%/40%/50%。\n2、不同唤醒体或命轮的「活动加成」以叠加的方式结算。"
  },
  LanguageConfig_BonusRuleContent_MagicStoryActivity_CN = {
    Text = "1、守密人拥有特定唤醒体或命轮（不要求上阵）可以使「剧本迷思」关卡任务报酬中的「飘零的灵感」获得额外的掉落加成（包括重现），具体加成如下：\n·唤醒体「莉莉」：启灵0/1/2/3及以上，加成20%/30%/40%/50%\n·SSR命轮「跨越疼痛」：叠位0/1/2/3及以上，加成20%/30%/40%/50%\n·SR命轮「35mm的魔法」：叠位0/1/2/3及以上，加成20%/30%/40%/50%\n2、不同唤醒体或命轮的「灵感加成」以叠加的方式结算。"
  },
  LanguageConfig_BonusRuleContent_MiryamActivity_CN = {
    Text = "1、守密人拥有特定唤醒体或命轮（不要求上阵）可以使「神国诞临」关卡任务报酬中的「祀者之泪」、「祀者之血」、「祀者之髓」获得额外的掉落加成（包括重现），具体加成如下：\n·唤醒体「弥利亚姆」：启灵0/1/2/3及以上，加成20%/30%/40%/50%\n·SSR命轮「虔诚的伟力」：叠位0/1/2/3及以上，加成20%/30%/40%/50%\n·SR命轮「深海的呼唤」：叠位0/1/2/3及以上，加成20%/30%/40%/50%\n2、不同唤醒体或命轮的「祀物加成」以叠加的方式结算。"
  },
  LanguageConfig_BonusRuleContent_MoskActivity_CN = {
    Text = "1、守密人拥有特定唤醒体或命轮（不要求上阵）可以使「莫丝与海」关卡任务报酬中的「海螺一号」、「海螺二号」、「海螺三号」获得额外的掉落加成，具体加成如下：\n·唤醒体「莫丝」：启灵0/1/2/3及以上，加成20%/30%/40%/50%。\n·SSR命轮「渺远的伊甸园」：叠位0/1/2/3及以上，加成20%/30%/40%/50%。\n·SR命轮「被囚禁的疯狂」：叠位0/1/2/3及以上，加成20%/30%/40%/50%。\n2、不同唤醒体或命轮的「活动加成」以叠加的方式结算。"
  },
  LanguageConfig_BonusRuleContent_MouchetteActivity_CN = {
    Text = "1、守密人拥有特定唤醒体或命轮（不要求上阵）可以使「迷失的自我」关卡任务报酬中的「迷雾之视」、「迷雾之梦」、「迷雾之源」获得额外的掉落加成，具体加成如下：\n·唤醒体「茉夏」：启灵0/1/2/3及以上，加成20%/30%/40%/50%。\n·SSR命轮「狂戮至世界尽头」：叠位0/1/2/3及以上，加成20%/30%/40%/50%。\n·SR命轮「理智明灯」：叠位0/1/2/3及以上，加成20%/30%/40%/50%。\n2、不同唤醒体或命轮的「活动加成」以叠加的方式结算。"
  },
  LanguageConfig_BonusRuleContent_MurphyActivity_CN = {
    Text = "1、守密人拥有特定唤醒体或命轮（不要求上阵）可以使「黑暗子宫」关卡任务报酬中的「无识之胚」、「无欲之胚」、「无厌之胚」获得额外的掉落加成（包括重现），具体加成如下：\n·唤醒体「墨菲」：启灵0/1/2/3及以上，加成20%/30%/40%/50%\n·SSR命轮「隐秘的诞生」：叠位0/1/2/3及以上，加成20%/30%/40%/50%\n·SR命轮「冰川下的沉眠」：叠位0/1/2/3及以上，加成20%/30%/40%/50%\n2、不同唤醒体或命轮的「胚胎加成」以叠加的方式结算。"
  },
  LanguageConfig_BonusRuleContent_OriginDollActivity_CN = {
    Text = "1、守密人拥有特定唤醒体或命轮（不要求上阵）可以使「虚无之门」关卡任务报酬中的「人偶零件」获得额外的掉落加成（包括重现），具体加成如下：\n·唤醒体「熔毁·朵尔」：启灵0/1/2/3及以上，加成20%/30%/40%/50%\n·SSR命轮「坠入虚无的人偶」：叠位0/1/2/3及以上，加成20%/30%/40%/50%\n·SR命轮「牧羊人的手杖」：叠位0/1/2/3及以上，加成20%/30%/40%/50%\n2、不同唤醒体或命轮的「人偶零件加成」以叠加的方式结算。"
  },
  LanguageConfig_BonusRuleContent_OriginHelotActivity_CN = {
    Text = "1、守密人拥有特定唤醒体或命轮（不要求上阵）可以使「野兽雄心」关卡任务报酬中的「寒冻花苞」、「银霜花苞」、「日光花苞」获得额外的掉落加成（包括重现），具体加成如下：\n·唤醒体「血链·希洛」：启灵0/1/2/3及以上，加成20%/30%/40%/50%\n·SSR命轮「沉入殷红」：叠位0/1/2/3及以上，加成20%/30%/40%/50%\n·SR命轮「待到雪山消融」：叠位0/1/2/3及以上，加成20%/30%/40%/50%\n2、不同唤醒体或命轮的「花苞加成」以叠加的方式结算。"
  },
  LanguageConfig_BonusRuleContent_OriginMurphyActivity_CN = {
    Text = "1、守密人拥有特定唤醒体或命轮（不要求上阵）可以使「创生七日」关卡任务报酬中的「安神香薰」、「驱魇香薰」、「捕梦香薰」获得额外的掉落加成，具体加成如下：\n·唤醒体「诞妄·墨菲」：启灵0/1/2/3及以上，加成20%/30%/40%/50%。\n·SSR命轮「黑暗中的安眠」：叠位0/1/2/3及以上，加成20%/30%/40%/50%。\n·SR命轮「蓝环毒素」：叠位0/1/2/3及以上，加成20%/30%/40%/50%。\n2、不同唤醒体或命轮的「活动加成」以叠加的方式结算。"
  },
  LanguageConfig_BonusRuleContent_PickmanActivity_CN = {
    Text = "1、守密人拥有特定唤醒体或命轮（不要求上阵）可以使「异界图卷」关卡任务报酬中的「真实之染」、「幻梦之染」、「癫狂之染」获得额外的掉落加成，具体加成如下：\n·唤醒体「皮克曼」：启灵0/1/2/3及以上，加成20%/30%/40%/50%。\n·SSR命轮「写实主义悖谬」：叠位0/1/2/3及以上，加成20%/30%/40%/50%。\n·SR命轮「渴求的画笔」：叠位0/1/2/3及以上，加成20%/30%/40%/50%。\n2、不同唤醒体或命轮的「活动加成」以叠加的方式结算。"
  },
  LanguageConfig_BonusRuleContent_PolluxActivity_CN = {
    Text = "1、守密人拥有特定唤醒体或命轮（不要求上阵）可以使「极昼的终夜」关卡任务报酬中的「觐见奉礼」、「忏悔奉礼」、「忠诚奉礼」获得额外的掉落加成，具体加成如下：\n·唤醒体「波吕克斯」：启灵0/1/2/3及以上，加成20%/30%/40%/50%。\n·SSR命轮「扭曲的骑士诗」：叠位0/1/2/3及以上，加成20%/30%/40%/50%。\n·SR命轮「圣子尊容」：叠位0/1/2/3及以上，加成20%/30%/40%/50%。\n2、不同唤醒体或命轮的「活动加成」以叠加的方式结算。"
  },
  LanguageConfig_BonusRuleContent_PontosActivity_CN = {
    Text = "1、守密人拥有特定唤醒体或命轮（不要求上阵）可以使「高屋巡猎」关卡任务报酬中的「新鲜的「猎物」」「硕大的「猎物」」「古老的「猎物」」获得额外的掉落加成，具体加成如下：\n·唤醒体「庞托斯」：启灵0/1/2/3及以上，加成20%/30%/40%/50%。\n·SSR命轮「活囚笼」：叠位0/1/2/3及以上，加成20%/30%/40%/50%。\n·SR命轮「指向歧路的罗盘」：叠位0/1/2/3及以上，加成20%/30%/40%/50%。\n2、不同唤醒体或命轮的「活动加成」以叠加的方式结算。"
  },
  LanguageConfig_BonusRuleContent_RykerActivity_CN = {
    Text = "1、守密人拥有特定唤醒体或命轮（不要求上阵）可以使「月夜传说」关卡任务报酬中的「决胜筹码」获得额外的掉落加成（包括重现），具体加成如下：\n·唤醒体「莱克」：启灵0/1/2/3及以上，加成20%/30%/40%/50%\n·SSR命轮「好运时间」：叠位0/1/2/3及以上，加成20%/30%/40%/50%\n·SR命轮「命运轮盘赌」：叠位0/1/2/3及以上，加成20%/30%/40%/50%\n2、不同唤醒体或命轮的「筹码加成」以叠加的方式结算。"
  },
  LanguageConfig_BonusRuleContent_SalvadorActivity_CN = {
    Text = "1、守密人拥有特定唤醒体或命轮（不要求上阵）可以使「圣堂之路」关卡任务报酬中的「义卖券」获得额外的掉落加成（包括重现），具体加成如下：\n·唤醒体「萨尔瓦多」：启灵0/1/2/3及以上，加成20%/30%/40%/50%\n·SSR命轮「神言石板」：叠位0/1/2/3及以上，加成20%/30%/40%/50%\n·SR命轮「镜中人」：叠位0/1/2/3及以上，加成20%/30%/40%/50%\n2、不同唤醒体或命轮的「义卖券加成」以叠加的方式结算。"
  },
  LanguageConfig_BonusRuleContent_SayaActivity_CN = {
    Text = "1、守密人拥有特定唤醒体或命轮（不要求上阵）可以使「暗室手记」关卡任务报酬中的「纯白鳞粉」、「红色鳞粉」、「耀光鳞粉」获得额外的掉落加成，具体加成如下：\n·唤醒体「沙耶」：启灵0/1/2/3及以上，加成20%/30%/40%/50%。\n·SSR命轮「愿世界化作芬芳」：叠位0/1/2/3及以上，加成20%/30%/40%/50%。\n·SR命轮「淤泥里的童话」：叠位0/1/2/3及以上，加成20%/30%/40%/50%。\n2、不同唤醒体或命轮的「活动加成」以叠加的方式结算。"
  },
  LanguageConfig_BonusRuleContent_SorelActivity_CN = {
    Text = "1、守密人拥有特定唤醒体或命轮（不要求上阵）可以使「蔷薇忆事」关卡任务报酬中的「通灵鸟羽扇」获得额外的掉落加成（包括重现），具体加成如下：\n·唤醒体「索蕾尔」：启灵0/1/2/3及以上，加成20%/30%/40%/50%\n·SSR命轮「以蔷薇之名」：叠位0/1/2/3及以上，加成20%/30%/40%/50%\n·SR命轮「百万蒙宠之眼」：叠位0/1/2/3及以上，加成20%/30%/40%/50%\n2、不同唤醒体或命轮的「羽扇加成」以叠加的方式结算。"
  },
  LanguageConfig_BonusRuleContent_StElmosFireActivity_CN = {
    Text = "1、守密人拥有特定唤醒体或命轮（不要求上阵）可以使「邃海迷航」关卡任务报酬中的「信号旗」获得额外的掉落加成（包括重现），具体加成如下：\n·唤醒体「克珀珊特」：启灵0/1/2/3及以上，加成20%/30%/40%/50%\n·SSR命轮「圣火中的指引」：叠位0/1/2/3及以上，加成20%/30%/40%/50%\n·SR命轮「海上领航者」：叠位0/1/2/3及以上，加成20%/30%/40%/50%\n2、不同唤醒体或命轮的「活动加成」以叠加的方式结算。"
  },
  LanguageConfig_BonusRuleContent_Summer2Activity_CN = {
    Text = "1、守密人解锁「假日纪行」中的「高级纪行」，可在「日光下新事」关卡任务报酬中获得额外100%的「海滨特产贝壳」掉落（包括重现）。\n2、特别的，癫狂难度首通挑战奖励不会受到「活动加成」影响。"
  },
  LanguageConfig_BonusRuleContent_TaisuiActivity_CN = {
    Text = "1、守密人拥有特定唤醒体或命轮（不要求上阵）可以使「临时文本」关卡任务报酬中的「临时文本」获得额外的掉落加成，具体加成如下：\n·唤醒体「太岁」：启灵0/1/2/3及以上，加成20%/30%/40%/50%。\n·SSR命轮「临时文本」：叠位0/1/2/3及以上，加成20%/30%/40%/50%。\n·SR命轮「临时文本」：叠位0/1/2/3及以上，加成20%/30%/40%/50%。\n2、不同唤醒体或命轮的「活动加成」以叠加的方式结算。"
  },
  LanguageConfig_BonusRuleContent_TawilActivity_CN = {
    Text = "1、守密人拥有特定唤醒体或命轮（不要求上阵）可以使「最终测试」关卡任务报酬中的「终末指针」获得额外的掉落加成（包括重现），具体加成如下：\n·唤醒体「塔薇」：启灵0/1/2/3及以上，加成20%/30%/40%/50%\n·SSR命轮「隐世的转轮」：叠位0/1/2/3及以上，加成20%/30%/40%/50%\n·SR命轮「真理之门」：叠位0/1/2/3及以上，加成20%/30%/40%/50%\n2、不同唤醒体或命轮的「终末指针加成」以叠加的方式结算。"
  },
  LanguageConfig_BonusRuleContent_ThaisActivity_CN = {
    Text = "1、守密人拥有特定唤醒体或命轮（不要求上阵）可以使「紊乱情欲」关卡任务报酬中的「丰穰种核」获得额外的掉落加成（包括重现），具体加成如下：\n·唤醒体「泰旖丝」：启灵0/1/2/3及以上，加成20%/30%/40%/50%\n·SSR命轮「慈悲的哺育」：叠位0/1/2/3及以上，加成20%/30%/40%/50%\n·SR命轮「灼热的吻别」：叠位0/1/2/3及以上，加成20%/30%/40%/50%\n2、不同唤醒体或命轮的「强欲加成」以叠加的方式结算。"
  },
  LanguageConfig_BonusRuleContent_TuluActivity_CN = {
    Text = "1、守密人拥有特定唤醒体或命轮（不要求上阵）可以使「深海凝视」关卡任务报酬中的「惫倦绪思」、「悲愁绪思」、「欢悦绪思」获得额外的掉落加成（包括重现），具体加成如下：\n·唤醒体「图鲁」：启灵0/1/2/3及以上，加成20%/30%/40%/50%\n·SSR命轮「神王的颂歌」：叠位0/1/2/3及以上，加成20%/30%/40%/50%\n·SR命轮「青石王座」：叠位0/1/2/3及以上，加成20%/30%/40%/50%\n2、不同唤醒体或命轮的「绪思加成」以叠加的方式结算。"
  },
  LanguageConfig_BonusRuleContent_WandaActivity_CN = {
    Text = "1、守密人拥有特定唤醒体或命轮（不要求上阵）可以使「燃烧的群宴」关卡任务报酬中的「原生胫骨」、「圆叶菊石」、「螺旋遗迹」获得额外的掉落加成（包括重现），具体加成如下：\n·唤醒体「旺达」：启灵0/1/2/3及以上，加成20%/30%/40%/50%\n·SSR命轮「女王的戒律」：叠位0/1/2/3及以上，加成20%/30%/40%/50%\n·SR命轮「伊萨拉乌的目光」：叠位0/1/2/3及以上，加成20%/30%/40%/50%\n2、不同唤醒体或命轮的「奇珍加成」以叠加的方式结算。"
  },
  LanguageConfig_BonusRuleContent_XuActivity_CN = {
    Text = "1、守密人拥有特定唤醒体或命轮（不要求上阵）可以使「玄女无相」关卡任务报酬中的「梨膏糖」获得额外的掉落加成，具体加成如下：\n·唤醒体「徐」：启灵0/1/2/3及以上，加成20%/30%/40%/50%。\n·SSR命轮「枉蹙眉」：叠位0/1/2/3及以上，加成20%/30%/40%/50%。\n·SR命轮「玉兰之饵」：叠位0/1/2/3及以上，加成20%/30%/40%/50%。\n2、不同唤醒体或命轮的「活动加成」以叠加的方式结算。"
  },
  LanguageConfig_BonusRuleTitle_Activity_CN = {
    Text = "加成说明"
  },
  LanguageConfig_BonusTips_A24Activity_CN = {
    Text = "获得「记忆拼图」加成：<NetworkDelayGreen:{s1}>"
  },
  LanguageConfig_BonusTips_Activity_CN = {
    Text = "活动加成：<NetworkDelayGreen:{s1}>"
  },
  LanguageConfig_BonusTips_HamelnActivity_CN = {
    Text = "获得高亢乐章加成：<NetworkDelayGreen:{s1}>"
  },
  LanguageConfig_BonusTips_HorlaActivity_CN = {
    Text = "获得诗文加成：<NetworkDelayGreen:{s1}>"
  },
  LanguageConfig_BonusTips_MagicStoryActivity_CN = {
    Text = "获得灵感加成：<NetworkDelayGreen:{s1}>"
  },
  LanguageConfig_BonusTips_MiryamActivity_CN = {
    Text = "获得祀物加成：<NetworkDelayGreen:{s1}>"
  },
  LanguageConfig_BonusTips_MurphyActivity_CN = {
    Text = "获得胚胎加成：<NetworkDelayGreen:{s1}>"
  },
  LanguageConfig_BonusTips_OriginDollActivity_CN = {
    Text = "获得人偶零件加成：<NetworkDelayGreen:{s1}>"
  },
  LanguageConfig_BonusTips_OriginHelotActivity_CN = {
    Text = "获得花苞加成：<NetworkDelayGreen:{s1}>"
  },
  LanguageConfig_BonusTips_RykerActivity_CN = {
    Text = "获得筹码加成：<NetworkDelayGreen:{s1}>"
  },
  LanguageConfig_BonusTips_SalvadorActivity_CN = {
    Text = "获得义卖券加成：<NetworkDelayGreen:{s1}>"
  },
  LanguageConfig_BonusTips_SorelActivity_CN = {
    Text = "获得羽扇加成：<NetworkDelayGreen:{s1}>"
  },
  LanguageConfig_BonusTips_TawilActivity_CN = {
    Text = "获得终末指针加成：<NetworkDelayGreen:{s1}>"
  },
  LanguageConfig_BonusTips_ThaisActivity_CN = {
    Text = "强欲加成：<NetworkDelayGreen:{s1}>"
  },
  LanguageConfig_BonusTips_TuluActivity_CN = {
    Text = "获得绪思加成：<NetworkDelayGreen:{s1}>"
  },
  LanguageConfig_BonusTips_WandaActivity_CN = {
    Text = "获得奇珍加成：<NetworkDelayGreen:{s1}>"
  },
  LanguageConfig_BoutBloodSkillMaxTimesTips_CN = {
    Text = "本回合猩红熔炉不可再次使用"
  },
  LanguageConfig_BpRewardSourceName_CN = {
    Text = "核心课题"
  },
  LanguageConfig_BpUnPurchaseLevelClickTips_CN = {
    Text = "当前不可购买等级"
  },
  LanguageConfig_BreakThroughCondition_1_CN = {
    Text = "<Gray:条件一>"
  },
  LanguageConfig_BreakThroughCondition_2_CN = {
    Text = "<Gray:条件二>"
  },
  LanguageConfig_BreakThroughCondition_3_CN = {
    Text = "<Gray:条件三>"
  },
  LanguageConfig_BreakThrough_Btn_Str_CN = {Text = "升格"},
  LanguageConfig_BreakThrough_Completed_Deblock_Skill_Str_CN = {
    Text = "可激活新技能"
  },
  LanguageConfig_BreakThrough_Completed_Level_Str_CN = {
    Text = "Lv.{s1}/Lv.{s2}"
  },
  LanguageConfig_BreakThrough_Completed_Title_Str_CN = {
    Text = "升格成功"
  },
  LanguageConfig_BreakThrough_Detail_Btn_Str_CN = {Text = "升格"},
  LanguageConfig_BreakThrough_Detail_Deblock_Skill_Str_CN = {
    Text = "可激活新技能"
  },
  LanguageConfig_BreakThrough_Detail_Item_Str_CN = {
    Text = "升格材料"
  },
  LanguageConfig_BreakThrough_Detail_Level_Str_CN = {
    Text = "Lv.{s1}/Lv.{s2}"
  },
  LanguageConfig_BreakThrough_Detail_Unmet_Tips_CN = {
    Text = "材料不足，无法升格"
  },
  LanguageConfig_BreakThrough_PlayLevel_Requirement_CN = {
    Text = "守密人达到Lv.{s1}可升格"
  },
  LanguageConfig_BreakThrough_Preview_Btn_Str_CN = {Text = "领取"},
  LanguageConfig_BreakThrough_Preview_Completed_Tips_CN = {Text = "已升格"},
  LanguageConfig_BreakThrough_Preview_Completed_Tips_Str_CN = {
    Text = "奖励已领取"
  },
  LanguageConfig_BreakThrough_Preview_Item_Str_CN = {
    Text = "升格材料"
  },
  LanguageConfig_BreakThrough_Preview_Not_Completed_Tips_CN = {
    Text = "唤醒体达到Lv.{s1}且守密人达到Lv.{s2}可升格"
  },
  LanguageConfig_BreakThrough_Preview_Title_Str_CN = {
    Text = "升格预览"
  },
  LanguageConfig_BreakThrough_Skill_Active_Requirement_CN = {
    Text = "需要激活{s1}"
  },
  LanguageConfig_BreakThrough_Skill_Active_Success_CN = {
    Text = "激活成功"
  },
  LanguageConfig_BreakThrough_Skill_Block_Str_CN = {Text = "已满级"},
  LanguageConfig_BreakThrough_Skill_Deblock_Str_CN = {
    Text = "唤醒体升格至{s1}阶解锁"
  },
  LanguageConfig_BreakThrough_Task_Requirement_CN = {
    Text = "完成任一升格条件后可升格"
  },
  LanguageConfig_BreakThrough_Unmet_Tips_CN = {
    Text = "调查等级  {s1}级 解锁"
  },
  LanguageConfig_BreakthroughTitleText_CN = {
    Text = "升格{s1}阶"
  },
  LanguageConfig_BuffOffset_CN = {Text = "抵消"},
  LanguageConfig_Buff_Tips_Buff_CN = {Text = "Buff"},
  LanguageConfig_Buff_Tips_DeBuff_CN = {Text = "DeBuff"},
  LanguageConfig_Buff_Tips_DispelBuff_CN = {
    Text = "无法驱散"
  },
  LanguageConfig_Burning_Opera_01_CN = {
    Text = "整个剧院已被点燃…虽然火焰能赋予你力量，但要当心那些不断燃烧的卡牌！"
  },
  LanguageConfig_Buy_Jewel_Btn_Sure_CN = {Text = "返回"},
  LanguageConfig_Buy_Jewel_Str_Price_CN = {Text = "价格"},
  LanguageConfig_Buy_Jewel_Str_Title_CN = {
    Text = "购买银芯"
  },
  LanguageConfig_C05AFNotUseCard_CN = {
    Text = "黑印不足"
  },
  LanguageConfig_C15AFNotUseCard_CN = {
    Text = "银钥能量不足"
  },
  LanguageConfig_CanEquipOneSSRWeaonRuleDesc_CN = {
    Text = "同个唤醒体只能装备一个SSR命轮"
  },
  LanguageConfig_CanEquipTwoSSRWeaonRuleDesc_CN = {
    Text = "现在可以装备两个SSR命轮"
  },
  LanguageConfig_CancelAutoBattle_CN = {
    Text = "自动战斗已取消"
  },
  LanguageConfig_CancelSelectAllAwaker_CN = {
    Text = "全部取消"
  },
  LanguageConfig_CanceledText_CN = {Text = "已取消"},
  LanguageConfig_CardString_01_CN = {Text = "伤害"},
  LanguageConfig_CardString_02_CN = {Text = "能力"},
  LanguageConfig_CardString_03_CN = {Text = "状态"},
  LanguageConfig_CardString_04_CN = {Text = "技能"},
  LanguageConfig_CardString_05_CN = {Text = "症状"},
  LanguageConfig_CardString_06_CN = {Text = "护盾"},
  LanguageConfig_CardTip_Destroy_CN = {
    Text = "<CardTip:销毁>\n打出后，本卡将从卡组中永久移除。"
  },
  LanguageConfig_CardTip_Innate_CN = {
    Text = "<CardTip:固有>\n战斗开始时，本卡将出现在手卡中。"
  },
  LanguageConfig_CardTip_Metallicize_CN = {
    Text = "<CardTip:金属化>\n每回合结束时，获得等同于当前加护层数的护盾值。"
  },
  LanguageConfig_Card_Awaker_Select_CN = {
    Text = "选择能力"
  },
  LanguageConfig_Card_Bag_Title_CN = {Text = "指令卡"},
  LanguageConfig_Card_Select_Act_Tips1_CN = {
    Text = "选择 1 个行动意图"
  },
  LanguageConfig_Card_Select_Act_Tips2_CN = {
    Text = "选择 2 个行动意图"
  },
  LanguageConfig_Card_Select_CN = {
    Text = "选择 {s1} 张卡牌"
  },
  LanguageConfig_Card_Select_Copy_Tips1_CN = {
    Text = "选择 1 张牌进行复制"
  },
  LanguageConfig_Card_Select_Copy_Tips1_Ruins_CN = {
    Text = "选择 1 张牌降低算力消耗并获得共鸣效果"
  },
  LanguageConfig_Card_Select_Del_Tips1_CN = {
    Text = "选择 1 张牌删除"
  },
  LanguageConfig_Card_Select_Del_Tips1_Curse_CN = {
    Text = "选择 1 张症状卡删除"
  },
  LanguageConfig_Card_Select_Del_Tips1_Ruins_CN = {
    Text = "选择 1 张牌删除并获得共鸣效果"
  },
  LanguageConfig_Card_Select_Del_Tips1_UP_CN = {
    Text = "选择最多 1 张牌删除"
  },
  LanguageConfig_Card_Select_Del_Tips2_CN = {
    Text = "选择 2 张牌删除"
  },
  LanguageConfig_Card_Select_Del_Tips2_Curse_CN = {
    Text = "选择 2 张症状卡删除"
  },
  LanguageConfig_Card_Select_Del_Tips2_Ruins_CN = {
    Text = "选择 2 张牌删除并获得共鸣效果"
  },
  LanguageConfig_Card_Select_Del_Tips2_Up_CN = {
    Text = "选择最多 2 张牌删除"
  },
  LanguageConfig_Card_Select_Del_Tips3_CN = {
    Text = "选择 3 张牌删除"
  },
  LanguageConfig_Card_Select_Del_Tips4_Curse_CN = {
    Text = "选择 4 张症状卡删除"
  },
  LanguageConfig_Card_Select_Del_Tips5_Up_CN = {
    Text = "选择最多 5 张牌删除"
  },
  LanguageConfig_Card_Select_Del_Tips6_Curse_CN = {
    Text = "选择 6 张症状卡删除"
  },
  LanguageConfig_Card_Select_Del_Tips6_Curse_Up_CN = {
    Text = "选择最多 6 张症状卡删除"
  },
  LanguageConfig_Card_Select_Del_Tipskelaimenting_CN = {
    Text = "选择 1 张指令卡置入手中。"
  },
  LanguageConfig_Card_Select_Del_Tipsnaogang2_CN = {
    Text = "选择至多 3 张牌加入手中"
  },
  LanguageConfig_Card_Select_Del_Tipsnaogang_CN = {
    Text = "选择至多 2 张卡牌删除，将它们置入「备用脑缸」。"
  },
  LanguageConfig_Card_Select_Discard_Tips2_CN = {
    Text = "选择 2 张牌丢弃"
  },
  LanguageConfig_Card_Select_Get_Tips1_CN = {
    Text = "选择 1 张牌加入手中"
  },
  LanguageConfig_Card_Select_Get_Tips1_Ceremony_CN = {
    Text = "选择进行 1 项仪式"
  },
  LanguageConfig_Card_Select_Get_Tips1_KeeperSkill_CN = {
    Text = "选择 1 张钥令"
  },
  LanguageConfig_Card_Select_Get_Tips1_Use_CN = {
    Text = "选择 1 张牌使用"
  },
  LanguageConfig_Card_Select_Get_Tips1_jingji1_CN = {
    Text = "选择额外效果"
  },
  LanguageConfig_Card_Select_Get_Tips1_qianmian1_CN = {
    Text = "选择 1 张千面幻象加入手中"
  },
  LanguageConfig_Card_Select_Get_Tips1_qianmian2_CN = {
    Text = "选择为千面幻象附加额外效果"
  },
  LanguageConfig_Card_Select_Get_Tips2_CN = {
    Text = "选择 2 张牌加入手中"
  },
  LanguageConfig_Card_Select_Get_Tips33_CN = {
    Text = "选择至多 3 张牌加入手中"
  },
  LanguageConfig_Card_Select_Get_Tips3_CN = {
    Text = "选择 3 张牌加入手中"
  },
  LanguageConfig_Card_Select_Get_Tips_Caroboo_CN = {
    Text = "金币还是巧克力？考验你的眼力的时候到了~"
  },
  LanguageConfig_Card_Select_Get_Tips_GLY1_CN = {
    Text = "选择释放效果"
  },
  LanguageConfig_Card_Select_Get_Tips_ShiWen_CN = {
    Text = "选择释放效果"
  },
  LanguageConfig_Card_Select_Get_Tips_mofei_CN = {
    Text = "选择「算力」或「抽牌」"
  },
  LanguageConfig_Card_Select_Get_Tips_waiyu_CN = {
    Text = "选择「兴奋」或「诅咒」"
  },
  LanguageConfig_Card_Select_Get_Tipsbaiyin_CN = {
    Text = "选择 1 个普通的造物。"
  },
  LanguageConfig_Card_Select_Get_Tipsfengrang_CN = {
    Text = "选择 1 张手牌，将其 3 张复制洗入抽牌堆。"
  },
  LanguageConfig_Card_Select_Get_Tipshuangjin_CN = {
    Text = "选择 1 个稀有的造物。"
  },
  LanguageConfig_Card_Select_Get_Tipslamengna2_CN = {
    Text = "选择 1 张牌赋予「回声」刻印，其余卡牌置入弃牌堆。"
  },
  LanguageConfig_Card_Select_Get_Tipslamengna3_CN = {
    Text = "选择任意张卡牌弃置，抽取等量卡牌。"
  },
  LanguageConfig_Card_Select_Get_Tipslamengna4_CN = {
    Text = "选择 1 张卡牌，使其算力消耗-1。"
  },
  LanguageConfig_Card_Select_Get_Tipslamengna5_CN = {
    Text = "选择 1 张非衍生指令卡"
  },
  LanguageConfig_Card_Select_Get_Tipslamengna6_CN = {
    Text = "选择任意张卡牌弃置，每弃置 1 张临时暴击伤害+15％"
  },
  LanguageConfig_Card_Select_Get_Tipslamengna7_CN = {
    Text = "选择 1 张卡牌，将其临时复制置入手中并使其算力消耗-1。"
  },
  LanguageConfig_Card_Select_Get_Tipslamengna_CN = {
    Text = "选择 1 张牌加入手中，其余卡牌置入弃牌堆。"
  },
  LanguageConfig_Card_Select_Get_Tipslaxiang_CN = {
    Text = "选择 1 张手牌，使其算力消耗变为 0，"
  },
  LanguageConfig_Card_Select_Get_Tipslengcai_CN = {
    Text = "选择 1 个惊世的造物。"
  },
  LanguageConfig_Card_Select_Get_Tipspikeman1_CN = {
    Text = "选择 1 张卡牌置入手中，并为其赋予「消耗」和「保留」。"
  },
  LanguageConfig_Card_Select_Get_Tipspikeman2_CN = {
    Text = "选择并获取 1 个皮克曼创构的造物。"
  },
  LanguageConfig_Card_Select_Get_Tipstiaojiu1_CN = {
    Text = "选择 1 味调料，在本场战斗中将其永久置入「祭灵夜特调」。"
  },
  LanguageConfig_Card_Select_Get_Tipsxiaomao_CN = {
    Text = "选择 1 名唤醒体，将其支援卡置入手中。"
  },
  LanguageConfig_Card_Select_Get_Tipszhiyuan_CN = {
    Text = "选择 1 张支援卡加入手中。"
  },
  LanguageConfig_Card_Select_Get_Tipszhuiyi_CN = {
    Text = "选择 1 个追忆效果并释放。"
  },
  LanguageConfig_Card_Select_Get_Unit4BossBuff_CN = {
    Text = "选择获得 1 枚「圣象赐福」"
  },
  LanguageConfig_Card_Select_Get_Unit4BossDeBuff_CN = {
    Text = "选择 1 枚「圣象赐福」，将其反转为「诅咒」"
  },
  LanguageConfig_Card_Select_Get_tawil_CN = {
    Text = "选择 3 张指令卡将其消耗"
  },
  LanguageConfig_Card_Select_Puppet_Tips_CN = {
    Text = "选择 1 张卡牌，将其强制打出。"
  },
  LanguageConfig_Card_Select_Redraw_Tips3_CN = {
    Text = "最多丢弃 3 张并抽取等量卡牌"
  },
  LanguageConfig_Card_Select_Retain_Tips1_CN = {
    Text = "选择 1 张牌保留在手中"
  },
  LanguageConfig_Card_Select_Retain_Tips2_CN = {
    Text = "选择 1 张牌保留在手中，并使其算力消耗 -1"
  },
  LanguageConfig_Card_Select_Sell_Tips1_CN = {
    Text = "选择 1 张牌出售"
  },
  LanguageConfig_Card_Select_Tips1_CN = {
    Text = "选择 1 张卡牌"
  },
  LanguageConfig_Card_Select_Tips1_consume_CN = {
    Text = "选择 1 张卡牌消耗"
  },
  LanguageConfig_Card_Select_Tips1_cost1_CN = {
    Text = "选择 1 张卡牌使其算力消耗变为 1"
  },
  LanguageConfig_Card_Select_Tips1_hamulin_CN = {
    Text = "选择 1 个乐音并释放"
  },
  LanguageConfig_Card_Select_Tips1_huihuana_CN = {
    Text = "选择 1 张卡牌添加「回环乐音」"
  },
  LanguageConfig_Card_Select_Tips1_huihuanb_CN = {
    Text = "选择 2 张卡牌添加「回环乐音」"
  },
  LanguageConfig_Card_Select_Tips1_kelaimenting_CN = {
    Text = "选择将「共感」转化为「精神创伤」或「恐惧固着」。"
  },
  LanguageConfig_Card_Select_Tips1_tawei_CN = {
    Text = "选择 1 个「追忆」并触发其效果"
  },
  LanguageConfig_Card_Select_Tips1_xu_CN = {
    Text = "选择「相许」或「夺魄」。"
  },
  LanguageConfig_Card_Select_Tips_2ndAnniversaryBOSS_CN = {
    Text = "选择至多 3 张卡牌赋予「余波」"
  },
  LanguageConfig_Card_Select_Up_Tips1_CN = {
    Text = "选择 1 张已镶嵌刻印卡牌对其刻印升级"
  },
  LanguageConfig_Card_Select_Upyixiang_Tips1_CN = {
    Text = "选择 1 张意象升级"
  },
  LanguageConfig_Card_Select_yixiang_Tips1_CN = {
    Text = "选择获得 1 张意象"
  },
  LanguageConfig_Card_Tip_Ability_CN = {
    Text = "<CardTip:灵知觉醒>\n此效果一个唤醒体只能触发一次，无法叠加"
  },
  LanguageConfig_Card_Tip_Anger_CN = {
    Text = "<CardTip:巨刃之威>\n消耗2点算力，对所有敌人造成攻击力*200%伤害，力量在此伤害上发挥3倍效果。消耗。"
  },
  LanguageConfig_Card_Tip_Artifact_CN = {
    Text = "<CardTip:坚韧>\n每层坚韧可以免疫一次debuff"
  },
  LanguageConfig_Card_Tip_Blood_CN = {
    Text = "<CardTip:胚胎融合>\n胚胎融合到达上限时将一张能够强化血肉界域本源降临的胚胎置入手中。"
  },
  LanguageConfig_Card_Tip_Bramble_CN = {
    Text = "<CardTip:尖刺>\n受到攻击时对攻击者造成和尖刺层数相等的伤害。"
  },
  LanguageConfig_Card_Tip_CantRemove_CN = {
    Text = "<CardTip:无法被移除>\n在整场探索过程中，本卡无法从卡组中移除。"
  },
  LanguageConfig_Card_Tip_CardDestroy_CN = {
    Text = "<CardTip:销毁>\n整场探索过程中只能使用1次，打出后将从卡组中永久移除。"
  },
  LanguageConfig_Card_Tip_Condition_CN = {
    Text = "<CardTip:状态>\n战斗结束后此卡会被移出卡组。"
  },
  LanguageConfig_Card_Tip_Consume_CN = {
    Text = "<CardTip:消耗>\n在战斗结束前被移除出卡组。"
  },
  LanguageConfig_Card_Tip_Critical_CN = {
    Text = "暴击率：[critical]\n暴击伤害：[critical_damage]"
  },
  LanguageConfig_Card_Tip_Dexterity_CN = {
    Text = "<CardTip:戒备>\n增加从指令卡获得的护盾值。"
  },
  LanguageConfig_Card_Tip_Energy_CN = {
    Text = "开场获得能量:  [ene_init]\n能量自动回复:  [ene_passive]\n能量消耗降低:  [ene_return]"
  },
  LanguageConfig_Card_Tip_Ethereal_CN = {
    Text = "<CardTip:虚无>\n若本卡从手牌被弃掉或洗入牌库，将被消耗。"
  },
  LanguageConfig_Card_Tip_Fire_CN = {
    Text = "<CardTip:魂火>\n魂火会增加执守幼灵的<BuffTipDamage:伤害>量。"
  },
  LanguageConfig_Card_Tip_Frail_CN = {
    Text = "<CardTip:脆弱>\n获得的护盾值减少50%"
  },
  LanguageConfig_Card_Tip_Free_CN = {
    Text = "<CardTip:免算力>\n指令卡的算力花费变为0。"
  },
  LanguageConfig_Card_Tip_Goat_CN = {
    Text = "<CardTip:圣洁之子>\n0费，在手牌中时，每使用 1 张牌就变为其 0 费的复制。消耗，保留。"
  },
  LanguageConfig_Card_Tip_Innate_CN = {
    Text = "<CardTip:固有>\n战斗开始时，本卡将出现在手卡中。"
  },
  LanguageConfig_Card_Tip_LifeSteal_CN = {
    Text = "<CardTip:吸血>\n恢复与未被护盾的伤害值等量的生命值。"
  },
  LanguageConfig_Card_Tip_Marking_CN = {
    Text = "<CardTip:触腕标记>\n触腕将集中攻击最后被标记的对象。"
  },
  LanguageConfig_Card_Tip_Multiprotection_CN = {
    Text = "<CardTip:多重加护>\n回合结束时，获得等同当前加护层数的护盾值。每次受到伤害，加护减少1层。"
  },
  LanguageConfig_Card_Tip_NoDiscard_CN = {
    Text = "<CardTip:保留>\n保留的卡不会在回合结束时被放入弃卡堆。"
  },
  LanguageConfig_Card_Tip_Regenerate_CN = {
    Text = "<CardTip:再生>\n回合结束时，恢复等同于再生层数的生命。"
  },
  LanguageConfig_Card_Tip_Strength_CN = {
    Text = "<CardTip:力量>\n增加造成的伤害量。"
  },
  LanguageConfig_Card_Tip_TentacleStrength_CN = {
    Text = "<CardTip:触腕伤害>\n增加触腕造成的伤害量。"
  },
  LanguageConfig_Card_Tip_Useless_CN = {
    Text = "<CardTip:无法打出>\n本卡无法从手卡中打出。"
  },
  LanguageConfig_Card_Tip_Vnlnerable_CN = {
    Text = "<CardTip:易伤>\n受到的伤害量增加50%。"
  },
  LanguageConfig_Card_Tip_Weak_CN = {
    Text = "<CardTip:虚弱>\n造成的伤害量减少25%。"
  },
  LanguageConfig_Card_Tip_Wind_CN = {
    Text = "<CardTip:中毒>\n每次施加中毒时层数叠加。敌方回合结束时，目标受到等同于当前中毒层数的伤害。"
  },
  LanguageConfig_Card_Tip_Wing_CN = {
    Text = "<CardTip:附肢>\n附肢会增加神域秘守的<BuffTipDamage:伤害>量。"
  },
  LanguageConfig_Card_Tip_devour_CN = {
    Text = "<CardTip:吞噬>\n消耗手牌中的1个血肉胚胎，触发额外效果"
  },
  LanguageConfig_Card_Upgrade_CN = {Text = "强化"},
  LanguageConfig_Card_Upgrade_Desc_CN = {
    Text = "选择1张卡进行强化"
  },
  LanguageConfig_CellCardHint_CN = {
    Text = "被出售的卡牌将在本局调查中永久移除，请谨慎选择"
  },
  LanguageConfig_ChangeDress_CN = {Text = "换装"},
  LanguageConfig_ChangeGenderCost_CN = {
    Text = "本次需要消耗{s1}"
  },
  LanguageConfig_ChangeGenderFreeTips_CN = {
    Text = "首次免费"
  },
  LanguageConfig_ChaosSchool_RelicTips_CN = {
    Text = "选择获得造物"
  },
  LanguageConfig_Chaos_Tips_Title2_CN = {
    Text = "原初吐息"
  },
  LanguageConfig_Chaos_Tips_Title_CN = {
    Text = "银钥共鸣"
  },
  LanguageConfig_Chapter7Resonance1_1_CN = {
    Text = "和其他共鸣效果"
  },
  LanguageConfig_Chapter7Resonance1_2_CN = {
    Text = "，获得 3 个随机症状"
  },
  LanguageConfig_Chapter7Resonance1_3_CN = {Text = "1"},
  LanguageConfig_Chapter7Resonance1_4_CN = {Text = "2"},
  LanguageConfig_ChargeItemNoChargeTest_CN = {
    Text = "本次测试不开放充值功能"
  },
  LanguageConfig_Charge_NotOpen_CN = {
    Text = "充值暂未开放"
  },
  LanguageConfig_ChestPreviewTitle_CN = {
    Text = "素材预览"
  },
  LanguageConfig_ChestTypeName_CN = {Text = "宝箱"},
  LanguageConfig_ChooseItemForDecompose_CN = {
    Text = "尚未选择需要分解的材料"
  },
  LanguageConfig_ChooseModel_CN = {
    Text = "选择模式"
  },
  LanguageConfig_Choose_CN = {Text = "选择"},
  LanguageConfig_ClearCopy_Btn_CN = {
    Text = "扫荡{s1}次"
  },
  LanguageConfig_ClearCopy_Str_Title_CN = {
    Text = "重现奖励"
  },
  LanguageConfig_ClearCopy_Tips_CN = {
    Text = "用扫荡来快捷战斗吧！"
  },
  LanguageConfig_ClearCopy_Tips_Unlock_CN = {
    Text = "三星通关关卡后解锁"
  },
  LanguageConfig_CloseExpression_PVP_CN = {
    Text = "屏蔽互动"
  },
  LanguageConfig_CollaborationSubplotTipsText_CN = {
    Text = "<Title:多维连接>\n1、需要达成以下条件方可进行多维连接：\n·完成对应的调查行动；\n·消耗指定数量的「现实起点」解锁。\n2、当多维连接处于限时活动福利期内时，无需消耗「现实起点」即可免费解锁。活动结束后调查进度将保留。\n3、首次完成多维连接调查任务可以获得无垢之芯。"
  },
  LanguageConfig_CollaborationSubplotTipsTitle_CN = {
    Text = "规则说明"
  },
  LanguageConfig_CollectionBoxCollectCountdown_CN = {
    Text = "距离可领取：{s1}"
  },
  LanguageConfig_CollectionBoxFillUpCountdown_CN = {
    Text = "距离存储上限：{s1}"
  },
  LanguageConfig_CollectionBoxProduceSpeed_CN = {
    Text = "{s1}/小时"
  },
  LanguageConfig_CollectionHall_Progress_ActivityCG_CN = {
    Text = "活动收集"
  },
  LanguageConfig_CollectionHall_Progress_Creation_CN = {
    Text = "造物收集"
  },
  LanguageConfig_CollectionHall_Progress_Default_CN = {
    Text = "收集进度"
  },
  LanguageConfig_CollectionHall_Progress_Event_CN = {
    Text = "事件收集"
  },
  LanguageConfig_CollectionHall_Progress_Music_CN = {
    Text = "留声机收集"
  },
  LanguageConfig_CollectionHall_Progress_PromotionVideo_CN = {Text = "PV收集"},
  LanguageConfig_CollectionHall_Progress_RadioDrama_CN = {
    Text = "广播剧收集"
  },
  LanguageConfig_CollectionHall_Progress_Role_CN = {
    Text = "角色收集"
  },
  LanguageConfig_CollectionHall_Progress_ScenesCG_CN = {
    Text = "场景CG收集"
  },
  LanguageConfig_CollectionHall_Progress_StoryLineCG_CN = {
    Text = "剧情CG收集"
  },
  LanguageConfig_CollectionHall_Progress_Trinket_CN = {
    Text = "密契收集"
  },
  LanguageConfig_CollectionHall_Progress_Weapon_CN = {
    Text = "命轮收集"
  },
  LanguageConfig_CollectionHall_Progress_WorldView_CN = {
    Text = "洪积世界收集"
  },
  LanguageConfig_CollectionNumber_CN = {
    Text = "秘典书库藏品数"
  },
  LanguageConfig_CollectionUnlockItemTitle_CN = {Text = "解锁"},
  LanguageConfig_CollectionUnlockItem_CN = {
    Text = "解锁此背景动画需要<Blue:「{s1}」×{s2}>。\n解锁后可设置为宿舍背景。"
  },
  LanguageConfig_Collection_Reward_Desc_CN = {
    Text = "累计收集数量达到"
  },
  LanguageConfig_CombatEffectiveness_CN = {Text = "战力"},
  LanguageConfig_CommentDataNull_CN = {
    Text = "暂无评论"
  },
  LanguageConfig_CommonItemAchievement_CN = {Text = "成就"},
  LanguageConfig_CommonItemBattle_CN = {Text = "战斗"},
  LanguageConfig_CommonItemDailyFirst_CN = {
    Text = "本日首通"
  },
  LanguageConfig_CommonItemDoubleOutputActivity_CN = {Text = "福利"},
  LanguageConfig_CommonItemExplore_CN = {Text = "探索"},
  LanguageConfig_CommonItemFirst3Star_CN = {Text = "三星"},
  LanguageConfig_CommonItemFirst_CN = {Text = "首通"},
  LanguageConfig_CommonItemHide_CN = {Text = "隐藏"},
  LanguageConfig_CommonItemShop_CN = {
    Text = "弥萨格商店"
  },
  LanguageConfig_CommonItemTalent_CN = {Text = "共鸣"},
  LanguageConfig_CommonReceive_CN = {Text = "领取"},
  LanguageConfig_CommonTabAll_CN = {Text = "全部"},
  LanguageConfig_CommonTipsOwnedText_CN = {
    Text = "当前拥有：{s1}"
  },
  LanguageConfig_Common_Button_Confirm_CN = {Text = "确定"},
  LanguageConfig_CommonlyAssistCount_CN = {
    Text = "数量 <color=#ffffff>{s1}</color>/{s2}"
  },
  LanguageConfig_CommunityJumpTipsTitle_CN = {
    Text = "加入社区"
  },
  LanguageConfig_CommunityJumpTips_CN = {
    Text = "欢迎守密人加入社区"
  },
  LanguageConfig_CommunityJump_1_CN = {Text = "FaceBook"},
  LanguageConfig_CommunityJump_2_CN = {Text = "Discord"},
  LanguageConfig_CompilingShaders_CN = {
    Text = "正在编译着色器"
  },
  LanguageConfig_ComposeButtonText_CN = {Text = "合成"},
  LanguageConfig_ComposeTimes_CN = {
    Text = "合成数量"
  },
  LanguageConfig_ComposeTitle_CN = {
    Text = "材料合成"
  },
  LanguageConfig_CompositeRemainTips_CN = {
    Text = "剩余可合成次数：<color=#ffffff>{s1}</color>"
  },
  LanguageConfig_ComsumeSet_CN = {
    Text = "置换设置"
  },
  LanguageConfig_ConductPasswordBattle1_CN = {
    Text = "正在进行密码对战-预组模式…"
  },
  LanguageConfig_ConductPasswordBattle2_CN = {
    Text = "正在进行密码对战-轮选模式…"
  },
  LanguageConfig_ConfessionEventRulesDesc_CN = {
    Text = "<Title:规则说明>\n1、通关「调查行动」7-3·普通之后，全新特别调查内容「繁衍狂热」开放！\n2、受神秘力量影响，唤醒体们陷入了「繁衍狂热」状态……请各位守密人小心！\n3、当唤醒体的同调率达到 10 级后可以解锁该唤醒体的「繁衍狂热事件」，消耗 「现实起点」× 3 进行解锁，完成后可以获取「无垢之芯」× 1！"
  },
  LanguageConfig_ConfessionEventRulesTitle_CN = {
    Text = "规则说明"
  },
  LanguageConfig_ConfirmationNoLongerPromptsText_1_CN = {
    Text = "今日不再提醒"
  },
  LanguageConfig_ConfirmationNoLongerPromptsText_2_CN = {
    Text = "{s1}天内不再提醒"
  },
  LanguageConfig_ConitinueSurvey_CN = {
    Text = "继续调查"
  },
  LanguageConfig_ConsumeItemTypeName_CN = {Text = "消耗品"},
  LanguageConfig_Contact_Tips_1_CN = {
    Text = "已解锁1个造物保留格！"
  },
  LanguageConfig_ContainOneSchool_CN = {
    Text = "必须包含"
  },
  LanguageConfig_ContinueChanllengeBtnTxt_CN = {
    Text = "继续挑战"
  },
  LanguageConfig_ConvertedToFragment_CN = {Text = "已转换"},
  LanguageConfig_CopyAchievementBtnGroupName_CN = {
    Text = "关卡成就"
  },
  LanguageConfig_CopyCollectBtnGroupName_CN = {
    Text = "星级评分"
  },
  LanguageConfig_CopyLeftLineup_CN = {
    Text = "复制左侧阵容"
  },
  LanguageConfig_CopyLineup_CN = {
    Text = "复制阵容"
  },
  LanguageConfig_CopyPassword_CN = {
    Text = "复制 <color=#5EF2FF>相位值</color>"
  },
  LanguageConfig_CopyRecording_CN = {
    Text = "复制回放"
  },
  LanguageConfig_CopyResonanceBtnGroupName_CN = {Text = "共鸣"},
  LanguageConfig_CopyRightLineup_CN = {
    Text = "复制右侧阵容"
  },
  LanguageConfig_CopySettleNoData_CN = {
    Text = "暂未更新数据"
  },
  LanguageConfig_CopySettleTeamDataBlood_CN = {
    Text = "调查最后剩余血量"
  },
  LanguageConfig_CopySettleTeamDataResist_CN = {
    Text = "死亡抵抗触发次数"
  },
  LanguageConfig_CopySettleTeamDataRevival_CN = {
    Text = "应急灵知体使用次数"
  },
  LanguageConfig_CopySettleTeamDataRound_CN = {
    Text = "最终战回合数"
  },
  LanguageConfig_CopySettleTitle_CN = {
    Text = "调查数据"
  },
  LanguageConfig_CopySettleUncleared_CN = {Text = "未通关"},
  LanguageConfig_CopySweepBtnText_CN = {Text = "重现"},
  LanguageConfig_Copy_Lock_CN = {
    Text = "{s1}达到{s2}解锁{s3}"
  },
  LanguageConfig_Copy_Recommend_Level_CN = {
    Text = "推荐等级："
  },
  LanguageConfig_Copy_Recommend_School_CN = {
    Text = "推荐界域："
  },
  LanguageConfig_CosmeticsRandChestRateText_CN = {
    Text = "<Title:概率说明>\n1、每次使用后有 10% 的概率获得无形者礼券的「专属头像和对战表情」，90%的概率获得往期核心课题、相位对弈赛季的限定头像和对战表情。\n2、所有专属头像和对战表情均分 10% 概率。具体可查看下文的「专属头像和对战表情清单」。\n3、核心课题的限定头像和对战表情将在该期学期课题结束约 1 年后会加入掉落清单。相位对弈赛季奖励的对战表情则将在该赛季结束后立即加入掉落清单。\n4、所有往期限定头像和对战表情均分 90%的概率。特别的，「无形者的请柬」也视为 1 个往期限定头像和对战表情，当掉落清单中没有其他往期限定头像和对战表情时，此时「无形者的请柬」独占90%的概率。\n5、当获得已有的头像或表情时，将转换为「无形者的请柬」× 1。收集一定数量的「无形者的请柬」使用，可任选一个「无形者的礼券」中的未获得的头像或对战表情。\n\n<Title:专属头像和对战表情清单>\n1、专属头像包括：\n以银钥之名：艾尔瓦、以银钥之名：戈利亚、以银钥之名：尤乌哈希、以银钥之名：卡茜亚、以银钥之名：诃勒特、以银钥之名：德克斯特、以银钥之名：茜尔维亚、以银钥之名：威廉。\n2、专属对战表情包括：\n发疯弥萨格：尤乌哈希·我要、发疯弥萨格：布朗·不知道、发疯弥萨格：希洛·杀杀杀、轻松弥萨格：茜尔维亚·喝茶、轻松弥萨格：诃勒特·熬夜、轻松弥萨格：奥吉尔·敬礼、轻松弥萨格：萝坦·哥俩好、轻松弥萨格：拉蒙娜·扶额、轻松弥萨格：朵尔·电量不足、相位通讯：守密人·我？、智慧弥萨格：戈利亚·强、智慧弥萨格：雷娅·流泪、智慧弥萨格：诺缔拉·诶？、智慧弥萨格：詹金·思索、智慧弥萨格：阿格里帕·暗中观察、智慧弥萨格：凯刻斯·记仇、小小弥萨格：詹金·吐舌。"
  },
  LanguageConfig_CosmeticsRandChestRateTitle_CN = {
    Text = "概率说明"
  },
  LanguageConfig_CostTips_CN = {
    Text = "算力 +{s1}"
  },
  LanguageConfig_CounterTagAwaker_CN = {
    Text = "特攻唤醒体"
  },
  LanguageConfig_CoursePopMultiTipText_CN = {
    Text = "多个教学…"
  },
  LanguageConfig_CurUenergyValue_CN = {
    Text = "当前狂气值{s1}"
  },
  LanguageConfig_CurrRefineLevelEffect_CN = {
    Text = "当前效果"
  },
  LanguageConfig_CurrencyNotEnoughText_CN = {
    Text = "所需「源液」不足，是否前往源液提取？"
  },
  LanguageConfig_CurrencyNotEnoughTitle_CN = {
    Text = "源液不足"
  },
  LanguageConfig_CurrentLevelFavorability_1_CN = {
    Text = "（当前：{s1}）"
  },
  LanguageConfig_CurrentLevelFavorability_2_CN = {
    Text = "<TaskFinish:（当前：{s1}）>"
  },
  LanguageConfig_CurrentTrinketSet_CN = {
    Text = "当前方案：{s1}"
  },
  LanguageConfig_CutClass_Btn_Finish_CN = {
    Text = "今日已代理"
  },
  LanguageConfig_CutClass_Btn_NoRecord_CN = {
    Text = "暂无法代理"
  },
  LanguageConfig_CutClass_Btn_Normal_CN = {
    Text = "外勤代理"
  },
  LanguageConfig_D05EX_Activity_Card_Tips_CN = {
    Text = "面对猜疑，做出抉择"
  },
  LanguageConfig_D05EX_Activity_Light_String_CN = {
    Text = "，补充 3 名团员"
  },
  LanguageConfig_DBG_Sweep_Count_CN = {
    Text = "{s1}/{s2}张"
  },
  LanguageConfig_DFDESideDia10_CN = {
    Text = "一个「小礼物」，你会怎么选择呢？"
  },
  LanguageConfig_DFDESideDia11_CN = {
    Text = "拒绝女士的馈赠可是会变得不幸哦。"
  },
  LanguageConfig_DFDESideDia12_CN = {
    Text = "哎呀，似乎对现在的状况无效哦。"
  },
  LanguageConfig_DFDESideDia1_CN = {
    Text = "它为自己逝去的青春而愤怒。"
  },
  LanguageConfig_DFDESideDia2_CN = {
    Text = "终于把这个吵闹的东西送出去了。"
  },
  LanguageConfig_DFDESideDia3_CN = {
    Text = "不要直视它的眼眶。"
  },
  LanguageConfig_DFDESideDia4_CN = {
    Text = "它对猎物的体脂率有严格要求。"
  },
  LanguageConfig_DFDESideDia5_CN = {
    Text = "当心，它会吃掉你的脑子哦。"
  },
  LanguageConfig_DFDESideDia6_CN = {
    Text = "它对逝去之物情有独钟……"
  },
  LanguageConfig_DFDESideDia7_CN = {
    Text = "记录了弥萨格郊外一成不变的乏味风景。"
  },
  LanguageConfig_DFDESideDia8_CN = {
    Text = "教你如何抵挡「猎犬」袭击。"
  },
  LanguageConfig_DFDESideDia9_CN = {
    Text = "记录了拉蒙娜日常生活的绝版胶片。"
  },
  LanguageConfig_DaFuDaiErHuodong1_CN = {
    Text = "获得一张自定义的「禁忌的交易」。"
  },
  LanguageConfig_DailyChallengeAll_CN = {Text = "全部"},
  LanguageConfig_DailyChallengeAttrBonus_CN = {Text = "属性+50%"},
  LanguageConfig_DailyChallengeAwardIllustrateContent_CN = {
    Text = "1、根据今日通关幻梦深潜的最高难度决定次日获取的「融蚀之珠」奖励，各难度对应的奖励如下：\n·幻梦深潜Ⅰ：融蚀之珠*300\n·幻梦深潜Ⅱ：融蚀之珠*400\n·幻梦深潜Ⅲ：融蚀之珠*500\n·幻梦深潜Ⅳ：融蚀之珠*600\n·幻梦深潜Ⅴ：融蚀之珠*700\n·幻梦深潜Ⅵ：融蚀之珠*800\n·幻梦深潜Ⅶ：融蚀之珠*900\n·幻梦深潜·癫狂：融蚀之珠*900\n2、奖励将于次日通过结算邮件发送，请守密人记得查收。\n3、如果守密人在参与「幻梦深潜」或「外勤代理」当日同时参与了「相位对弈」，则次日9点结算的融蚀之珠奖励，将以每日幻梦奖励和「相位对弈」排行奖励中更高的融蚀之珠奖励为准。"
  },
  LanguageConfig_DailyChallengeAwardIllustrateTitle_CN = {
    Text = "规则说明"
  },
  LanguageConfig_DailyChallengeAwardPreviewTitle_CN = {
    Text = "奖励预览"
  },
  LanguageConfig_DailyChallengeAwardSendTimeText_CN = {
    Text = "奖励于次日%s发送至邮件"
  },
  LanguageConfig_DailyChallengeBloodDimension_CN = {
    Text = "血肉超维"
  },
  LanguageConfig_DailyChallengeBlood_CN = {
    Text = "至纯血肉"
  },
  LanguageConfig_DailyChallengeChallengeNoneText_CN = {
    Text = "今日尚无挑战记录"
  },
  LanguageConfig_DailyChallengeChaos_CN = {
    Text = "至纯混沌"
  },
  LanguageConfig_DailyChallengeChosenResonanceTitle_CN = {
    Text = "已选共鸣"
  },
  LanguageConfig_DailyChallengeChosenStar_CN = {
    Text = "当前星级"
  },
  LanguageConfig_DailyChallengeClearButton_CN = {Text = "清空"},
  LanguageConfig_DailyChallengeCountdown_Hour_CN = {
    Text = "每周试炼奖励重置： {s1}天{s2}小时"
  },
  LanguageConfig_DailyChallengeCountdown_Minute_CN = {
    Text = "每周试炼奖励重置： {s1}时{s2}分"
  },
  LanguageConfig_DailyChallengeCountdown_Week_CN = {
    Text = "本周排行奖励重置： {s1}"
  },
  LanguageConfig_DailyChallengeDimension_CN = {
    Text = "至纯超维"
  },
  LanguageConfig_DailyChallengeEmptyTips_CN = {
    Text = "暂无记录"
  },
  LanguageConfig_DailyChallengeEnterButtonGreyTips_CN = {
    Text = "请选择挑战共鸣项"
  },
  LanguageConfig_DailyChallengeEnterButton_CN = {Text = "挑战"},
  LanguageConfig_DailyChallengeExpAttenuationRulesTipsAlert_CN = {
    Text = "获得深潜经验降低"
  },
  LanguageConfig_DailyChallengeExpAttenuationRulesTipsTitle_CN = {
    Text = "规则说明"
  },
  LanguageConfig_DailyChallengeExpAttenuationRulesTips_CN = {
    Text = "·当「守密人等级」或「队伍平均等级」显著高于挑战关卡的推荐等级时，则获得深潜经验降低。"
  },
  LanguageConfig_DailyChallengeExpOutAttenuation_CN = {
    Text = "奖励衰减"
  },
  LanguageConfig_DailyChallengeExpOutBase_CN = {
    Text = "基础奖励"
  },
  LanguageConfig_DailyChallengeExpRewardCoefficientLevelTips_CN = {
    Text = "·若「守密人等级」与关卡的推荐等级相近，则挑战胜利即可完成深潜成就，获得「深潜经验」。\n   ·「挑战征程」：当挑战难度的「推荐等级」高于 「守密人等级」- 40 级 时，可获得基础深潜经验。\n   ·「超越征程」：当挑战难度的「推荐等级」高于 「守密人等级」- 20 级 时，可再额外获得一份基础深潜经验。"
  },
  LanguageConfig_DailyChallengeExpRewardTask1_CN = {
    Text = "挑战征程"
  },
  LanguageConfig_DailyChallengeExpRewardTask2_CN = {
    Text = "超越征程"
  },
  LanguageConfig_DailyChallengeInstructionsExample_CN = {
    Text = "（{s1}）「{s2}」：{s3}"
  },
  LanguageConfig_DailyChallengeInstructionsV2_CN = {
    Text = "<Title:【幻梦深潜】>\n·初始造物、关卡造物会在每周一9点(GMT+8)时发生变化。\n·每次挑战都会随机进入一个挑战场景。\n<Title:【深潜经验】>\n·若「守密人等级」与关卡的推荐等级相近，则挑战胜利即可完成深潜成就，获得「深潜经验」。\n   ·「挑战征程」：当挑战难度的「推荐等级」高于 「守密人等级」- 40 级 时，可获得基础深潜经验。\n   ·「超越征程」：当挑战难度的「推荐等级」高于 「守密人等级」- 20 级 时，可再额外获得一份基础深潜经验。\n<Title:【深潜等级】>\n·当深潜经验达到一定值时，深潜等级提升。每升一级都可以获得丰富的奖励。\n<Title:【赛季更新】>\n·一般情况下，赛季每 28 天重置。\n·调查结束会获得调查评分，每赛季会记录本赛季最高的调查评分用作当赛季排行，可重复调查以提高评分。当与其他守密人的调查评分相同时，将会视为同一名次。\n·赛季结束时会结算本赛季排名，并通过邮件发送本赛季排名奖励。守密人可以通过点击「排行榜」-「排行奖励」中查看排行奖励。\n·每个赛季均会有赛季任务，完成赛季任务即可获得丰富的奖励。赛季任务会在赛季结束时重置。\n<Title:【每赛季强化唤醒体】>\n·每赛季的每个界域会有两名随机唤醒体在本赛季的幻梦深潜行动中变得躁狂，因此其体质、攻击力、防御力提高50%。\n<Title:【调查评分】>\n·调查结束会用当前关卡的难度基础分跟完成的评分项进行结算，挑战越高难度时难度基础分越高。\n·下面是具体评分项。\n1、「时序沙漏」：初始回合为 50，每剩余 1 回合额外获得 20 分。\n2、「深渊呼唤」：使用 1 / 2 / 3 / 4 名强化唤醒体时出战时，获得 250 / 500 /750 / 1000 分。\n3、「幻境援救」：每使用 1 次应急灵知体，调查评分降低 20% ，多次触发多次乘算。\n4、「拓梦先驱」：每日首次游玩 获得 500 分。"
  },
  LanguageConfig_DailyChallengeInstructions_CN = {
    Text = "<Title:【幻梦深潜】>\n·初始造物、关卡造物会在每周一9点(GMT+8)时发生变化。\n·每次挑战都会随机进入一个挑战场景。\n<Title:【深潜经验】>\n·若「守密人等级」与关卡的推荐等级相近，则挑战胜利即可完成深潜成就，获得「深潜经验」。\n   ·「挑战征程」：当挑战难度的「推荐等级」高于 「守密人等级」- 40 级 时，可获得基础深潜经验。\n   ·「超越征程」：当挑战难度的「推荐等级」高于 「守密人等级」- 20 级 时，可再额外获得一份基础深潜经验。\n<Title:【深潜等级】>\n·当深潜经验达到一定值时，深潜等级提升。每升一级都可以获得丰富的奖励。\n<Title:【赛季更新】>\n·一般情况下，赛季每 28 天重置。\n·调查结束会获得调查评分，每赛季会记录本赛季最高的调查评分用作当赛季排行，可重复调查以提高评分。当与其他守密人的调查评分相同时，将会视为同一名次。\n·赛季结束时会结算本赛季排名，并通过邮件发送本赛季排名奖励。守密人可以通过点击「排行榜」-「排行奖励」中查看排行奖励。\n·每个赛季均会有赛季任务，完成赛季任务即可获得丰富的奖励。赛季任务会在赛季结束时重置。\n<Title:【每赛季强化唤醒体】>\n·每赛季的每个界域会有两名随机唤醒体在本赛季的幻梦深潜行动中变得躁狂，因此其体质、攻击力、防御力提高50%。\n<Title:【调查评分】>\n·调查结束会用当前关卡的难度基础分跟完成的评分项进行结算，挑战越高难度时难度基础分越高。\n·下面是具体评分项。\n1、「时序沙漏」：初始回合为 50，每剩余 1 回合额外获得 20 分。\n2、「深渊呼唤」：使用 1/2 名强化唤醒体时出战时，获得 250 / 500 分。\n3、「幻境援救」：每使用 1 次应急灵知体，调查评分降低 20% ，多次触发多次乘算。\n4、「拓梦先驱」：每日首次游玩 获得 500 分。"
  },
  LanguageConfig_DailyChallengeLevel_CN = {Text = "{s1}级"},
  LanguageConfig_DailyChallengeLimitedDoubleLessTip_CN = {Text = "双倍"},
  LanguageConfig_DailyChallengeLimitedDoubleShortTip_CN = {
    Text = "限时双倍"
  },
  LanguageConfig_DailyChallengeLimitedDoubleTip_CN = {
    Text = "限时双倍经验"
  },
  LanguageConfig_DailyChallengeLiquidation_CN = {
    Text = "排行榜结算中…"
  },
  LanguageConfig_DailyChallengeLockedResonanceTips_CN = {
    Text = "完成上级共鸣挑战解锁"
  },
  LanguageConfig_DailyChallengeMagnificationDescribe_CN = {
    Text = "当前调查评分倍率×{s1}，最终评分以调查完成为准"
  },
  LanguageConfig_DailyChallengeOceanBlood_CN = {
    Text = "深海血肉"
  },
  LanguageConfig_DailyChallengeOceanDimension_CN = {
    Text = "深海超维"
  },
  LanguageConfig_DailyChallengeOcean_CN = {
    Text = "至纯深海"
  },
  LanguageConfig_DailyChallengeRankingRuleDesc_CN = {
    Text = "1、调查头衔的排名区间会根据参与总人数动态变化，比例如下：\n·幻梦传奇：前0.2%\n·幻梦主宰：0.2%~1%\n·深潜大师：1%~5%\n·深潜学者：5%~15%\n·梦境学徒：15%~35%\n·潜游新手：35%~75%\n·失眠病患：75%后\n2、当出现与其他守密人同分的情况时，排名会按照挑战时间进行先后排序，但排行奖励将以此分的最高排名为准。"
  },
  LanguageConfig_DailyChallengeRankingRuleTitle_CN = {
    Text = "排行规则"
  },
  LanguageConfig_DailyChallengeResonanceSelectTips_CN = {
    Text = "请从右侧选择共鸣"
  },
  LanguageConfig_DailyChallengeResonanceSelectTitle_CN = {
    Text = "可选共鸣"
  },
  LanguageConfig_DailyChallengeRewardButtonText_CN = {
    Text = "奖励规则"
  },
  LanguageConfig_DailyChallengeRewardCount_CN = {
    Text = "累计奖励{s1}/{s2}"
  },
  LanguageConfig_DailyChallengeRewardPreview_CN = {
    Text = "奖励预览"
  },
  LanguageConfig_DailyChallengeRewardTips_1_CN = {
    Text = "选择更高的挑战难度以获得更多奖励"
  },
  LanguageConfig_DailyChallengeRewardTips_2_CN = {
    Text = "已获得所有奖励"
  },
  LanguageConfig_DailyChallengeRewardTips_CN = {
    Text = "挑战难度达到"
  },
  LanguageConfig_DailyChallengeRightWeeklyTitle_CN = {
    Text = "本周深潜记录"
  },
  LanguageConfig_DailyChallengeRules_CN = {
    Text = "深潜规则"
  },
  LanguageConfig_DailyChallengeScoreBase_CN = {
    Text = "难度基础分： <OptionHighlight_Dadly: {s1}>"
  },
  LanguageConfig_DailyChallengeScoreMultiple_CN = {
    Text = "评分倍率 <OptionHighlight_Dadly:× {s1}>"
  },
  LanguageConfig_DailyChallengeStarAwardShort_CN = {
    Text = "还差{s1}<Star>获得下阶段奖励"
  },
  LanguageConfig_DailyChallengeStarAward_CN = {Text = "{s1}/{s2}"},
  LanguageConfig_DailyChallengeTips_CN = {
    Text = "幕间演习：所有唤醒体等级、技能等级、调整为 1 级，造物的强度与守密人调查等级为 1 时的强度一致。"
  },
  LanguageConfig_DailyChallengeTodayRelicGetConfirmButton_CN = {Text = "确定"},
  LanguageConfig_DailyChallengeTodayRelicGetTitle_CN = {
    Text = "获得每日造物"
  },
  LanguageConfig_DailyChallengeTodayRelicTitle_CN = {
    Text = "本日造物"
  },
  LanguageConfig_DailyChallengeTodayStarTitle_CN = {
    Text = "本日最高星级"
  },
  LanguageConfig_DailyChallengeUnlockNewResonanceConfirmButton_CN = {Text = "确定"},
  LanguageConfig_DailyChallengeUnlockNewResonanceTitle_CN = {
    Text = "解锁新共鸣"
  },
  LanguageConfig_DailyChallenge_CN = {
    Text = "融珠兑换"
  },
  LanguageConfig_DailyChallenge_CurrentProgress_CN = {
    Text = "(当前：{s1})"
  },
  LanguageConfig_DailyChallengexSettlementBasicScoreTips_CN = {
    Text = "根据所挑战的关卡难度获得的难度基础分数"
  },
  LanguageConfig_DailyChallengexSettlementBasicScoreTitle_CN = {
    Text = "基础分数"
  },
  LanguageConfig_DailyCopyChallengeBtnText_CN = {Text = "挑战"},
  LanguageConfig_DailyCopyRules_CN = {
    Text = "1、融蚀之墟内通关对应的关卡后可获得大量唤醒体升格素材、「灵知制剂」和「蔷薇金券」!\n2、完成关卡挑战后解锁重现，重现可以立即获得该关卡的任务报酬。每次重现需消耗等同于进行调查所需的「灵啡肽」。\n3、在调查等级达到 20 级后解锁技能素材关卡。\n4、若三星通关高难度关卡，则较低难度的关卡挑战进度会自动标记为三星通关。"
  },
  LanguageConfig_DailyCopy_Start_CN = {Text = "挑战"},
  LanguageConfig_DailyCopy_Str_Blood_Title_CN = {
    Text = "器质残像"
  },
  LanguageConfig_DailyCopy_Str_Dialog_CN = {
    Text = "攻略关卡后，可以获取材料\n能拿的东西，当然全部拿光"
  },
  LanguageConfig_DailyCopy_Str_Dimension_Title_CN = {
    Text = "维度残像"
  },
  LanguageConfig_DailyCopy_Str_Money_Exp_CN = {
    Text = "制剂淬炼"
  },
  LanguageConfig_DailyCopy_Str_Money_Title_CN = {
    Text = "金券搜查"
  },
  LanguageConfig_DailyCopy_Str_Ocean_Title_CN = {
    Text = "海渊残像"
  },
  LanguageConfig_DailyCopy_Str_Title_CN = {
    Text = "融蚀之墟"
  },
  LanguageConfig_DailyCopy_Str_TrinketCopy_CN = {
    Text = "攻略关卡后，可以获取密契\n能拿的东西，当然全部拿光"
  },
  LanguageConfig_DailyHistoryLevelViewTitle_DailyChallenge_CN = {
    Text = "深潜奖励"
  },
  LanguageConfig_DailyHistoryLevelViewTitle_DailyChallenge_ExpProgress_CN = {
    Text = "深潜经验{s1}"
  },
  LanguageConfig_DailyResetTips_CN = {
    Text = "每日刷新，回到主界面"
  },
  LanguageConfig_Daily_First_Finish_CN = {
    Text = "首次通关"
  },
  LanguageConfig_Daily_First_Finish_Tips_CN = {
    Text = "通关后获得下阶段奖励"
  },
  LanguageConfig_DataStatistics_CN = {
    Text = "数据统计"
  },
  LanguageConfig_DataTransmissionTips_CN = {
    Text = "数据传输中，请稍后"
  },
  LanguageConfig_DateFormat_CN = {
    Text = ": {s1}~{s2}"
  },
  LanguageConfig_DayChallengeOptionalDifficuly1_10_CN = {
    Text = "敌人生命 +750%"
  },
  LanguageConfig_DayChallengeOptionalDifficuly1_11_CN = {
    Text = "敌人生命 +1000%"
  },
  LanguageConfig_DayChallengeOptionalDifficuly1_12_CN = {
    Text = "敌人生命 +1100%"
  },
  LanguageConfig_DayChallengeOptionalDifficuly1_13_CN = {
    Text = "敌人生命 +1200%"
  },
  LanguageConfig_DayChallengeOptionalDifficuly1_14_CN = {
    Text = "敌人生命 +1300%"
  },
  LanguageConfig_DayChallengeOptionalDifficuly1_15_CN = {
    Text = "敌人生命 +1400%"
  },
  LanguageConfig_DayChallengeOptionalDifficuly1_16_CN = {
    Text = "敌人生命 +1500%"
  },
  LanguageConfig_DayChallengeOptionalDifficuly1_1_CN = {
    Text = "无额外难度加成"
  },
  LanguageConfig_DayChallengeOptionalDifficuly1_2_CN = {
    Text = "敌人生命 +25%"
  },
  LanguageConfig_DayChallengeOptionalDifficuly1_3_CN = {
    Text = "敌人生命 +75%"
  },
  LanguageConfig_DayChallengeOptionalDifficuly1_4_CN = {
    Text = "敌人生命 +125%"
  },
  LanguageConfig_DayChallengeOptionalDifficuly1_5_CN = {
    Text = "敌人生命 +200%"
  },
  LanguageConfig_DayChallengeOptionalDifficuly1_6_CN = {
    Text = "敌人生命 +275%"
  },
  LanguageConfig_DayChallengeOptionalDifficuly1_7_CN = {
    Text = "敌人生命 +350%"
  },
  LanguageConfig_DayChallengeOptionalDifficuly1_8_CN = {
    Text = "敌人生命 +450%"
  },
  LanguageConfig_DayChallengeOptionalDifficuly1_9_CN = {
    Text = "敌人生命 +600%"
  },
  LanguageConfig_DayChallengeOptionalDifficuly2_10_CN = {
    Text = "敌人伤害 +150%"
  },
  LanguageConfig_DayChallengeOptionalDifficuly2_11_CN = {
    Text = "敌人伤害 +200%"
  },
  LanguageConfig_DayChallengeOptionalDifficuly2_12_CN = {
    Text = "敌人伤害 +220%"
  },
  LanguageConfig_DayChallengeOptionalDifficuly2_13_CN = {
    Text = "敌人伤害 +240%"
  },
  LanguageConfig_DayChallengeOptionalDifficuly2_14_CN = {
    Text = "敌人伤害 +260%"
  },
  LanguageConfig_DayChallengeOptionalDifficuly2_15_CN = {
    Text = "敌人伤害 +280%"
  },
  LanguageConfig_DayChallengeOptionalDifficuly2_16_CN = {
    Text = "敌人伤害 +300%"
  },
  LanguageConfig_DayChallengeOptionalDifficuly2_1_CN = {
    Text = "无额外难度加成"
  },
  LanguageConfig_DayChallengeOptionalDifficuly2_2_CN = {
    Text = "敌人伤害 +5%"
  },
  LanguageConfig_DayChallengeOptionalDifficuly2_3_CN = {
    Text = "敌人伤害 +15%"
  },
  LanguageConfig_DayChallengeOptionalDifficuly2_4_CN = {
    Text = "敌人伤害 +25%"
  },
  LanguageConfig_DayChallengeOptionalDifficuly2_5_CN = {
    Text = "敌人伤害 +40%"
  },
  LanguageConfig_DayChallengeOptionalDifficuly2_6_CN = {
    Text = "敌人伤害 +55%"
  },
  LanguageConfig_DayChallengeOptionalDifficuly2_7_CN = {
    Text = "敌人伤害 +70%"
  },
  LanguageConfig_DayChallengeOptionalDifficuly2_8_CN = {
    Text = "敌人伤害 +90%"
  },
  LanguageConfig_DayChallengeOptionalDifficuly2_9_CN = {
    Text = "敌人伤害 +120%"
  },
  LanguageConfig_Day_CN = {Text = "天"},
  LanguageConfig_DeathResistFail_CN = {
    Text = "<color=#FF7370>死亡抵抗失败</color>"
  },
  LanguageConfig_DeathResist_1_CN = {
    Text = "死亡抵抗！"
  },
  LanguageConfig_DeathResistance_CN = {
    Text = "<color=#E3FFE3>死亡抵抗</color>"
  },
  LanguageConfig_DecomposeButtonText_CN = {Text = "分解"},
  LanguageConfig_DecomposeTimes_CN = {
    Text = "分解数量"
  },
  LanguageConfig_DecomposeTitle_CN = {
    Text = "命轮分解"
  },
  LanguageConfig_DeepSeaInvasionDefensiveActiviityTips10_CN = {
    Text = "已获得等级补偿"
  },
  LanguageConfig_DeepSeaInvasionDefensiveActiviityTips11_CN = {
    Text = "已获得等级修正"
  },
  LanguageConfig_DeepSeaInvasionDefensiveActiviityTips12_CN = {
    Text = "已获得等级修正"
  },
  LanguageConfig_DeepSeaInvasionDefensiveActiviityTips13_CN = {
    Text = "在「猫海淘银」中有等级补偿机制，以便各位守密人能够共同进行抓捕！\n等级补偿规则如下：\n·调查队伍中，等级不足 60 级的唤醒体在本次挑战中将会补偿至 60 级。\n·调查队伍中，技能等级不足 5 级的唤醒体在本次挑战中将会补偿至 5 级。\n·调查队伍中，「疯狂预兆」不足 6 级的唤醒体在本次挑战中将会补偿至 6 级。\n·调查队伍中，「灵塑适性」不足 5 级的唤醒体在本次挑战中将会补偿至 5 级。\n ·若守密人等级不足60级，在本次挑战中将会补偿至60级。"
  },
  LanguageConfig_DeepSeaInvasionDefensiveActiviityTips14_CN = {
    Text = "该异动海潮的集群已被消灭，无法继续挑战"
  },
  LanguageConfig_DeepSeaInvasionDefensiveActiviityTips15_CN = {
    Text = "所有异动海潮集群已被消灭，无法继续挑战"
  },
  LanguageConfig_DeepSeaInvasionDefensiveActiviityTips1_CN = {
    Text = "与其他守密人共同作战，获取珍稀奖励"
  },
  LanguageConfig_DeepSeaInvasionDefensiveActiviityTips2_CN = {
    Text = "所有异动海潮集群已被消灭"
  },
  LanguageConfig_DeepSeaInvasionDefensiveActiviityTips3_CN = {
    Text = "进入挑战"
  },
  LanguageConfig_DeepSeaInvasionDefensiveActiviityTips4_CN = {
    Text = "今日挑战 {s1}"
  },
  LanguageConfig_DeepSeaInvasionDefensiveActiviityTips5_CN = {
    Text = "世界BOSS进度"
  },
  LanguageConfig_DeepSeaInvasionDefensiveActiviityTips6_CN = {Text = "{s1}/7"},
  LanguageConfig_DeepSeaInvasionDefensiveActiviityTips7_CN = {
    Text = "今日挑战 {s1}"
  },
  LanguageConfig_DeepSeaInvasionDefensiveActiviityTips8_CN = {
    Text = "今日挑战 {s1}"
  },
  LanguageConfig_DeepSeaInvasionDefensiveActiviityTips9_CN = {
    Text = "等级补偿"
  },
  LanguageConfig_DefaultName_CN = {
    Text = "西维斯特"
  },
  LanguageConfig_DefaultWord_CN = {Text = "默认"},
  LanguageConfig_DerivedCardDesc_CN = {
    Text = "衍生卡说明"
  },
  LanguageConfig_DestroyWeapon_CN = {
    Text = "摧毁命轮"
  },
  LanguageConfig_Dev_EnterAccount_CN = {
    Text = "请输入账号"
  },
  LanguageConfig_Dev_SelectServer_CN = {
    Text = "请选择服务器"
  },
  LanguageConfig_DevelopVersionShowText_CN = {
    Text = "Res: {s1}.{s2}.{s3}.{s4}"
  },
  LanguageConfig_DiamondDonateDesc_CN = {
    Text = "您捐献的每滴源液都弥足珍贵，它们会投入融蚀研究和校舍建设中，化作弥萨格的一部分，与各位一同奔赴那个不被遗忘的未来。\n愿银钥指引我们。"
  },
  LanguageConfig_DiamondDonateTipContent_CN = {
    Text = "<Title:捐献规则>\n·通过「源液捐献」消耗的「源液」都会计入累计捐献值。\n·此外，在「唤醒」中「银芯」不足时直接捐献的源液也会计入。\n<Title:奖励规则>\n·每捐献 1 滴「源液」对应获得 1 点贡献值。\n·贡献值每达到 2500 可获得 1 份特别回馈。\n·每 20 份回馈为一轮循环。\n·每轮循环总计回馈包括：「精粹原初灵核」×1、「原初灵核」×3、「贤者之石」×6、「追念羽笔」×800、「无形者的礼券」×100、「千面印章」×5000、「蔷薇金券」×50000000。"
  },
  LanguageConfig_DiamondDonateTipTitle_CN = {
    Text = "规则说明"
  },
  LanguageConfig_DiamondShop_Str_Title_CN = {
    Text = "购买银芯"
  },
  LanguageConfig_DimensionAbilityCoolDown_CN = {
    Text = "「湮灭」冷却中，无法使用，还需冷却 {s1} 回合"
  },
  LanguageConfig_DisasterReliefKuroshioEntryNameFormat_CN = {Text = "{s1}·{s2}"},
  LanguageConfig_DisasterReliefKuroshioTipsDesc_CN = {
    Text = "请守密人留意，随着调查深入推进，融灾黑潮的环境特征不同，且会对特定区域造成影响"
  },
  LanguageConfig_DisasterReliefKuroshio_CN = {
    Text = "融灾黑潮"
  },
  LanguageConfig_DispatchAgain_CN = {
    Text = "再次派遣"
  },
  LanguageConfig_DispatchClear_CN = {Text = "清空"},
  LanguageConfig_DispatchClose_CN = {Text = "关闭"},
  LanguageConfig_DispatchNoReceiveTask_CN = {
    Text = "暂无已完成的派遣任务"
  },
  LanguageConfig_DispatchNormal_CN = {Text = "派遣"},
  LanguageConfig_DispatchOneClickFormation_CN = {
    Text = "快捷上阵"
  },
  LanguageConfig_DispatchReceiveAll_CN = {
    Text = "一键领取"
  },
  LanguageConfig_DispatchSucessfulTip_CN = {
    Text = "派遣成功"
  },
  LanguageConfig_Dispel_Tips_CN = {Text = "驱散{s1}"},
  LanguageConfig_DissolutionJewelShopRules_CN = {
    Text = "1、守密人可以通过消耗一定的「融蚀之珠」兑换商品。\n2、当守密人调查等级提升时，融珠兑换商店会随之升级并解锁新内容。\n3、融珠兑换商店内的商品每隔一定的时间会自动刷新库存。\n4、守密人可以通过「常训任务：每周试炼」来获得「融蚀之珠」。"
  },
  LanguageConfig_Dot_CN = {Text = "。"},
  LanguageConfig_DoubleExperience_01_CN = {
    Text = "双倍经验"
  },
  LanguageConfig_DoubleExperience_02_CN = {Text = "额外"},
  LanguageConfig_DoubleExperience_03_CN = {
    Text = "双倍课题经验"
  },
  LanguageConfig_DoubleKill_CN = {Text = "双杀！"},
  LanguageConfig_DoubleOutputActivityBonusHead_CN = {
    Text = "奖励+100%"
  },
  LanguageConfig_DoubleOutputActivityRemainTimes_CN = {
    Text = "剩余{s1}次"
  },
  LanguageConfig_DoubleOutputActivityStageTips_CN = {
    Text = "今日剩余双倍奖励次数：<DoubleOutputActivityTimes:{s1}/{s2}>"
  },
  LanguageConfig_DoubleOutputActivityTimesHead_CN = {
    Text = "今日奖励额外+{s1}%"
  },
  LanguageConfig_DoubleOutputActivityTimesRunOut_CN = {
    Text = "今日双倍奖励次数已耗尽"
  },
  LanguageConfig_DoubleOutputActivityTimes_CN = {
    Text = "今日额外奖励+50%"
  },
  LanguageConfig_DownloadStorageSpaceTips_CN = {
    Text = "存储空间不足，需要预留至少{s1}存储空间，否则运行时可能导致资源丢失"
  },
  LanguageConfig_DrawEmptyStr_CN = {
    Text = "已获取所有奖励"
  },
  LanguageConfig_DrawOneStr_CN = {Text = "抽取1次"},
  LanguageConfig_DressingWord_CN = {Text = "着装中"},
  LanguageConfig_DropItemTypeName_CN = {Text = "礼盒"},
  LanguageConfig_DynamicStageRuleDesc_CN = {
    Text = "·该关卡难度与守密人等级有关。守密人等级越高，敌人越强，通关后获得的蔷薇金券、灵知制剂、同调率奖励也会少量提高。"
  },
  LanguageConfig_DynamicStageRuleTitle_CN = {
    Text = "规则说明"
  },
  LanguageConfig_EffectDescription_CN = {
    Text = "效果说明"
  },
  LanguageConfig_EmojiCommonDesc_CN = {Text = "[表情]"},
  LanguageConfig_EnchantDesc_CN = {
    Text = "刻印说明"
  },
  LanguageConfig_EnchantGroup_1_CN = {Text = "刻印"},
  LanguageConfig_EnchantGroup_2_CN = {
    Text = "特殊刻印"
  },
  LanguageConfig_EnchantStoreTitle_CN = {
    Text = "刻印融痕"
  },
  LanguageConfig_EnchantmentAwardButton_CN = {Text = "刻印"},
  LanguageConfig_EnchantmentAwardFull_CN = {
    Text = "所有卡牌均已镶嵌刻印"
  },
  LanguageConfig_EnchantmentAwardLevelUp_CN = {
    Text = "幸运刻印！"
  },
  LanguageConfig_EnchantmentAwardTitle2_CN = {
    Text = "选择两张卡牌镶嵌刻印"
  },
  LanguageConfig_EnchantmentAwardTitle_CN = {
    Text = "选择一张卡牌镶嵌刻印"
  },
  LanguageConfig_EnchantmentAwardUncheck_CN = {
    Text = "请选择一张卡牌镶嵌刻印"
  },
  LanguageConfig_EnchantmentUnit8_Title1_CN = {
    Text = "选择 1 张卡牌领悟繁育之理"
  },
  LanguageConfig_EnchantmentUnit8_Title1_plus_CN = {
    Text = "选择 1 张卡牌完全领悟繁育之理"
  },
  LanguageConfig_EnchantmentUnit8_Title2_CN = {
    Text = "选择 1 张卡牌领悟欢愉之理"
  },
  LanguageConfig_EnchantmentUnit8_Title2_plus_CN = {
    Text = "选择 1 张卡牌完全领悟欢愉之理"
  },
  LanguageConfig_EnchantmentUnit8_Title3_CN = {
    Text = "选择 1 张卡牌领悟智识之理"
  },
  LanguageConfig_EnchantmentUnit8_Title3_plus_CN = {
    Text = "选择 1 张卡牌完全领悟智识之理"
  },
  LanguageConfig_EnchantmentUnit8_Title4_CN = {
    Text = "选择最多 2 张卡牌赋予「渊海回声」刻印。"
  },
  LanguageConfig_EnergyCommonAutoRecoverTips_CN = {
    Text = "当前补充速度：5分钟/支"
  },
  LanguageConfig_EnergyMonthCardCountDownDesc_CN = {
    Text = "剩余领取天数 <color=#21849a>{s1}</color> 天"
  },
  LanguageConfig_EnergyMonthCardDailyRewardDesc_CN = {
    Text = "30天内每日邮件领取"
  },
  LanguageConfig_EnergyMonthCardImmediateRewardDesc_CN = {
    Text = "购买后立即获得"
  },
  LanguageConfig_EnergyMonthCardOutLimitDayTips_CN = {
    Text = "剩余{s1}时长大于{s2}天，无法购买"
  },
  LanguageConfig_EnergyMonthCardRuleContent_CN = {
    Text = "【鞘内补给介绍】\n每次购买鞘内补给，可立即获得「银芯」× 680 与为期 30 天的鞘内补给生效时间。\n鞘内补给生效时间内，每日可从邮箱中领取「灵啡肽」× 300 和「追念羽笔」× 30 ，每日9点重置【GMT+8】。\n \n【注意事项】\n鞘内补给剩余生效时间≤180天时续购，总生效时间才会延长。\n当鞘内补给剩余生效时间＞180天时不可再进行购买。\n如因特殊原因导致重复购买，总生效时间将无法进行累加，并将直接返还「银芯」× 680。\n玩家在鞘内补给生效期间未领取的「灵啡肽」和「追念羽笔」，将不会返还。"
  },
  LanguageConfig_EnergyMonthCardRuleTitle_CN = {
    Text = "鞘内补给说明"
  },
  LanguageConfig_EnergyOverAutoRecoverTips_CN = {
    Text = "当前补充速度：15分钟/支"
  },
  LanguageConfig_Energy_Buy_Item_Acess_CN = {
    Text = "当前银芯"
  },
  LanguageConfig_Energy_Buy_Item_Used_CN = {
    Text = "消耗银芯"
  },
  LanguageConfig_Energy_Countdown_Str_CN = {
    Text = "{s1}后恢复1点「灵啡肽」"
  },
  LanguageConfig_Energy_Revert_Str_Content_CN = {
    Text = "要回复「灵啡肽」吗？"
  },
  LanguageConfig_Energy_Revert_Str_Num_CN = {Text = "灵啡肽"},
  LanguageConfig_Energy_Revert_Str_Time_CN = {
    Text = "（今日剩余回复次数{s1}/{s2}次）"
  },
  LanguageConfig_Energy_Revert_Str_Title_CN = {
    Text = "灵啡肽回复"
  },
  LanguageConfig_EnhancedPrompt_CN = {
    Text = "本赛季 {s1} 在幻梦深潜中行动时会变得躁狂，其体质、攻击力、防御力提高50%。"
  },
  LanguageConfig_EnterPassword_CN = {
    Text = "输入 <color=#5EF2FF>相位值</color>"
  },
  LanguageConfig_Event_ItemOwnCnt_CN = {
    Text = "持有数：{s1}"
  },
  LanguageConfig_Event_ItemUseCancel_CN = {Text = "取消"},
  LanguageConfig_Event_ItemUseCnt_CN = {
    Text = "使用数量"
  },
  LanguageConfig_Event_ItemUseConfirm_CN = {Text = "确认"},
  LanguageConfig_Event_ItemUseLeftCnt_CN = {
    Text = "剩余：{s1}"
  },
  LanguageConfig_Event_ItemUseTitle_CN = {
    Text = "快捷使用"
  },
  LanguageConfig_Event_Shop_BuyBtn_N_CN = {Text = "取消"},
  LanguageConfig_Event_Shop_BuyBtn_Y_CN = {Text = "确认"},
  LanguageConfig_Event_Shop_BuyTip_1_CN = {
    Text = "黑印不足"
  },
  LanguageConfig_Event_Shop_BuyTip_2_CN = {
    Text = "黑印不足"
  },
  LanguageConfig_Event_Shop_String_5_CN = {Text = "售罄"},
  LanguageConfig_ExaltUpgradeDescription_CN = {
    Text = "等于其他技能等级的平均值"
  },
  LanguageConfig_ExchangeConfirmText_CN = {
    Text = "「银芯」不足，是否使用「源液」× {s1} 兑换等量「银芯」"
  },
  LanguageConfig_ExchangeConfirmTitle_CN = {
    Text = "银芯不足"
  },
  LanguageConfig_ExchangeConfirm_CN = {
    Text = "确认置换"
  },
  LanguageConfig_ExchangeCostInfoPreviewTips_CN = {
    Text = "将通过置换，获得 <Blue:{s1}> 个<Blue:{s2}>"
  },
  LanguageConfig_ExchangeCostItemEnoughTips_CN = {
    Text = "置换产物"
  },
  LanguageConfig_ExchangeCostItemNotEnoughTips_CN = {
    Text = "材料不足"
  },
  LanguageConfig_ExchangeCostItemNumNotEnoughTips_CN = {
    Text = "当前所选材料不足{s1}个，无法置换"
  },
  LanguageConfig_ExchangeCostItemNumReachLimitTips_CN = {
    Text = "当前选中的消耗道具数量已达到上限"
  },
  LanguageConfig_ExchangeCostSelectLimitTips_CN = {
    Text = "最多只能选择 6 种类型材料，无法选择更多类型"
  },
  LanguageConfig_ExchangeCostSelectPanelTips_CN = {
    Text = "消耗已选材料可置换 <Blue:{s1}> 个新材料"
  },
  LanguageConfig_ExchangeCostSelectPanelTitle_CN = {
    Text = "选择材料"
  },
  LanguageConfig_ExchangeNumZeroText_CN = {
    Text = "兑换数量不能为0"
  },
  LanguageConfig_ExchangePlanSaveTips_CN = {
    Text = "已保存「千面印章」不足时的置换设置"
  },
  LanguageConfig_ExchangeShopRules_CN = {
    Text = "<Title:兑换商店>\n·守密人可以在各个兑换商店通过消耗一定的对应货币兑换商品。\n·当守密人调查等级提升时，兑换商店会随之升级并解锁新内容。\n·兑换商店内的商品每隔一定的时间会自动刷新库存。\n\n<Title:金券兑换>\n·守密人可以在首次通关主线调查事件或通过「融蚀之墟：金券搜查」、「派遣奖励」、「课题奖励」与限时玩法活动奖励来获得「蔷薇金券」。\n\n<Title:沉淀兑换>\n·守密人可以通过唤醒来获得「根源沉淀」。\n\n<Title:调查兑换>\n·守密人可以在主线调查事件获得三星关卡星级或通过「超验存在」来获得「调查徽章」。\n\n<Title:无光兑换>\n·守密人可以通过「无光之境」或通过「融灾禁区」来获得「黑色供物」。\n\n<Title:融珠兑换>\n·守密人可以通过「常训任务：每周试炼」来获得「融蚀之珠」。"
  },
  LanguageConfig_ExchangeTips_CN = {
    Text = "是否确认消耗以下材料，置换获得 <Blue:{s2}> 个<Blue:{s3}>？"
  },
  LanguageConfig_ExchangeTitle_CN = {
    Text = "兑换银芯"
  },
  LanguageConfig_Exchange_Start_CN = {Text = "置换"},
  LanguageConfig_ExitInvestigation_CN = {
    Text = "退出调查"
  },
  LanguageConfig_ExpFullTips_CN = {Text = "  已满"},
  LanguageConfig_ExpiredConvertText_CN = {
    Text = "部分物品已转换"
  },
  LanguageConfig_ExpiredText_CN = {
    Text = "以下物品已过期，将无法使用"
  },
  LanguageConfig_ExploreCurseConfirm_CN = {
    Text = "承压前进（压力废弃）"
  },
  LanguageConfig_ExploreCurseDesc_CN = {
    Text = "重压之下，你的精神逐渐紧绷，向某个看不见的临界点不断逼近。（压力废弃）\n\n你获得了{s1}张“{s2}”"
  },
  LanguageConfig_ExploreCurseTitle_CN = {
    Text = "症状（压力废弃）"
  },
  LanguageConfig_ExploreSpiritDesc_CN = {
    Text = "不知从何而来的目光如有实体地压在你身上。你感到呼吸困难，眼前逐渐模糊……（压力废弃）"
  },
  LanguageConfig_ExploreSpiritTitle_CN = {
    Text = "压力过载（压力废弃）"
  },
  LanguageConfig_ExploreStressMaxReduceMaxHP_CN = {
    Text = "{s1}生命上限"
  },
  LanguageConfig_ExploreStressMax_CN = {Text = "MAX"},
  LanguageConfig_ExploreStressRaise_CN = {
    Text = " +{s1}压力"
  },
  LanguageConfig_ExtraGift_CN = {
    Text = "额外赠送"
  },
  LanguageConfig_ExtraSSRWeaponRuleContent_CN = {
    Text = "<Title:超限因果>\n·一般情况下，同一个唤醒体只能装备一个SSR命轮。\n·当唤醒体装备了额外叠位达到12的SSR命轮时，能够激活「超限因果」效果，使唤醒体能同时装备两个SSR命轮。"
  },
  LanguageConfig_ExtraSSRWeaponRuleTitle_CN = {
    Text = "规则说明"
  },
  LanguageConfig_ExtraSSRWeaponUnlockTips_CN = {
    Text = "「超限因果」已激活！"
  },
  LanguageConfig_FailureConfirm_CN = {
    Text = "止步于此"
  },
  LanguageConfig_FailureHint_CN = {
    Text = "提升唤醒体的力量后，再来挑战强敌吧！"
  },
  LanguageConfig_FastPromotionTypeName_CN = {
    Text = "灵知增幅器"
  },
  LanguageConfig_FavorSettleShowSourceTabActivity_CN = {
    Text = "活动加成"
  },
  LanguageConfig_FavorSettleShowSourceTabAssist_CN = {
    Text = "助战加成"
  },
  LanguageConfig_FavorSettleShowSourceTabCard_CN = {Text = "出牌"},
  LanguageConfig_FavorSettleShowSourceTabCost_CN = {Text = "算力"},
  LanguageConfig_FavorSettleShowSourceTabKeeper_CN = {
    Text = "银钥能量"
  },
  LanguageConfig_FavorSettleShowSourceTabManual_CN = {
    Text = "手动战斗"
  },
  LanguageConfig_FavorSettleShowSourceTabTotal_CN = {Text = "总额"},
  LanguageConfig_FavorSettleShowSourceTabUlti_CN = {Text = "狂气"},
  LanguageConfig_FavorSettleShowSourceTabWeapon_CN = {
    Text = "命轮加成"
  },
  LanguageConfig_FavorabilityIncrease_CN = {
    Text = "{s1}  同调率<color=#1AE8F5>+{s2}</color>"
  },
  LanguageConfig_FavorabilityLimit_description_02_CN = {
    Text = "以下唤醒体同调率已满："
  },
  LanguageConfig_FavorabilityLimit_description_CN = {
    Text = "同调率基础上限为42000"
  },
  LanguageConfig_FavorabilityUnlockCondition_1_CN = {
    Text = "{s1}同调率达到{s2}级可解锁"
  },
  LanguageConfig_FavorabilityUnlockCondition_2_CN = {
    Text = "<Gray1:{s1}同调率达到{s2}级可解锁>"
  },
  LanguageConfig_FightAgain_CN = {
    Text = "重新战斗"
  },
  LanguageConfig_FilterAwakerOptionsTipsDesc_CN = {
    Text = "可筛选特定唤醒体，了解携带该唤醒体的阵容。"
  },
  LanguageConfig_FilterAwakerOptionsTipsTitle_CN = {
    Text = "选择通关唤醒体"
  },
  LanguageConfig_FilterAwakerUnableSelect_CN = {
    Text = "无法选择"
  },
  LanguageConfig_FinalBoss_Bubble1_CN = {
    Text = "如此……僭越……"
  },
  LanguageConfig_FinalBoss_Bubble2_CN = {
    Text = "不必……挣扎……"
  },
  LanguageConfig_FinalBoss_Bubble3_CN = {
    Text = "银色六翼，予汝护佑。"
  },
  LanguageConfig_FinalBoss_Bubble4_CN = {
    Text = "双翼初张……银匙于此倾转。"
  },
  LanguageConfig_FinalBoss_Bubble5_CN = {
    Text = "四翼渐生……光羽于此辉耀。"
  },
  LanguageConfig_FinalBoss_Bubble6_CN = {
    Text = "六翼满开……终焉于此降诞！"
  },
  LanguageConfig_FinalBoss_Name_CN = {
    Text = "「塔薇：万象门扉」"
  },
  LanguageConfig_FinalBoss_Tips1_CN = {
    Text = "全知的神明亦有不可抵御之物。使用钥令会导致让祂的意图切换，调整策略可以更有效的攻克！"
  },
  LanguageConfig_FinalBoss_Tips2_CN = {
    Text = "大量打出指令卡会使祂加速行动，提前做好防备！"
  },
  LanguageConfig_FinalBoss_Tips3_CN = {
    Text = "祂的能力得到强化，切换不同的意图时会额外造成效果，请小心应对！"
  },
  LanguageConfig_FirstTimeNormalRewardTagText_CN = {
    Text = "首通双倍"
  },
  LanguageConfig_FirstUnity_Monster_Tips_1_CN = {
    Text = "银色六翼，予汝护佑。"
  },
  LanguageConfig_FirstUnity_Monster_Tips_2_CN = {
    Text = "双翼初张，狂气汇集。"
  },
  LanguageConfig_FirstUnity_Monster_Tips_3_CN = {
    Text = "四翼渐生，银羽夺辉！"
  },
  LanguageConfig_FirstUnity_Monster_Tips_4_CN = {
    Text = "六翼满开，审判将至！"
  },
  LanguageConfig_FirstUnity_Monster_Tips_5_CN = {
    Text = "狂气充盈，审判将至！"
  },
  LanguageConfig_FiveFreePullsTips_CN = {
    Text = "可免费 5 连唤醒 {s1} 次"
  },
  LanguageConfig_Float_Tip_BloodDevour_CN = {
    Text = "吞噬效果发动！"
  },
  LanguageConfig_Float_Tip_DefenceCrash_CN = {
    Text = "护盾破除！"
  },
  LanguageConfig_Float_Tip_DimensionJump_CN = {
    Text = "跃迁效果发动！"
  },
  LanguageConfig_Float_Tip_EnergyDown_CN = {
    Text = "能量下降…"
  },
  LanguageConfig_Float_Tip_Revive_CN = {Text = "重生"},
  LanguageConfig_Float_Tip_TentacleFull_CN = {
    Text = "触腕满溢！"
  },
  LanguageConfig_FloatingTextColor_Green_CN = {Text = "00CB00"},
  LanguageConfig_FloatingTextColor_Red_CN = {Text = "FF0000"},
  LanguageConfig_ForceAssistTeam_CN = {
    Text = "本次调查必须上场助战唤醒体"
  },
  LanguageConfig_ForgedRelicTypeName_CN = {
    Text = "<OrangeRelic:黄金造物>"
  },
  LanguageConfig_Formation_Administration_CombatNum_String_CN = {Text = "总战力"},
  LanguageConfig_Formation_Administration_Current_Team_String_CN = {
    Text = "当前队伍"
  },
  LanguageConfig_Formation_Administration_Sure_Btn_CN = {Text = "选择"},
  LanguageConfig_Formation_Administration_Title_String_CN = {
    Text = "队伍管理"
  },
  LanguageConfig_Formation_CurrentTeam_AvgLevelNum_String_CN = {
    Text = "当前队伍平均等级"
  },
  LanguageConfig_Formation_Default_TeamName_String1_CN = {Text = "队伍1"},
  LanguageConfig_Formation_Default_TeamName_String2_CN = {Text = "队伍2"},
  LanguageConfig_Formation_Default_TeamName_String3_CN = {Text = "队伍3"},
  LanguageConfig_Formation_Default_TeamName_String4_CN = {Text = "队伍4"},
  LanguageConfig_Formation_Default_TeamName_String5_CN = {Text = "队伍5"},
  LanguageConfig_Formation_EnterCopy_Btn_CN = {Text = "调查"},
  LanguageConfig_Formation_Fast_Btn_CN = {
    Text = "快速编队"
  },
  LanguageConfig_Formation_Fast_Sure_Btn_CN = {Text = "保存"},
  LanguageConfig_Formation_RecommendLevel_CN = {
    Text = "推荐等级"
  },
  LanguageConfig_Formation_RecommendTeam_LevelNum_String_CN = {
    Text = "关卡推荐等级"
  },
  LanguageConfig_Formation_RenameTeam_Back_Btn_CN = {Text = "取消"},
  LanguageConfig_Formation_RenameTeam_CurrentTeam_String_CN = {
    Text = "当前名称："
  },
  LanguageConfig_Formation_RenameTeam_Recommend_String_CN = {
    Text = "点击编辑队伍名"
  },
  LanguageConfig_Formation_RenameTeam_Sure_Btn_CN = {Text = "确认"},
  LanguageConfig_Formation_RenameTeam_Title_String_CN = {
    Text = "修改队伍名"
  },
  LanguageConfig_Formation_Role_ForceAssist_Recommend_CN = {
    Text = "<Blue:选择助战唤醒体上场>"
  },
  LanguageConfig_Formation_Role_Recommend_String_CN = {
    Text = "点击选择唤醒体上场"
  },
  LanguageConfig_Formation_SelectRole_Details_Btn_CN = {Text = "详情"},
  LanguageConfig_Formation_SelectRole_DifferentOccupation_String_CN = {
    Text = "界域冲突"
  },
  LanguageConfig_Formation_SelectRole_NotBattle_String_CN = {
    Text = "无法上场"
  },
  LanguageConfig_Formation_SelectRole_Nothing_Tips_CN = {
    Text = "无该界域唤醒体"
  },
  LanguageConfig_Formation_SelectRole_Recommend_String1_CN = {
    Text = "暂无选中唤醒体"
  },
  LanguageConfig_Formation_SelectRole_Recommend_String2_CN = {
    Text = "点击左侧唤醒体头像进行选择"
  },
  LanguageConfig_Formation_SelectRole_Sure_Btn1_CN = {Text = "下场"},
  LanguageConfig_Formation_SelectRole_Sure_Btn2_CN = {Text = "上场"},
  LanguageConfig_Formation_SelectRole_Sure_Btn3_CN = {Text = "替换"},
  LanguageConfig_Formation_SelectRole_Title_String_CN = {
    Text = "选择唤醒体"
  },
  LanguageConfig_FreeTrialRuleDesc_CN = {
    Text = "·在唤醒体试玩中，守密人可以参与所有唤醒体的试玩关卡，帮助你掌握唤醒体的基本用法。\n·常驻唤醒体的试玩关卡将提供「银芯」、「无垢之芯」的首通奖励！\n·限定唤醒体的试玩关卡将提供「根源沉淀」的首通奖励"
  },
  LanguageConfig_FreeTrialRuleTitle_CN = {
    Text = "规则说明"
  },
  LanguageConfig_FreeTrialTitle_CN = {
    Text = "唤醒体试玩"
  },
  LanguageConfig_Frenzy_CN = {
    Text = "哎嘿嘿嘿"
  },
  LanguageConfig_FriendGameCount_CN = {
    Text = "友谊赛{s1}<size=24>人邀请</size>"
  },
  LanguageConfig_FriendGameInviteTipsDraft_CN = {
    Text = "正在邀请你参与 轮选模式…"
  },
  LanguageConfig_FriendGameInviteTipsNormal_CN = {
    Text = "正在邀请你参与 预组对决…"
  },
  LanguageConfig_FriendGameNull_CN = {
    Text = "邀请已取消"
  },
  LanguageConfig_FriendGameWaitAccept_CN = {
    Text = "接受友谊赛的邀请"
  },
  LanguageConfig_FriendGameWaitFormation_CN = {
    Text = "编辑队伍"
  },
  LanguageConfig_FriendGame_CN = {Text = "友谊赛"},
  LanguageConfig_FriendInvitationCopy_CN = {Text = "复制"},
  LanguageConfig_FriendInvitationPaste_CN = {Text = "粘贴"},
  LanguageConfig_FriendInvitationRule_CN = {
    Text = "<Title:邀请活动>\n1.守密人可以通过分享邀请码来邀请新的守密人加入弥萨格校园，共赴冒险之旅。\n2.受邀的守密人完成任务后，您可以领取任务奖励获取「银钥辉光」，当「银钥辉光」达到一定数量后，可以领取丰富的奖励！\n3.守密人等级达到5/10/15/20级后可以分别获得20/20/20/40「银钥辉光」。\n4.每位守密人最多可以通过 50 位邀请的守密人获取任务奖励，超出数量的部分不再提供任务奖励。\n5.邀请的守密人在调查等级达到 5 级后才会被计入已邀请人数。\n<Title:绑定邀请>\n1.守密人可以填写邀请码来跟邀请的玩家进行绑定，并立即获得「银芯」× 300的奖励！\n2.每位守密人只能在初到弥萨格的前 7 天内输入邀请码，超时后「绑定邀请」的入口将会关闭。"
  },
  LanguageConfig_FriendInvitationShareText_CN = {
    Text = "加入《忘却前夜》，共赴冒险之旅！通过我的邀请码{s1}下载，还能领取专属奖励！\n{s2}"
  },
  LanguageConfig_FriendInvitationTips_Accepted_CN = {
    Text = "已接受<Blue:{s1}>的邀请！"
  },
  LanguageConfig_FrozenResentment_CN = {
    Text = "别看，别听，别步入@1……"
  },
  LanguageConfig_FunctionNotComplete_CN = {
    Text = "功能未完成"
  },
  LanguageConfig_GMNetText_CN = {Text = "{s1}ms"},
  LanguageConfig_GMUserIdText_CN = {Text = "UID：{s1}"},
  LanguageConfig_GMVersionText_CN = {Text = "Ver：{s1}"},
  LanguageConfig_GamePassportTip_CN = {
    Text = "解锁高级纪行\n完成任务后可额外领取奖励"
  },
  LanguageConfig_GamePassportTitle_CN = {
    Text = "守密纪行"
  },
  LanguageConfig_GenderChangeConfirmContent_CN = {
    Text = "将守密人性别切换为<Blue:「{s1}」>，体验游戏剧情。"
  },
  LanguageConfig_GenderChangeConfirmFreeTips_CN = {
    Text = "本次修改免费，之后修改将消耗<Blue:「{s1}」× {s2}>。"
  },
  LanguageConfig_GenderChangeConfirmTitle_CN = {
    Text = "切换性别"
  },
  LanguageConfig_GenderChangeSuccessfulTips_CN = {
    Text = "已修改性别为：{s1}"
  },
  LanguageConfig_GetAchievementPopTipsText_CN = {Text = "{s1}"},
  LanguageConfig_GetConditionStr_CN = {
    Text = "第{s1}次开始有机会获得"
  },
  LanguageConfig_GetRelic_CN = {
    Text = "获得造物"
  },
  LanguageConfig_GetSSRDecompose_CN = {
    Text = "SSR分解获得"
  },
  LanguageConfig_GiftDiamondDeductTip_CN = {
    Text = "<size=30><color=#ACBFCA>消耗「源液」时，优先扣除赠送的「源液」。\n（提取：{s1}，赠送：{s2}）</color></size>"
  },
  LanguageConfig_GiveAwayItem_CN = {Text = "赠送"},
  LanguageConfig_GoGetWord_CN = {
    Text = "前往购买"
  },
  LanguageConfig_GoTo_CN = {Text = "前往"},
  LanguageConfig_GoldShopRefreshDesc_CN = {
    Text = "{s1}小时{s2}分"
  },
  LanguageConfig_GoldShopRefreshTimesOutTips_CN = {
    Text = "手动刷新次数已达上限"
  },
  LanguageConfig_GoldShopRuleTitle_CN = {
    Text = "金券兑换说明"
  },
  LanguageConfig_GoldenWeekSummonDesc1_CN = {
    Text = "<SummonOrange:选定唤醒体和命轮>获取概率提升！"
  },
  LanguageConfig_GoldenWeekSummonDesc2_CN = {
    Text = "选定后本期不可再更改"
  },
  LanguageConfig_GoodSourcePVP_CN = {
    Text = "相位对弈"
  },
  LanguageConfig_GoodSourceSocial_CN = {
    Text = "守密人档案"
  },
  LanguageConfig_GuideNotePermResSummaryProgress_CN = {
    Text = " {s1} / {s2}"
  },
  LanguageConfig_GuideNote_Breakthrough_CN = {
    Text = "满足升格条件(任选其一)"
  },
  LanguageConfig_GuideNote_CrazyOmen_CN = {
    Text = "疯狂预兆升级条件"
  },
  LanguageConfig_GuideNote_ExplorationProgress_CN = {
    Text = "当前收集进度"
  },
  LanguageConfig_GuideNote_Format_CN = {
    Text = "\n   · {s1}"
  },
  LanguageConfig_GuideNote_MaterialMet_CN = {
    Text = "素材已满足"
  },
  LanguageConfig_GuideNote_MaterialNeeded_CN = {
    Text = "还需获得素材"
  },
  LanguageConfig_GuideNote_MoreImprovement_CN = {
    Text = "更多提升"
  },
  LanguageConfig_GuideNote_RecommendMystic_CN = {
    Text = "推荐密契"
  },
  LanguageConfig_GuideNote_ResetTime_CN = {
    Text = "重置时间"
  },
  LanguageConfig_GuideNote_Rules_Description3_CN = {
    Text = "<Title:强化密仪>\n·选择一名唤醒体，可以查看其所需的材料以及推荐佩戴的密契，其所需材料根据当前已有材料和当前可到达的极限所计算。"
  },
  LanguageConfig_GuideNote_Rules_Title1_CN = {
    Text = "日常试训"
  },
  LanguageConfig_GuideNote_Rules_Title2_CN = {
    Text = "周常试训"
  },
  LanguageConfig_GuideNote_Rules_Title3_CN = {
    Text = "强化密仪"
  },
  LanguageConfig_GuideNote_Rules_Title4_CN = {
    Text = "禁忌试炼"
  },
  LanguageConfig_GuideNote_Rules_Title5_CN = {
    Text = "银辉之路"
  },
  LanguageConfig_GuideNote_Rules_Title6_CN = {
    Text = "资源勘探"
  },
  LanguageConfig_GuideNote_SkillImprovement_CN = {
    Text = "技能升级条件"
  },
  LanguageConfig_GuideNote_Title1_CN = {
    Text = "密境课室"
  },
  LanguageConfig_GuideNote_Title2_CN = {
    Text = "日常试训"
  },
  LanguageConfig_GuideNote_Title3_CN = {
    Text = "周常试训"
  },
  LanguageConfig_GuideNote_Title4_CN = {
    Text = "强化秘仪"
  },
  LanguageConfig_GuideNote_Title5_CN = {
    Text = "禁忌试炼"
  },
  LanguageConfig_GuideNote_Title6_CN = {
    Text = "银辉之路"
  },
  LanguageConfig_GuideNote_Title7_CN = {
    Text = "资源勘探"
  },
  LanguageConfig_HZWMainDia1_CN = {
    Text = "外乡佬，可别小看我们！"
  },
  LanguageConfig_HZWMainDia2_CN = {
    Text = "别来捣乱，外乡佬！"
  },
  LanguageConfig_HalfBleeding_CN = {
    Text = "出血减半"
  },
  LanguageConfig_HolyRelicTypeName_CN = {
    Text = "<OrangeRelic:受祝造物>"
  },
  LanguageConfig_Hour_CN = {Text = "小时"},
  LanguageConfig_HowToPlayTxt_CN = {
    Text = "玩法说明"
  },
  LanguageConfig_ImmuneSpDown_CN = {
    Text = "免疫算力降低"
  },
  LanguageConfig_InGameDownloadChecking_CN = {
    Text = "正在校验资源，请稍后…{s1}%"
  },
  LanguageConfig_InGameDownloadReady_CN = {
    Text = "准备下载资源"
  },
  LanguageConfig_InGameDownloadRedownloading_CN = {
    Text = "正在重新下载资源中，请稍候…{s1}%"
  },
  LanguageConfig_InGameDownloadUnzipStart_CN = {
    Text = "准备解压资源"
  },
  LanguageConfig_InGameDownloadUnziping_CN = {
    Text = "正在解压资源，请稍候…{s1}%"
  },
  LanguageConfig_InGameDownloadingProg_CN = {
    Text = "下载中{s1}"
  },
  LanguageConfig_InGameDownloadingTips_CN = {
    Text = "关闭省电策略或低电量模式可支持后台下载，开启通知权限可以获得下载状态推送"
  },
  LanguageConfig_InGameDownloadingTitle_CN = {
    Text = "资源下载"
  },
  LanguageConfig_InheritConsumeDrawItemConvertTips_CN = {
    Text = "即将转化为「无垢之芯」"
  },
  LanguageConfig_InterludeStageRewardsTitle_CN = {
    Text = "三星奖励"
  },
  LanguageConfig_InvestAchievement_CN = {
    Text = "成就/调查成就"
  },
  LanguageConfig_InvestigationBadgeShopRules_CN = {
    Text = "1、守密人可以通过消耗一定的「调查徽章」兑换商品。\n2、当守密人调查等级提升时，调查兑换商店会随之升级并解锁新内容。\n3、调查兑换商店内的商品每隔一定的时间会自动刷新库存。\n4、守密人可以在主线调查事件获得三星关卡星级或通过「超验存在」来获得「调查徽章」。"
  },
  LanguageConfig_Investigation_Failed_CN = {
    Text = "调查终止"
  },
  LanguageConfig_Investigation_Successful_CN = {
    Text = "调查完成"
  },
  LanguageConfig_InviteAwaker_CN = {
    Text = "免费唤醒"
  },
  LanguageConfig_InviteWeapon_CN = {
    Text = "选择命轮"
  },
  LanguageConfig_IsNewDotText_CN = {
    Text = "今日推荐"
  },
  LanguageConfig_ItemByDecompose_CN = {
    Text = "分解可获得材料"
  },
  LanguageConfig_ItemEquipping_CN = {
    Text = "当前装备"
  },
  LanguageConfig_ItemForCompose_CN = {
    Text = "合成配方"
  },
  LanguageConfig_ItemGain_AwakerGainLikeReward_CHN_CN = {
    Text = "同调率奖励"
  },
  LanguageConfig_ItemGain_String_LevelUpGet_CHN_CN = {
    Text = "溢出经验返还"
  },
  LanguageConfig_ItemGain_String_MainCont_CHN_CN = {
    Text = "点击屏幕继续"
  },
  LanguageConfig_ItemGain_String_MainCont_ENG_CN = {Text = "CONTINUE"},
  LanguageConfig_ItemGain_String_MainTitle_CHN_CN = {
    Text = "获得物资"
  },
  LanguageConfig_ItemGain_String_MainTitle_CN = {
    Text = "获得物资"
  },
  LanguageConfig_ItemGain_String_MainTitle_ENG_CN = {
    Text = "ITEMS GAINED"
  },
  LanguageConfig_ItemGain_String_ShareTitle_CN = {
    Text = "分享奖励"
  },
  LanguageConfig_ItemGain_String_SpecialItemUse_CN = {
    Text = "获得物资"
  },
  LanguageConfig_ItemGain_String_WorkCont_CHN_CN = {
    Text = "点击屏幕继续"
  },
  LanguageConfig_ItemGain_String_WorkTitle_CHN_CN = {
    Text = "获得物资"
  },
  LanguageConfig_ItemNameNumNextLineShow_CN = {
    Text = "「{s1}」\n×{s2}"
  },
  LanguageConfig_ItemNameNumShow_CN = {
    Text = "「{s1}」×{s2}"
  },
  LanguageConfig_ItemNameShow_CN = {Text = "「{s1}」"},
  LanguageConfig_ItemNeed_CN = {Text = "需要"},
  LanguageConfig_ItemNumShow_CN = {Text = "×{s1}"},
  LanguageConfig_ItemType_Awaker_CN = {Text = "唤醒体"},
  LanguageConfig_ItemType_HeadAndEmoji_CN = {
    Text = "头像和表情"
  },
  LanguageConfig_ItemType_Material_CN = {Text = "素材"},
  LanguageConfig_ItemType_Specail_CN = {Text = "特殊"},
  LanguageConfig_ItemType_Trinket_CN = {Text = "密契"},
  LanguageConfig_ItemType_Weapon_CN = {Text = "命轮"},
  LanguageConfig_ItemUseTimes_CN = {
    Text = "使用次数"
  },
  LanguageConfig_ItemUsingDesc_CN = {Text = "使用中"},
  LanguageConfig_KMMainDia1_CN = {
    Text = "快……跑吧……"
  },
  LanguageConfig_KMMainDia2_CN = {
    Text = "呜……痛……"
  },
  LanguageConfig_KPLevel_CN = {Text = "守密人"},
  LanguageConfig_KarenActivityRewardBottomText_CN = {
    Text = "当前清扫工具 {s1}"
  },
  LanguageConfig_KarenActivityRewardTitle_CN = {
    Text = "除尘津贴"
  },
  LanguageConfig_KeeperSkillCannotChange_CN = {
    Text = "当前副本不可更换银钥技能"
  },
  LanguageConfig_KeeperSkillEnergyConsume_CN = {
    Text = "银钥能量消耗:{s1}"
  },
  LanguageConfig_KeeperSkillEnergy_CN = {
    Text = "银钥能量{s1}"
  },
  LanguageConfig_KeeperSkillEquipPrompt_CN = {
    Text = "已选择使用钥令 {s1}"
  },
  LanguageConfig_KeeperSkillTitle_CN = {Text = "钥令"},
  LanguageConfig_Keeper_Cost_CN = {
    Text = "能量消耗:"
  },
  LanguageConfig_KilledMonsterCount_CN = {
    Text = "已抓捕 <color=#5EF2FF> {s1} </color> 只"
  },
  LanguageConfig_LLMainDia1_CN = {
    Text = "我——是——谁？"
  },
  LanguageConfig_LLMainDia2_CN = {
    Text = "妈……妈……"
  },
  LanguageConfig_LLMainDia3_CN = {
    Text = "我要……守护"
  },
  LanguageConfig_LLMainDia4_CN = {
    Text = "一点……也……不痛"
  },
  LanguageConfig_LTMainDia1_CN = {
    Text = "太好了，上次可还没分出胜负呢！"
  },
  LanguageConfig_LTMainDia2_CN = {
    Text = "看看这招！"
  },
  LanguageConfig_LTMainDia3_CN = {
    Text = "哈哈，这可比上次来劲，我可要动真格了！"
  },
  LanguageConfig_LTMainDia4_CN = {
    Text = "现在，热身结束"
  },
  LanguageConfig_LackOfGoldCoin_CN = {
    Text = "「蔷薇金券」不足"
  },
  LanguageConfig_LackOfItemForCompose_CN = {
    Text = "所需材料不足，无法合成"
  },
  LanguageConfig_LackOfItemForDecompose_CN = {
    Text = "尚未拥有可分解的材料"
  },
  LanguageConfig_LackOfTrinketForRecast_CN = {
    Text = "尚未拥有未装备的SSR品阶密契"
  },
  LanguageConfig_LargeSubplotResonanceRules_CN = {
    Text = "1、「特遣纪录」的部分调查事件有专属共鸣，可以使用共鸣升级材料激活共鸣效果，共鸣将在调查时提供强力的协助。\n2、在唤醒体限时活动期间，完成指定任务可以获得共鸣升级材料。活动结束后，可通过消耗「蔷薇金券」× 5000 额外兑换 1 个共鸣升级材料。\n3、地图内会出现共鸣节点，移动至共鸣节点上将在本次探索获得共鸣效果。"
  },
  LanguageConfig_LargeSubplotTipsText_CN = {
    Text = "<Title:特遣纪录>\n1、需要达成以下条件方可进行特遣纪录：\n·完成对应的调查行动；\n·消耗 「现实起点」× 7 解锁。\n2、当特遣纪录处于限时活动福利期内时，无需消耗「现实起点」即可免费解锁。活动结束后调查进度将保留。\n3、完成特遣纪录调查任务可以获得无垢之芯、守密人经验和调查徽章等奖励。"
  },
  LanguageConfig_LargeSubplotTipsTitle_CN = {
    Text = "规则说明"
  },
  LanguageConfig_LargeSubplotTitle_CN = {
    Text = "特遣纪录"
  },
  LanguageConfig_LeaveSpStore_Tips_CN = {
    Text = "蠕动的融痕发出嘶哑的低语：\n离开，便再也无法在此处与它会面。"
  },
  LanguageConfig_LeftCountText_CN = {
    Text = "剩余次数"
  },
  LanguageConfig_LeftNumStr_CN = {
    Text = "{s1}({s2}/{s3})"
  },
  LanguageConfig_Less_Sweep_Item_CN = {
    Text = "扫荡券不足"
  },
  LanguageConfig_LevelDetailBattle_Boss_Tips_CN = {Text = "首领"},
  LanguageConfig_LevelDetailBattle_Elite_Tips_CN = {Text = "精英"},
  LanguageConfig_LevelDetailEnchantGroup_CN = {Text = "刻印"},
  LanguageConfig_LevelDetailRelicEnchantGroupNone_CN = {
    Text = "暂无造物及刻印"
  },
  LanguageConfig_LevelDetailRelicGroup_CN = {Text = "造物"},
  LanguageConfig_LevelFailureGuide_CN = {
    Text = " ·提升唤醒体等级\n·强化唤醒体技能\n·叠位命轮\n·强化密契\n·激活启灵"
  },
  LanguageConfig_LevelLimitIncrease_CN = {
    Text = "等级上限提升"
  },
  LanguageConfig_LevelSuppression_Description_Detail_CN = {
    Text = "·推荐等级主要为守密人提供本次调查难度的参考标准，若队伍平均等级或守密人调查等级低于推荐等级，进行的调查时可能会遇到较大的挑战。"
  },
  LanguageConfig_LevelSuppression_Description_Title_CN = {
    Text = "推荐等级"
  },
  LanguageConfig_LevelSuppression_tips_CN = {
    Text = "我方队伍属性{s1}"
  },
  LanguageConfig_LevelUnlockDesc_CN = {
    Text = "通关{s1}后解锁"
  },
  LanguageConfig_LevelUpGamePassport_CN = {
    Text = "纪行进阶"
  },
  LanguageConfig_LevelUpTipsAccountDamagerText_CN = {
    Text = "关卡造物和刻印强度已提升"
  },
  LanguageConfig_LevelUpTipsHpMultiplierText_CN = {
    Text = "唤醒体每点体质带来的最大生命提升至<TipsHighlightText_1: {s1} >"
  },
  LanguageConfig_Level_Detail_Stamina_CN = {Text = "{s1}/{s2}"},
  LanguageConfig_Level_Up_Energy_Str_CN = {Text = "灵啡肽"},
  LanguageConfig_Level_Up_Level_Str_CN = {Text = "等级"},
  LanguageConfig_Level_Up_Max_Energy_Str_CN = {
    Text = "灵啡肽上限"
  },
  LanguageConfig_Level_Up_Tips_CN = {
    Text = "守密人调查等级提升"
  },
  LanguageConfig_Level_Up_Title_CN = {
    Text = "等级提升"
  },
  LanguageConfig_LikeBounusTips_CN = {
    Text = "{s1}同调率加成"
  },
  LanguageConfig_LikeSourceCollectionHallComment_CN = {
    Text = "典藏馆收藏评论"
  },
  LanguageConfig_LikeSourcePvpCollectionComment_CN = {
    Text = "相位对弈卡牌评论"
  },
  LanguageConfig_LilyResonance1_1_CN = {
    Text = "，普通刻印 3 选 1"
  },
  LanguageConfig_LilyResonance1_2_CN = {
    Text = "，高级刻印 3 选 1"
  },
  LanguageConfig_LilyResonance4_1_CN = {
    Text = "，获得 1 张「灵感」"
  },
  LanguageConfig_LilyResonance4_2_CN = {
    Text = "，获得 2 张「灵感」"
  },
  LanguageConfig_LimitedTimeFreeUnlock_CN = {
    Text = "限时免费解锁"
  },
  LanguageConfig_LinkageActivityTitle_CN = {
    Text = "多维连接"
  },
  LanguageConfig_Localized_CN = {
    Text = "已本地化"
  },
  LanguageConfig_LockedSubplotStageName_CN = {
    Text = "@1<CardDescColor.Light>@2<CardDescColor.Light>"
  },
  LanguageConfig_LoginInterface_Announcement_CN = {Text = "告示"},
  LanguageConfig_LoginInterface_Btn_Enter_CN = {
    Text = "进入大学"
  },
  LanguageConfig_LoginPV1_Name_CN = {
    Text = "忘却前夜"
  },
  LanguageConfig_LoginPV2_Name_CN = {
    Text = "愿银钥指引前路"
  },
  LanguageConfig_LoginPV3_Name_CN = {
    Text = "来自遗忘  <▼>"
  },
  LanguageConfig_LoginPV4_Name_CN = {
    Text = "星辰正位之刻"
  },
  LanguageConfig_LoginPlatFormActivityTxt_CN = {
    Text = "完善资料、使用不同设备游玩并提取源液，即可获得专属限定头像与幻衣奖励！"
  },
  LanguageConfig_LoginPvModifyTipDesc_CN = {
    Text = "被选定的动画会在后续每次登录时播放，但调查进度到达新阶段时依旧优先播放一次新的动画，清除游戏数据或重新安装游戏会清除被选定的动画。"
  },
  LanguageConfig_LoginPvModifyTipTitle_CN = {Text = "说明"},
  LanguageConfig_Login_ResetLoginBackground_CN = {
    Text = "重置登录背景"
  },
  LanguageConfig_Login_SetLoginBackground_CN = {
    Text = "设为登录背景"
  },
  LanguageConfig_LotteryCoreRewardLabel_CN = {Text = "特殊"},
  LanguageConfig_LotteryCoreRewardResetTimes_CN = {
    Text = "特殊物品剩余重置:{s1}"
  },
  LanguageConfig_LotteryCoreReward_CN = {
    Text = "特殊物品"
  },
  LanguageConfig_LotteryDrawBtnText_CN = {
    Text = "诗文交换"
  },
  LanguageConfig_LotteryNormalReward_CN = {
    Text = "普通物品"
  },
  LanguageConfig_LotteryPhoneticDialogue10_CN = {
    Text = "再虔诚一些，再献祭一些……神国在注视你的祝祷，它终有一天会回应你。"
  },
  LanguageConfig_LotteryPhoneticDialogue11_CN = {
    Text = "即使是最平凡的人，也能被这些诗句打动……这朵花为你而绽放！"
  },
  LanguageConfig_LotteryPhoneticDialogue12_CN = {
    Text = "诗有自己的情绪，就像花有自己的花语。这是献给你的。"
  },
  LanguageConfig_LotteryPhoneticDialogue13_CN = {
    Text = "请注视吧，我将永远战斗。"
  },
  LanguageConfig_LotteryPhoneticDialogue14_CN = {
    Text = "你是来见证我的凯旋的吗？"
  },
  LanguageConfig_LotteryPhoneticDialogue15_CN = {
    Text = "努力吧，挣扎吧，好孩子，想要老师摸摸头吗？"
  },
  LanguageConfig_LotteryPhoneticDialogue16_CN = {
    Text = "靠这些破烂，你又能拯救什么？"
  },
  LanguageConfig_LotteryPhoneticDialogue17_CN = {
    Text = "哎呀，客人的手气很好呢，要不要再试一次？"
  },
  LanguageConfig_LotteryPhoneticDialogue18_CN = {
    Text = "要再看看吗？小店还有更珍贵的货品哦。"
  },
  LanguageConfig_LotteryPhoneticDialogue19_CN = {
    Text = "这份报告非常美味，多谢款待。"
  },
  LanguageConfig_LotteryPhoneticDialogue1_CN = {
    Text = "感谢你的爱心，亲爱的。"
  },
  LanguageConfig_LotteryPhoneticDialogue20_CN = {
    Text = "嗯，我收下了。还有其他的么？"
  },
  LanguageConfig_LotteryPhoneticDialogue21_CN = {
    Text = "谢谢你的礼物，还请收下这些。"
  },
  LanguageConfig_LotteryPhoneticDialogue22_CN = {
    Text = "我找到了些珍贵的材料，希望对你有些帮助。"
  },
  LanguageConfig_LotteryPhoneticDialogue23_CN = {
    Text = "一份简单的前菜，祝您用餐愉快。"
  },
  LanguageConfig_LotteryPhoneticDialogue24_CN = {
    Text = "由圣主亲制的主菜，还合您的胃口吗，客人？"
  },
  LanguageConfig_LotteryPhoneticDialogue25_CN = {
    Text = "别太在意技法与规则。"
  },
  LanguageConfig_LotteryPhoneticDialogue26_CN = {
    Text = "理性只教你描摹，疯狂才能让你创造。"
  },
  LanguageConfig_LotteryPhoneticDialogue27_CN = {
    Text = "世人畏惧疯狂，是因他们未曾见过真实。"
  },
  LanguageConfig_LotteryPhoneticDialogue28_CN = {
    Text = "你看到了吗？真实的世界！"
  },
  LanguageConfig_LotteryPhoneticDialogue29_CN = {
    Text = "我看到了真实的色彩，多么美妙。"
  },
  LanguageConfig_LotteryPhoneticDialogue2_CN = {
    Text = "哎呀，这可真是不错的运气！拿好了哦。"
  },
  LanguageConfig_LotteryPhoneticDialogue30_CN = {
    Text = "疯狂和荒诞，才是真实之美，艺术之美！"
  },
  LanguageConfig_LotteryPhoneticDialogue31_CN = {
    Text = "黑色，黑色仍然在这里，继续洗刷你的罪孽吧。"
  },
  LanguageConfig_LotteryPhoneticDialogue32_CN = {
    Text = "多么美丽，我看见了你纯净的灵魂……"
  },
  LanguageConfig_LotteryPhoneticDialogue33_CN = {
    Text = "喂，守密人！就算当时的事再重来一次，你也会救我的对吧？\n……那我就能安心睡个好觉了。谢、咳，我是说，谢谢。"
  },
  LanguageConfig_LotteryPhoneticDialogue34_CN = {
    Text = "最近一直梦到以前的事情，烦死了，这东西最好是有点用。"
  },
  LanguageConfig_LotteryPhoneticDialogue35_CN = {
    Text = "神母为神国做出了崇高的牺牲，我们愿用一切换取她的安宁。"
  },
  LanguageConfig_LotteryPhoneticDialogue36_CN = {
    Text = "多谢您对神母的进奉，希望这能为她带来一夜好眠。"
  },
  LanguageConfig_LotteryPhoneticDialogue37_CN = {
    Text = "这场梦会永不休止地循环下去，而你……\n庆幸吧，我将恩准你加入其中。"
  },
  LanguageConfig_LotteryPhoneticDialogue38_CN = {
    Text = "你见过我的梦是什么样的吗？那种不洁且污秽到极致的场面……"
  },
  LanguageConfig_LotteryPhoneticDialogue39_CN = {
    Text = "身外之物何其冗余，您若有什么愿望，不妨直接向妾身诉说……"
  },
  LanguageConfig_LotteryPhoneticDialogue3_CN = {
    Text = "你这可算捡到宝了，年轻人，我这店铺里的东西可都是上古遗物啊！"
  },
  LanguageConfig_LotteryPhoneticDialogue40_CN = {
    Text = "您若身处远东的荒旧废墟，切记万万不可胡乱祭奉——妖鬼野狐？嘻……那些可不值一提呢。"
  },
  LanguageConfig_LotteryPhoneticDialogue41_CN = {
    Text = "小煤球，最棒！"
  },
  LanguageConfig_LotteryPhoneticDialogue42_CN = {
    Text = "小煤球，厉害！"
  },
  LanguageConfig_LotteryPhoneticDialogue43_CN = {
    Text = "亮晶晶！送给，小煤球！"
  },
  LanguageConfig_LotteryPhoneticDialogue44_CN = {
    Text = "朋友，喜欢！莫丝，小煤球，交换！"
  },
  LanguageConfig_LotteryPhoneticDialogue45_CN = {
    Text = "海螺，好漂亮！莫丝，收藏！小煤球，奖励！"
  },
  LanguageConfig_LotteryPhoneticDialogue46_CN = {
    Text = "莫丝，喜欢！谢谢，小煤球！"
  },
  LanguageConfig_LotteryPhoneticDialogue47_CN = {
    Text = "没错……被命运遗弃的人啊，打破它的囚笼吧！"
  },
  LanguageConfig_LotteryPhoneticDialogue48_CN = {
    Text = "呵，命运的一个小小玩笑。"
  },
  LanguageConfig_LotteryPhoneticDialogue49_CN = {
    Text = "繁殖、成长，这些都和爱息息相关。"
  },
  LanguageConfig_LotteryPhoneticDialogue4_CN = {
    Text = "竟然被这么强大的魔法选中了，难道你是传说中的天选之子吗？"
  },
  LanguageConfig_LotteryPhoneticDialogue50_CN = {
    Text = "在我孤身到达那个世界的时候，有个人教会了我很多、很多知识，直到今天也一直努力学习着。"
  },
  LanguageConfig_LotteryPhoneticDialogue51_CN = {
    Text = "你曾被什么人无所保留地爱过，或者抛却一切地爱过什么人吗？\n我觉得那是一件非常美好的事。"
  },
  LanguageConfig_LotteryPhoneticDialogue52_CN = {
    Text = "人类的恋爱、不，生物的恋爱，真是奇妙啊。\n比自己还要重要的存在，比一切都要重要的存在。"
  },
  LanguageConfig_LotteryPhoneticDialogue53_CN = {
    Text = "请和我一起等待吧，那个闪耀的、光辉的、美丽的世界的开始。"
  },
  LanguageConfig_LotteryPhoneticDialogue54_CN = {
    Text = "谢谢你的礼物，它应该会带来一些新发现。"
  },
  LanguageConfig_LotteryPhoneticDialogue55_CN = {
    Text = "嘶……真的假的？中大彩了？！"
  },
  LanguageConfig_LotteryPhoneticDialogue56_CN = {
    Text = "这种小丫头的话你也信？"
  },
  LanguageConfig_LotteryPhoneticDialogue57_CN = {
    Text = "太好了！不，我想找的东西并不在这里……但我很为大家的收获开心。"
  },
  LanguageConfig_LotteryPhoneticDialogue58_CN = {
    Text = "我……相信大家，一定都能实现自己的愿望。"
  },
  LanguageConfig_LotteryPhoneticDialogue59_CN = {
    Text = "嘻嘻，来领受吧，不要逃跑哦，好好享受真正的、仙女的赐福~"
  },
  LanguageConfig_LotteryPhoneticDialogue5_CN = {
    Text = "嗯？啊，拿走吧。感谢你的爱心之类的。"
  },
  LanguageConfig_LotteryPhoneticDialogue60_CN = {
    Text = "还差一点，就差一点点啦，再来一次~"
  },
  LanguageConfig_LotteryPhoneticDialogue61_CN = {
    Text = "临时文本"
  },
  LanguageConfig_LotteryPhoneticDialogue62_CN = {
    Text = "临时文本"
  },
  LanguageConfig_LotteryPhoneticDialogue63_CN = {
    Text = "临时文本"
  },
  LanguageConfig_LotteryPhoneticDialogue64_CN = {
    Text = "临时文本"
  },
  LanguageConfig_LotteryPhoneticDialogue65_CN = {
    Text = "临时文本"
  },
  LanguageConfig_LotteryPhoneticDialogue66_CN = {
    Text = "临时文本"
  },
  LanguageConfig_LotteryPhoneticDialogue6_CN = {
    Text = "哦，运气不错嘛。不像隔壁大约翰，我的东西都是讲究实际效果的。希望它能对你有用。"
  },
  LanguageConfig_LotteryPhoneticDialogue7_CN = {
    Text = "将你最深重的欲望表露于我……我将予你渴求之物。"
  },
  LanguageConfig_LotteryPhoneticDialogue8_CN = {
    Text = "我能感受到你的不满足……那就期盼我、索求我吧。"
  },
  LanguageConfig_LotteryPhoneticDialogue9_CN = {
    Text = "静静聆听吧。这清脆的声响，便是神国对你的回应。"
  },
  LanguageConfig_LotteryProgressText_CN = {
    Text = "剩余：{s1}/{s2}"
  },
  LanguageConfig_LotteryResetBtnText_CN = {
    Text = "重置{s1}/{s2}"
  },
  LanguageConfig_LotteryRuleContent_CN = {
    Text = "1、「柯蕾特的花房」共有三个花圃，开启时间如下：\n·「鸢尾花圃」： 7 月 15 日 9 时开启。\n·「桔梗花圃」： 7 月 17 日 9 时开启。\n·「蔷薇花圃」： 7 月 19 日 9 时开启。\n2、每次交换将消耗 1000「惆怅的诗文」/「遗憾的诗文」/「欢欣的诗文」，随机获得花圃中的五个物品奖励。\n3、每个花圃的物品奖励分为「特殊物品」和「普通物品」两种，重置时可以使特殊物品奖励的剩余数量重置至上限，具体规则为：\n（1）前2次重置：当「特殊物品」无剩余数量后，守密人可以选择重置，重置后会将「特殊物品」和「普通物品」的剩余数量重置至上限；也可以选择继续交换，当「普通物品」也无剩余数量后，须进行重置才可以继续交换。\n（2）第3次开始重置：当「普通物品」无剩余数量后才可以进行重置，重置会将「普通物品」的剩余数量重置至上限，「特殊物品」不再重置。\n4、8 月 5 日 9:00（GMT+8）后，剩余未交换的「诗文」将按照每200个兑换「蔷薇金券*5000」的比例进行回收，请守密人注意查收邮件。"
  },
  LanguageConfig_LotteryRuleTitle_CN = {
    Text = "规则说明"
  },
  LanguageConfig_LuckyBagRedDotText_CN = {Text = "推荐"},
  LanguageConfig_LuckyTime_1_CN = {
    Text = "好运时间：1"
  },
  LanguageConfig_LuckyTime_2_CN = {
    Text = "好运时间：2"
  },
  LanguageConfig_LuckyTime_3_CN = {
    Text = "好运时间：3"
  },
  LanguageConfig_LuckyTime_4_CN = {
    Text = "好运时间-绝佳好运：4！"
  },
  LanguageConfig_LuckyTime_5_CN = {
    Text = "好运时间-绝佳好运：5！"
  },
  LanguageConfig_MLYMResonance1_1_CN = {
    Text = "【牺牲珍视之物】随机失去「温暖的家庭」、「诚挚的朋友」或「安定的生活」中的 1 张卡。"
  },
  LanguageConfig_MLYMResonance1_2_CN = {
    Text = "【献祭珍视之物】选择失去「温暖的家庭」、「诚挚的朋友」或「安定的生活」中的 1 张卡,并加入1张「神国幻影」。"
  },
  LanguageConfig_Mail_BackpackFull_Message_CN = {
    Text = "尊敬的守密人，您于{s1}中获得的奖励因背包已满未能领取，现以邮件奖励补发给您，请及时清理背包"
  },
  LanguageConfig_Mail_BackpackFull_Sender_CN = {
    Text = "Z1项目组"
  },
  LanguageConfig_Mail_BackpackFull_Title_CN = {
    Text = "系统奖励补发"
  },
  LanguageConfig_Mail_CheckPrompt_CN = {
    Text = "选择一封邮件查看"
  },
  LanguageConfig_Mail_CollectAll_CN = {
    Text = "全部领取"
  },
  LanguageConfig_Mail_CountDown_Day_CN = {
    Text = "{s1}天后到期"
  },
  LanguageConfig_Mail_CountDown_Hour_CN = {
    Text = "{s1}小时后到期"
  },
  LanguageConfig_Mail_CountDown_Soon_CN = {
    Text = "即将到期"
  },
  LanguageConfig_Mail_DeleteRead_CN = {
    Text = "删除已读"
  },
  LanguageConfig_Mail_Description_Detail_CN = {
    Text = "<Title:【邮件容量】>\n·邮箱最多保存100封邮件。\n·邮件到达上限时，系统会自动删除最早的邮件。\n·每封邮件都有有效期，到期后会自动删除。\n\n<Title:【珍藏邮件箱】>\n·生日祝福等特别邮件在领取完奖励后会放入邮件珍藏箱，并拥有永久的有效期。"
  },
  LanguageConfig_Mail_Description_Title_CN = {
    Text = "邮箱说明"
  },
  LanguageConfig_Mail_Number_CN = {Text = " {s1}/{s2}"},
  LanguageConfig_Mail_Number_Treasures_CN = {
    Text = "珍藏数 {s1}/{s2}"
  },
  LanguageConfig_Mail_Recive_CN = {Text = "领取"},
  LanguageConfig_Mail_SendTime_CN = {
    Text = "时间：{s1}"
  },
  LanguageConfig_Mail_Sender_CN = {
    Text = "发件人：{s1}"
  },
  LanguageConfig_Mail_Title_CN = {Text = "邮箱"},
  LanguageConfig_Mail_Treasures_CN = {
    Text = "邮件珍藏箱"
  },
  LanguageConfig_MainCopyOutPanelTrinketMaxTips_CN = {
    Text = "密契背包已满，新获得的密契已通过邮件下发"
  },
  LanguageConfig_MainCopyTitle_CN = {
    Text = "调查行动"
  },
  LanguageConfig_MainInterface_Awaker_CN = {Text = "唤醒体"},
  LanguageConfig_MainInterface_Bag_CN = {Text = "物资"},
  LanguageConfig_MainInterface_Battlepass_CN = {Text = "通行令"},
  LanguageConfig_MainInterface_Btn_Arena_CN = {
    Text = "幕间演习"
  },
  LanguageConfig_MainInterface_Btn_BOSS_CN = {
    Text = "超验存在"
  },
  LanguageConfig_MainInterface_Btn_DailyChallenge_CN = {
    Text = "幻梦深潜"
  },
  LanguageConfig_MainInterface_Btn_DailyCopy_CN = {
    Text = "融蚀之墟"
  },
  LanguageConfig_MainInterface_Btn_MultiTeamArena_CN = {
    Text = "狂蚀集训-开发中"
  },
  LanguageConfig_MainInterface_Btn_Send_CN = {Text = "派遣"},
  LanguageConfig_MainInterface_Btn_TrinketCopy_CN = {
    Text = "禁忌纂录"
  },
  LanguageConfig_MainInterface_Btn_WeekChallenge_CN = {
    Text = "无光之境"
  },
  LanguageConfig_MainInterface_Challenge_CN = {
    Text = "幕间演习"
  },
  LanguageConfig_MainInterface_Home_CN = {
    Text = "研究中心"
  },
  LanguageConfig_MainInterface_MainCopy_CN = {Text = "调查"},
  LanguageConfig_MainInterface_Recharge_CN = {Text = "商城"},
  LanguageConfig_MainInterface_Shop_CN = {
    Text = "交换商店"
  },
  LanguageConfig_MainInterface_Summon_CN = {Text = "唤醒"},
  LanguageConfig_MainLinesChallenge_CN = {Text = "调查"},
  LanguageConfig_MainLinesDetail_CN = {
    Text = "关卡详情"
  },
  LanguageConfig_MainLinesHard_CN = {Text = "困难"},
  LanguageConfig_MainLinesInvestigationResult_CN = {
    Text = "调查评价"
  },
  LanguageConfig_MainLinesInvestigation_CN = {Text = "调查"},
  LanguageConfig_MainLinesSimple_CN = {Text = "普通"},
  LanguageConfig_MainLines_AchieveCondition_CN = {
    Text = "成就条件（{s1}/{s2}）"
  },
  LanguageConfig_MainLines_Chapter0_CN = {Text = "序章"},
  LanguageConfig_MainLines_Chapter1_CN = {Text = "第一章"},
  LanguageConfig_MainLines_Chapter2_CN = {Text = "第二章"},
  LanguageConfig_MainLines_Chapter3_CN = {Text = "第三章"},
  LanguageConfig_MainLines_Chapter4_CN = {Text = "第四章"},
  LanguageConfig_MainLines_Chapter5_CN = {Text = "第五章"},
  LanguageConfig_MainLines_Chapter6_CN = {Text = "第六章"},
  LanguageConfig_MainLines_Chapter9_CN = {Text = "终章"},
  LanguageConfig_MainLines_Chapterx_CN = {
    Text = "第 {s1} 章"
  },
  LanguageConfig_MainLines_CompleteInvestigation_CN = {
    Text = "完成调查"
  },
  LanguageConfig_MainLines_CurrentProgressGreen_CN = {
    Text = "当前：<GreenQuality:{s1}>"
  },
  LanguageConfig_MainLines_CurrentProgressRed_CN = {
    Text = "当前：<RedQuality:{s1}>"
  },
  LanguageConfig_MainLines_DiamondMapNodeTips_CN = {
    Text = "本次为特殊体验，不获得物品。"
  },
  LanguageConfig_MainLines_HideCondition_CN = {
    Text = "隐藏条件（{s1}/{s2}）"
  },
  LanguageConfig_MainLines_Investigation_Reward_CN = {
    Text = "调查奖励"
  },
  LanguageConfig_MainLines_NextStep_CN = {Text = "下一步"},
  LanguageConfig_MainLines_StopThere_CN = {
    Text = "止步于此"
  },
  LanguageConfig_MainLines_ThreeStarConditionTips_CN = {
    Text = "调查评价"
  },
  LanguageConfig_MainLines_ThreeStarCondition_CN = {
    Text = "三星条件（{s1}/{s2}）"
  },
  LanguageConfig_MainLines_Ways_To_Lift_CN = {
    Text = "提升方式"
  },
  LanguageConfig_MainShopSingleBuyConfirmPanel_Lock_CN = {Text = "未解锁"},
  LanguageConfig_MainShopSingleBuyConfirmPanel_MaxPotency_CN = {
    Text = "启灵已达最高"
  },
  LanguageConfig_MainShopSingleBuyConfirmPanel_SellOut_CN = {Text = "已售罄"},
  LanguageConfig_Main_Title_3_CN = {
    Text = "学籍档案"
  },
  LanguageConfig_MapEvent_Key_Tips1_CN = {
    Text = "当前已拥有钥匙"
  },
  LanguageConfig_MapNodeChaosName_CN = {
    Text = "迷雾结节"
  },
  LanguageConfig_MapNodeKeyDescription_CN = {
    Text = "一串锈迹斑斑的钥匙，可帮助守密人打开锈蚀门扉。"
  },
  LanguageConfig_MatchSuccessful_CN = {
    Text = "准备对战"
  },
  LanguageConfig_MatchingPasswordBattle_CN = {
    Text = "正在匹配密码对战…"
  },
  LanguageConfig_MaxHp_CN = {
    Text = "最大生命"
  },
  LanguageConfig_MaxLevelWeaponShopTips_CN = {
    Text = "叠位已满"
  },
  LanguageConfig_MaxLevel_Str_CN = {Text = "Max"},
  LanguageConfig_MaxLevel_Tips_CN = {Text = "已满级"},
  LanguageConfig_MaxLevel_Tips_Exp_CN = {Text = "已满级"},
  LanguageConfig_MaxLvPreview_Txt_CN = {
    Text = "<color=#5EF2FF>{s1}</color>"
  },
  LanguageConfig_MaxPotencyAwakerShopTips_CN = {
    Text = "人格深化已满"
  },
  LanguageConfig_Minute_CN = {Text = "分"},
  LanguageConfig_MockDungeonTitle_CN = {
    Text = "模拟训练"
  },
  LanguageConfig_MonsterHideIntention_CN = {Text = "未知"},
  LanguageConfig_MonsterMeatReaction1_CN = {
    Text = "不是……我的……错……"
  },
  LanguageConfig_MonsterMeatReaction2_CN = {
    Text = "不ﾉ是ｲ...驫我8的ﾃ...P错ｬ..."
  },
  LanguageConfig_MonsterMeatReaction3_CN = {
    Text = "只想……活下去……"
  },
  LanguageConfig_MonsterMeatReaction4_CN = {
    Text = "只ﾗ想ｸ...ﾎ麤活ﾑ下w去ｦ..."
  },
  LanguageConfig_MonsterMeatTips1_CN = {
    Text = "肉ﾑ块w似ｦ乎J能ﾒ认ｩ知ﾇ齉唤ｯ醒7体ﾘ卡L牌ﾝ,但Q过ｱ量ﾏ的r认ｮ知ﾌ会d侵ﾙ蚀3它ｪ的ﾔ龥意G识ｽ...ﾈ..."
  },
  LanguageConfig_MonsterMeatTips2_CN = {
    Text = "肉块似乎能认知唤醒体卡牌，但过量的认知会侵蚀它的意识……"
  },
  LanguageConfig_MonsterMeat_Bubble1_CN = {
    Text = "可ﾐ以4Pｾ......喰qｪ齉ﾙ掉Kt......nの東鬱ｿ7西ｪ"
  },
  LanguageConfig_MonsterMeat_Bubble2_CN = {
    Text = "可以……吃掉……的东西"
  },
  LanguageConfig_MonsterMeat_Name_CN = {
    Text = "古怪肉块"
  },
  LanguageConfig_Monster_2ndAnniversary_WorldBoss1_CN = {
    Text = "敌人的影响让你难以打出卡牌！跟随银钥的指引战胜悲泣之化身！"
  },
  LanguageConfig_Monster_2ndAnniversary_WorldBoss2_CN = {
    Text = "释放狂气的手段似乎遭到了限制，爆发更多的狂气来突破恐惧之化身的封锁吧。"
  },
  LanguageConfig_Monster_2ndAnniversary_WorldBoss3_CN = {
    Text = "唤醒体的能力会被逐渐溶解，试着将力量集中于一人来战胜刺骨之化身！"
  },
  LanguageConfig_Monster_2ndAnniversary_WorldBoss4_CN = {
    Text = "敌人的锁链会影响你多次出手的能力，多次爆发突破封印即可战胜诡谲之化身！"
  },
  LanguageConfig_Monster_2ndAnniversary_WorldBoss5_CN = {
    Text = "通常的攻击手段似乎不太起作用…尝试换个思路来击破邪信之化身……"
  },
  LanguageConfig_Monster_2ndAnniversary_WorldBoss6_CN = {
    Text = "敌人的疯狂会让你丢失自我，回转更多的指令卡来对抗疯狂，战胜疯狂之化身！"
  },
  LanguageConfig_Monster_2ndAnniversary_WorldBoss7_CN = {
    Text = "敌人的再生能力极强且能清除状态影响，每回合稳定造成伤害来击破诞临之化身！"
  },
  LanguageConfig_Monster_6unit_B0006_Tips1_CN = {
    Text = "自…女儿的…中……醒来……"
  },
  LanguageConfig_Monster_6unit_B0006_Tips2_CN = {
    Text = "蜕变…自此而生……"
  },
  LanguageConfig_Monster_6unit_B0006_Tips3_CN = {
    Text = "螺湮的暂熄……不…余不要……"
  },
  LanguageConfig_Monster_6unit_C0602_tips1_CN = {
    Text = "自寄主中重生……"
  },
  LanguageConfig_Monster_6unit_C0602boss_tips1_CN = {
    Text = "我···看到你了······"
  },
  LanguageConfig_Monster_6unit_C0602boss_tips2_CN = {
    Text = "敌人正要以惊人速度回复生命，对其造成伤害来阻止它！"
  },
  LanguageConfig_Monster_6unit_C0603_BOSSSIZE_Tips1_CN = {
    Text = "见证吧，见证此身蒙神恩之力……！"
  },
  LanguageConfig_Monster_6unit_C0603_Tips1_CN = {
    Text = "诞生…嘶…诞生……"
  },
  LanguageConfig_Monster_6unit_C0603_tips1_CN = {
    Text = "我的珊瑚…希望你能喜欢…"
  },
  LanguageConfig_Monster_6unit_C0603_tips2_CN = {
    Text = "敌人每损失一定生命，就会有「变异珊瑚」自体内生成！"
  },
  LanguageConfig_Monster_6unit_EndBoss_Select_Card_Tips_CN = {
    Text = "选择一个效果释放"
  },
  LanguageConfig_Monster_8unit_EndBoss_Num3_Tips_CN = {
    Text = "不要攻击光之子！击败暗之子来唤醒她吧！"
  },
  LanguageConfig_Monster_8unit_EndBoss_Select_TaweiCard_Tips1_CN = {
    Text = "是吗？在怨恨的锁链遍布中…拯救你的伙伴们吧。"
  },
  LanguageConfig_Monster_8unit_EndBoss_Select_TaweiCard_Tips2_CN = {
    Text = "是吗？在无数的畸变衍生中…拯救你看重的世界吧。"
  },
  LanguageConfig_Monster_8unit_EndBoss_Select_TaweiCard_Tips3_CN = {
    Text = "是吗？在自身的方向迷失中…拯救你自己吧。"
  },
  LanguageConfig_Monster_8unit_EndBoss_Select_TaweiCard_Tips4_CN = {
    Text = "沉默，犹疑，软弱…你的弱点是致命的，守密人。"
  },
  LanguageConfig_Monster_8unit_EndBoss_Select_TaweiCard_Tips_CN = {
    Text = "回应塔薇"
  },
  LanguageConfig_Monster_AF_C09_CN = {
    Text = "潘狄娅会狠狠惩罚胆敢攻击她的坏孩子……"
  },
  LanguageConfig_Monster_ALKNSpider_DarkTips_CN = {
    Text = "哭吧，笑吧！那宿命的终末，就快要来临！"
  },
  LanguageConfig_Monster_ALKNSpider_LightTips_CN = {
    Text = "睡吧，睡吧……那宿命的结局，将于此降临……"
  },
  LanguageConfig_Monster_ALKN_Bubble1_CN = {
    Text = "转动吧，纺轮将织就万物。"
  },
  LanguageConfig_Monster_ALKN_Bubble2_CN = {
    Text = "命运捆缚你我，无人可以逃离……"
  },
  LanguageConfig_Monster_ALKN_Bubble3_CN = {
    Text = "裁断吧，无法挽回的命运啊。"
  },
  LanguageConfig_Monster_ALKN_DarkTips1_CN = {
    Text = "命运的终局，就快要降临……"
  },
  LanguageConfig_Monster_ALKN_DarkTips2_CN = {
    Text = "接受吧，阿拉克涅……命运，将为你带来解脱！！"
  },
  LanguageConfig_Monster_ALKN_DarkTips3_CN = {
    Text = "「过去——以命运的丝线封缄，你将永坠沉默之渊！」"
  },
  LanguageConfig_Monster_ALKN_DarkTips4_CN = {
    Text = "「现在—— 让一切命数与编织的谎言，统统化为灰烬！」"
  },
  LanguageConfig_Monster_ALKN_DarkTips5_CN = {
    Text = "「未来——将这枚荆棘的种子，深埋入明日的土壤。未来，我们一无所有……」"
  },
  LanguageConfig_Monster_ALKN_DarkTips6_CN = {
    Text = "「断吧……断吧！来啊，命运！我用一切被抛弃的尸骨，为你献上这最后一支悲歌！」"
  },
  LanguageConfig_Monster_ALKN_Tips1_CN = {
    Text = "每回合首张指令卡会落入维度裂隙，释放钥令将它拨回原轨。"
  },
  LanguageConfig_Monster_ALKN_Tips2_CN = {
    Text = "维度裂隙中的卡牌已被堕落的命运污染，谨慎打出！"
  },
  LanguageConfig_Monster_Agrippa_bubble_01_CN = {
    Text = "卑贱的家伙……竟敢这么对我！"
  },
  LanguageConfig_Monster_Agrippa_bubble_tips_01_CN = {
    Text = "当心！敌人的攻击会附带中毒效果。"
  },
  LanguageConfig_Monster_Agrippa_bubble_tips_02_CN = {
    Text = "敌人受到一定伤害后会获得加固并转换为防御姿态。"
  },
  LanguageConfig_Monster_Awaker_O04_Tips_1_CN = {
    Text = "凯刻斯正在以惊人的速度愈合伤口，攻击以干扰他的回复！"
  },
  LanguageConfig_Monster_B0001_1_CN = {
    Text = "你感觉身体逐渐变得沉重，难以给唤醒体下指令…"
  },
  LanguageConfig_Monster_B0001_2_CN = {
    Text = "对不起…"
  },
  LanguageConfig_Monster_B0001_3_CN = {
    Text = "当心！本回合未被打出的卡牌都将化为石头…"
  },
  LanguageConfig_Monster_B0002_1_CN = {
    Text = "好饿，乔治好饿……"
  },
  LanguageConfig_Monster_B0002_2_CN = {
    Text = "不要抛弃乔治，不要抛弃我们……！"
  },
  LanguageConfig_Monster_B0002_Tips_1_CN = {
    Text = "乔治正准备号令他的伙伴们……"
  },
  LanguageConfig_Monster_B0003_Tips_1_CN = {
    Text = "疯狂与融蚀正在吞没你的卡牌，打出的卡牌将被消耗。"
  },
  LanguageConfig_Monster_B0003_Tips_2_CN = {
    Text = "封锁…世界之扉！"
  },
  LanguageConfig_Monster_B0004_1_CN = {
    Text = "「梭行维度之犬」盯上你了……注意维度裂隙，放入卡牌来保护自己！"
  },
  LanguageConfig_Monster_B0004_2_CN = {
    Text = "撕裂……现实！"
  },
  LanguageConfig_Monster_B0005_1_CN = {
    Text = "「可恶的…不敬之人…」"
  },
  LanguageConfig_Monster_B0005_2_CN = {
    Text = "「沉睡之主，听吾呼唤…」"
  },
  LanguageConfig_Monster_B0005_3_CN = {
    Text = "「永恒@1，候@1入梦…」"
  },
  LanguageConfig_Monster_B0005_4_CN = {
    Text = "「混沌将散，群星…归位」"
  },
  LanguageConfig_Monster_B0005_5_CN = {
    Text = "「主啊，容我僭越，对不敬者予以仲裁……！」"
  },
  LanguageConfig_Monster_B0005_6_CN = {
    Text = "「不…不！为何阻拦……！」"
  },
  LanguageConfig_Monster_B0005_7_CN = {
    Text = "「亵渎之徒…降以极刑！」"
  },
  LanguageConfig_Monster_B0005_CN = {
    Text = "「渎神者…我将以代行者之名，降下神罚！」"
  },
  LanguageConfig_Monster_B0005_Tips_1_CN = {
    Text = "曾名为「弥利亚姆」的异怪，正在祈祷神之注视……"
  },
  LanguageConfig_Monster_B0007_SideDia1_CN = {
    Text = "母树吞噬了大量亚兰血肉……"
  },
  LanguageConfig_Monster_B0007_SideDia2_CN = {
    Text = "母树树瘤内传来生命的搏动……"
  },
  LanguageConfig_Monster_B0007_SideDia3_CN = {
    Text = "祂即源流，祂即丰穰，祂孕育万千子嗣……"
  },
  LanguageConfig_Monster_B0008_Name1_CN = {
    Text = "「双子神像」"
  },
  LanguageConfig_Monster_B0008_Name2_CN = {
    Text = "「暗之子」"
  },
  LanguageConfig_Monster_B0008_Name3_CN = {
    Text = "「遗忘的伊始」"
  },
  LanguageConfig_Monster_B0008_Name4_CN = {
    Text = "「终焉的遗忘之理」"
  },
  LanguageConfig_Monster_B0008_SideDia10_CN = {
    Text = "抱歉…守密人…我只能坚持到这里了…"
  },
  LanguageConfig_Monster_B0008_SideDia11_CN = {
    Text = "于丽埃特已经放弃了支援神像…战胜它吧！"
  },
  LanguageConfig_Monster_B0008_SideDia1_CN = {
    Text = "当心矛盾体的融合度！完全融合后，拉蒙娜的意识将陷入危险…"
  },
  LanguageConfig_Monster_B0008_SideDia2_CN = {
    Text = "于丽埃特借用了门扉的力量，神像的融合度每回合都在提升！"
  },
  LanguageConfig_Monster_B0008_SideDia3_CN = {
    Text = "「遗忘」的力量影响了精神维度，乐音将无法再传达…"
  },
  LanguageConfig_Monster_B0008_SideDia4_CN = {
    Text = "当心双子的融合度！若其达到 100%，拉蒙娜的意识可能会受到较大影响…"
  },
  LanguageConfig_Monster_B0008_SideDia5_CN = {
    Text = "无谓的挣扎…门扉的力量，守护神像的孕育吧…"
  },
  LanguageConfig_Monster_B0008_SideDia6_CN = {
    Text = "回归吧，拉蒙娜…让我们一起，迎接最终的遗忘之理…"
  },
  LanguageConfig_Monster_B0008_SideDia7_CN = {
    Text = "完美的融合…就是此时！重塑万物之光…"
  },
  LanguageConfig_Monster_B0008_SideDia8_CN = {
    Text = "为何逃避……那最终的……遗忘的净化！"
  },
  LanguageConfig_Monster_B0008_SideDia9_CN = {
    Text = "侵食…毁灭…遗忘…净化！"
  },
  LanguageConfig_Monster_B0009_Name1_CN = {
    Text = "「托乎瓦波，亘古混沌」"
  },
  LanguageConfig_Monster_B0009_SideDia1_CN = {
    Text = "*&…………*&%&"
  },
  LanguageConfig_Monster_B0009_SideDia2_CN = {
    Text = "&%……&重……&启&&*……破碎……"
  },
  LanguageConfig_Monster_B0009_SideDia3_CN = {
    Text = "原初的混沌即将在数回合后降临…但当务之急是应对这些源源不断的目光…在合适的时机击破敌人来获得喘息！"
  },
  LanguageConfig_Monster_B0009_SideDia4_CN = {
    Text = "&%…万千世界%……¥&*…降临………"
  },
  LanguageConfig_Monster_B0009_SideDia5_CN = {
    Text = "……融蚀……消亡"
  },
  LanguageConfig_Monster_B0009_SideDia6_CN = {
    Text = "……无上……威压"
  },
  LanguageConfig_Monster_B0009_SideDia7_CN = {
    Text = "……遗忘……"
  },
  LanguageConfig_Monster_B0009_SideDia8_CN = {
    Text = "……锁链……"
  },
  LanguageConfig_Monster_B0009_SideDia9_CN = {
    Text = "融蚀雾盾已被破除！旅途的追忆重新回到了你的抽牌堆，这使你充满了决心…"
  },
  LanguageConfig_Monster_B05EX_SideDia10_CN = {
    Text = "斩断链接之人带着怎样的力量与决心，让我看看吧，守密人。"
  },
  LanguageConfig_Monster_B05EX_SideDia11_CN = {
    Text = "链接正在逐渐减弱…如果这就是你坚持的道路的话，我会支持你的。"
  },
  LanguageConfig_Monster_B05EX_SideDia12_CN = {
    Text = "挣扎在无尽的融蚀黑潮中吧——深渊之门，已然开启！"
  },
  LanguageConfig_Monster_B05EX_SideDia13_CN = {
    Text = "当心！朵尔的「终末」正在堆积……达到 10层后她将引来真正的末日……"
  },
  LanguageConfig_Monster_B05EX_SideDia15_CN = {
    Text = "末日…终于降临了！"
  },
  LanguageConfig_Monster_B05EX_SideDia16_CN = {
    Text = "在深暗的未知面前，化为虚无吧。"
  },
  LanguageConfig_Monster_B05EX_SideDia17_CN = {
    Text = "朵尔分体在受到致死伤害后，会移动到后排并造成更高的伤害！控制节奏！"
  },
  LanguageConfig_Monster_B05EX_SideDia18_CN = {
    Text = "真可惜。又要浪费一个备用躯体。"
  },
  LanguageConfig_Monster_B05EX_SideDia19_CN = {
    Text = "这就是我的第一哲学。"
  },
  LanguageConfig_Monster_B05EX_SideDia1_CN = {
    Text = "聆听吧…亘古寒冰的低语…！"
  },
  LanguageConfig_Monster_B05EX_SideDia20_CN = {Text = "1……"},
  LanguageConfig_Monster_B05EX_SideDia21_CN = {Text = "2……"},
  LanguageConfig_Monster_B05EX_SideDia22_CN = {Text = "3……"},
  LanguageConfig_Monster_B05EX_SideDia23_CN = {Text = "4……"},
  LanguageConfig_Monster_B05EX_SideDia24_CN = {
    Text = "5……再快一点……"
  },
  LanguageConfig_Monster_B05EX_SideDia25_CN = {Text = "6……"},
  LanguageConfig_Monster_B05EX_SideDia26_CN = {Text = "7……"},
  LanguageConfig_Monster_B05EX_SideDia27_CN = {Text = "8……"},
  LanguageConfig_Monster_B05EX_SideDia28_CN = {Text = "9……"},
  LanguageConfig_Monster_B05EX_SideDia29_CN = {
    Text = "10！末日…终于降临了！"
  },
  LanguageConfig_Monster_B05EX_SideDia2_CN = {
    Text = "群山…在寒焰中苏醒…！"
  },
  LanguageConfig_Monster_B05EX_SideDia30_CN = {
    Text = "终末，即将降临…！"
  },
  LanguageConfig_Monster_B05EX_SideDia31_CN = {
    Text = "亲眼见证终末吧！"
  },
  LanguageConfig_Monster_B05EX_SideDia32_CN = {
    Text = "这里可是我的实验室…"
  },
  LanguageConfig_Monster_B05EX_SideDia33_CN = {
    Text = "好久不见，搭档。"
  },
  LanguageConfig_Monster_B05EX_SideDia3_CN = {
    Text = "每打出 3 张卡牌后会冻结 1 张指令卡，小心行事！"
  },
  LanguageConfig_Monster_B05EX_SideDia4_CN = {
    Text = "残余的冻结卡牌本回合会被全部粉碎，并化为敌人的伤害…当心！"
  },
  LanguageConfig_Monster_B05EX_SideDia5_CN = {
    Text = "当心！朵尔的「终末」正在堆积……达到 10层后她将引来真正的末日……"
  },
  LanguageConfig_Monster_B05EX_SideDia6_CN = {
    Text = "主君的力量，我见证了……"
  },
  LanguageConfig_Monster_B05EX_SideDia7_CN = {
    Text = "击破其护盾能够使其受到大量伤害，但也会使其获得临时力量。小心行事。"
  },
  LanguageConfig_Monster_B05EX_SideDia8_CN = {
    Text = "我将永远守护这份誓言！"
  },
  LanguageConfig_Monster_B05EX_SideDia9_CN = {
    Text = "只要缸中之脑不灭，「我」就源源不断。思考，然后行动。"
  },
  LanguageConfig_Monster_B05EX_bubble_01_CN = {
    Text = "挣扎吧。血链只会越缚越紧。"
  },
  LanguageConfig_Monster_B05EX_bubble_02_CN = {
    Text = "逃不掉的。到此为止吧！"
  },
  LanguageConfig_Monster_B05EX_bubble_03_CN = {
    Text = "这份仇怨……就用你们的血来偿还！"
  },
  LanguageConfig_Monster_B05EX_tips_01_CN = {
    Text = "每次打出指令卡都会使敌人获得「狂热」，谨慎出牌！"
  },
  LanguageConfig_Monster_B05EX_tips_02_CN = {
    Text = "本回合护盾能力失效。想尽办法生存吧！"
  },
  LanguageConfig_Monster_B05EX_tips_03_CN = {
    Text = "「嗜血链球」状态下「索魂者」免疫一切伤害和生命损失，注意应对！"
  },
  LanguageConfig_Monster_B05_Tips1_CN = {
    Text = "品尝我的绝望与愤怒吧！！"
  },
  LanguageConfig_Monster_B11AF_bubble_01_CN = {
    Text = "仙女驾到！还不献上供奉吗？"
  },
  LanguageConfig_Monster_B11AF_bubble_02_CN = {
    Text = "哼哼，这就是仙女的赐福！相信我，它一定会应验的！"
  },
  LanguageConfig_Monster_B11AF_bubble_03_CN = {
    Text = "小气鬼，画个圈圈诅咒你！"
  },
  LanguageConfig_Monster_B11AF_bubble_04_CN = {
    Text = "来吧，吞下这甜蜜的赐福吧！"
  },
  LanguageConfig_Monster_B11AF_bubble_05_CN = {
    Text = "满满当当的供奉！喜欢！"
  },
  LanguageConfig_Monster_B11AF_bubble_06_CN = {
    Text = "哈啊？什么叫一无所获？！"
  },
  LanguageConfig_Monster_B11AF_bubble_07_CN = {
    Text = "一半供奉也不错了～再接再厉～"
  },
  LanguageConfig_Monster_B11AF_tips_01_CN = {
    Text = "「白雪仙女」正在收取供奉，上供者可接受赐福，不上供者将招致惩罚。"
  },
  LanguageConfig_Monster_B11AF_tips_02_CN = {
    Text = "注意！「白雪仙女」将索要更多供奉。"
  },
  LanguageConfig_Monster_BZLLZ_1_CN = {
    Text = "猎颅者正在狩猎一名唤醒体，他的行动会强化猎颅者！"
  },
  LanguageConfig_Monster_C0102_AT_1_CN = {
    Text = "敌人变得疯狂了！对其展开攻击来降低威胁！"
  },
  LanguageConfig_Monster_C0102_AT_2_CN = {
    Text = "敌人正在准备进行一记重击！"
  },
  LanguageConfig_Monster_C0203_Tips_1_CN = {
    Text = "蜡像们使用了蜡油武装…！"
  },
  LanguageConfig_Monster_C0303_Tips_1_CN = {
    Text = "zzzzzZZZZZ······"
  },
  LanguageConfig_Monster_C0303_Tips_2_CN = {
    Text = "······？？？"
  },
  LanguageConfig_Monster_C0502_1_CN = {
    Text = "「再临，诞生，再临，诞生……」"
  },
  LanguageConfig_Monster_C0502_2_CN = {
    Text = "敌人将「海中之物」寄生在了你的身体内！打出卡牌会受到伤害并使其变弱！"
  },
  LanguageConfig_Monster_C0502_CN = {
    Text = "「我…看到你了……」"
  },
  LanguageConfig_Monster_C0503BOSS_Tips_1_CN = {
    Text = "剩余手牌越多敌人的攻击就越弱，保留更多手牌来减弱攻势！"
  },
  LanguageConfig_Monster_C0503BOSS_Tips_2_CN = {
    Text = "剩余手牌越多敌人就会获得更多屏障，尽可能打出手牌！"
  },
  LanguageConfig_Monster_C0503BOSS_Tips_3_CN = {
    Text = "当心！敌人的重击会弃掉你所有的手牌！"
  },
  LanguageConfig_Monster_C0603BOSS_Tips_1_CN = {
    Text = "敌人每失去一定生命，就会有「灵觉之子」自其腹中诞生！"
  },
  LanguageConfig_Monster_C0603_Title_CN = {
    Text = "当心！释放狂气爆发会使敌人获得「孕育」状态，增强敌人的力量，达到 5 层还会释放强力技能！"
  },
  LanguageConfig_Monster_C06_Tips_1_CN = {
    Text = "「分裂患者」即将发狂，快用「安闲之铃」降低她的狂气！"
  },
  LanguageConfig_Monster_C06_Tips_2_CN = {
    Text = "所有人都难逃一死……粉碎吧！"
  },
  LanguageConfig_Monster_C09_Tips_1_CN = {
    Text = "甜蜜恶鬼准备反击···！"
  },
  LanguageConfig_Monster_C11_SideDia1_CN = {
    Text = "我将护佑亚兰！"
  },
  LanguageConfig_Monster_C11_SideDia2_CN = {
    Text = "敌人准备释放心眼利刃！击破护盾来降低伤害！"
  },
  LanguageConfig_Monster_C702BOSS_SideDia1_CN = {
    Text = "「圣河努比亚」将要进行一次强力攻击！击败其他敌人来削弱它！"
  },
  LanguageConfig_Monster_C702_SideDia1_CN = {
    Text = "「塞尔凯特」将要进行一次强力攻击！击败其他敌人来削弱它！"
  },
  LanguageConfig_Monster_C702_SideDia2_CN = {
    Text = "似乎敌人将要潜入阴影中来保护自己…"
  },
  LanguageConfig_Monster_C702_SideDia3_CN = {
    Text = "&&……%暗影）&…袭&…%"
  },
  LanguageConfig_Monster_C703_SideDia1_CN = {
    Text = "&…%…&融为*（）一体&……%"
  },
  LanguageConfig_Monster_C703_SideDia2_CN = {
    Text = "当心！抽到症状或状态卡时，「努比亚」们会获得临时力量！"
  },
  LanguageConfig_Monster_C704BOSS_SideDia1_CN = {
    Text = "列阵！据守！"
  },
  LanguageConfig_Monster_C704BOSS_SideDia2_CN = {
    Text = "列阵！强攻！"
  },
  LanguageConfig_Monster_C704BOSS_SideDia3_CN = {
    Text = "你的血肉已还于圣河！"
  },
  LanguageConfig_Monster_C704BOSS_SideDia4_CN = {
    Text = "将士们！准备列阵！"
  },
  LanguageConfig_Monster_C706BOSS_SideDia1_CN = {
    Text = "以漫天黄沙…为你送葬……"
  },
  LanguageConfig_Monster_C706BOSS_SideDia2_CN = {
    Text = "当心！敌人将号令满天的黄沙，吞噬所有唤醒体的狂气！"
  },
  LanguageConfig_Monster_Castor_01_CN = {
    Text = "无论前方阻挡我们的是什么，我都会带他再次逃出去。"
  },
  LanguageConfig_Monster_Castor_02_CN = {
    Text = "你的愿望，我们的愿望……我一定会坚持下去的。"
  },
  LanguageConfig_Monster_Castor_03_CN = {
    Text = "敌人将释放所有蓄积的黑羽，注意防护！"
  },
  LanguageConfig_Monster_Chapter8_01_CN = {
    Text = "回复手段会受到影响，小心敌人的飞刃！"
  },
  LanguageConfig_Monster_Chapter8_02_CN = {
    Text = "释放钥令会使艾瑞卡的机体状态产生变化。想办法利用它！"
  },
  LanguageConfig_Monster_Chapter8_03_CN = {
    Text = "接收到不明指令。切换为进攻模式。"
  },
  LanguageConfig_Monster_Chapter8_04_CN = {
    Text = "接收到不明指令。切换为防御模式。"
  },
  LanguageConfig_Monster_Chapter8_05_CN = {
    Text = "打出与其意图对应算力的卡牌后会削弱敌人攻击，但也会将卡牌消耗。小心行事！"
  },
  LanguageConfig_Monster_Chapter8_06_CN = {
    Text = "尽可能阻挡「原初的乐音」，否则敌人将大幅增强自身……！"
  },
  LanguageConfig_Monster_Chapter8_07_CN = {
    Text = "尝试接下吧…我全心全力的一剑……！"
  },
  LanguageConfig_Monster_Chapter8_08_CN = {
    Text = "主人答应过……蜕变的我，将永久存续……！"
  },
  LanguageConfig_Monster_Chapter8_09_CN = {
    Text = "血肉的子嗣啊…成长吧……"
  },
  LanguageConfig_Monster_Chapter8_10_CN = {
    Text = "小心！敌人即将造成穿刺伤害和高额脆弱，护盾手段会受到影响！"
  },
  LanguageConfig_Monster_Chapter8_11_CN = {
    Text = "乖乖听话，我的小猫咪。"
  },
  LanguageConfig_Monster_Chapter8_12_CN = {
    Text = "平静下来，我的孩子。我会带你们，走上正确的道路……"
  },
  LanguageConfig_Monster_Chapter8_13_CN = {
    Text = "献上你们的掌声吧。演出，迎来高潮！"
  },
  LanguageConfig_Monster_Chapter8_14_CN = {
    Text = "为了提灯教会……！"
  },
  LanguageConfig_Monster_Chapter8_15_CN = {
    Text = "提灯将赐予我们光荣的进化！"
  },
  LanguageConfig_Monster_Chapter8_16_CN = {
    Text = "「N」移动到了分身之后……找到合适机会一举击破吧！"
  },
  LanguageConfig_Monster_Chapter8_17_CN = {
    Text = "敌人获得了超高额的加固…配合血污灯芯找到机会来终结对手吧！"
  },
  LanguageConfig_Monster_Corposant_01_CN = {
    Text = "冷光，在此领航……"
  },
  LanguageConfig_Monster_Corposant_02_CN = {
    Text = "航线已确定，全体注意。"
  },
  LanguageConfig_Monster_Corposant_03_CN = {
    Text = "牺牲不可避免，而我已做好了准备。"
  },
  LanguageConfig_Monster_Corposant_04_CN = {
    Text = "以雷霆，惩戒反抗者！"
  },
  LanguageConfig_Monster_Corposant_05_CN = {
    Text = "我将化为圣艾尔摩之火，照亮前路。"
  },
  LanguageConfig_Monster_Cursedbreath_Bubble_CN = {
    Text = "「净化罪孽者受祝……」"
  },
  LanguageConfig_Monster_Cursedbreath_Tips_CN = {
    Text = "尽可能格挡敌人攻击来避免其召唤！"
  },
  LanguageConfig_Monster_D08_SideDia1_CN = {
    Text = "侦测到敌对人员。电磁炮充能完毕，正在瞄准……"
  },
  LanguageConfig_Monster_DCD06_01_BOSSSIZE_SideDia1_CN = {
    Text = "敌人将会用认知错乱覆盖随机 1 名唤醒体的卡牌！"
  },
  LanguageConfig_Monster_DCD06_01_BOSSSIZE_SideDia2_CN = {
    Text = "让往昔的回忆，都随枯枝消逝。"
  },
  LanguageConfig_Monster_DCD06_01_BOSSSIZE_SideDia3_CN = {
    Text = "沉醉吧，在这如诗般的乐园……"
  },
  LanguageConfig_Monster_DCD06_01_SideDia1_CN = {
    Text = "敌人将会用认知失调覆盖随机 1 名唤醒体的卡牌！"
  },
  LanguageConfig_Monster_DYQ_1_CN = {
    Text = "敌人被「维度障壁」环绕，生命减少到一定程度后会获得大量护盾。"
  },
  LanguageConfig_Monster_Decay_Tips_CN = {
    Text = "回复生命超过 50% 最大生命即可解除腐朽状态——"
  },
  LanguageConfig_Monster_DeepSeaAcolyte_Tips_CN = {
    Text = "敌人的「血誓」会大幅增加临时触腕！造成伤害破除其「血誓」吧！"
  },
  LanguageConfig_Monster_Doresain_01_CN = {
    Text = "不要打扰我用餐。"
  },
  LanguageConfig_Monster_Doresain_02_CN = {
    Text = "成为我的食物吧。"
  },
  LanguageConfig_Monster_Doresain_03_CN = {
    Text = "你将为你的行为付出代价。"
  },
  LanguageConfig_Monster_Doresain_04_CN = {
    Text = "请小心，敌人消耗的残骸越多，本次力量提升效果就越强！"
  },
  LanguageConfig_Monster_FL01_CN = {
    Text = "迟缓效果让你难以打出卡牌！多多释放狂气爆发来战胜悲泣之化身！"
  },
  LanguageConfig_Monster_FL02_CN = {
    Text = "蜡像馆的灵魂渴望你的狂气…回转更多的指令卡来战胜恐惧之化身！"
  },
  LanguageConfig_Monster_FL03_CN = {
    Text = "特定卡牌会被逐渐溶解……把握你无法放弃的…从而战胜刺骨之化身……"
  },
  LanguageConfig_Monster_FL04_CN = {
    Text = "锁链与维度壁障是梭行维度之犬的拿手好戏……每回合尝试打出伤害即可战胜诡谲之化身……"
  },
  LanguageConfig_Monster_FL05_CN = {
    Text = "通常的攻击手段似乎不太起作用…尝试换个思路来击破邪信之化身……"
  },
  LanguageConfig_Monster_FL06_CN = {
    Text = "敌人会让你陷入疯狂…银钥或许能让你找回一部分理智…战胜疯狂之化身吧。"
  },
  LanguageConfig_Monster_FL07_CN = {
    Text = "敌人的再生能力极强且能够清除各种状态！尝试一举击破诞临之化身！"
  },
  LanguageConfig_Monster_FL08_CN = {
    Text = "姐姐…我原本想和你说些什么…"
  },
  LanguageConfig_Monster_FL09_CN = {
    Text = "拥抱吧…我们一起…就不会消失…"
  },
  LanguageConfig_Monster_FL10_CN = {
    Text = "请告诉我，真正的你是谁？"
  },
  LanguageConfig_Monster_FL11_CN = {
    Text = "不会的，不会的…那是治疗…"
  },
  LanguageConfig_Monster_FL12_CN = {
    Text = "这里可是我的实验室…"
  },
  LanguageConfig_Monster_FL13_CN = {
    Text = "终末，即将降临…！"
  },
  LanguageConfig_Monster_FL14_CN = {
    Text = "亲眼见证终末吧！"
  },
  LanguageConfig_Monster_FL15_CN = {
    Text = "@1go-@4 8的融蚀雾盾已被破除，承受的伤害大幅提高，趁此一举击溃祂……！"
  },
  LanguageConfig_Monster_FL16_CN = {
    Text = "@3想给你@3心理咨询@3"
  },
  LanguageConfig_Monster_FL17_CN = {
    Text = "@4痛楚……@2更多……"
  },
  LanguageConfig_Monster_FL18_CN = {
    Text = "敌人正在与巢群意志沟通，趁此发起攻击吧！"
  },
  LanguageConfig_Monster_FL19_CN = {
    Text = "当心，每次释放狂气爆发敌人都会获得临时疯狂。"
  },
  LanguageConfig_Monster_FL20_CN = {
    Text = "医生……医生！@1救我！"
  },
  LanguageConfig_Monster_FL21_CN = {
    Text = "@2们，献上……你@1的痛苦"
  },
  LanguageConfig_Monster_FL22_CN = {
    Text = "与我……链接……"
  },
  LanguageConfig_Monster_FL23_CN = {
    Text = "敌人获得了大量力量，但同时获得了旧日余烬，每回合受到的伤害提高……"
  },
  LanguageConfig_Monster_FL24_CN = {
    Text = "选择 1 名唤醒体，封印其所有卡牌和狂气爆发 3 回合。"
  },
  LanguageConfig_Monster_FL25_CN = {
    Text = "超维@1之蛹正在积蓄宇宙幽能，尽可能击杀虫族来打断它…！"
  },
  LanguageConfig_Monster_Faint_Bubble1_CN = {
    Text = "汀克特不想要我离开壳，但是她不在了……"
  },
  LanguageConfig_Monster_Faint_Bubble2_CN = {
    Text = "失控…危险…远离我……"
  },
  LanguageConfig_Monster_Faint_Tips1_CN = {
    Text = "菲茵特正在汲取养料……尝试对其造成伤害打断她！"
  },
  LanguageConfig_Monster_Faint_Tips2_CN = {
    Text = "每次打出指令卡都会被吸收力量，谨慎行动！"
  },
  LanguageConfig_Monster_Faros_bubble_tips_01_CN = {
    Text = "当心！防御住触腕伤害后会附带中毒效果！"
  },
  LanguageConfig_Monster_FishLeap_Bubble_CN = {
    Text = "鱼群飞跃!！"
  },
  LanguageConfig_Monster_Ghoul_01_CN = {
    Text = "葬骸城，庇佑我的魂灵…"
  },
  LanguageConfig_Monster_Ghoul_02_CN = {
    Text = "在巨浪面前化为尘土吧…"
  },
  LanguageConfig_Monster_Ghoul_03_CN = {
    Text = "很迅猛的攻击…但我不会倒下…！"
  },
  LanguageConfig_Monster_Ghoul_04_CN = {
    Text = "为了她…我绝不能倒下…！"
  },
  LanguageConfig_Monster_Ghoul_05_CN = {
    Text = "小心，敌人已经进入了狂暴状态，每次受到伤害都会获得临时力量！"
  },
  LanguageConfig_Monster_Ghoul_06_CN = {
    Text = "蹈海者的巨浪即将来袭…对其造成暴击来阻止它！"
  },
  LanguageConfig_Monster_HDN_SideDia1_CN = {
    Text = "霍迪妮大师要抓一个幸运小孩！谁会成为幸运儿呢~"
  },
  LanguageConfig_Monster_HDN_SideDia2_CN = {
    Text = "精妙绝伦的飞牌表演！"
  },
  LanguageConfig_Monster_HDN_SideDia3_CN = {
    Text = "霍迪妮大师的魔术秀~在此开场！"
  },
  LanguageConfig_Monster_HDN_SideDia4_CN = {
    Text = "去吧！魔术助手！把霍迪妮大师的观众抬上来！"
  },
  LanguageConfig_Monster_JL_Tips_1_CN = {
    Text = "珈伦进入了吃饱喝足状态！你每次消耗算力，珈伦都会获得力量！"
  },
  LanguageConfig_Monster_KM_1_CN = {
    Text = "敌人叠加了「反击」状态，谨慎采取攻击！"
  },
  LanguageConfig_Monster_KXY_SideDia1_CN = {
    Text = "既然不要了，不如消失掉吧！"
  },
  LanguageConfig_Monster_KXY_SideDia2_CN = {
    Text = "选哪张都没有用，没有用！"
  },
  LanguageConfig_Monster_KathiguRa_01_CN = {
    Text = "敌人觉醒后会弃置所有剩余手牌并赋予<BurningKeywords:燃烧>，谨慎行动！"
  },
  LanguageConfig_Monster_KathiguRa_02_CN = {
    Text = "在亿万耀光中，焚烧吧！"
  },
  LanguageConfig_Monster_KathiguRa_03_CN = {
    Text = "爆燃之火啊，在此重燃吧！"
  },
  LanguageConfig_Monster_KathiguRa_04_CN = {
    Text = "敌人将爆发强力攻击！打出燃烧卡牌来削弱敌人。"
  },
  LanguageConfig_Monster_LLZ_1_CN = {
    Text = "猎颅者正在进行追猎，每抽一张牌都会引起他的关注！"
  },
  LanguageConfig_Monster_LLZ_2_CN = {
    Text = "猎颅者正在狩猎一名唤醒体，他的行动会引发猎颅者的寻踪本能！"
  },
  LanguageConfig_Monster_LL_1_CN = {
    Text = "敌人受到一定程度伤害后将会转变行动方式！"
  },
  LanguageConfig_Monster_LL_2_CN = {
    Text = "敌人的护盾值在回合结束时将转化为生命，击破它吧！"
  },
  LanguageConfig_Monster_LT_1_CN = {
    Text = "敌人准备释放「灵知觉醒」来逆转局势！此时免疫一切伤害…"
  },
  LanguageConfig_Monster_Liz_Bubble1_CN = {
    Text = "于绿炎中净化吧！"
  },
  LanguageConfig_Monster_Liz_Bubble2_CN = {
    Text = "心怀敬意地欣赏吧，告死之舞……"
  },
  LanguageConfig_Monster_Liz_Tips1_CN = {
    Text = "敌人受到伤害后会进行强化，请谨慎行动！"
  },
  LanguageConfig_Monster_Liz_Tips2_CN = {
    Text = "敌人将释放告死之舞，弃掉所有卡牌，尽可能打出卡牌！"
  },
  LanguageConfig_Monster_Liz_Tips3_CN = {
    Text = "敌人损失生命后会为绿炎助燃，控制节奏！"
  },
  LanguageConfig_Monster_MLYM_Tips_CN = {
    Text = "当心！释放狂气爆发会使敌人获得「呼唤」状态，增强敌人的力量，达到 5 层还会释放强力技能！"
  },
  LanguageConfig_Monster_MadHorse_1_CN = {
    Text = "一回合内的每次伤害都会扩大敌人的融蚀伤口。"
  },
  LanguageConfig_Monster_MadHorse_2_CN = {
    Text = "如果没完全挡住伤害，会获得额外的「伤口」。"
  },
  LanguageConfig_Monster_Mofei_Tips_CN = {
    Text = "本回合对其造成的伤害必定暴击，找准机会吧！"
  },
  LanguageConfig_Monster_Mouchette_Bubble1_CN = {
    Text = "闪耀☆龙卷风——！！"
  },
  LanguageConfig_Monster_Mouchette_Bubble2_CN = {
    Text = "来吧，来吧！杀戮游戏开始了，让我们厮杀到世界尽头吧！"
  },
  LanguageConfig_Monster_Mouchette_Bubble3_CN = {
    Text = "锵☆锵！杀戮时间到——接下来该我了哟~"
  },
  LanguageConfig_Monster_Mouchette_Tips1_CN = {
    Text = "注意，每当「雾中骇兽」的攻击受到抵挡，都会让她变得更强！"
  },
  LanguageConfig_Monster_Mouchette_Tips2_CN = {
    Text = "当心，「雾中骇兽」的攻击每造成一次伤害，都会让她变得更加狂热！"
  },
  LanguageConfig_Monster_Neurotoxin_Bubble_CN = {
    Text = "践行「神母」的意志！"
  },
  LanguageConfig_Monster_Neurotoxin_Tips_CN = {
    Text = "敌人即将造成穿刺伤害，当心！"
  },
  LanguageConfig_Monster_NewUnit4_EndBoss_Bubble1_CN = {
    Text = "堕入轮回……永享乐土……"
  },
  LanguageConfig_Monster_NewUnit4_EndBoss_Bubble2_CN = {
    Text = "神国的荣耀，应照耀世间！"
  },
  LanguageConfig_Monster_NewUnit4_EndBoss_Bubble3_CN = {
    Text = "你将……面见轮回的枢纽……"
  },
  LanguageConfig_Monster_NewUnit4_EndBoss_Bubble4_CN = {
    Text = "无知者……你们早已身处于吾神的国度。"
  },
  LanguageConfig_Monster_NewUnit4_EndBoss_Tips1_CN = {
    Text = "击破「梦境桎梏」可降低迟缓，但也会使「乐园帷幕」的排斥效果更加强大……"
  },
  LanguageConfig_Monster_NewUnit4_EndBoss_Tips2_CN = {
    Text = "打出迟缓的卡牌可以降低敌人伤害次数……！"
  },
  LanguageConfig_Monster_NewUnit5_EndBoss_Bubble1_CN = {
    Text = "接受吧，阿拉克涅……命运，将为你带来解脱！！"
  },
  LanguageConfig_Monster_NewUnit5_EndBoss_Tips1_CN = {
    Text = "打出指令卡会使敌人命运的束缚逐渐降低，从而获得狂热……"
  },
  LanguageConfig_Monster_NewUnit5_EndBoss_Tips2_CN = {
    Text = "打出指令卡会进入维度裂隙，并赋予同名卡「命运残碎」。积累命运残碎，让阿拉克涅修正这扭曲的命运吧！"
  },
  LanguageConfig_Monster_O01_SideDia1_CN = {
    Text = "zzzZZZZ……"
  },
  LanguageConfig_Monster_O01_SideDia2_CN = {
    Text = "*&…%￥…@…&……zzzzZZZZ……"
  },
  LanguageConfig_Monster_O01_SideDia3_CN = {
    Text = "是谁打扰了我的安眠……！"
  },
  LanguageConfig_Monster_O01_SideDia4_CN = {
    Text = "聒噪之徒…为你的愚行忏悔吧！"
  },
  LanguageConfig_Monster_O01_SideDia5_CN = {
    Text = "打出卡牌或释放狂气爆发会消除图鲁的困意…"
  },
  LanguageConfig_Monster_O01_SideDia6_CN = {Text = "3……"},
  LanguageConfig_Monster_O01_SideDia7_CN = {Text = "2……"},
  LanguageConfig_Monster_O01_SideDia8_CN = {Text = "1……"},
  LanguageConfig_Monster_O07_Tips1_CN = {
    Text = "殉身吧，神国的祭品！"
  },
  LanguageConfig_Monster_Ocean_Tips_CN = {
    Text = "每个回合开始时，所有触腕会进行 1 次攻击。"
  },
  LanguageConfig_Monster_Ocean_Title_CN = {Text = "触腕"},
  LanguageConfig_Monster_Pickman_bubble_01_CN = {
    Text = "什么是真实？什么是虚假？"
  },
  LanguageConfig_Monster_Pickman_bubble_02_CN = {
    Text = "疯狂，即是这个世界唯一的真相！即是艺术唯一的真相！"
  },
  LanguageConfig_Monster_Pickman_bubble_tips_01_CN = {
    Text = "敌人将要造成大量伤害，尽可能打出认知失调卡牌来降低敌人伤害！"
  },
  LanguageConfig_Monster_Pickman_bubble_tips_02_CN = {
    Text = "敌人变强了，施加的认知失调产生了奇怪的变化！"
  },
  LanguageConfig_Monster_Pickman_bubble_tips_03_CN = {
    Text = "注意！打出认知错乱卡牌时，敌方攻击次数会增加。"
  },
  LanguageConfig_Monster_Pollux_bubble_01_CN = {
    Text = "直面你的罪孽，承受提灯的审判。"
  },
  LanguageConfig_Monster_Pollux_bubble_02_CN = {
    Text = "满身罪孽之人，向持灯者忏悔吧！"
  },
  LanguageConfig_Monster_Pollux_bubble_tips_01_CN = {
    Text = "「圣子·白夜」即将释放「圣心」！打出指令卡会使他愈发狂热，谨慎行动！"
  },
  LanguageConfig_Monster_Pollux_bubble_tips_02_CN = {
    Text = "「圣子·白夜」将承担每次行动产生的「罪印」，且「代罪」的清除效果减半。"
  },
  LanguageConfig_Monster_Pollux_bubble_tips_03_CN = {
    Text = "苦痛正在等待宣泄……「圣心」或许能成为它的出口。"
  },
  LanguageConfig_Monster_Probe_Tips_CN = {
    Text = "剩余手牌越多敌人就会获得更多临时反击！"
  },
  LanguageConfig_Monster_RMQ_SideDia1_CN = {
    Text = "持灯者与我同在！"
  },
  LanguageConfig_Monster_RMQ_SideDia2_CN = {
    Text = "由我撕裂不净之徒！"
  },
  LanguageConfig_Monster_RMQ_SideDia3_CN = {
    Text = "注意！在本回合打出卡牌后会强化怪物的技能，每打出 1 张卡牌都会切换其强化效果。"
  },
  LanguageConfig_Monster_RMQ_SideDia4_CN = {
    Text = "我将…跨越新的世界…"
  },
  LanguageConfig_Monster_RamonoPlus_Bubble1_CN = {
    Text = "因果于此刻闭合，迎接你的昨日。"
  },
  LanguageConfig_Monster_RamonoPlus_Bubble2_CN = {
    Text = "剑锋承载万千轮回，你，无处可逃！"
  },
  LanguageConfig_Monster_RamonoPlus_Tips1_CN = {
    Text = "释放钥令会使「觉者」积攒回环，请勿滥用！"
  },
  LanguageConfig_Monster_RamonoPlus_Tips2_CN = {
    Text = "「觉者」预知了数张卡牌。打出后会为敌人提供回环，尝试将其弃置。"
  },
  LanguageConfig_Monster_S0103_1_CN = {
    Text = "维度之孔使你失去了部分力量……"
  },
  LanguageConfig_Monster_S0103_2_CN = {
    Text = "维度之孔的攻击中充满了电流…"
  },
  LanguageConfig_Monster_S0202_1_CN = {
    Text = "咯吱…（磨牙声）…"
  },
  LanguageConfig_Monster_S0203_1_CN = {
    Text = "西区佬，送你一点小礼物，接着！"
  },
  LanguageConfig_Monster_S0203_2_CN = {
    Text = "詹金召唤了鼠群…攻击她会使鼠群更加愤怒！"
  },
  LanguageConfig_Monster_S0203_3_CN = {
    Text = "头好晕…有点难以招架攻击了…"
  },
  LanguageConfig_Monster_S0302_1_CN = {
    Text = "超脱之俯仰进行鲜血仪式，每回合都会强化！…"
  },
  LanguageConfig_Monster_S0303_1_CN = {
    Text = "「聆听启示」强化了所有敌人！"
  },
  LanguageConfig_Monster_S0303_2_CN = {
    Text = "「固守之执妄」强化了所有敌人！"
  },
  LanguageConfig_Monster_S0303_AT_BOSSSIZE_SideDia1_CN = {
    Text = "当心！敌人的维度之力已经达到了极限！本回合维度锁链会生效 3 次，谨慎发起进攻！"
  },
  LanguageConfig_Monster_S0303_AT_BOSSSIZE_SideDia2_CN = {
    Text = "「以图存续」强化了所有敌人！"
  },
  LanguageConfig_Monster_S0303_AT_BOSSSIZE_SideDia3_CN = {
    Text = "敌人周身环绕着充满仇恨的维度锁链，会封锁第一名对它发起进攻的唤醒体！"
  },
  LanguageConfig_Monster_S2B0001_Name1_CN = {Text = "@1go-@4 8"},
  LanguageConfig_Monster_S2B0002_Name1_CN = {
    Text = "「宇宙@2投影」"
  },
  LanguageConfig_Monster_SeaWandererBoss_bubble_01_CN = {
    Text = "我于腐潮之夜盛放…遵循吾主…吞噬！"
  },
  LanguageConfig_Monster_SeaWandererBoss_bubble_02_CN = {
    Text = "聆听吾主…接受吾主的审判…！"
  },
  LanguageConfig_Monster_SeaWandererBoss_tips_01_CN = {
    Text = "杜勒赛因正在努力催化溟梦之帷法阵，全力抵挡伤害来守护它！"
  },
  LanguageConfig_Monster_SeaWandererBoss_tips_02_CN = {
    Text = "敌人的形态不是十分稳定，每次击破生命条都可以降低敌人的侵略性！"
  },
  LanguageConfig_Monster_SeaWandererBoss_tips_03_CN = {
    Text = "当心卡牌上附带的「蹈海者狂乱」！打出或弃掉时会有深海分殖体出现！"
  },
  LanguageConfig_Monster_Seamonsteronslaught_Bubble_CN = {
    Text = "「吾神的威名不容亵渎！」"
  },
  LanguageConfig_Monster_Snakerend_Tips_CN = {
    Text = "剩余手牌越少敌人的攻势就越强！"
  },
  LanguageConfig_Monster_TDJZ_1_CN = {
    Text = "你被施加了「出血」状态，可以通过治疗进行解除。"
  },
  LanguageConfig_Monster_TDJZ_2_CN = {
    Text = "处于「祈祷」状态下会大大提升攻击次数，需要对其造成伤害来进行削减。"
  },
  LanguageConfig_Monster_Tinct_Bubble1_CN = {
    Text = "我又要失去你了吗，姐姐……"
  },
  LanguageConfig_Monster_Tinct_Bubble2_CN = {
    Text = "如果歌声响彻寰宇，你就能听到了吗，姐姐……"
  },
  LanguageConfig_Monster_Tinct_Tips1_CN = {
    Text = "汀克特的幻光会造成「迟缓」……尽可能打出手中的保留卡牌！"
  },
  LanguageConfig_Monster_Tinct_Tips2_CN = {
    Text = "手牌不会再自动丢弃，务必及时处理迟缓卡牌！"
  },
  LanguageConfig_Monster_TwistedFate1_CN = {
    Text = "破除@2！吞噬@3！！！"
  },
  LanguageConfig_Monster_TwistedFate2_CN = {
    Text = "狂气爆发会让敌人的意图改变并强化，请当心！"
  },
  LanguageConfig_Monster_WDZZ_1_CN = {
    Text = "唤醒体的「狂气爆发」技能本回合被封印。"
  },
  LanguageConfig_Monster_XL_1_CN = {
    Text = "敌人大幅强化了「力量」，小心！"
  },
  LanguageConfig_Monster_Z0001_SideDia1_CN = {
    Text = "今天捣点什么乱好呢……"
  },
  LanguageConfig_Monster_Z0001_SideDia2_CN = {
    Text = "来一场绅士的决斗！"
  },
  LanguageConfig_Monster_Z0001_SideDia3_CN = {
    Text = "哎呀，银芯从帽子里掉出来了……"
  },
  LanguageConfig_Monster_Z0001_SideDia4_CN = {
    Text = "喵嗷——你们不能这样对一个绅士！"
  },
  LanguageConfig_Monster_Z0001_SideDia5_CN = {
    Text = "一起度过热闹的夜晚！"
  },
  LanguageConfig_Monster_shuilian1_CN = {
    Text = "请不要接近我……"
  },
  LanguageConfig_Monster_shuilian2_CN = {
    Text = "我并不想伤害你们……"
  },
  LanguageConfig_Monster_shuilian3_CN = {
    Text = "请不要再前进了……"
  },
  LanguageConfig_Monster_tawil_Bubble0_CN = {Text = "3……"},
  LanguageConfig_Monster_tawil_Bubble1_CN = {Text = "2……"},
  LanguageConfig_Monster_tawil_Bubble2_CN = {Text = "1……"},
  LanguageConfig_Monster_tawil_Bubble3_CN = {
    Text = "你将以何为钥，叩响最终的门扉？"
  },
  LanguageConfig_Monster_tawil_Bubble4_CN = {
    Text = "我知晓。我见证。我……于此降临。"
  },
  LanguageConfig_Monster_tawil_Bubble5_CN = {
    Text = "穷极之门将启……最终的「答案」，就要映现。"
  },
  LanguageConfig_Monster_tawil_Bubble6_CN = {
    Text = "万物自一而始。万物终归于一。"
  },
  LanguageConfig_Monster_tawil_Tips1_CN = {
    Text = "每次使用指令卡都将使敌人的攻击强化，请谨慎行动！"
  },
  LanguageConfig_Monster_tawil_Tips2_CN = {
    Text = "尽可能格挡敌人的伤害，避免受到「轮回悖论」影响！"
  },
  LanguageConfig_Monster_xiluo0_CN = {
    Text = "聆听吧，复仇者的愤怒！"
  },
  LanguageConfig_Monster_xiluo1_CN = {
    Text = "我将舍弃圣女之命。"
  },
  LanguageConfig_Monster_xiluo2_CN = {
    Text = "那是不被容许的怜悯吗？"
  },
  LanguageConfig_Monster_xiluo3_CN = {
    Text = "我曾是你的掌上明珠……"
  },
  LanguageConfig_MonthCardLeftDaysText_CN = {
    Text = "剩余{s1}天"
  },
  LanguageConfig_MonthCardRuleText_CN = {
    Text = "<Title:【月相观测介绍】>\n·每次购买月相观测，可立即获得「银芯」× 300 和为期 30 天的月相观测许可。\n·月相观测生效时间内，每日登录可领取「银芯」× 200。（每日9点更新【GMT+8】）\n\n\n<Title:【注意事项】>\n·月相观测剩余生效时间≤150天内续购，可延长生效时间。\n·守密人在月相观测生效期间如因未登录而未领取的「银芯」不会返还。"
  },
  LanguageConfig_MoppingUp_lock_Warn_CN = {
    Text = "调查等级2级解锁快速调查"
  },
  LanguageConfig_MultiLifeReduceStar_CN = {
    Text = "本次通关评价将降为{s1}星"
  },
  LanguageConfig_MultiSelectBox_BuyConfirmText_CN = {
    Text = "是否确认购买以下物品？"
  },
  LanguageConfig_MultiSelectBox_FixItemTitle_CN = {
    Text = "固定物品"
  },
  LanguageConfig_MultiSelectBox_SelectItemText_CN = {
    Text = "请选择礼包内容"
  },
  LanguageConfig_MultiSelectBox_SelectItemTitle_CN = {
    Text = "自选物品"
  },
  LanguageConfig_MustBattle_CN = {
    Text = "必须上阵"
  },
  LanguageConfig_NFYMainDia1_CN = {
    Text = "对不起，我必须阻止你们"
  },
  LanguageConfig_NFYMainDia2_CN = {
    Text = "弗朗西斯夫人……我……还不能倒下"
  },
  LanguageConfig_NameChangeTips_CN = {
    Text = "修改后，{s1}小时内不可再次修改"
  },
  LanguageConfig_NeedToActivateTheFrontPotency_CN = {
    Text = "需要激活前置启灵点"
  },
  LanguageConfig_NegativeStatusColor_CN = {Text = "#BB646D"},
  LanguageConfig_NetBlockMaskTips_CN = {
    Text = "网络通信中，请稍候"
  },
  LanguageConfig_NewLevelUp_alllClean_CN = {
    Text = "全部清除"
  },
  LanguageConfig_NewLevelUp_autoSet_CN = {
    Text = "自动置入"
  },
  LanguageConfig_NewPreOrderPurchaseCountdownTips_CN = {
    Text = "{s1}内购买可领取限时专属奖励"
  },
  LanguageConfig_NewPreOrderPurchaseTobeClaimed_CN = {
    Text = "{s1}后消失，购买后可立即领取"
  },
  LanguageConfig_NextRefineLevelEffect_CN = {
    Text = "叠位后效果"
  },
  LanguageConfig_NextStep_CN = {Text = "下一步"},
  LanguageConfig_NoAwakerAwaked_CN = {
    Text = "无已觉醒的唤醒体"
  },
  LanguageConfig_NoCounterTagAwaker_CN = {
    Text = "暂无特攻唤醒体"
  },
  LanguageConfig_Nonimagery_1_1_1_1_CN = {Text = "哭泣"},
  LanguageConfig_Nonimagery_1_1_1_2_CN = {Text = "眺望"},
  LanguageConfig_Nonimagery_1_1_1_3_CN = {Text = "穿越"},
  LanguageConfig_Nonimagery_1_2_1_1_CN = {Text = "却"},
  LanguageConfig_Nonimagery_1_2_1_2_CN = {Text = "还是"},
  LanguageConfig_Nonimagery_1_2_1_3_CN = {Text = "仍然"},
  LanguageConfig_Nonimagery_1_3_1_1_CN = {Text = "挥动着"},
  LanguageConfig_Nonimagery_1_3_1_2_CN = {Text = "跳跃着"},
  LanguageConfig_Nonimagery_1_3_1_3_CN = {Text = "忍耐着"},
  LanguageConfig_Nonimagery_1_4_1_1_CN = {Text = "直到"},
  LanguageConfig_Nonimagery_1_4_1_2_CN = {Text = "无论"},
  LanguageConfig_Nonimagery_1_4_1_3_CN = {Text = "为了"},
  LanguageConfig_NormalGamePassport_CN = {
    Text = "普通纪行"
  },
  LanguageConfig_NotOwned_CN = {Text = "未拥有"},
  LanguageConfig_OffSell_CN = {Text = "已下架"},
  LanguageConfig_OpenExpression_PVP_CN = {
    Text = "开启互动"
  },
  LanguageConfig_Option_RankListAchievementCount_CN = {
    Text = "达成成就数"
  },
  LanguageConfig_Option_RankListAssistanceCount_CN = {
    Text = "助战次数"
  },
  LanguageConfig_Option_RankListCollectionNum_CN = {
    Text = "秘典书库藏品数"
  },
  LanguageConfig_Option_RankListFollowerNum_CN = {
    Text = "追随者数"
  },
  LanguageConfig_Option_RankListGetlikeCount_CN = {
    Text = "被点赞数"
  },
  LanguageConfig_Option_RankListHomologyRate_CN = {
    Text = "同调率总等级"
  },
  LanguageConfig_Option_RankListLikeCount_CN = {Text = "点赞数"},
  LanguageConfig_Option_RankListLoginDays_CN = {
    Text = "登录天数"
  },
  LanguageConfig_Option_RankListPlayerLevel_CN = {
    Text = "守密人等级"
  },
  LanguageConfig_OrangeEnchantConfigTypeName_CN = {
    Text = "<OrangeRelic:高级刻印>"
  },
  LanguageConfig_OrangeRelicTypeName_CN = {
    Text = "<OrangeRelic:黄金造物>"
  },
  LanguageConfig_OtherAchievement_CN = {
    Text = "成就/其他成就"
  },
  LanguageConfig_OtherStatusColor_CN = {Text = "#FFFFFF"},
  LanguageConfig_OverLimitUtlSkill_CN = {
    Text = "<OverLimitUtlSkillKeywords:超限爆发>"
  },
  LanguageConfig_Overload_CN = {
    Text = "算力超载！"
  },
  LanguageConfig_OwnedCount_CN = {
    Text = "已拥有：{s1}"
  },
  LanguageConfig_Owned_CN = {Text = "已拥有"},
  LanguageConfig_PVETeamShareCode_CN = {
    Text = "调查行动——编队分享\n守密人：{1}（{2}） 队伍名：{3}\n\n{10}、{21}、{23}、{25}\n{30}、{41}、{43}、{45}\n{50}、{61}、{63}、{65}\n{70}、{81}、{83}、{85}\n{4}\n\n{0}"
  },
  LanguageConfig_PVPAttentionBtnUnClickableStateTips_CN = {
    Text = "已经关注对手啦"
  },
  LanguageConfig_PVPAwakerTrain_CN = {
    Text = "唤醒体试训"
  },
  LanguageConfig_PVPBPLockTxt_CN = {
    Text = "解锁核心课题，本期课题可使用所有卡牌"
  },
  LanguageConfig_PVPBPUnLockTxt_CN = {
    Text = "本期课题限时解锁中"
  },
  LanguageConfig_PVPBattlePerformance_CN = {
    Text = "战斗表现"
  },
  LanguageConfig_PVPBattle_Tips_NumberOfCards_CN = {
    Text = "目前一共持有 {s1} 张手牌。\n手牌上限默认为 10。\n每回合开始会抽 5 张牌，当持有的手牌到达手牌上限时将不再获得手牌。"
  },
  LanguageConfig_PVPCollectFilterTypeName_All_CN = {Text = "全部"},
  LanguageConfig_PVPCollectFilterTypeName_Blood_CN = {Text = "血肉"},
  LanguageConfig_PVPCollectFilterTypeName_Chaos_CN = {Text = "混沌"},
  LanguageConfig_PVPCollectFilterTypeName_Dimension_CN = {Text = "超维"},
  LanguageConfig_PVPCollectFilterTypeName_KeeperSkill_CN = {Text = "钥令"},
  LanguageConfig_PVPCollectFilterTypeName_Ocean_CN = {Text = "深海"},
  LanguageConfig_PVPCollectFilterTypeName_Weapon_CN = {Text = "命轮"},
  LanguageConfig_PVPEmailRewardrTxt_CN = {
    Text = "由于上个赛季您有段位奖励未领取，已通过本邮件发放，请及时查收。"
  },
  LanguageConfig_PVPFailTips_CN = {
    Text = "无需气馁，每位守密人都会经历挑战。重新来过，下一次你会更强！"
  },
  LanguageConfig_PVPFirstWinBonus_CN = {
    Text = "首胜加成"
  },
  LanguageConfig_PVPGoodBtnUnClickableStateTips_CN = {
    Text = "已经点赞过对手啦"
  },
  LanguageConfig_PVPInstructions_CN = {
    Text = "<Title:【相位对弈】>\n· 相位对弈模式是《忘却前夜》附赠玩法，每个赛季游戏每张卡牌和整体游戏玩法都可能会大幅度重做变化，来换取更平衡更有趣的游戏环境，因此请谨慎为解锁相位对弈的游戏内容而投入资源。\n<Title:【匹配相关】>\n· 相位对弈是两人对抗游戏，需要通过匹配功能等待一段时间以寻找对手，匹配功能会优先寻找旗鼓相当的对手与你进行对抗。\n·同步匹配：守密人可以勾选「预组模式」与「轮选模式」同时对多模式进行匹配，可以有效缩短匹配到对手的等待时间。\n·精准匹配：开启设置会寻找更势均力敌的对手，但这会延长匹配到对手的等待时间。关闭设置会缩短匹配到对手的等待时间，但对手相对不那么势均力敌。\n·模拟对手：开启设置将允许匹配时看情况分配模拟对手，这会缩短匹配到对手的等待时间。关闭设置将仅允许匹配时分配真人对手，这会延长匹配到对手的等待时间。\n<Title:【积分排名】>\n·分数规则：初始积分为 0 分，守密人可通过匹配对战获得积分。\n·分数变化：当双方分数一致时，胜利方将获得 5% 总积分的积分，失败方将失去等值积分。\n·新手保护：当积分低于 1500 时，胜利时将获得更多的分数，失败时将失去更少的分数。\n·强敌挑战：当战胜强敌时获得更多的分数，败于强敌时将失去更少的分数。战胜弱敌时获得更少的分数。\n·分数独立：「预组模式」与「轮选模式」各自拥有独立的积分，但二者一致使用上述积分规则。\n<Title:【赛季更新】>\n·赛季重置：一般情况下，赛季每 28 天重置。重置后，所有人的积分超过 3000 的部分将会减半。\n·赛季排行：「预组模式」与「轮选模式」各自拥有独立的赛季和赛季排行，赛季排行奖励将会在每次赛季结束时进行结算。\n·排行条件：当前赛季内参与一场即可进入对应模式的赛季排行，并以赛季内的历史最高分作为排名依据。当前赛季内获胜一场即可在赛季结束时根据当前赛季排行结算奖励。\n·赛季任务：「预组模式」与「轮选模式」均会有赛季任务，完成赛季任务可以获得丰富的奖励。赛季任务会在每次赛季更新时重置。\n<Title:【预组模式】>\n· 「预组模式」是相位对弈的基础模式，使用预先准备的编队与对手进行对抗，在匹配前需要选择自己的编队与未知编队的对手进行对抗。\n<Title:【轮选模式】>\n·「轮选模式」是相位对弈的进阶模式，无需预组队伍便可进行匹配，在开始战斗前双方需要在一个拥有唤醒体、命轮、钥令的卡池中轮流选取，以此构建自己的编队在后续与对方进行对战。\n· 每场对局中系统会随机选取一个造物，在对战中生效。"
  },
  LanguageConfig_PVPMatchDefeat_CN = {
    Text = "比赛失败"
  },
  LanguageConfig_PVPMatchVictory_CN = {
    Text = "比赛胜利"
  },
  LanguageConfig_PVPOpeningVoiceUnlockDesc_CN = {
    Text = "在相位对弈中触发该对话后解锁"
  },
  LanguageConfig_PVPRankRewardCountdown_CN = {
    Text = "当前赛季剩余{s1}天{s2}小时"
  },
  LanguageConfig_PVPRankingRuleDesc_CN = {
    Text = "<Title:【积分排行】>\n·「预组模式」与「轮选模式」各自拥有独立的赛季和赛季排行，赛季排行奖励将会在每次赛季结束时进行结算。\n·当前赛季内参与一场即可进入对应模式的赛季排行，并以赛季内的历史最高分作为排名依据。当前赛季内获胜一场即可在赛季结束时根据当前赛季排行结算奖励。\n<Title:【排名比例】>\n·对弈头衔按参与排行的积分排名，比例如下:\n     ·相位传奇：前2%\n     ·相位支配者：2%~10%\n     ·对弈大师：10%~25%\n     ·相位精英：25%~50%\n     ·对弈学徒：50%~75%\n     ·相位新手：75%后\n·当出现与其他守密人相同积分的情况时，将按照进入排行的先后进行排序，但对弈头衔和奖励仍以此分的最高排名为准。"
  },
  LanguageConfig_PVPRankingRuleTitle_CN = {
    Text = "排行规则"
  },
  LanguageConfig_PVPRecordTime_Day_CN = {
    Text = " {s1} 天前"
  },
  LanguageConfig_PVPRecordTime_Hour_CN = {
    Text = "{s1} 小时前"
  },
  LanguageConfig_PVPRecordTime_Minute_CN = {
    Text = "{s1} 分前"
  },
  LanguageConfig_PVPSeasonBonus_CN = {
    Text = "赛季加成"
  },
  LanguageConfig_PVPSeasonCountdown_CN = {
    Text = "{s1}天{s2}小时"
  },
  LanguageConfig_PVPSettleAccelerateField_CN = {
    Text = "守密人经验加速"
  },
  LanguageConfig_PVPTargetErrorTips_CN = {
    Text = "技能目标错误，请重新选择目标"
  },
  LanguageConfig_PVPTeamShareCode_CN = {
    Text = "相位对弈——编队分享\n守密人：{1}（{2}）\n\n编队名：{3}\n{12}、{7}、{6}、{5}、{4}\n{13}、{11}、{10}、{9}、{8}\n\n{0}"
  },
  LanguageConfig_PVPTraning_ChooseKeeperSkill_CN = {
    Text = "选择 1 张钥令"
  },
  LanguageConfig_PVPTraning_ChooseWeapon_CN = {
    Text = "选择 1 张命轮"
  },
  LanguageConfig_PVPTraning_EnemyName_CN = {
    Text = "弥萨格校猫"
  },
  LanguageConfig_PVPTraning_ResetCooldown_CN = {
    Text = "重置功能冷却中，请稍后再试"
  },
  LanguageConfig_PVPWinningStreak_CN = {
    Text = "连续胜利"
  },
  LanguageConfig_PVP_Opponent_Exited_CN = {
    Text = "对手已退出"
  },
  LanguageConfig_PVPandDailyChallengeExpTips_CN = {
    Text = "通过「幻梦深潜」和「相位对弈」可以获取守密人经验，每日通过该途径最多可以获取{s1}点，今日已获取{s2}点。"
  },
  LanguageConfig_PassportAdvancedPurchased_Txt_CN = {
    Text = "已购买高阶课题"
  },
  LanguageConfig_PassportAdvanced_Txt_CN = {
    Text = "解锁立即获得「银芯」× <color=#5EF2FF><size=32>680</size></color>"
  },
  LanguageConfig_PassportHoistDoubleUpgrade_Txt_CN = {
    Text = "升级课题立即获得「银芯」× <color=#5EF2FF><size=32>390</size></color>，并提升 <color=#5EF2FF><size=32>20</size></color> 级课题等级"
  },
  LanguageConfig_PassportHoistDouble_Txt_CN = {
    Text = "解锁立即获得「银芯」× <color=#5EF2FF><size=32>1070</size></color>，并提升<color=#5EF2FF><size=32>20</size>级</color>课题等级"
  },
  LanguageConfig_PassportHoistPurchased_Txt_CN = {
    Text = "已购买核心课题"
  },
  LanguageConfig_PassportHoistUpgrade_Txt_CN = {
    Text = "升级课题立即获得「银芯」×<color=#5EF2FF><size=32>780</size></color>，并提升 <color=#5EF2FF><size=32>10</size></color> 级课题等级"
  },
  LanguageConfig_PassportHoist_Txt_CN = {
    Text = "解锁立即获得「银芯」× <color=#5EF2FF><size=32>1460</size></color>，并提升 <color=#5EF2FF><size=32>10</size></color> 级课题等级"
  },
  LanguageConfig_PasswordBattle1_CN = {
    Text = "预组模式"
  },
  LanguageConfig_PasswordBattle2_CN = {
    Text = "轮选模式"
  },
  LanguageConfig_PasswordBattlePasswordPrompt_CN = {
    Text = "请输入 6 位密码。"
  },
  LanguageConfig_PasswordBattleQueueButton_CN = {Text = "排队中"},
  LanguageConfig_PasswordBattleRuleTips_CN = {
    Text = "·密码对战：在创建对战后，可以通过在 社交媒体 或 通讯软件中发布 <color=#5EF2FF>相位值</color> 对群体发起邀请，其他守密人可以通过输入 <color=#5EF2FF>相位值</color> 加入你的对战，由于同时只能与一个人发起对战，因此对战名额先到先得，成功开启对战后其他应邀的守密人将被拒绝。\n·拒绝对战：若遇到不想与其对战的守密人创建者也可拒绝与其对战，拒绝过多会出现拉黑提示，可通过拉黑操作阻止其加入你的对战，直至解除拉黑。"
  },
  LanguageConfig_PasswordBattle_CN = {
    Text = "密码对战"
  },
  LanguageConfig_PasswordBattle_FriendGame_CN = {Text = "友谊赛"},
  LanguageConfig_PermanentActivityRuleContent_CN = {
    Text = "<Title:记忆回廊>\n·带有「记忆回廊」标记的活动，在活动时间结束后将被收录到「记忆回廊」中，可继续在「记忆回廊」中体验相应的玩法和剧情。\n<Title:收录规则>\n·带有「记忆回廊」标记的活动会有丰富的限时奖励，在活动时间结束后限时奖励将无法再领取，请各位守密人及时领取限时奖励。\n·活动被收录到「记忆回廊」后，会自动保留此前的进度，各位守密人可继续体验。"
  },
  LanguageConfig_PermanentActivityRuleTitle_CN = {
    Text = "规则说明"
  },
  LanguageConfig_PermanentActivityTitle_CN = {
    Text = "记忆回廊"
  },
  LanguageConfig_PhiloStone_CN = {Text = "黑印"},
  LanguageConfig_PhiloStone_Desc_CN = {
    Text = "融痕渴求的神秘印记，可以用于换取等价物品。"
  },
  LanguageConfig_PickCosmeticsAllEmojiGot_CN = {
    Text = "您已获得列表内所有对战表情"
  },
  LanguageConfig_PickCosmeticsAllPlayerAvatarsGot_CN = {
    Text = "您已获得列表内所有头像"
  },
  LanguageConfig_PlayerExpRateTxt_CN = {
    Text = "当前经验加速：{s1}%"
  },
  LanguageConfig_PlayerExpRuleContent_CN = {
    Text = "<Title:至高礼赞>\n1、在「智识赠礼」活动中，完成每个任务均可获得一个「至高礼赞」效果，使守密人经验获得加速，最高可达 100%。多个「至高礼赞」效果同时存在时，取最高的加速效果。\n2、解锁或获得更高级的「至高礼赞」效果时，会按照加速比例和当前可被加速的守密人经验总量，立即获得额外的守密人经验。\n3、解锁「至高礼赞」后，守密人每次获得守密人经验时，都将获得对应加速比例的额外守密人经验。\n4、请注意，「至高礼赞」带来的额外守密人经验不会计入可被加速的守密人经验总量。\n5、当前可被加速的守密人经验总量：{s1}。\n6、加速已累计获得额外守密人经验：{s2}（{s3}%）。"
  },
  LanguageConfig_PlayerExpRuleTitle_CN = {
    Text = "加速说明"
  },
  LanguageConfig_PlayerLevelTaskLabel_CN = {
    Text = "成长记录"
  },
  LanguageConfig_PlayerLv_CN = {
    Text = "调查等级"
  },
  LanguageConfig_PlayerNotLoggedIn_CN = {
    Text = "玩家-未登录"
  },
  LanguageConfig_PlusGamePassport_CN = {
    Text = "高级纪行"
  },
  LanguageConfig_Poem_CN = {Text = "诗篇"},
  LanguageConfig_PoetryFormatGroup_1_CN = {
    Text = "斑驳的{s1}长久等候，@2停留在@2的刺痛\n@2的房间，当{s2}燃烧的声音响起\n{s3}便落满了花园"
  },
  LanguageConfig_PoetryFormatGroup_2_CN = {
    Text = "在{s1}身旁，在一场@2消亡的@2 \n舞曲@2于追逐，{s2}开始谢幕。 \n@2，听吧：在这个夜晚，我将与{s3}共舞。"
  },
  LanguageConfig_PoetryFormatGroup_3_CN = {
    Text = "与{s1}对饮，举起@2的杯盏\n窗外的@2属于{s2}，那是@2的时空\n@2夜幕@2的火光，生命让位于{s3}。"
  },
  LanguageConfig_PoetryFormatGroup_4_CN = {
    Text = "一片叶子，把@2借给{s1}\n这是@2的徒劳：{s2}与@2，远远相望\n只有凋落，{s3}才相互拥抱"
  },
  LanguageConfig_PoetryFormatGroup_5_CN = {
    Text = "在荆棘之外，{s1}与@2盛开\n永恒的{s2}从@2落下\n落入@2，落入{s3}孤单的怀中"
  },
  LanguageConfig_PoetryFormatGroup_6_CN = {
    Text = "深渊中的{s1}，从@2的掌中盛开\n@2梦里的@2啊，我曾是@2的{s2}\n在{s3}坠落的@2，我将回忆起你荒寂的心"
  },
  LanguageConfig_PontosHuoDong_Tips1_CN = {
    Text = "选择「护卫」或「猎取」"
  },
  LanguageConfig_PoolGroupTitle_10_CN = {
    Text = "与群星相会"
  },
  LanguageConfig_PoolGroupTitle_11_CN = {
    Text = "三相衡生"
  },
  LanguageConfig_PoolGroupTitle_12_CN = {
    Text = "因果苗圃"
  },
  LanguageConfig_PoolGroupTitle_13_CN = {
    Text = "三相衡生"
  },
  LanguageConfig_PoolGroupTitle_14_CN = {
    Text = "因果苗圃"
  },
  LanguageConfig_PoolGroupTitle_15_CN = {
    Text = "三相衡生"
  },
  LanguageConfig_PoolGroupTitle_16_CN = {
    Text = "因果苗圃"
  },
  LanguageConfig_PoolGroupTitle_17_CN = {
    Text = "三相衡生"
  },
  LanguageConfig_PoolGroupTitle_18_CN = {
    Text = "因果苗圃"
  },
  LanguageConfig_PoolGroupTitle_19_CN = {
    Text = "时序外同行"
  },
  LanguageConfig_PoolGroupTitle_1_CN = {
    Text = "三相衡生"
  },
  LanguageConfig_PoolGroupTitle_20_CN = {
    Text = "三相衡生·其二"
  },
  LanguageConfig_PoolGroupTitle_21_CN = {
    Text = "因果苗圃·其二"
  },
  LanguageConfig_PoolGroupTitle_22_CN = {
    Text = "群星的盛绽"
  },
  LanguageConfig_PoolGroupTitle_23_CN = {
    Text = "三相衡生"
  },
  LanguageConfig_PoolGroupTitle_24_CN = {
    Text = "因果苗圃"
  },
  LanguageConfig_PoolGroupTitle_25_CN = {
    Text = "三相衡生"
  },
  LanguageConfig_PoolGroupTitle_26_CN = {
    Text = "因果苗圃"
  },
  LanguageConfig_PoolGroupTitle_27_CN = {
    Text = "三相衡生"
  },
  LanguageConfig_PoolGroupTitle_28_CN = {
    Text = "因果苗圃"
  },
  LanguageConfig_PoolGroupTitle_29_CN = {
    Text = "三相衡生"
  },
  LanguageConfig_PoolGroupTitle_2_CN = {
    Text = "因果苗圃"
  },
  LanguageConfig_PoolGroupTitle_30_CN = {
    Text = "因果苗圃"
  },
  LanguageConfig_PoolGroupTitle_31_CN = {
    Text = "三相衡生"
  },
  LanguageConfig_PoolGroupTitle_32_CN = {
    Text = "因果苗圃"
  },
  LanguageConfig_PoolGroupTitle_33_CN = {
    Text = "溯忆寻光"
  },
  LanguageConfig_PoolGroupTitle_34_CN = {
    Text = "三相衡生"
  },
  LanguageConfig_PoolGroupTitle_35_CN = {
    Text = "因果苗圃"
  },
  LanguageConfig_PoolGroupTitle_36_CN = {
    Text = "三相衡生"
  },
  LanguageConfig_PoolGroupTitle_37_CN = {
    Text = "因果苗圃"
  },
  LanguageConfig_PoolGroupTitle_38_CN = {
    Text = "三相衡生"
  },
  LanguageConfig_PoolGroupTitle_39_CN = {
    Text = "因果苗圃"
  },
  LanguageConfig_PoolGroupTitle_3_CN = {
    Text = "往事失落以前"
  },
  LanguageConfig_PoolGroupTitle_40_CN = {
    Text = "三相衡生"
  },
  LanguageConfig_PoolGroupTitle_41_CN = {
    Text = "因果苗圃"
  },
  LanguageConfig_PoolGroupTitle_42_CN = {
    Text = "三相衡生"
  },
  LanguageConfig_PoolGroupTitle_43_CN = {
    Text = "因果苗圃"
  },
  LanguageConfig_PoolGroupTitle_44_CN = {
    Text = "三相衡生"
  },
  LanguageConfig_PoolGroupTitle_45_CN = {
    Text = "因果苗圃"
  },
  LanguageConfig_PoolGroupTitle_46_CN = {
    Text = "三相衡生"
  },
  LanguageConfig_PoolGroupTitle_47_CN = {
    Text = "因果苗圃"
  },
  LanguageConfig_PoolGroupTitle_48_CN = {
    Text = "三相衡生"
  },
  LanguageConfig_PoolGroupTitle_49_CN = {
    Text = "因果苗圃"
  },
  LanguageConfig_PoolGroupTitle_4_CN = {
    Text = "三相衡生"
  },
  LanguageConfig_PoolGroupTitle_50_CN = {
    Text = "三相衡生"
  },
  LanguageConfig_PoolGroupTitle_51_CN = {
    Text = "因果苗圃"
  },
  LanguageConfig_PoolGroupTitle_52_CN = {
    Text = "三相衡生"
  },
  LanguageConfig_PoolGroupTitle_53_CN = {
    Text = "因果苗圃"
  },
  LanguageConfig_PoolGroupTitle_5_CN = {
    Text = "因果苗圃"
  },
  LanguageConfig_PoolGroupTitle_6_CN = {
    Text = "三相衡生"
  },
  LanguageConfig_PoolGroupTitle_7_CN = {
    Text = "因果苗圃"
  },
  LanguageConfig_PoolGroupTitle_8_CN = {
    Text = "三相衡生"
  },
  LanguageConfig_PoolGroupTitle_9_CN = {
    Text = "因果苗圃"
  },
  LanguageConfig_PositiveStatusColor_CN = {Text = "#93D1A0"},
  LanguageConfig_PotencyComingSoon_CN = {
    Text = "该唤醒体的超限爆发能力暂未开放，敬请期待"
  },
  LanguageConfig_PotencyNumberOfLayers_CN = {Text = "第{s1}层"},
  LanguageConfig_PotencyPopupTitle_CN = {
    Text = "人格深化"
  },
  LanguageConfig_PotencyUnlockFormat_CN = {
    Text = "人格深化{s1}解锁"
  },
  LanguageConfig_Potency_LevelUp_Success_CN = {
    Text = "启灵成功"
  },
  LanguageConfig_PreOrderBeforePurchaseTips_CN = {
    Text = "购买后可按时领取所有奖励"
  },
  LanguageConfig_PreOrderNeedWaitTobeClaimed_CN = {
    Text = "{s1}后可领取"
  },
  LanguageConfig_PreOrderNotPurchasedNeedWait_CN = {
    Text = "购买{s1}后可领取"
  },
  LanguageConfig_PreOrderNotPurchasedTobeClaimed_CN = {
    Text = "购买后可立即领取"
  },
  LanguageConfig_PreOrderPurchaseCountdownTips_CN = {
    Text = "{s1}后无法购买"
  },
  LanguageConfig_PreOrderPurchasedTips_CN = {
    Text = "已完成购买\n可按时领取所有奖励"
  },
  LanguageConfig_PreOrderTobeClaimed_CN = {Text = "待领取"},
  LanguageConfig_PrerequisiteStagesRequired_CN = {
    Text = "需完成前置关卡"
  },
  LanguageConfig_PreviewClose_CN = {Text = "关闭"},
  LanguageConfig_PrizeNum10_CN = {Text = "十等奖"},
  LanguageConfig_PrizeNum1_CN = {Text = "一等奖"},
  LanguageConfig_PrizeNum2_CN = {Text = "二等奖"},
  LanguageConfig_PrizeNum3_CN = {Text = "三等奖"},
  LanguageConfig_PrizeNum4_CN = {Text = "四等奖"},
  LanguageConfig_PrizeNum5_CN = {Text = "五等奖"},
  LanguageConfig_PrizeNum6_CN = {Text = "六等奖"},
  LanguageConfig_PrizeNum7_CN = {Text = "七等奖"},
  LanguageConfig_PrizeNum8_CN = {Text = "八等奖"},
  LanguageConfig_PrizeNum9_CN = {Text = "九等奖"},
  LanguageConfig_PromoteMethod_CN = {
    Text = "提升方式"
  },
  LanguageConfig_PurpleRelicTypeName_CN = {
    Text = "<OrangeRelic:特殊造物>"
  },
  LanguageConfig_PvEReplayAddRoundsNum_CN = {
    Text = "额外·最终战回合数"
  },
  LanguageConfig_PvEReplayCode_CN = {
    Text = "调查行动-{3}——战斗回放\n守密人：{1}（{2}）\n\n{4}、{5}、{6}、{17}\n{7}、{8}、{9}、{18}\n{10}、{11}、{12}、{19}\n{13}、{14}、{15}、{20}\n{16}\n\n{0}"
  },
  LanguageConfig_PvEReplayDefeatTips_CN = {
    Text = "调查失败，无法分享回放。"
  },
  LanguageConfig_PvEReplayRoundsNum_CN = {
    Text = "最终战回合数"
  },
  LanguageConfig_PvEReplayTabNullDesc_CN = {
    Text = "暂无调查行动记录"
  },
  LanguageConfig_PvPChallengeBtnText_CN = {Text = "挑战"},
  LanguageConfig_PvPExitReplay_CN = {
    Text = "退出录像"
  },
  LanguageConfig_PvPGiveUp_CN = {Text = "投降"},
  LanguageConfig_PvPMatchingText_CN = {
    Text = "正在匹配实力相当的对手"
  },
  LanguageConfig_PvPMatchinging_CN = {
    Text = "正在 {s1} 人中匹配实力相当的对手{s2}"
  },
  LanguageConfig_PvPMoreGameBeCancelTips_CN = {
    Text = "对方已取消"
  },
  LanguageConfig_PvPMoreGameBeRefusedTips_CN = {
    Text = "对方已拒绝"
  },
  LanguageConfig_PvPMoreGameBtnActiveRefuseStateTips_CN = {
    Text = "你已拒绝过对方"
  },
  LanguageConfig_PvPMoreGameBtnOverWinStateTips_CN = {
    Text = "已有一人获得两次胜利，不可再来一局"
  },
  LanguageConfig_PvPMoreGameBtnQuitStateTips_CN = {
    Text = "对方已退出对局"
  },
  LanguageConfig_PvPMoreGameBtnRefuseStateTips_CN = {
    Text = "对方已拒绝过你"
  },
  LanguageConfig_PvPMoreGameTitle_CN = {
    Text = "再来一局"
  },
  LanguageConfig_PvPMoreGame_CN = {
    Text = "再来一局"
  },
  LanguageConfig_PvPPlayOrderFirst_CN = {Text = "先手"},
  LanguageConfig_PvPPlayOrderSecond_CN = {Text = "后手"},
  LanguageConfig_PvPReplayCode_CN = {
    Text = "相位对弈-{25}——战斗回放\n\n{3}（{26}）\n{12}、{7}、{6}、{5}、{4}\n{13}、{11}、{10}、{9}、{8}\n---------------VS--------------------\n{14}（{27}）\n{23}、{18}、{17}、{16}、{15}\n{24}、{22}、{21}、{20}、{19}\n\n{0}"
  },
  LanguageConfig_PvPReplayCode_Copy_CN = {
    Text = "已复制到剪贴板"
  },
  LanguageConfig_PvPReplayCode_ErrorPaste_CN = {
    Text = "输入内容 不合法 或 已过期"
  },
  LanguageConfig_PvPReplayModeDisp1_CN = {
    Text = "预组模式"
  },
  LanguageConfig_PvPReplayModeDisp2_CN = {
    Text = "轮选模式"
  },
  LanguageConfig_PvPReplayModeDisp3_CN = {
    Text = "密码预组"
  },
  LanguageConfig_PvPReplayModeDisp4_CN = {
    Text = "密码轮选"
  },
  LanguageConfig_PvPReplayModeDisp5_CN = {
    Text = "友谊预组"
  },
  LanguageConfig_PvPReplayModeDisp6_CN = {
    Text = "友谊轮选"
  },
  LanguageConfig_PvPReplayTabNullDesc_CN = {
    Text = "暂无相位对弈记录"
  },
  LanguageConfig_PvPReplay_CheckBot_CN = {
    Text = "无法查看模拟对手详情"
  },
  LanguageConfig_PvPTeamBuildChallengeNotFullTips_CN = {
    Text = "需要将编队填满才可进行匹配"
  },
  LanguageConfig_PvPTeamBuildPanelSaveBtnText_CN = {Text = "上阵"},
  LanguageConfig_PvPTeamMultiBuildTitle_CN = {
    Text = "编辑队伍"
  },
  LanguageConfig_PvPTeamSingleBuildAwakerTitle_CN = {
    Text = "选择唤醒体"
  },
  LanguageConfig_PvPTeamSingleBuildKeyTitle_CN = {
    Text = "选择钥令卡"
  },
  LanguageConfig_PvPTeamSingleBuildWeaponTitle_CN = {
    Text = "选择命轮卡"
  },
  LanguageConfig_PvPTrainGiveUp_CN = {Text = "退出"},
  LanguageConfig_PvPWinCount_CN = {
    Text = "赛季胜场：{s1}胜"
  },
  LanguageConfig_PvpBattleRewardRankBonus_CN = {
    Text = "积分加成"
  },
  LanguageConfig_PvpCollectCommentBtnMine_CN = {
    Text = "我的评论"
  },
  LanguageConfig_PvpCollectCommentBtnPublish_CN = {
    Text = "发布评论"
  },
  LanguageConfig_PvpCollectCommentEditLabel_CN = {
    Text = "最多输入 {s1} 字符"
  },
  LanguageConfig_PvpCollectCommentEditTimeOutTips_CN = {
    Text = "超过30天的评论不可编辑"
  },
  LanguageConfig_PvpCollectCommentLikeForbid_CN = {
    Text = "无法点赞自己的评论"
  },
  LanguageConfig_PvpCollectCommentPublishTime_CN = {
    Text = "发布于  {s1}"
  },
  LanguageConfig_PvpCollectCommentSortModePublishTime_CN = {Text = "最新"},
  LanguageConfig_PvpCollectCommentSortModeRecommend_CN = {Text = "推荐"},
  LanguageConfig_PvpCollectCommentUpdateTime_CN = {
    Text = "编辑于  {s1}"
  },
  LanguageConfig_PvpCollectEditCommentViewTitle_CN = {
    Text = "编辑评论"
  },
  LanguageConfig_PvpCommentTimeLessThan1Day_CN = {
    Text = "{s1}小时前"
  },
  LanguageConfig_PvpCommentTimeLessThan1Hour_CN = {
    Text = "{s1}分钟前"
  },
  LanguageConfig_PvpCommentTimeLessThan1Min_CN = {Text = "刚刚"},
  LanguageConfig_PvpCommentTimeLessThan1Month_CN = {Text = "{s1}天前"},
  LanguageConfig_PvpCommentTimeLessThan1Year_CN = {Text = "{s1}月前"},
  LanguageConfig_PvpCommentTimeMoreThan1Year_CN = {Text = "{s1}年前"},
  LanguageConfig_PvpDraftAdjustPosReady_CN = {
    Text = "准备就绪"
  },
  LanguageConfig_PvpDraftClickConfirmWhenNotSelect_CN = {
    Text = "请先选择参战唤醒体/命轮/钥令"
  },
  LanguageConfig_PvpDraftParamEntryLockTips_CN = {
    Text = "当前赛季的积分曾到达 {s1} 可参与"
  },
  LanguageConfig_PvpFriendBattle_CN = {Text = "友谊赛"},
  LanguageConfig_PvpHistoryLevelViewTitle_Draft_CN = {
    Text = "轮选奖励"
  },
  LanguageConfig_PvpHistoryLevelViewTitle_Draft_ExpProgress_CN = {
    Text = "轮选经验{s1}"
  },
  LanguageConfig_PvpHistoryLevelViewTitle_PreBuild_CN = {
    Text = "预组奖励"
  },
  LanguageConfig_PvpHistoryLevelViewTitle_PreBuild_ExpProgress_CN = {
    Text = "预组经验{s1}"
  },
  LanguageConfig_PvpMatchBattle_CN = {
    Text = "匹配对战"
  },
  LanguageConfig_PvpMatchCanceling_CN = {
    Text = "正在取消…"
  },
  LanguageConfig_PvpMatchEmptyPvpTypeTips_CN = {
    Text = "请至少选中一项模式再进行匹配"
  },
  LanguageConfig_PvpOnlyKeeperSkillClickTips_CN = {
    Text = "该钥令为「相位对弈」专属钥令，暂不可在调查中使用"
  },
  LanguageConfig_PvpRuleTipsCreationTitle_CN = {
    Text = "【轮选造物】"
  },
  LanguageConfig_PvpTaskViewTitle_CN = {
    Text = "对弈纪录"
  },
  LanguageConfig_PvpVoiceName_AwakerDied_CN = {Text = "死亡"},
  LanguageConfig_PvpVoiceName_CountingStart_CN = {Text = "催促"},
  LanguageConfig_PvpVoiceName_OperationImpossible_CN = {Text = "错误"},
  LanguageConfig_PvpVoiceName_OperationStop_CN = {Text = "思考"},
  LanguageConfig_PvpVoiceName_PlayerEnter_CN = {Text = "开场"},
  LanguageConfig_PvpVoiceName_ReletedAwakerInEnemies_CN = {
    Text = "闲话·关于{s1}"
  },
  LanguageConfig_PvpVoiceName_SkillReady_CN = {Text = "必杀"},
  LanguageConfig_QualityBlue_CN = {Text = "R"},
  LanguageConfig_QualityOrange_CN = {Text = "SSR"},
  LanguageConfig_QualityPurple_CN = {Text = "SR"},
  LanguageConfig_QualityWhite_CN = {Text = "N"},
  LanguageConfig_QuantityHeld_CN = {
    Text = "持有数量：{s1}"
  },
  LanguageConfig_QuestionnaireEmailSender_CN = {
    Text = "弥萨格大学校务处"
  },
  LanguageConfig_RPGJJC_Desc_CN = {
    Text = "你可以消耗「演习凭证」挑战其他守密人布置的防守队伍，挑战成功后将会提升排名。你也需要精心布置你的防守队伍，否则将可能被其他守密人挑战成功造成排名下降。排名越高每小时获得的「演习徽章」越多。「演习凭证」将跟随时间自动获得。「演习徽章」可以在兑换商店中兑换蔷薇金券、灵知制剂等道具。"
  },
  LanguageConfig_RPGTeam_School_All_CN = {Text = "总览"},
  LanguageConfig_RPGTeam_School_Have_No_Actor_CN = {
    Text = "当前界域暂未获得唤醒体"
  },
  LanguageConfig_RailHistoryLevelViewTitle_ExpProgress_CN = {
    Text = "贵宾积分{s1}"
  },
  LanguageConfig_RailWayActivityRewardTitle_CN = {
    Text = "专列轨迹"
  },
  LanguageConfig_RailWayCurProgress_CN = {
    Text = "当前进度{s1}"
  },
  LanguageConfig_RailWayHistoryLevelViewTitle_CN = {
    Text = "雅室规格"
  },
  LanguageConfig_RailWayLevelAdjustmentTipsContent_CN = {
    Text = "在「疾驰的欢愉专列」中有等级补偿机制，具体规则如下：\n  ·调查队伍中，等级不足 60 级的唤醒体在本次挑战中将会补偿至 60 级。\n  ·调查队伍中，技能等级不足 5 级的唤醒体在本次挑战中将会补偿至 5 级。\n  ·调查队伍中，「疯狂预兆」不足 6 级的唤醒体在本次挑战中将会补偿至 6 级。\n  ·调查队伍中，「灵塑适性」不足 5 级的唤醒体在本次挑战中将会补偿至 5 级。\n  ·若守密人等级不足60级，在本次挑战中将会补偿至60级。"
  },
  LanguageConfig_RailWayLevelAdjustmentTipsTitle_CN = {
    Text = "等级补偿"
  },
  LanguageConfig_RailWayLevelAdjustmentTips_CN = {
    Text = "等级补偿"
  },
  LanguageConfig_RailWayMaxProgress_CN = {
    Text = "生涯最高进度"
  },
  LanguageConfig_RailWayOutBreakRecordTips_CN = {
    Text = "进度新高！"
  },
  LanguageConfig_RailWayOutMaxExp_CN = {
    Text = "{s1}「贵宾积分」"
  },
  LanguageConfig_RailWayResonanceRuleContent_CN = {
    Text = "1、在「疾驰的欢愉专列」有更丰富的共鸣强化，以便在挑战中为守密人们提供强力的协助。\n2、在「沿途留影」中可以获得共鸣升级材料，消耗材料可以激活共鸣效果。\n3、每个阶段都会有调查行动共鸣事件，进入调查行动共鸣事件后将获得对应章节的强力共鸣效果，该共鸣效果会持续至整场调查结束。\n4、在「小「N」的协助」中获得的共鸣效果将会从调查开始持续至调查结束。"
  },
  LanguageConfig_RailWayRulesContentV2_CN = {
    Text = "<Title:玩法简介>\n1、「疾驰的欢愉专列」是采用「星辰篇」规则的连续挑战模式。守密人将在多变的随机遭遇中连续挑战多个调查行动中出现过的最终首领！\n2、玩法中造物持有上限最高可提升至 36 个。\n3、挑战过程中可同时拥有并强化 3 种调查行动中的强大「共鸣」效果。\n4、每使用 1 次应急灵知体，会减少 20% 本次挑战获取的「贵宾积分」。\n5、支持中途退出并保留进度，但队伍状态不会随外部养成变化同步更新。进度至多保留至上一次挑战的 7 天后，若保留期间没有继续挑战则视为放弃挑战，进度不再保留。\n\n<Title:等级补偿>\n参与「列车启程」会获得等级补偿，具体规则如下：\n  ·调查队伍中，等级不足 60 级的唤醒体在本次挑战中将会补偿至 60 级。\n  ·调查队伍中，技能等级不足 5 级的唤醒体在本次挑战中将会补偿至 5 级。\n  ·调查队伍中，「疯狂预兆」不足 6 级的唤醒体在本次挑战中将会补偿至 6 级。\n  ·调查队伍中，「灵塑适性」不足 5 级的唤醒体在本次挑战中将会补偿至 5 级。\n  ·若守密人等级不足60级，在本次挑战中将会补偿至60级。\n\n<Title:关卡阶段>\n1、单次挑战总计分为三个阶段，每个阶段的主题敌人与共鸣效果将在对应范围内随机生成：\n  ·第一阶段： 对应「忘却篇」第一至四章内容。\n  ·第二阶段： 对应「忘却篇」第五至八章内容。\n  ·第三阶段： 对应「星辰篇」第一至四章内容。\n ·在癫狂难度下，完成第三阶段挑战后将额外挑战第四阶段最终首领「塔薇」。\n2、击败阶段首领后，可从随机 3 个「时灵摆」中择一获取。\n\n<Title:难度与初始造物>\n本次挑战共设三个难度，各难度有不同的关卡奖励和初始造物，各位守密人可以在选择挑战难度前了解详细信息。\n\n<Title:关卡奖励>\n1、通过击败各难度中的精英与首领可获取「贵宾积分」，「贵宾积分」用于提升「雅室规格」等级以获取奖励。\n  ·第一阶段：战胜精英/首领获得「贵宾积分」×25/75 \n  ·第二阶段：战胜精英/首领获得「贵宾积分」×50/150 \n  ·第三阶段：战胜精英/首领获得「贵宾积分」×75/225 \n2、挑战的难度越高，将会获得越多的「贵宾积分」。\n  ·【困难难度】：完成三个阶段获得的「贵宾积分」提高 150% \n\n  ·【癫狂难度】：完成三个阶段获得的「贵宾积分」提高 400%\n ·击败最终首领「塔薇」后，可额外获得「贵宾积分」× 1500。\n\n<Title:赛季更新>\n1、「贵宾名录」会记录挑战表现优异的守密人，每个赛季期间挑战 1 次，并且成功获得「贵宾积分」的守密人即可进入「贵宾名录」。\n2、「贵宾名录」的赛季排名会以单次挑战获得最多的「贵宾积分」和所用最少的「回合数」为依据，可重复挑战以提高排名。\n3、赛季结束后，会通过邮件结算本赛季「贵宾名录」的排名奖励。\n4、每个赛季均会有赛季任务，完成赛季任务即可获得丰富的奖励。赛季任务会在每次赛季更新时重置。\n5、赛季切换时，尚在战斗中的关卡在完成挑战后可以直接完成最新的赛季任务，但无法进入「贵宾名录」。"
  },
  LanguageConfig_RailWayRulesContent_CN = {
    Text = "<Title:玩法简介>\n1、「疾驰的欢愉专列」是采用「星辰篇」规则的连续挑战模式。守密人将在多变的随机遭遇中连续挑战多个调查行动中出现过的最终首领！\n2、玩法中造物持有上限最高可提升至 36 个。\n3、挑战过程中可同时拥有并强化 3 种调查行动中的强大「共鸣」效果。\n4、每使用 1 次应急灵知体，会减少 20% 本次挑战获取的「贵宾积分」。\n5、支持中途退出并保留进度，但队伍状态不会随外部养成变化同步更新。进度至多保留至上一次挑战的 7 天后，若保留期间没有继续挑战则视为放弃挑战，进度不再保留。\n\n<Title:等级补偿>\n参与「列车启程」会获得等级补偿，具体规则如下：\n  ·调查队伍中，等级不足 60 级的唤醒体在本次挑战中将会补偿至 60 级。\n  ·调查队伍中，技能等级不足 5 级的唤醒体在本次挑战中将会补偿至 5 级。\n  ·调查队伍中，「疯狂预兆」不足 6 级的唤醒体在本次挑战中将会补偿至 6 级。\n  ·调查队伍中，「灵塑适性」不足 5 级的唤醒体在本次挑战中将会补偿至 5 级。\n  ·若守密人等级不足60级，在本次挑战中将会补偿至60级。\n\n<Title:关卡阶段>\n1、单次挑战总计分为三个阶段，每个阶段的主题敌人与共鸣效果将在对应范围内随机生成：\n  ·第一阶段： 对应「忘却篇」第一至四章内容。\n  ·第二阶段： 对应「忘却篇」第五至八章内容。\n  ·第三阶段： 对应「星辰篇」第一至四章内容。\n2、击败阶段首领后，可从随机 3 个「时灵摆」中择一获取。\n\n<Title:难度与初始造物>\n本次挑战共设三个难度，各难度有不同的关卡奖励和初始造物，各位守密人可以在选择挑战难度前了解详细信息。\n\n<Title:关卡奖励>\n1、通过击败各难度中的精英与首领可获取「贵宾积分」，「贵宾积分」用于提升「雅室规格」等级以获取奖励。\n  ·第一阶段：战胜精英/首领获得「贵宾积分」×25/75 \n  ·第二阶段：战胜精英/首领获得「贵宾积分」×50/150 \n  ·第三阶段：战胜精英/首领获得「贵宾积分」×75/225 \n2、挑战的难度越高，将会获得越多的「贵宾积分」。\n  ·【困难难度】：完成三个阶段获得的「贵宾积分」提高 150%\n  ·【癫狂难度】：完成三个阶段获得的「贵宾积分」提高 400%\n\n<Title:赛季更新>\n1、「贵宾名录」会记录挑战表现优异的守密人，每个赛季期间挑战 1 次，并且成功获得「贵宾积分」的守密人即可进入「贵宾名录」。\n2、「贵宾名录」的赛季排名会以单次挑战获得最多的「贵宾积分」和所用最少的「回合数」为依据，可重复挑战以提高排名。\n3、赛季结束后，会通过邮件结算本赛季「贵宾名录」的排名奖励。\n4、每个赛季均会有赛季任务，完成赛季任务即可获得丰富的奖励。赛季任务会在每次赛季更新时重置。\n5、赛季切换时，尚在战斗中的关卡在完成挑战后可以直接完成最新的赛季任务，但无法进入最新一期「贵宾名录」。"
  },
  LanguageConfig_RailWayRulesTitle_CN = {
    Text = "疾驰的欢愉专列"
  },
  LanguageConfig_RailWaySaveAndExit_CN = {
    Text = "保存并退出"
  },
  LanguageConfig_RailWaySettlementDetails1_CN = {
    Text = "基础奖励"
  },
  LanguageConfig_RailWaySettlementDetails2_CN = {
    Text = "使用应急灵知体降低"
  },
  LanguageConfig_RailWayStageCrazyMileExpGetDescV2_CN = {
    Text = "本次调查最多获得{s1}「贵宾积分」。\n已使用{s3}次「应急灵知体」，当前已获得{s2}「贵宾积分」。\n  ·第一阶段：战胜精英/首领获得「贵宾积分」×25/75\n  ·第二阶段：战胜精英/首领获得「贵宾积分」×50/150\n  ·第三阶段：战胜精英/首领获得「贵宾积分」×75/225 \n  ·困难/癫狂难度所获得的「贵宾积分」会提高 150%/400%\n  ·击败癫狂难度第四阶段首领可额外获得「贵宾积分」× 1500。\n  ·每使用 1次「应急灵知体」，「贵宾积分」降低20%。"
  },
  LanguageConfig_RailWayStageCrazyMileExpGetDesc_CN = {
    Text = "本次调查最多获得{s1}「贵宾积分」。\n已使用{s3}次「应急灵知体」，当前已获得{s2}「贵宾积分」。\n  ·第一阶段：战胜精英/首领获得「贵宾积分」×25/75\n  ·第二阶段：战胜精英/首领获得「贵宾积分」×50/150\n  ·第三阶段：战胜精英/首领获得「贵宾积分」×75/225 \n  ·困难/癫狂难度所获得的「贵宾积分」会提高 150%/400%\n  ·每使用 1次「应急灵知体」，「贵宾积分」降低20%。"
  },
  LanguageConfig_RailWayStageCrazyNowDescV2_CN = {
    Text = "癫狂难度会有 4 个阶段，前 3 个阶段中每个阶段有 6 场战斗。第 4 阶段会直接挑战最终首领。\n当前已到第 {s1} 阶段-第 {s2} 场战斗。"
  },
  LanguageConfig_RailWayStageCrazyNowDesc_CN = {
    Text = "当前调查中会有 3 个阶段，每个阶段有 6 场战斗。\n当前已到第 {s1} 阶段-第 {s2} 场战斗。"
  },
  LanguageConfig_RailWayStageDifficultyBuffContent1_CN = {
    Text = "<Title:关卡奖励>\n第一阶段：战胜精英/首领获得「贵宾积分」×25/75 \n第二阶段：战胜精英/首领获得「贵宾积分」×50/150 \n第三阶段：战胜精英/首领获得「贵宾积分」×75/225 \n<Title:初始造物>\n调查开始时获得造物「小「N」的完整相机」\n·<OrangeQuality:黄金调和>：「算力调和」带来的算力提高效果最大为 1 点，每拥有 1% 伤害强效则使得灵识研究深度效果提高 1%。\n·<RedQuality:长途倦意>：战斗中所有生命回复效果降低 50%。"
  },
  LanguageConfig_RailWayStageDifficultyBuffContent2_CN = {
    Text = "<Title:关卡奖励>\n挑战的难度越高，将会获得越多的「贵宾积分」。完成三个阶段获得的「贵宾积分」提高 150%\n<Title:初始造物>\n调查开始时获得造物「小「N」的破旧相机」\n·<OrangeQuality:黄金调和>：「算力调和」带来的算力提高效果最大为 1 点，每拥有 1% 伤害强效则使得灵识研究深度效果提高 1%。\n·<OrangeQuality:维度赠礼>：探索开始时，随机获得 1 个维度影像造物，手牌上限提高 1 。\n·<RedQuality:长途倦意>：战斗中所有生命回复效果降低 50%。\n·<RedQuality:眩晕征兆>：战斗开始时，所有唤醒体当前狂气与银钥能量降低 50%。"
  },
  LanguageConfig_RailWayStageDifficultyBuffContent3V2_CN = {
    Text = "<Title:特别挑战>\n癫狂难度下，完成第三阶段后将额外挑战第四阶段最终首领「塔薇」。\n<Title:关卡奖励>\n挑战的难度越高，将会获得越多的「贵宾积分」。完成三个阶段获得的「贵宾积分」提高 400%\n击败最终首领「塔薇」后，可额外获得「贵宾积分」× 1500。\n<Title:初始造物>\n调查开始时获得造物「小「N」的混乱相机」\n·<OrangeQuality:黄金调和>：「算力调和」带来的算力提高效果最大为 1 点，每拥有 1% 伤害强效则使得灵识研究深度效果提高 1%。\n·<OrangeQuality:维度赠礼>：探索开始时，随机获得 1 个维度影像造物，手牌上限提高 2 。\n·<OrangeQuality:受祝仪式>：战胜第一、第二阶段的首领奖励变更为随机受祝造物 3 选 1。\n·<RedQuality:长途倦意>：战斗中所有生命回复效果降低 50%。\n·<RedQuality:眩晕征兆>：战斗开始时，所有唤醒体当前狂气与银钥能量降低 50%。\n·<RedQuality:永夜长廊>：探索开始时，所有唤醒体的基础狂气与银钥能量上限提高 50%"
  },
  LanguageConfig_RailWayStageDifficultyBuffContent3_CN = {
    Text = "<Title:关卡奖励>\n挑战的难度越高，将会获得越多的「贵宾积分」。完成三个阶段获得的「贵宾积分」提高 400%\n<Title:初始造物>\n调查开始时获得造物「小「N」的混乱相机」\n·<OrangeQuality:黄金调和>：「算力调和」带来的算力提高效果最大为 1 点，每拥有 1% 伤害强效则使得灵识研究深度效果提高 1%。\n·<OrangeQuality:维度赠礼>：探索开始时，随机获得 1 个维度影像造物，手牌上限提高 2 。\n·<OrangeQuality:受祝仪式>：战胜第一、第二阶段的首领奖励变更为随机受祝造物 3 选 1。\n·<RedQuality:长途倦意>：战斗中所有生命回复效果降低 50%。\n·<RedQuality:眩晕征兆>：战斗开始时，所有唤醒体当前狂气与银钥能量降低 50%。\n·<RedQuality:永夜长廊>：探索开始时，所有唤醒体的基础狂气与银钥能量上限提高 50%"
  },
  LanguageConfig_RailWayStageInformationTitle_CN = {
    Text = "关卡规则说明"
  },
  LanguageConfig_RailWayStageMileExpGetDesc_CN = {
    Text = "本次调查最多获得{s1}「贵宾积分」。\n已使用{s3}次「应急灵知体」，当前已获得{s2}「贵宾积分」。\n  ·第一阶段：战胜精英/首领获得「贵宾积分」×25/75\n  ·第二阶段：战胜精英/首领获得「贵宾积分」×50/150\n  ·第三阶段：战胜精英/首领获得「贵宾积分」×75/225 \n  ·困难/癫狂难度所获得的「贵宾积分」会提高 150%/400%\n  ·每使用 1次「应急灵知体」，「贵宾积分」降低20%。"
  },
  LanguageConfig_RailWayStageMileExpGetTitle_CN = {
    Text = "贵宾积分"
  },
  LanguageConfig_RailWayStageNowDesc_CN = {
    Text = "当前调查中会有 3 个阶段，每个阶段有 6 场战斗。\n当前已到第 {s1} 阶段-第 {s2} 场战斗。"
  },
  LanguageConfig_RailWayStageNowTitle_CN = {
    Text = "调查进度"
  },
  LanguageConfig_RailWayTaskViewTitle_CN = {
    Text = "沿途留影"
  },
  LanguageConfig_RandomChestTipConfirmBtnTxt_CN = {
    Text = "随机获得"
  },
  LanguageConfig_RandomSelectAward_CN = {
    Text = "随机获得"
  },
  LanguageConfig_RankDataFirstLoadTip_CN = {
    Text = "数据请求中"
  },
  LanguageConfig_RankDataNull_CN = {
    Text = "暂无记录"
  },
  LanguageConfig_RankListAchievementCount_CN = {
    Text = "达成成就数"
  },
  LanguageConfig_RankListAssistanceCount_CN = {
    Text = "助战次数"
  },
  LanguageConfig_RankListCollectionNum_CN = {
    Text = "秘典书库藏品数"
  },
  LanguageConfig_RankListFollowerNum_CN = {
    Text = "追随者数"
  },
  LanguageConfig_RankListGetlikeCount_CN = {
    Text = "被点赞数"
  },
  LanguageConfig_RankListHomologyRate_CN = {
    Text = "同调率总等级"
  },
  LanguageConfig_RankListLikeCount_CN = {Text = "点赞数"},
  LanguageConfig_RankListLoginDays_CN = {
    Text = "登录天数"
  },
  LanguageConfig_RankListPlayerLevel_CN = {
    Text = "守密人等级/经验"
  },
  LanguageConfig_RankingPercentDesc_CN = {Text = "{s1}"},
  LanguageConfig_RateStrColored_CN = {
    Text = "倍率<color=#5EF2FF>×{s1}</color>"
  },
  LanguageConfig_RateStr_CN = {
    Text = "倍率×{s1}"
  },
  LanguageConfig_RatingTipsDesc_CN = {
    Text = "特此邀请你前往商店给出对游戏宝贵的评价与意见"
  },
  LanguageConfig_RatingTipsTitle_CN = {
    Text = "评价邀请"
  },
  LanguageConfig_ReConnect_1_CN = {
    Text = "尝试重新同步中…"
  },
  LanguageConfig_ReConnect_6_CN = {
    Text = "正在进行精神同步"
  },
  LanguageConfig_ReConnect_7_CN = {
    Text = "失去同步"
  },
  LanguageConfig_ReRoundNoReward_CN = {
    Text = "当前没有可领取的任务，快去参加「相位对弈」"
  },
  LanguageConfig_ReRoundRewardTitle_CN = {
    Text = "回合奇赏"
  },
  LanguageConfig_ReRoundScoreStr_CN = {
    Text = "当前魔法橡果数量:{s1}"
  },
  LanguageConfig_ReachLimitForCompose_CN = {
    Text = "已达上限，无法合成"
  },
  LanguageConfig_ReadAllStr_CN = {
    Text = "全部已读"
  },
  LanguageConfig_RecClass_Description_Detail_CN = {
    Text = "·如果队伍激活界域与任一推荐界域相同，则所有出战唤醒体的体质、攻击、防御获得固定比例的提升。"
  },
  LanguageConfig_RecClass_Description_Title_CN = {
    Text = "推荐界域说明"
  },
  LanguageConfig_RecClass_tips_CN = {
    Text = "我方队伍属性{s1}"
  },
  LanguageConfig_RecastButtonText_CN = {Text = "重印"},
  LanguageConfig_RecastConsumeTrinketTips_1_CN = {
    Text = "可通过重印获得{s1}个密契匣子"
  },
  LanguageConfig_RecastConsumeTrinketTips_2_CN = {
    Text = "消耗已选密契可制造<color=#fea338>{s1}</color>个新密契（至下一个新密契所需：<color=#fea338>{s2}/{s3}</color>）"
  },
  LanguageConfig_RecastConsumeTrinketTips_CN = {
    Text = "将任意3个SSR密契重印为新的密契"
  },
  LanguageConfig_RecastTimes_CN = {
    Text = "重印次数"
  },
  LanguageConfig_RecastTitle_CN = {
    Text = "密契重印"
  },
  LanguageConfig_RecommendAccountLevel_CN = {
    Text = "推荐{s1}级"
  },
  LanguageConfig_RecordShortcut_CN = {
    Text = "按下绑定的键位"
  },
  LanguageConfig_RecordsSortTypeTime_CN = {
    Text = "通关日期"
  },
  LanguageConfig_RedEnchantConfigTypeName_CN = {
    Text = "<RedRelic:诅咒刻印>"
  },
  LanguageConfig_RedRelicTypeName_CN = {
    Text = "<RedRelic:诅咒造物>"
  },
  LanguageConfig_RedemptionCodePanelTitle_CN = {
    Text = "兑换奖励"
  },
  LanguageConfig_RedemptionTips_10026_CN = {
    Text = "您已领取过此兑换码的同类奖励。"
  },
  LanguageConfig_RedemptionTips_10028_CN = {
    Text = "您已领取过此兑换码的互斥奖励。"
  },
  LanguageConfig_RedemptionTips_10029_CN = {
    Text = "当前兑换码奖励已过期。"
  },
  LanguageConfig_RedemptionTips_10602_CN = {
    Text = "当前兑换码类型未生效 或 您不满足礼包码的领取条件。"
  },
  LanguageConfig_RedemptionTips_10603_CN = {
    Text = "当前兑换码没有配置奖励。"
  },
  LanguageConfig_RedemptionTips_10604_CN = {
    Text = "您使用同类型兑换码次数达到上限。"
  },
  LanguageConfig_RedemptionTips_10607_CN = {
    Text = "系统繁忙，请稍后重试。"
  },
  LanguageConfig_RedemptionTips_10608_CN = {
    Text = "您输入的角色编号或者角色名称错误，请重试。"
  },
  LanguageConfig_RedemptionTips_10610_CN = {
    Text = "您已兑换过该兑换码的互斥兑换码。"
  },
  LanguageConfig_RedemptionTips_10611_CN = {
    Text = "当前兑换码兑换人数已达到上限。"
  },
  LanguageConfig_RedemptionTips_10612_CN = {
    Text = "您已兑换过此兑换码。"
  },
  LanguageConfig_RedemptionTips_15000_CN = {
    Text = "您不满足此兑换码奖励的领取条件。"
  },
  LanguageConfig_RedemptionTips_200_CN = {
    Text = "兑换成功！请稍后前往信箱中查收。"
  },
  LanguageConfig_RedemptionTips_419_CN = {
    Text = "兑换码不存在。"
  },
  LanguageConfig_RedemptionTips_429_CN = {
    Text = "您的操作过于频繁，请稍后再试。"
  },
  LanguageConfig_RedemptionTips_430_CN = {
    Text = "兑换码奖励不可用。"
  },
  LanguageConfig_RedemptionTips_Empty_CN = {
    Text = "当前兑换码为空，请输入兑换码。"
  },
  LanguageConfig_RedemptionTips_other_CN = {
    Text = "当前兑换码兑换人数已达上限或兑换码不存在。"
  },
  LanguageConfig_ReducedDeathResistance_CN = {
    Text = "死亡抵抗降低！"
  },
  LanguageConfig_RefineReturn_CN = {
    Text = "叠位溢出返还"
  },
  LanguageConfig_Refine_CN = {Text = "叠位"},
  LanguageConfig_Refresh_CN = {Text = "刷新"},
  LanguageConfig_RefusedText_CN = {Text = "已拒绝"},
  LanguageConfig_RelicAwardButton_CN = {Text = "确定"},
  LanguageConfig_RelicAwardTitle_CN = {
    Text = "选取一个造物"
  },
  LanguageConfig_RelicAwardUncheck_CN = {
    Text = "请选择一个造物"
  },
  LanguageConfig_RelicDeleteCardDesc_CN = {
    Text = "选择{s1}张卡牌删除"
  },
  LanguageConfig_RelicGroup_100_CN = {Text = "血肉"},
  LanguageConfig_RelicGroup_101_CN = {Text = "超维"},
  LanguageConfig_RelicGroup_10_CN = {Text = "戏法"},
  LanguageConfig_RelicGroup_11_CN = {Text = "诅咒"},
  LanguageConfig_RelicGroup_12_CN = {Text = "护佑"},
  LanguageConfig_RelicGroup_13_CN = {Text = "双生"},
  LanguageConfig_RelicGroup_14_CN = {Text = "增殖"},
  LanguageConfig_RelicGroup_15_CN = {Text = "至臻"},
  LanguageConfig_RelicGroup_16_CN = {Text = "即刻"},
  LanguageConfig_RelicGroup_1_CN = {Text = "起源"},
  LanguageConfig_RelicGroup_201_CN = {Text = "原初"},
  LanguageConfig_RelicGroup_202_CN = {Text = "主宰"},
  LanguageConfig_RelicGroup_203_CN = {Text = "潜能"},
  LanguageConfig_RelicGroup_204_CN = {Text = "统御"},
  LanguageConfig_RelicGroup_205_CN = {Text = "处决"},
  LanguageConfig_RelicGroup_206_CN = {Text = "腐蚀"},
  LanguageConfig_RelicGroup_207_CN = {Text = "洞察"},
  LanguageConfig_RelicGroup_208_CN = {Text = "凋亡"},
  LanguageConfig_RelicGroup_209_CN = {Text = "血祭"},
  LanguageConfig_RelicGroup_210_CN = {Text = "无明"},
  LanguageConfig_RelicGroup_251_CN = {Text = "超维"},
  LanguageConfig_RelicGroup_252_CN = {Text = "血肉"},
  LanguageConfig_RelicGroup_253_CN = {Text = "深海"},
  LanguageConfig_RelicGroup_290_CN = {
    Text = "维度影像-混沌"
  },
  LanguageConfig_RelicGroup_291_CN = {
    Text = "维度影像-深海"
  },
  LanguageConfig_RelicGroup_292_CN = {
    Text = "维度影像-血肉"
  },
  LanguageConfig_RelicGroup_293_CN = {
    Text = "维度影像-超维"
  },
  LanguageConfig_RelicGroup_2_CN = {Text = "萌芽"},
  LanguageConfig_RelicGroup_3_CN = {Text = "节律"},
  LanguageConfig_RelicGroup_4_CN = {Text = "无厌"},
  LanguageConfig_RelicGroup_5_CN = {Text = "脓血"},
  LanguageConfig_RelicGroup_6_CN = {Text = "狂想"},
  LanguageConfig_RelicGroup_7_CN = {Text = "诡丽"},
  LanguageConfig_RelicGroup_8_CN = {Text = "适性"},
  LanguageConfig_RelicGroup_997_CN = {Text = "受祝"},
  LanguageConfig_RelicGroup_998_CN = {Text = "负罪"},
  LanguageConfig_RelicGroup_999_CN = {
    Text = "造物组测试999"
  },
  LanguageConfig_RelicGroup_99_CN = {Text = "深海"},
  LanguageConfig_RelicGroup_9_CN = {Text = "进击"},
  LanguageConfig_RelicLvUnlock_CN = {
    Text = "解锁造物"
  },
  LanguageConfig_RelicSelectedEnoughHint_CN = {
    Text = "不能选择更多造物了"
  },
  LanguageConfig_RelicSelectedNotEnoughHint_CN = {
    Text = "请选择{s1}个造物"
  },
  LanguageConfig_RelicStoreTitle_CN = {
    Text = "造物融痕"
  },
  LanguageConfig_RelicStrengthShopTitle_CN = {
    Text = "选择{s1}个造物进行强化"
  },
  LanguageConfig_Relic_Select_CN = {
    Text = "选择 {s1} 个造物"
  },
  LanguageConfig_RemainValidTime_CN = {
    Text = "剩余有效时间:"
  },
  LanguageConfig_RemoveBuff_CN = {Text = "驱散"},
  LanguageConfig_RemoveCardHint_CN = {
    Text = "被删除的卡牌将在本局调查中永久移除，请谨慎选择"
  },
  LanguageConfig_RemoveDeBuff_CN = {Text = "净化"},
  LanguageConfig_RenderChangeCDTips_CN = {
    Text = "切换性别功能{s1}后冷却完毕"
  },
  LanguageConfig_RepairTipsContent_CN = {
    Text = "修复功能将删除所有已下载的游戏资源，点选确认后将重新下载。\n建议仅发生在游戏无法正常进行、闪退等问题时使用此功能。\n确认是否清除资源？"
  },
  LanguageConfig_RepairTipsTitle_CN = {
    Text = "资源修复"
  },
  LanguageConfig_Repeat_Get_Copy_Reward_CN = {
    Text = "已获得蔷薇金券效率奖励"
  },
  LanguageConfig_RepelBuff_CN = {
    Text = "击退状态"
  },
  LanguageConfig_RepetitiveAwakerConvert_CN = {
    Text = "重复唤醒体，已转化"
  },
  LanguageConfig_ReplayLoadingTips_CN = {
    Text = "正在连接回放…"
  },
  LanguageConfig_ReplayLoadingTitle_CN = {
    Text = "战斗记录"
  },
  LanguageConfig_ReplayTabRule_CN = {
    Text = "<Title:【调查模式】>\n·在调查行动、无光之境和限时玩法活动等关卡调查完成后，可在此查看对应的调查记录。\n·失败的调查模式挑战不会被记录。\n·当前仅支持关卡中最后一场战斗的回放。\n\n<Title:【回放】>\n·可在下方的输入框内输入战斗记录来观看对应的战斗回放。\n·可以在调查模式「调查数据」、相位对弈「战斗结算」等界面中复制对战记录并分享给他人。\n·「调查行动」和「相位对弈」最多各保存100条，并且记录最多保留30天。"
  },
  LanguageConfig_ReplayTabTitle_CN = {
    Text = "战斗记录"
  },
  LanguageConfig_ReplenishEnergy_Comfirm1_CN = {Text = "确认"},
  LanguageConfig_ReplenishEnergy_Comfirm2_CN = {Text = "兑换"},
  LanguageConfig_ReplenishEnergy_ExchangeDesc1_CN = {
    Text = "使用后，获得「灵啡肽」× <Blue:{s1}>"
  },
  LanguageConfig_ReplenishEnergy_ExchangeDesc2_CN = {
    Text = "消耗 <Blue:「银芯」× {s1}>，获得「灵啡肽」× <Blue:{s2}>，今日剩余获取次数：<Blue:{s3}>"
  },
  LanguageConfig_ReplenishEnergy_ExchangeSubDesc2_CN = {
    Text = "单日补充次数越多，所需「银芯」越多"
  },
  LanguageConfig_ReplenishEnergy_Supplement_CN = {
    Text = "补充方式"
  },
  LanguageConfig_ReplenishEnergy_Title_CN = {
    Text = "补充灵啡肽"
  },
  LanguageConfig_ReportTimeLimited_CN = {
    Text = "今日举报次数已达上限"
  },
  LanguageConfig_ResearchComplete_CN = {
    Text = "完成调查"
  },
  LanguageConfig_ResetTaskTimeCountdown_CN = {
    Text = "{s1}小时{s2}分钟后重置"
  },
  LanguageConfig_ResonanceActiveDefault_CN = {
    Text = "默认开启"
  },
  LanguageConfig_ResonanceActiveExtraItem_CN = {
    Text = "（可使用{s1}激活）"
  },
  LanguageConfig_ResonanceActiveNoneEffectsText_CN = {
    Text = "未激活任何共鸣"
  },
  LanguageConfig_ResonanceActiveText_CN = {Text = "激活"},
  LanguageConfig_ResonanceArriveMaxLevelText_CN = {
    Text = "已升至最高等级"
  },
  LanguageConfig_ResonanceEffectsText_CN = {
    Text = "%s(Lv.%d)：%s"
  },
  LanguageConfig_ResonanceParticleTypeName_CN = {
    Text = "共鸣粒子"
  },
  LanguageConfig_ResonanceRelateToEvent_CN = {
    Text = "受【共鸣】效果影响"
  },
  LanguageConfig_ResonanceResetCostConfirm_CN = {
    Text = "是否需要消耗<color=%s>%d</color>%s重置当前关卡共鸣点？"
  },
  LanguageConfig_ResonanceReset_CN = {
    Text = "共鸣点重置"
  },
  LanguageConfig_ResonanceRewardTagText_CN = {
    Text = "共鸣加成"
  },
  LanguageConfig_ResonanceRules_CN = {
    Text = "1、每章调查事件都有共鸣，共鸣可以在调查时提供强力的协助。\n2、首通关卡将会获得共鸣升级材料，消耗材料可以激活共鸣效果。\n3、共鸣将会在地图内的节点出现，移动至共鸣节点上将在本次探索获得共鸣。"
  },
  LanguageConfig_ResonanceSelectCard_CN = {
    Text = "选择一张卡牌复制"
  },
  LanguageConfig_ResonanceText_CN = {Text = "共鸣"},
  LanguageConfig_ResonanceTipsName_CN = {Text = "「%s」"},
  LanguageConfig_ResonanceUnlockText_CN = {Text = "未解锁"},
  LanguageConfig_ResonanceUnlockTips_CN = {
    Text = "激活{s1}后解锁"
  },
  LanguageConfig_ResonanceUnlock_And_CN = {Text = "和"},
  LanguageConfig_ResonanceUnlock_Or_CN = {Text = "或"},
  LanguageConfig_ResonanceUpgradeText_CN = {Text = "升级"},
  LanguageConfig_Resonance_Group_Desc_1_CN = {
    Text = "在节点【善意的礼物】处，可将 1 张「天真的回礼」加入牌库 —— 算力消耗 1，给予狂气最低的一名唤醒体 30 狂气，消耗。"
  },
  LanguageConfig_Resonance_Group_Desc_24_CN = {
    Text = "在「疯狂之路」事件中指定一名唤醒体使其精神分裂，失去初始的四张指令卡，此后，前进的道路才会出现并使你获得 3 选 1 黄金造物。\n你可以在后续的四个「精神碎片」事件中逐个找回失去的指令卡，找回的指令卡将直接拥有独特的<EnsembleKeywords:「合奏」>刻印。"
  },
  LanguageConfig_Resonance_Group_Desc_2_CN = {
    Text = "在节点【未完的蜡像】处，可选择 1 张卡牌，使其算力消耗降低1。"
  },
  LanguageConfig_Resonance_Group_Desc_3_CN = {
    Text = "在节点【古怪脓疱】处，可将一张「畸变之心」加入牌库，算力消耗 0，打出后弃掉所有手牌并抽取弃牌数+1的牌，消耗。"
  },
  LanguageConfig_Resonance_Group_Desc_4_CN = {
    Text = "在节点【蜂蜜甜酒】处，可将一张「蜂蜜甜酒」加入牌库 —— 算力消耗 1，获得 1 层临时屏障，消耗。"
  },
  LanguageConfig_Resonance_Group_Desc_5_CN = {
    Text = "于关卡「沉溺之徒」及之后关卡的节点【代行之仪】处，可获得「神国腕肢」效果——回合结束后对前排敌方造成自身队伍 10% 最大生命的伤害。\n可将一张「代行者的裁决」加入牌库——0算力消耗，打出后失去 10% 当前生命，使「神国腕肢」对后排敌方造成 3 倍伤害，若在首领战中则造成 10 倍伤害。消耗。"
  },
  LanguageConfig_Resonance_Group_Desc_6_CN = {
    Text = "于「纯白之帆」处，将一张「乌托邦帷幕」加入牌库。1 算力消耗，查看 3 个与当前携带不同的钥令，选择 1 个立即释放，不会触发钥令冷却。首领战中可额外使用 1 次。消耗。"
  },
  LanguageConfig_Resonance_Group_Desc_7_CN = {
    Text = "探索起点附近，会遭遇特殊的共鸣事件——【孕育之母】，选择一张指令卡，使其获得特殊的【孕育】刻印，但也使你获得 3 张随机症状卡。\n【孕育】刻印：使卡牌获得保留，回合结束时若在手中，获得一张附加保留和消耗的原始复制。"
  },
  LanguageConfig_Resonance_Group_Desc_8_CN = {
    Text = "探索起点附近，会遭遇特殊的共鸣事件——【入学仪式】，将【极夜微光】加入牌库。\n【极夜微光】：选择抽牌堆或弃牌堆的 1 张指令卡置入手中，并使其算力消耗变为 0。使用 1 次后消耗。"
  },
  LanguageConfig_Resonance_Group_Desc_9_CN = {
    Text = "探索起点附近，会遭遇特殊的共鸣事件——【入学仪式】，将【极夜微光】加入牌库且其继承第八章的所有加成。"
  },
  LanguageConfig_Resonance_Group_Desc_D05EX_CN = {
    Text = "获得初始造物「科考团」：初始拥有 30 科考团人数。战斗开始时，将 5 张「猜疑」置入牌库中。「猜疑」：打出后将选择消耗不同的科考团人数，获得不同效果。\n\n在探索的过程中，将不断的面临「猜疑」的抉择，科考团人员的损失，触发联络处后，还有机会获得救援，最后安全撤离时，根据剩余科考团人数获得「救难勋章」，撤离人数越多「救难勋章」越强大。"
  },
  LanguageConfig_Resonance_Group_Desc_Horla_CN = {
    Text = "探索开始时获得初始造物「奥尔拉的笔与墨」：战斗结束后获得 1 层「笔墨」，「笔墨」达到 2 层后消耗，随机将 1 张「意象」置入牌库。\n可在特殊的共鸣事件【春天的赠礼】中选择「创作献诗」：选择 3 张「意象」卡，让奥尔拉为你创作「献诗」。"
  },
  LanguageConfig_Resonance_Group_Desc_Lily_CN = {
    Text = "在共鸣事件「制片人的迷思」处，选项「求助合伙人」可以获得高级刻印 3 选 1 。"
  },
  LanguageConfig_Resonance_Group_Desc_MLYM_CN = {
    Text = "探索开始时将 3 张增益卡加入牌库：<DerivativeCardKeywords_57:「温暖的家庭」>、<DerivativeCardKeywords_58:「诚挚的朋友」>、<DerivativeCardKeywords_59:「安定的生活」>。\n「温暖的家庭」：获得 2 点算力。\n「诚挚的朋友」：对所有敌人施加 1 层虚弱、易伤。\n「安定的生活」：抽 2 张牌。"
  },
  LanguageConfig_Resonance_Group_Desc_Railway_CN = {
    Text = "待填充。"
  },
  LanguageConfig_Resonance_Group_Desc_SEWD_CN = {
    Text = "「欲望」事件获得随机负罪造物或黄金造物；「忏悔」事件将负罪造物净化为受祝造物；「救赎」事件可以删除症状卡获得奖励"
  },
  LanguageConfig_Resonance_Group_Desc_Wangda_CN = {
    Text = "在共鸣事件「代行密令」处，选项「获取经费」可以获得25黑印和随机白银造物 。"
  },
  LanguageConfig_Resonance_Group_Desc_x1_CN = {
    Text = "在共鸣事件「尚未流失的意识」处，将 一张「备用脑缸」洗入牌库。「备用脑缸」能够暂时储存曾经使用过的卡牌，依据不同场合决定是否将其取出置入手中。"
  },
  LanguageConfig_Resonance_Group_Desc_x2_CN = {
    Text = "在「生命的蜕变」事件处，选择一名唤醒体转化为「虫族」。\n「虫族」的狂气回充和银钥充能提高 50%，所有指令卡算力消耗 -1，但打出后会消耗。"
  },
  LanguageConfig_Resonance_Group_Desc_x3_CN = {
    Text = "在「宴前仪礼」事件处，将 1 张「祭灵夜特调」置入牌库。\n「祭灵夜特调」：算力消耗 1，所有唤醒体暴击率和暴击伤害临时提高 10%。打出「祭灵夜特调」后，将 1 种材料置入其中，使其在本场战斗中永久获得特定效果！"
  },
  LanguageConfig_Resonance_Group_Desc_x4_CN = {
    Text = "在「墨菲的幻影」事件处，将 3 张「循环的倒影」置入牌库。\n打出「循环的倒影」时，发现一个「追忆效果」将其释放，消耗。余波：所有唤醒体获得 5 点狂气。"
  },
  LanguageConfig_Resonance_Group_Desc_x5_CN = {
    Text = "临时文本，星辰章五共鸣功能描述。"
  },
  LanguageConfig_Resonance_Group_Desc_x6_CN = {
    Text = "临时文本，星辰章六共鸣功能描述。"
  },
  LanguageConfig_Resonance_Group_Name_1_CN = {
    Text = "孩童的歌谣"
  },
  LanguageConfig_Resonance_Group_Name_2_CN = {
    Text = "蜡像手记"
  },
  LanguageConfig_Resonance_Group_Name_3_CN = {
    Text = "呓语冥思"
  },
  LanguageConfig_Resonance_Group_Name_4_CN = {
    Text = "疯人学究"
  },
  LanguageConfig_Resonance_Group_Name_5_CN = {
    Text = "航海日记"
  },
  LanguageConfig_Resonance_Group_Name_6_CN = {
    Text = "纯白之帆"
  },
  LanguageConfig_Resonance_Group_Name_7_CN = {
    Text = "万千子嗣"
  },
  LanguageConfig_Resonance_Group_Name_8_CN = {
    Text = "极夜的微光"
  },
  LanguageConfig_Resonance_Group_Name_9_CN = {
    Text = "无上的意志"
  },
  LanguageConfig_Resonance_Group_Name_Railway_CN = {
    Text = "疾驰的欢愉专列"
  },
  LanguageConfig_ResurrectionCoinPurchaseTips_CN = {
    Text = "（兑换后将直接消耗并且复活，若撤退则会返还应急灵知体。应急灵知体每周限购3次，当前剩余次数：{s1}/3）"
  },
  LanguageConfig_ResurrectionCoinSkillDescription_CN = {
    Text = "死亡后可发动，在使用应急灵知体后恢复所有生命、狂气、银钥能量，并在该回合免疫后续的所有伤害。"
  },
  LanguageConfig_Resurrection_CN = {Text = "复活"},
  LanguageConfig_ReturnEventRewardButtonText_CN = {
    Text = "重启补给"
  },
  LanguageConfig_ReturnEventRewardSenderText_CN = {
    Text = "——朵尔"
  },
  LanguageConfig_ReturnEventRewardText_CN = {
    Text = "与融蚀对抗的使命是一条通向未知的不归路，路上遍布陷阱与危机。\n而「拯救世界」又是一个太重要，也太容易让人迷失的课题。在弥萨格大学的历史上，有不少年轻调查员受到使命感的蛊惑，失去理智地燃烧了自己。\n因此你能做出休息一段时间的决定，我们都很庆幸。我们承受不起又一次失去守密人的损失。\n寒暄到此为止，为了能让你迅速回到调查状态，我为你拟定了一套重启训练方案。照着做，拿着结果回来找我，我自有奖励。\n顺便，拉蒙娜为你准备了一些「小礼物」。她挺想你的。"
  },
  LanguageConfig_ReturnEventRewardTitleText_CN = {
    Text = "重启未知的旅途"
  },
  LanguageConfig_Revive_Tips_CN = {
    Text = "已启用<RedQuality:应急灵知体>\n唤醒体已重新恢复战斗能力\n把握最后的机会吧"
  },
  LanguageConfig_RewardItemAccelerateTag_CN = {Text = "加速"},
  LanguageConfig_RoleDayExpLimit_CN = {
    Text = "今日经验上限"
  },
  LanguageConfig_RoleDetailsAttributeLevelUp_Btn_LevelUpLimit_CN = {
    Text = "升至上限"
  },
  LanguageConfig_RoleDetailsAttributeLevelUp_Btn_LevelUp_CN = {Text = "升1级"},
  LanguageConfig_RoleDetailsAttributeLevelUp_Str_LimitTip_CN = {
    Text = "等级已达上限"
  },
  LanguageConfig_RoleDetailsEquipDetails_Btn_Change_CN = {Text = "更换"},
  LanguageConfig_RoleDetailsEquipDetails_Btn_LevelUp_CN = {Text = "强化"},
  LanguageConfig_RoleDetailsEquipDetails_Btn_PutOn_CN = {Text = "装备"},
  LanguageConfig_RoleDetailsEquipDetails_Btn_Remove_CN = {Text = "卸下"},
  LanguageConfig_RoleDetailsEquipDetails_Btn_Replace_CN = {Text = "替换"},
  LanguageConfig_RoleDetailsSkillLevelUp_Btn_Determine_CN = {Text = "升级"},
  LanguageConfig_RoleDetailsSkill_Str_AbilitySkill_CN = {
    Text = "灵知觉醒"
  },
  LanguageConfig_RoleDetails_Str_DBG_CN = {
    Text = "调查模式"
  },
  LanguageConfig_RoleDetails_Str_RPG_CN = {
    Text = "课题模式"
  },
  LanguageConfig_RoleInterfaceSort_Str_AtkType_CN = {Text = "强袭"},
  LanguageConfig_RoleInterfaceSort_Str_Atk_CN = {
    Text = "攻击 {s1}"
  },
  LanguageConfig_RoleInterfaceSort_Str_DefType_CN = {Text = "防卫"},
  LanguageConfig_RoleInterfaceSort_Str_Def_CN = {
    Text = "防御 {s1}"
  },
  LanguageConfig_RoleInterfaceSort_Str_Favorability_CN = {
    Text = "同调率 {s1}"
  },
  LanguageConfig_RoleInterfaceSort_Str_Hp_CN = {
    Text = "体质 {s1}"
  },
  LanguageConfig_RoleInterfaceSort_Str_Level_CN = {Text = "Lv.{s1}"},
  LanguageConfig_RoleInterfaceSort_Str_Potency_CN = {
    Text = "启灵 {s1}/{s2}"
  },
  LanguageConfig_RoleInterfaceSort_Str_Score_CN = {
    Text = "战力 {s1}"
  },
  LanguageConfig_RoleInterfaceSort_Str_SupType_CN = {Text = "特殊"},
  LanguageConfig_RoleInterface_Btn_Determine_CN = {Text = "关闭"},
  LanguageConfig_RoleInterface_SortTypeBtn_Atk_CN = {Text = "攻击"},
  LanguageConfig_RoleInterface_SortTypeBtn_Collection_CN = {Text = "收藏"},
  LanguageConfig_RoleInterface_SortTypeBtn_Def_CN = {Text = "防御"},
  LanguageConfig_RoleInterface_SortTypeBtn_Favorability_CN = {Text = "同调率"},
  LanguageConfig_RoleInterface_SortTypeBtn_Hp_CN = {Text = "体质"},
  LanguageConfig_RoleInterface_SortTypeBtn_Level_CN = {Text = "等级"},
  LanguageConfig_RoleInterface_SortTypeBtn_Potency_CN = {Text = "启灵"},
  LanguageConfig_RoleInterface_SortTypeBtn_Score_CN = {Text = "战力"},
  LanguageConfig_RoleInterface_SortTypeBtn_Star_CN = {Text = "稀有度"},
  LanguageConfig_RoleInterface_SortTypeBtn_Type_CN = {Text = "界域"},
  LanguageConfig_RoleInterface_Str_Tips_CN = {
    Text = "暂无该界域的唤醒体"
  },
  LanguageConfig_RoleInterface_Str_Title_CN = {Text = "全界域"},
  LanguageConfig_RootSedimentShopRules_CN = {
    Text = "1、守密人可以通过消耗一定的「根源沉淀」兑换商品。\n2、当守密人调查等级提升时，沉淀兑换商店会随之升级并解锁新内容。\n3、沉淀兑换商店内的商品每隔一定的时间会自动刷新库存。\n4、守密人可以通过唤醒来获得「根源沉淀」。"
  },
  LanguageConfig_RuleTipsTitle_CN = {
    Text = "规则说明"
  },
  LanguageConfig_RulesOfPlay_CN = {
    Text = "幻梦深潜"
  },
  LanguageConfig_RuneGain_Title_CN = {
    Text = "选择1张卡牌镶嵌刻印"
  },
  LanguageConfig_SDKLogining_CN = {
    Text = "「用户中心」登录中，请稍后。"
  },
  LanguageConfig_SEWDResonance1_1_CN = {
    Text = "获得随机负罪造物"
  },
  LanguageConfig_SEWDResonance1_2_CN = {
    Text = "获得3选1负罪造物"
  },
  LanguageConfig_SaleSuccessful_CN = {
    Text = "出售成功"
  },
  LanguageConfig_SalvadorStageUnlockDesc_CN = {
    Text = "完成特遣纪录前置关卡解锁"
  },
  LanguageConfig_SchoolNotAagreeWith_CN = {
    Text = "界域冲突"
  },
  LanguageConfig_SchoolRequired_CN = {
    Text = "要求界域"
  },
  LanguageConfig_SchoolTaskLabel_CN = {
    Text = "界域精通"
  },
  LanguageConfig_SchoolTowerChallengeLockTips_CN = {
    Text = "完成上一关卡后解锁"
  },
  LanguageConfig_SchoolTowerChallengeNotReachLevelTips_CN = {
    Text = "挑战所需等级不足"
  },
  LanguageConfig_SchoolTowerRuleTxt_CN = {
    Text = "<Title:无光之境>\n·无光之境，是一系列难度较高的关卡。通关关卡可以领取丰厚奖励。此外，达成累计的关卡评分星级还可以获取额外奖励。\n\n<Title:调查要求>\n·无光之境的关卡可能会要求使用指定界域和数量的唤醒体进行调查，守密人可以在关卡详情和队伍配置界面中查看。\n\n<Title:初始造物>\n·无光之境的关卡会存在独特的造物，该造物仅在当前关卡生效，合理利用造物效果将会使调查事半功倍。"
  },
  LanguageConfig_SchoolTowerTeamBuildFobiddenTips_CN = {
    Text = "当前选择不满足队伍要求"
  },
  LanguageConfig_School_Activate_CN = {Text = "已激活"},
  LanguageConfig_School_Blood_Content_String_CN = {
    Text = "·回合开始时<CardKeyWord:胚胎融合> +20（随损失生命提升，最高 40），达到上限时将 1 张<CardKeyWord:「胚胎」>置入手牌。\n·血肉界域的「狂气爆发」会消耗<CardKeyWord:「胚胎」>触发<CardKeyWord:吞噬>效果，每回合首次吞噬后会获得最大生命 2% 的护盾和 1% 的临时力量。（随损失生命提高，最大为 2 倍）"
  },
  LanguageConfig_School_Blood_Title_String_CN = {
    Text = "猩红献祭"
  },
  LanguageConfig_School_Chaos_Content_String_CN = {
    Text = "·混沌界域唤醒体可以突破界域限制与其他界域唤醒体编队。\n·任意队伍中如果存在混沌唤醒体，可以额外获得 100% 死亡抵抗。\n·回合结束和释放「狂气爆发」后，<CardKeyWord:银钥能量> +50。"
  },
  LanguageConfig_School_Chaos_Title_String_CN = {
    Text = "宇宙万象"
  },
  LanguageConfig_School_Dimension_Content_String_CN = {
    Text = "·每回合打出的第 1 张指令卡的临时复制会进入<CardKeyWord:超维空间>并触发其跃迁效果。\n·当超维空间达到上限时，获得 1 个额外的超维回合，该回合不再通常抽牌，而是将超维空间的卡牌加入手牌。超维回合能触发所有跃迁效果。"
  },
  LanguageConfig_School_Dimension_Title_String_CN = {
    Text = "维度跃迁"
  },
  LanguageConfig_School_Ocean_Content_String_CN = {
    Text = "·战斗开始时生成 1 条触腕，触腕在回合结束时攻击前排敌人。\n·每释放 1 次狂气爆发，在回合结束时驱使 1 条触腕攻击。\n·每获得 3 点力量提供 1 点触腕伤害，力量每下降 3 点使触腕伤害降低 1 点。"
  },
  LanguageConfig_School_Ocean_Title_String_CN = {
    Text = "沉渊之触"
  },
  LanguageConfig_School_Tips_String_CN = {
    Text = "在调查模式中，根据队伍包含的界域激活界域天赋效果。\n点击可查看详情。"
  },
  LanguageConfig_School_Title_String_CN = {
    Text = "界域天赋"
  },
  LanguageConfig_ScoreAchieveNum_CN = {
    Text = "累计深潜经验值：{s1}"
  },
  LanguageConfig_ScoreAchieveTitle_CN = {
    Text = "深潜纪录"
  },
  LanguageConfig_ScoreMaxTo_CN = {
    Text = "累计深潜经验值达到"
  },
  LanguageConfig_ScoreMultipleDesc_CN = {
    Text = "（总评分为以下总和×{s1}）"
  },
  LanguageConfig_ScoreReachTile_CN = {
    Text = "每周试炼"
  },
  LanguageConfig_ScoreReachTo_CN = {
    Text = "分数累计至"
  },
  LanguageConfig_ScoreSumDesc_CN = {
    Text = "（总评分为以下总和）"
  },
  LanguageConfig_SeasonDesc_0_CN = {
    Text = "赛季0描述"
  },
  LanguageConfig_SeasonDesc_1_CN = {
    Text = "赛季1描述"
  },
  LanguageConfig_SeasonDesc_2_CN = {
    Text = "赛季2描述"
  },
  LanguageConfig_SeasonDesc_3_CN = {
    Text = "赛季3描述"
  },
  LanguageConfig_SeasonDesc_4_CN = {
    Text = "赛季4描述"
  },
  LanguageConfig_SeasonName_0_CN = {
    Text = "赛季0名称"
  },
  LanguageConfig_SeasonName_1_CN = {
    Text = "赛季1名称"
  },
  LanguageConfig_SeasonName_2_CN = {
    Text = "赛季2名称"
  },
  LanguageConfig_SeasonName_3_CN = {
    Text = "赛季3名称"
  },
  LanguageConfig_SeasonName_4_CN = {
    Text = "赛季4名称"
  },
  LanguageConfig_SeasonRankListSettlementNotice1_CN = {
    Text = "本赛季将在{s1}天{s2}小时后结算排行奖励"
  },
  LanguageConfig_SeasonRankListSettlementNotice2_CN = {
    Text = "本赛季将在{s1}小时{s2}分钟后结算排行奖励"
  },
  LanguageConfig_SecondAnniversaryDailyGainAbleTip_CN = {Text = "可领取"},
  LanguageConfig_SecondAnniversaryDailyReward_CN = {
    Text = "每日校猫赠礼"
  },
  LanguageConfig_SecondAnniversaryDailyTimeAlert_CN = {
    Text = "倒计时{s1}后可领"
  },
  LanguageConfig_SecondAnniversarySevenDaySign_CN = {
    Text = "校猫七日奖励"
  },
  LanguageConfig_SecondAnniversaryShopName_CN = {
    Text = "校猫的小店"
  },
  LanguageConfig_Second_CN = {Text = "秒"},
  LanguageConfig_SelectAllAwaker_CN = {Text = "全选"},
  LanguageConfig_SelectItemToDecompose_CN = {
    Text = "请从左侧选择需要分解的材料"
  },
  LanguageConfig_SelectKeeperSkillToUse_Title1_CN = {
    Text = "选择一个钥令释放"
  },
  LanguageConfig_SelectKeeperSkill_Title1_CN = {
    Text = "选择一个钥令"
  },
  LanguageConfig_SelectOneWheelEquipment_CN = {
    Text = "选择 1 个命轮装备"
  },
  LanguageConfig_SelectTrinketHave_CN = {Text = "有"},
  LanguageConfig_SelectTrinketMainAttr_CN = {
    Text = "选择主属性"
  },
  LanguageConfig_SelectTrinketNo_CN = {Text = "无"},
  LanguageConfig_SelectTrinketSubAttr_CN = {
    Text = "选择副属性"
  },
  LanguageConfig_SelectTrinketSuit_CN = {
    Text = "选择套装"
  },
  LanguageConfig_Select_yixiangCard_CN = {
    Text = "选择 3 张意象合成献诗"
  },
  LanguageConfig_SelectedSpecNumAwakers_CN = {
    Text = "请选择{s1}个唤醒体"
  },
  LanguageConfig_ServerWideKilledMonstersCount_CN = {
    Text = "全维度已抓捕 <color=#5EF2FF> {s1} </color> 只"
  },
  LanguageConfig_Server_Closed_CN = {
    Text = "校园维护中，请静候修整完成"
  },
  LanguageConfig_Server_Stop_Confirm_CN = {Text = "确认"},
  LanguageConfig_Server_Stop_Desc_CN = {
    Text = "服务器连接中断，稍后将返回登录页面。"
  },
  LanguageConfig_Server_Stop_Tittle_CN = {
    Text = "连接中断"
  },
  LanguageConfig_Server_Warn_10_CN = {
    Text = "未找到对应密境"
  },
  LanguageConfig_Server_Warn_11_CN = {
    Text = "密境事件已完成"
  },
  LanguageConfig_Server_Warn_12_CN = {
    Text = "密境事件配置类型填写错误"
  },
  LanguageConfig_Server_Warn_13_CN = {
    Text = "密境事件不存在"
  },
  LanguageConfig_Server_Warn_14_CN = {
    Text = "黑印不足，无法购买"
  },
  LanguageConfig_Server_Warn_15_CN = {
    Text = "此卡无法强化"
  },
  LanguageConfig_Server_Warn_16_CN = {
    Text = "此卡已达强化上限"
  },
  LanguageConfig_Server_Warn_17_CN = {
    Text = "行商不出售此商品"
  },
  LanguageConfig_Server_Warn_18_CN = {
    Text = "无此奖励"
  },
  LanguageConfig_Server_Warn_19_CN = {
    Text = "奖励已领取"
  },
  LanguageConfig_Server_Warn_1_CN = {
    Text = "操作成功"
  },
  LanguageConfig_Server_Warn_20_CN = {
    Text = "事件数据错误"
  },
  LanguageConfig_Server_Warn_21_CN = {
    Text = "商品已购买"
  },
  LanguageConfig_Server_Warn_22_CN = {
    Text = "未找到课题单元数据"
  },
  LanguageConfig_Server_Warn_23_CN = {
    Text = "单元已提交，无需再次提交"
  },
  LanguageConfig_Server_Warn_24_CN = {
    Text = "单元下的课题尚未全部完成，无法提交"
  },
  LanguageConfig_Server_Warn_25_CN = {
    Text = "课题无模块"
  },
  LanguageConfig_Server_Warn_26_CN = {
    Text = "关卡无课题数据"
  },
  LanguageConfig_Server_Warn_2_CN = {
    Text = "配置表错误"
  },
  LanguageConfig_Server_Warn_3_CN = {
    Text = "客户端传入数据错误"
  },
  LanguageConfig_Server_Warn_4_CN = {
    Text = "服务未启动"
  },
  LanguageConfig_Server_Warn_5_CN = {
    Text = "角色数据错误"
  },
  LanguageConfig_Server_Warn_6_CN = {
    Text = "没有角色，需创建"
  },
  LanguageConfig_Server_Warn_7_CN = {
    Text = "已有角色，不需要再次创建"
  },
  LanguageConfig_Server_Warn_8_CN = {
    Text = "角色名重复"
  },
  LanguageConfig_Server_Warn_9_CN = {
    Text = "密境错误"
  },
  LanguageConfig_Service_Not_Errcode_CN = {
    Text = "功能提示：未找到提示代码"
  },
  LanguageConfig_Service_Tips_11859_CN = {
    Text = "未达到建筑解锁条件"
  },
  LanguageConfig_Service_Tips_11860_CN = {
    Text = "未达到建筑升级条件"
  },
  LanguageConfig_Service_Tips_11861_CN = {
    Text = "建筑升级材料不足"
  },
  LanguageConfig_Service_Tips_71_CN = {
    Text = "不满足使用条件"
  },
  LanguageConfig_SetLogInReward_MOBILE_Tips_CN = {
    Text = "使用移动设备登录"
  },
  LanguageConfig_SetLogInReward_PC_Tips_CN = {
    Text = "使用PC设备登录"
  },
  LanguageConfig_SetLogInReward_Tips_CN = {
    Text = "多平台登录可获得限定头像等奖励！"
  },
  LanguageConfig_SettingPanelTitle_CN = {Text = "设置"},
  LanguageConfig_SettingToggleClose_CN = {Text = "关闭"},
  LanguageConfig_SettingToggleOpen_CN = {Text = "开启"},
  LanguageConfig_ShareFacebookText_CN = {
    Text = "我在《忘却前夜》抽到了{s1}，快来看看吧！"
  },
  LanguageConfig_ShareLineText_CN = {
    Text = "我在《忘却前夜》抽到了{s1}，快来看看吧！"
  },
  LanguageConfig_ShareTwitterText_CN = {
    Text = "我在《忘却前夜》抽到了{s1}，快来看看吧！"
  },
  LanguageConfig_ShenGuoShangFu_01_CN = {
    Text = "击杀所有海怪后，会出现最终的敌人!"
  },
  LanguageConfig_Shield_Break_CN = {
    Text = "护盾破除"
  },
  LanguageConfig_ShopChargeDesc_CN = {
    Text = "{s1}滴{s2}"
  },
  LanguageConfig_ShopConfirmExchange_CN = {
    Text = "确认兑换"
  },
  LanguageConfig_ShopEnchantGiftText_CN = {Text = "礼物"},
  LanguageConfig_ShopExchangeQuantity_CN = {
    Text = "兑换数量"
  },
  LanguageConfig_ShopItem_Str_Free_CN = {Text = "免费"},
  LanguageConfig_ShopLimitTimeActivity_CN = {
    Text = "限时活动"
  },
  LanguageConfig_ShopNameDefault_CN = {
    Text = "弥萨格商店"
  },
  LanguageConfig_ShopName_ActivityShop10_CN = {Text = "回声"},
  LanguageConfig_ShopName_ActivityShop11_CN = {
    Text = "觉知海渊"
  },
  LanguageConfig_ShopName_ActivityShop12_CN = {
    Text = "求知的愿望"
  },
  LanguageConfig_ShopName_ActivityShop13_CN = {
    Text = "敬献贡礼"
  },
  LanguageConfig_ShopName_ActivityShop15_CN = {
    Text = "学生会办公楼"
  },
  LanguageConfig_ShopName_ActivityShop16_CN = {
    Text = "隐秘的据点"
  },
  LanguageConfig_ShopName_ActivityShop17_CN = {
    Text = "茉夏的小屋"
  },
  LanguageConfig_ShopName_ActivityShop18_CN = {
    Text = "无边猎场"
  },
  LanguageConfig_ShopName_ActivityShop19_CN = {
    Text = "斗兽场祭祀台"
  },
  LanguageConfig_ShopName_ActivityShop20_CN = {
    Text = "临时文本"
  },
  LanguageConfig_ShopName_ActivityShop2_CN = {
    Text = "人格解析"
  },
  LanguageConfig_ShopName_ActivityShop3_CN = {
    Text = "魔法剧本商店"
  },
  LanguageConfig_ShopName_ActivityShop4_CN = {
    Text = "金红庆典"
  },
  LanguageConfig_ShopName_ActivityShop5_CN = {
    Text = "圣胎孵化"
  },
  LanguageConfig_ShopName_ActivityShop6_CN = {
    Text = "好运俱乐部"
  },
  LanguageConfig_ShopName_ActivityShop7_CN = {
    Text = "安眠宫殿"
  },
  LanguageConfig_ShopName_ActivityShop8_CN = {
    Text = "人格解析"
  },
  LanguageConfig_ShopName_ActivityShop9_CN = {
    Text = "旺达的奇珍宝匣"
  },
  LanguageConfig_ShopName_ReturnCoinShop_CN = {
    Text = "返校商店"
  },
  LanguageConfig_Shop_Batch_Buy_Btn_CN = {
    Text = "批量购买{s1}"
  },
  LanguageConfig_Shop_Buy_Btn_CN = {Text = "购买"},
  LanguageConfig_Shop_Buy_Lack_Arena_Money_CN = {
    Text = "竞技场币不足"
  },
  LanguageConfig_Shop_Buy_Lack_Money_CN = {Text = "{s1}不足"},
  LanguageConfig_Shop_Buy_Str_BuyLimit_CN = {
    Text = "剩余：{s1}"
  },
  LanguageConfig_Shop_Confirm_Buy_Btn_Back_CN = {Text = "取消"},
  LanguageConfig_Shop_Confirm_Buy_Btn_Sure_CN = {Text = "确定"},
  LanguageConfig_Shop_Confirm_Buy_Str_Need_Arena_Money_CN = {
    Text = "消耗竞技场币{s1}"
  },
  LanguageConfig_Shop_Confirm_Buy_Str_Need_Money_CN = {Text = "消耗{s1}"},
  LanguageConfig_Shop_Confirm_Buy_Str_Now_Arena_Money_CN = {
    Text = "当前竞技场币{s1}"
  },
  LanguageConfig_Shop_Confirm_Buy_Str_Now_Money_CN = {Text = "当前{s1}"},
  LanguageConfig_Shop_Confirm_Buy_Str_Tips_CN = {
    Text = "确认花费{s1}购买以下道具吗？"
  },
  LanguageConfig_Shop_Confirm_Buy_Str_Title_CN = {
    Text = "购买确认"
  },
  LanguageConfig_Shop_Confirm_Revert_Str_Arena_Money_Tips_CN = {
    Text = "竞技场币不足"
  },
  LanguageConfig_Shop_Confirm_Revert_Str_Lack_Money_Tips_CN = {
    Text = "蔷薇金券不足"
  },
  LanguageConfig_Shop_Confirm_Revert_Str_Money_Tips_CN = {Text = "要使用"},
  LanguageConfig_Shop_Confirm_Revert_Str_Tips_CN = {
    Text = "重置商店内容吗？"
  },
  LanguageConfig_Shop_Confirm_Revert_Str_Title_CN = {
    Text = "确认重置"
  },
  LanguageConfig_Shop_GiftBag_Exchange_CN = {Text = "兑换"},
  LanguageConfig_Shop_Now_Num_Goods_Str_CN = {
    Text = "持有数：{s1}"
  },
  LanguageConfig_Shop_Refresh_Cost_Text_CN = {
    Text = "消耗{s1}黑印"
  },
  LanguageConfig_Shop_Remove_Btn_Select_CN = {
    Text = "取消选中"
  },
  LanguageConfig_Shop_Revert_Btn_Price_CN = {
    Text = "用{s1}立即重置"
  },
  LanguageConfig_Shop_Revert_Button_Text_CN = {
    Text = "立即重置"
  },
  LanguageConfig_Shop_Revert_Str_Next_Time_CN = {
    Text = "重置倒计时：{s1}"
  },
  LanguageConfig_Shop_Sell_Out_Tips_CN = {Text = "售罄"},
  LanguageConfig_ShortDaysDisplay_CN = {Text = "{s1}天"},
  LanguageConfig_ShortHourDisplay_CN = {Text = "{s1}时"},
  LanguageConfig_SinRelicTypeName_CN = {
    Text = "<RedRelic:负罪造物>"
  },
  LanguageConfig_SkillActivated_CN = {Text = "已激发"},
  LanguageConfig_SkillDetailedInformation_CN = {
    Text = "详细信息"
  },
  LanguageConfig_SkillLevelExUpgrade_CN = {
    Text = "<AwakerSkill:技能等级+{s1}>"
  },
  LanguageConfig_SkillLevelUp_NeedAwakerLevel_CN = {
    Text = "唤醒体需达到等级 <Color4:{s1}>"
  },
  LanguageConfig_SkillMaterialTypeName_CN = {
    Text = "技能材料"
  },
  LanguageConfig_SkillNotActivated_CN = {Text = "未激发"},
  LanguageConfig_SkillStowInformation_CN = {
    Text = "收起信息"
  },
  LanguageConfig_SkillUpgradeInsufficientMaterial_CN = {
    Text = "技能升级素材不足"
  },
  LanguageConfig_Skill_LevelUp_Success_CN = {
    Text = "技能升级成功"
  },
  LanguageConfig_SkinTurntableActivityDesc1_CN = {
    Text = "再抽<color=#e3c96e>{s1}</color>次开始有机会获得4星幻衣"
  },
  LanguageConfig_SkinTurntableActivityDesc2_CN = {
    Text = "本次抽取有<color=#e3c96e>{s1}%</color>的概率获得4星幻衣"
  },
  LanguageConfig_SkinTurntableActivityDesc3_CN = {
    Text = "继续抽取以获得剩余奖品"
  },
  LanguageConfig_Sleep_CN = {
    Text = "..z<size=40>z</size>Z<size=40>Z</size>"
  },
  LanguageConfig_SmallPotencyDesc_CN = {
    Text = "次级启灵（已废弃）"
  },
  LanguageConfig_SmallPotencyTitle_CN = {Text = "共用"},
  LanguageConfig_SmallSubplotTipsText_CN = {
    Text = "<Title:意识潜游>\n1、部分意识潜游需要达成以下条件方可进行：\n·完成前置调查事件；\n·消耗指定数量的「现实起点」解锁。\n2、当意识潜游处于限时活动福利期内时，无需消耗「现实起点」即可免费解锁。活动结束后调查进度将保留。\n3、完成意识潜游调查任务可以获得无垢之芯、守密人经验和调查徽章等奖励。"
  },
  LanguageConfig_SmallSubplotTipsTitle_CN = {
    Text = "规则说明"
  },
  LanguageConfig_SmallSubplotTitle_CN = {
    Text = "意识潜游"
  },
  LanguageConfig_SocialChangeAvatarFrameBtnTxt_CN = {
    Text = "更换头像框"
  },
  LanguageConfig_SocialOnlineTimeLabel_CN = {
    Text = "上线时间"
  },
  LanguageConfig_SocialSourcePanelAccelerateTips_CN = {
    Text = "经验加速 {s1}%"
  },
  LanguageConfig_SocialSystemAccumulatedRatingThisWeek_CN = {
    Text = "本周累计评分"
  },
  LanguageConfig_SocialSystemAddNewFans_CN = {
    Text = "新增追随者"
  },
  LanguageConfig_SocialSystemBirthday_CN = {
    Text = "{s1}月{s2}日"
  },
  LanguageConfig_SocialSystemCancelCommonUseBattleHelp_CN = {
    Text = "取消常用助战"
  },
  LanguageConfig_SocialSystemCancelFollow_CN = {
    Text = "取消关注"
  },
  LanguageConfig_SocialSystemCannotSearchForOneself_CN = {
    Text = "不可搜索自己"
  },
  LanguageConfig_SocialSystemChangeAvatar_CN = {
    Text = "更换头像"
  },
  LanguageConfig_SocialSystemChangeBatch_CN = {Text = "换一批"},
  LanguageConfig_SocialSystemCommonUseBattleHelp_CN = {
    Text = "设为常用助战"
  },
  LanguageConfig_SocialSystemCommunity_CN = {Text = "社区"},
  LanguageConfig_SocialSystemCoolDown_CN = {
    Text = "冷却{s1}秒"
  },
  LanguageConfig_SocialSystemEnterNoteName_CN = {
    Text = "请输入备注名"
  },
  LanguageConfig_SocialSystemEnterUID_CN = {
    Text = "请输入UID"
  },
  LanguageConfig_SocialSystemFansEmptyStatusDesc_CN = {
    Text = "终会有第一个发现你的守密人"
  },
  LanguageConfig_SocialSystemFansEmptyStatusTitle_CN = {
    Text = "暂无追随者"
  },
  LanguageConfig_SocialSystemFans_CN = {Text = "追随者"},
  LanguageConfig_SocialSystemFollowEmptyStatusDesc_CN = {
    Text = "去关注更多有趣的守密人吧"
  },
  LanguageConfig_SocialSystemFollowEmptyStatusTitle_CN = {
    Text = "暂无关注"
  },
  LanguageConfig_SocialSystemFollow_CN = {Text = "关注"},
  LanguageConfig_SocialSystemFollowed_CN = {Text = "已关注"},
  LanguageConfig_SocialSystemHighestRecord_CN = {
    Text = "最高纪录"
  },
  LanguageConfig_SocialSystemHighestTitle_CN = {
    Text = "最高头衔"
  },
  LanguageConfig_SocialSystemInterrelated_CN = {
    Text = "互相关注"
  },
  LanguageConfig_SocialSystemIntroductionNone_CN = {
    Text = "暂无简介"
  },
  LanguageConfig_SocialSystemIntroductionNotYetEdited_CN = {
    Text = "点击输入简介"
  },
  LanguageConfig_SocialSystemIntroduction_CN = {
    Text = "编辑简介"
  },
  LanguageConfig_SocialSystemInvitation_CN = {Text = "邀请"},
  LanguageConfig_SocialSystemJustVisited_CN = {
    Text = "刚刚来访"
  },
  LanguageConfig_SocialSystemLeaveNoteName_CN = {
    Text = "为【{s1}】备注名称，取消关注将清除备注"
  },
  LanguageConfig_SocialSystemLikeEmptyStatusDesc_CN = {
    Text = "去点赞更多有趣的守密人吧"
  },
  LanguageConfig_SocialSystemLikeHistory_CN = {
    Text = "点赞记录"
  },
  LanguageConfig_SocialSystemLookupEmptyStatusDesc_CN = {
    Text = "点击换一批，认识更多有趣的守密人"
  },
  LanguageConfig_SocialSystemLookupEmptyStatusTitle_CN = {
    Text = "暂无陌生人"
  },
  LanguageConfig_SocialSystemLookup_CN = {Text = "查找"},
  LanguageConfig_SocialSystemMainLineMadness_CN = {Text = "癫狂"},
  LanguageConfig_SocialSystemModifyRemarks_CN = {
    Text = "修改备注"
  },
  LanguageConfig_SocialSystemNewAddition_CN = {Text = "新增"},
  LanguageConfig_SocialSystemNewFansTip_CN = {
    Text = "可查看近期新增的{s1}名追随者"
  },
  LanguageConfig_SocialSystemNoFoundInTheSearch_CN = {
    Text = "未搜索到其他守密人"
  },
  LanguageConfig_SocialSystemRank_CN = {Text = "达人榜"},
  LanguageConfig_SocialSystemSchoolTowerGap_CN = {
    Text = "无光之境"
  },
  LanguageConfig_SocialSystemSchoolTowerWheelGap_CN = {
    Text = "无光之境·轮转间隙"
  },
  LanguageConfig_SocialSystemSearchPlayers_CN = {
    Text = "输入UID查找守密人"
  },
  LanguageConfig_SocialSystemSearchResult_CN = {
    Text = "搜索结果"
  },
  LanguageConfig_SocialSystemSearch_CN = {Text = "搜索"},
  LanguageConfig_SocialSystemSetBirthday_CN = {
    Text = "设置生日"
  },
  LanguageConfig_SocialSystemSetRemarks_CN = {
    Text = "设置备注"
  },
  LanguageConfig_SocialSystemSocialInteraction_CN = {Text = "校友会"},
  LanguageConfig_SocialSystemStranger_CN = {Text = "陌生人"},
  LanguageConfig_SocialSystemStrollingAround_CN = {
    Text = "正在闲逛..."
  },
  LanguageConfig_SocialSystemSurveyProgress_CN = {
    Text = "调查行动"
  },
  LanguageConfig_SocialSystemVisitedDaysAgo_CN = {
    Text = "{s1}天前来访"
  },
  LanguageConfig_SocialSystemVisitedHoursAgo_CN = {
    Text = "{s1}小时前来访"
  },
  LanguageConfig_SocialSystemVisitedMinutesAgo_CN = {
    Text = "{s1}分钟前来访"
  },
  LanguageConfig_SocialSystemVisitorEmptyStatusDesc_CN = {
    Text = "等待其他守密人留下足迹"
  },
  LanguageConfig_SocialSystemVisitorEmptyStatusTitle_CN = {
    Text = "暂无来访者"
  },
  LanguageConfig_SocialSystemVisitor_CN = {Text = "来访者"},
  LanguageConfig_SocialUnfollowedFans_CN = {Text = "未关注"},
  LanguageConfig_SocializeAdmireReason_CN = {Text = "来自{s1}"},
  LanguageConfig_SocializeAdmireTime_Day_CN = {
    Text = "{s1} 天前点赞了你"
  },
  LanguageConfig_SocializeAdmireTime_Hour_CN = {
    Text = "{s1} 小时前点赞了你"
  },
  LanguageConfig_SocializeAdmireTime_JustNow_CN = {
    Text = "刚刚点赞了你"
  },
  LanguageConfig_SocializeAdmireTime_Minute_CN = {
    Text = "{s1} 分钟前点赞了你"
  },
  LanguageConfig_SocializeAwakerLevel_CN = {
    Text = "唤醒体等级"
  },
  LanguageConfig_SocializeBatchCancel_CN = {
    Text = "批量取关"
  },
  LanguageConfig_SocializeExitCancel_CN = {
    Text = "退出取关"
  },
  LanguageConfig_SocializeFinishCancel_CN = {
    Text = "完成取关"
  },
  LanguageConfig_SocializeOnLineState_Activity_CN = {
    Text = "正在参与活动..."
  },
  LanguageConfig_SocializeOnLineState_Alchemy_CN = {
    Text = "正在进行冶炼..."
  },
  LanguageConfig_SocializeOnLineState_Awaker_CN = {
    Text = "正在观察唤醒体..."
  },
  LanguageConfig_SocializeOnLineState_Bag_CN = {
    Text = "正在清点物资..."
  },
  LanguageConfig_SocializeOnLineState_Battlepass_CN = {
    Text = "正在研究课题..."
  },
  LanguageConfig_SocializeOnLineState_Challenge_CN = {
    Text = "正在准备幕间演习..."
  },
  LanguageConfig_SocializeOnLineState_Copy_CN = {
    Text = "正在禁忌纂录..."
  },
  LanguageConfig_SocializeOnLineState_DailyChallenge_CN = {
    Text = "正在幻梦深潜..."
  },
  LanguageConfig_SocializeOnLineState_DailyCopy_CN = {
    Text = "正在融蚀之墟..."
  },
  LanguageConfig_SocializeOnLineState_Dispatch_CN = {
    Text = "正在派遣任务..."
  },
  LanguageConfig_SocializeOnLineState_MainCopyInvestigate_CN = {
    Text = "正在调查行动..."
  },
  LanguageConfig_SocializeOnLineState_MainCopy_CN = {
    Text = "正在准备调查..."
  },
  LanguageConfig_SocializeOnLineState_Manual_CN = {
    Text = "正在查看学籍档案..."
  },
  LanguageConfig_SocializeOnLineState_PVP_CN = {
    Text = "正在相位对弈…"
  },
  LanguageConfig_SocializeOnLineState_PreparePVP_CN = {
    Text = "准备进行相位对弈…"
  },
  LanguageConfig_SocializeOnLineState_Shop_CN = {
    Text = "正在弥萨格商店..."
  },
  LanguageConfig_SocializeOnLineState_Summon_CN = {
    Text = "正在尝试唤醒..."
  },
  LanguageConfig_SocializeOnLineState_WeekChallenge_CN = {
    Text = "正在无光之境..."
  },
  LanguageConfig_SocializeOnLineState_WeeklyBoss_CN = {
    Text = "正在超验存在..."
  },
  LanguageConfig_SocializeOnLineTime_Day_CN = {
    Text = " {s1} 天前在线"
  },
  LanguageConfig_SocializeOnLineTime_Hour_CN = {
    Text = " {s1} 小时前在线"
  },
  LanguageConfig_SocializeOnLineTime_Minute_CN = {
    Text = " {s1} 分钟前在线"
  },
  LanguageConfig_SocializeOnLineTime_Month_CN = {
    Text = " {s1} 个月前在线"
  },
  LanguageConfig_SocializeOnLineTime_YearMonth_CN = {
    Text = "上次登录：{s1}年{s2}月"
  },
  LanguageConfig_SocializeOnLineTime_Year_CN = {
    Text = " {s1} 年前在线"
  },
  LanguageConfig_SocializeRoleLevel_CN = {
    Text = "守密人等级"
  },
  LanguageConfig_Socialize_AllStrangersFollowed_CN = {
    Text = "已全部关注"
  },
  LanguageConfig_Socialize_AttentionPlayer_CN = {
    Text = "助战关注按钮"
  },
  LanguageConfig_Socialize_CancelAttention_CN = {
    Text = "助战取消按钮"
  },
  LanguageConfig_Socialize_FollowTime_Day_CN = {
    Text = "{s1} 天前关注了你"
  },
  LanguageConfig_Socialize_FollowTime_Hour_CN = {
    Text = "{s1} 小时前关注了你"
  },
  LanguageConfig_Socialize_FollowTime_JustNow_CN = {
    Text = "刚刚关注了你"
  },
  LanguageConfig_Socialize_FollowTime_Minute_CN = {
    Text = "{s1} 分钟前关注了你"
  },
  LanguageConfig_SoulSynchronization_CN = {
    Text = "同调结束"
  },
  LanguageConfig_SpecialMaterialTypeName_CN = {
    Text = "特殊材料"
  },
  LanguageConfig_SpecialRating_CN = {Text = "评分项"},
  LanguageConfig_SpecialShopCustomSoldOutTips_CN = {
    Text = "「感应」在单个灰烬遗迹中只能使用 1 次"
  },
  LanguageConfig_SpecialShopName_CN = {
    Text = "灰烬遗迹"
  },
  LanguageConfig_SpecialShopNoStrengthRelicTips_CN = {
    Text = "无造物可被强化。"
  },
  LanguageConfig_SpecialShopRefreshCostLabel_CN = {Text = "花费"},
  LanguageConfig_SpecialSubplotTipsText_CN = {
    Text = "<Title:异梦视界>\n1、需要达成以下条件方可进行异梦视界：\n·完成对应的调查行动；\n·消耗「现实起点」× 7 解锁。\n2、当异梦视界处于限时活动福利期内时，无需消耗「现实起点」即可免费解锁。活动结束后调查进度将保留。\n3、首次完成异梦视界调查任务可以获得无垢之芯。"
  },
  LanguageConfig_SpecialSubplotTipsTitle_CN = {
    Text = "规则说明"
  },
  LanguageConfig_SpecialSubplotTitle_CN = {
    Text = "异梦视界"
  },
  LanguageConfig_SpecialTeamAssignTitle_CN = {
    Text = "预设队伍"
  },
  LanguageConfig_SpecialTeamBanTips_CN = {
    Text = "本次调查{s1}无法上场"
  },
  LanguageConfig_SpecialTeamPreset_CN = {Text = "预选"},
  LanguageConfig_SpecialTeamTryOut_CN = {Text = "试用"},
  LanguageConfig_Speicial_kuangre1_CN = {
    Text = "即将进入「指令狂热」状态，当前剩余 3 张指令卡……"
  },
  LanguageConfig_Speicial_kuangre2_CN = {
    Text = "即将进入「指令狂热」状态，当前剩余 2 张指令卡……"
  },
  LanguageConfig_Speicial_kuangre3_CN = {
    Text = "即将进入「指令狂热」状态，当前剩余 1 张指令卡……"
  },
  LanguageConfig_Speicial_kuangre4_CN = {
    Text = "已进入「指令狂热」！本回合每打出 1 张指令卡，指令卡算力消耗+1，额外获得 100 点狂气。"
  },
  LanguageConfig_SpiritualDeepenInsufficientMaterials_CN = {
    Text = "灵知深化材料不足"
  },
  LanguageConfig_SpiritualDeepen_CN = {
    Text = "灵知深化"
  },
  LanguageConfig_StageAchieveTaskGot_CN = {Text = "已达成"},
  LanguageConfig_StageAchieveTaskNotGot_CN = {Text = "未达成"},
  LanguageConfig_StageAchievementButton_CN = {
    Text = "成就（{s1}/{s2}）"
  },
  LanguageConfig_StageChapterMorimens_CN = {Text = "忘却篇"},
  LanguageConfig_StageChapterMorimens_Full_CN = {
    Text = "忘却前夜"
  },
  LanguageConfig_StageChapterStarsCameRight_CN = {Text = "星辰篇"},
  LanguageConfig_StageChapterStarsCameRight_Full_CN = {
    Text = "星辰正位之刻"
  },
  LanguageConfig_StageCloseCountdownText_CN = {
    Text = "{s1}后关闭"
  },
  LanguageConfig_StageClosedText_CN = {Text = "已关闭"},
  LanguageConfig_StageCopyUnlockDescFomat_CN = {Text = "{s1}解锁"},
  LanguageConfig_StageHideRewardsButton_CN = {
    Text = "隐藏（{s1}/{s2}）"
  },
  LanguageConfig_StageHighDifficultTipsContent_CN = {
    Text = "前路危机四伏，潜藏着人类难以匹敌之物\n准备万全，谨慎做出每一个抉择\n向那些勇于挑战黑暗与未知的人们致敬\n愿银钥指引前路"
  },
  LanguageConfig_StageHighDifficultTipsTitle_CN = {Text = "警告"},
  LanguageConfig_StageInitialStateContent_CN = {
    Text = "「%s」 ：%s"
  },
  LanguageConfig_StageInitialStateTitle_1_CN = {
    Text = "增益效果"
  },
  LanguageConfig_StageInitialStateTitle_CN = {
    Text = "减益效果"
  },
  LanguageConfig_StageOpenCountdownText_CN = {
    Text = "{s1}后开启"
  },
  LanguageConfig_StageRelicEmpty_CN = {
    Text = "当前关卡无初始造物"
  },
  LanguageConfig_StageRewardsTitle_CN = {
    Text = "成就奖励"
  },
  LanguageConfig_StageUnlockCountdownText_CN = {
    Text = "{s1}天{s2}小时后开启"
  },
  LanguageConfig_StarRatingRules_CN = {
    Text = "每关的探索都会根据首领战回合数来获得调查评价，每关最高可以获得3星，积累星数可以获取「银芯」奖励。"
  },
  LanguageConfig_StateEffectDesc_CN = {
    Text = "状态说明"
  },
  LanguageConfig_StateEffectDurationDesc_1_CN = {
    Text = "本回合有效"
  },
  LanguageConfig_StateEffectDurationDesc_2_CN = {
    Text = "本场战斗有效"
  },
  LanguageConfig_StateEffectDurationDesc_3_CN = {
    Text = "本次探索有效"
  },
  LanguageConfig_StatusApplier1_CN = {
    Text = "敌方<color=#bb646d> {s1} </color>"
  },
  LanguageConfig_StatusApplier2_CN = {
    Text = "友方<color=#76aac8> {s1} </color>"
  },
  LanguageConfig_StatusApplier3_CN = {
    Text = "<color=#bb646d> {s1} </color>"
  },
  LanguageConfig_StatusApplier4_CN = {
    Text = "<color=#76aac8> {s1} </color>"
  },
  LanguageConfig_StatusApplier5_CN = {Text = "、"},
  LanguageConfig_StoreAwakerAwake_CN = {
    Text = "唤醒体觉醒"
  },
  LanguageConfig_StoreBuyCancel_CN = {Text = "取消"},
  LanguageConfig_StoreBuyConfirm_CN = {Text = "确认"},
  LanguageConfig_StoreEnchantmentCancel_CN = {Text = "取消"},
  LanguageConfig_StoreEnchantmentConfirmTitle_CN = {
    Text = "确定刻印此卡"
  },
  LanguageConfig_StoreEnchantmentConfirm_CN = {Text = "确认"},
  LanguageConfig_StoreGiveBloodTitle_CN = {Text = "感应"},
  LanguageConfig_StoreGiveBlood_CN = {
    Text = "失去 <color=#BB646D> {s1} </color> 点生命，获得 {s2} 枚黑印。"
  },
  LanguageConfig_StoreGoodsTypeEnchantment_CN = {Text = "刻印"},
  LanguageConfig_StoreGoodsTypeItem_CN = {Text = "材料"},
  LanguageConfig_StoreGoodsTypeRelic_CN = {Text = "造物"},
  LanguageConfig_StorePhiloStoneLack_CN = {
    Text = "黑印不足"
  },
  LanguageConfig_StoreReleaseNoAwaker_CN = {
    Text = "所有唤醒体均已觉醒"
  },
  LanguageConfig_StoreReleaseTimesOut_CN = {
    Text = "剩余次数不足"
  },
  LanguageConfig_StoreRenewButton_CN = {
    Text = "刷新({s1}/{s2})"
  },
  LanguageConfig_StoreRenewTimes_CN = {
    Text = "剩余{s1}次"
  },
  LanguageConfig_StoreRenewTitle_CN = {
    Text = "刷新商品"
  },
  LanguageConfig_StoreSellCardCancel_CN = {Text = "取消"},
  LanguageConfig_StoreSellCardConfirm_CN = {Text = "确定"},
  LanguageConfig_StoreSellCardNoCard_CN = {
    Text = "没有可出售指令卡"
  },
  LanguageConfig_StoreSellCardPrice_CN = {
    Text = "获得{s1}黑印"
  },
  LanguageConfig_StoreSellCardTimesOut_CN = {
    Text = "剩余次数不足"
  },
  LanguageConfig_StoreSellCardTitle_CN = {
    Text = "出售一张指令卡"
  },
  LanguageConfig_StoreSellCard_CN = {
    Text = "出售一张指令卡"
  },
  LanguageConfig_StoreSoldOut_CN = {
    Text = "当前商品已售罄"
  },
  LanguageConfig_StoreTitle_CN = {Text = "融痕"},
  LanguageConfig_StoreTitle_Sp_CN = {
    Text = "特殊融痕"
  },
  LanguageConfig_StoryGuideTitle_CN = {
    Text = "剧情导览"
  },
  LanguageConfig_StoryItemTypeName_CN = {
    Text = "剧情道具"
  },
  LanguageConfig_StoryLineTask_String_Available_CN = {Text = "领取"},
  LanguageConfig_StoryLineTask_String_Received_CN = {Text = "已领取"},
  LanguageConfig_StoryLine_EffectTip_CN = {
    Text = "在此处可以查看地形效果以及怪物信息"
  },
  LanguageConfig_StoryLine_LockAdvance_CN = {
    Text = "{s1}达到{s2}解锁{s3}"
  },
  LanguageConfig_StoryRole_Unlock_CN = {
    Text = "该剧情线尚未解锁，无法进入。"
  },
  LanguageConfig_StorylineGuide_0_CN = {
    Text = "向死而生。"
  },
  LanguageConfig_StorylineGuide_10_CN = {
    Text = "当然，混乱是一切的结局。可总有人不愿放弃挣扎，不是吗？"
  },
  LanguageConfig_StorylineGuide_11_CN = {
    Text = "不可直视头顶的寰宇。不可直视内心的深渊。"
  },
  LanguageConfig_StorylineGuide_12_CN = {
    Text = "进食，是这个世界唯一的美德。"
  },
  LanguageConfig_StorylineGuide_13_CN = {
    Text = "无垠的幻梦里没有答案。这场梦境，到了该醒来的时候了。"
  },
  LanguageConfig_StorylineGuide_14_CN = {
    Text = "命运的舞台之上，我们将扮演的角色，从来无从选择。"
  },
  LanguageConfig_StorylineGuide_15_CN = {
    Text = "旅人啊，请悄声步入雪夜。于无愿的尖峰，见证大梦的终结。"
  },
  LanguageConfig_StorylineGuide_16_CN = {
    Text = "临时文本"
  },
  LanguageConfig_StorylineGuide_17_CN = {
    Text = "临时文本"
  },
  LanguageConfig_StorylineGuide_18_CN = {
    Text = "临时文本"
  },
  LanguageConfig_StorylineGuide_19_CN = {
    Text = "临时文本"
  },
  LanguageConfig_StorylineGuide_1_CN = {
    Text = "踏入伦蒂尼恩危险的夜雾吧，守密人。属于你的道路，于此开始。"
  },
  LanguageConfig_StorylineGuide_20_CN = {
    Text = "临时文本"
  },
  LanguageConfig_StorylineGuide_2_CN = {
    Text = "艺术家，疯子，苦行者，痴愚之人……这座城市是属于你的展馆，蜡像们站在故事开场的地方，渴盼着你的光临。"
  },
  LanguageConfig_StorylineGuide_3_CN = {
    Text = "拉伊的风雪厌弃杀戮，她等待着你，只为一场交易。她将带给你，你无比渴求的秘密。她的价格永远残忍，永远合理。"
  },
  LanguageConfig_StorylineGuide_4_CN = {
    Text = "回忆吧，为回忆而战，为回忆而死。回忆是我们的福音书，我们的墓志铭。除了回忆，我们一无所有。"
  },
  LanguageConfig_StorylineGuide_5_CN = {
    Text = "在群星坠落以前，我们面向海洋祈祷：愿平静的涛声护我们入梦，愿我们重回故土的怀抱，长梦不醒。"
  },
  LanguageConfig_StorylineGuide_6_CN = {
    Text = "吟咏吧——那古老的王，已重新看见祂的王座。神圣的谕令，将为每一位虔诚的子民，带来神的国度。"
  },
  LanguageConfig_StorylineGuide_7_CN = {
    Text = "聆听，祈祷，呼唤，繁衍，服从最高贵的理想与最卑微的欲望。以母亲的名义，祂得以于混沌与恐惧中长存。"
  },
  LanguageConfig_StorylineGuide_8_CN = {
    Text = "长明的灯已燃起，那幽暗的光，将为你照亮通往终途的路。"
  },
  LanguageConfig_StorylineGuide_9_CN = {
    Text = "告诉祂，你的回答。"
  },
  LanguageConfig_StrongerTitle_CN = {
    Text = "通过「幕间演习」获取素材，强化你的唤醒体吧！"
  },
  LanguageConfig_StrongerWayTitle_CN = {
    Text = "如何变强"
  },
  LanguageConfig_StrongerWay_CN = {
    Text = "·「调查行动」1-2·普通解锁：「融蚀之墟」，可以获得大量唤醒体养成素材。\n·「调查行动」3-10·普通解锁：「超验存在」，可以获得大量唤醒体技能升级素材。\n·「调查等级」15级解锁：「第二命轮」，可以装备第二命轮获得强大战力。\n·「调查等级」25级解锁：「禁忌纂录」，可以获得大量密契，增强唤醒体能力。"
  },
  LanguageConfig_SubPlotAvgPreviewItemName_CN = {
    Text = "前情回顾{s1}"
  },
  LanguageConfig_SubplotActivityRewardTimeTips_CN = {
    Text = "\n<GrayState:({s1}天{s2}小时后开启)>"
  },
  LanguageConfig_SubplotFreeTips_CN = {
    Text = "活动期间<WeaponEffect_Num:「限时免费解锁」>调查内容"
  },
  LanguageConfig_SubplotJumpButton_CN = {Text = "调查"},
  LanguageConfig_SuitPlanChoosenTitle_CN = {
    Text = "选择方案"
  },
  LanguageConfig_SummonAutoDecomposeItem_CN = {
    Text = "自动分解"
  },
  LanguageConfig_SummonAwakerFragment_CN = {Text = [[
{s1}
*{s2}]]},
  LanguageConfig_SummonCountdown_CN = {
    Text = "剩余时间：\n{s1}"
  },
  LanguageConfig_SummonDailyDiscount_CN = {
    Text = "今日限定一次"
  },
  LanguageConfig_SummonDailyRecommend_CN = {
    Text = "今日推荐"
  },
  LanguageConfig_SummonExtraItem_CN = {
    Text = "额外赠送"
  },
  LanguageConfig_SummonFirstDesc_CN = {
    Text = "首次5连唤醒不满意唤醒结果可无限重抽"
  },
  LanguageConfig_SummonFirstTitle_CN = {
    Text = "初回限定"
  },
  LanguageConfig_SummonLimitDesc_CN = {Text = "限定"},
  LanguageConfig_SummonNoCallbackTips_CN = {
    Text = "上一次唤醒尚未完成，请稍候"
  },
  LanguageConfig_SummonOptionCountDesc_CN = {
    Text = "已选<space=0.2em><color=#e1e1e1>{s1}/{s2}</color>"
  },
  LanguageConfig_SummonProbabilityUpDescFormat_CN = {
    Text = "<SummonOrange:「{s1}」>获取概率提升！"
  },
  LanguageConfig_SummonRepetitiveAwaker_CN = {
    Text = "重复唤醒体，已转化"
  },
  LanguageConfig_SummonRulesExtraTxt1_CN = {
    Text = "次数不足时，如果有额外补偿次数，则以额外补偿次数补足。"
  },
  LanguageConfig_SummonRulesExtraTxt2_CN = {
    Text = "当前额外补偿次数：{s1}"
  },
  LanguageConfig_SummonRulesTitle_CN = {
    Text = "唤醒规则"
  },
  LanguageConfig_SummonSelectAwakeBtnTips_CN = {
    Text = "开始选择"
  },
  LanguageConfig_SummonSelectAwakePanelDesc_CN = {
    Text = "1、循序命理：守密人可从本期循序命理唤醒活动可选的唤醒体列表中选择 1 名作为本次定向唤醒的目标。\n2、推荐命轮：选定唤醒体后，将自动选中该唤醒体的推荐命轮！\n3、唤醒概率UP：\n·每次通过唤醒获取到SSR时，有33.33%的概率为本期选定的SSR唤醒体或推荐命轮，唤醒体与推荐命轮将平分UP概率。 \n·若本次唤醒获取的SSR非本期选定的SSR唤醒体或命轮，则下次通过唤醒获取的SSR必定为本期选定的SSR唤醒体或命轮。\n·若连续2次唤醒获取到相同本期UP物品，则下次通过唤醒获取的UP必定为另一本期UP物品。\n4、唤醒体与其推荐命轮一旦选定后，本期无法再更改定向唤醒对象。"
  },
  LanguageConfig_SummonSelectAwakerBtnUnClickTips_CN = {
    Text = "请先选中唤醒体"
  },
  LanguageConfig_SummonSelectAwakerOwnedLabel_CN = {Text = "已拥有"},
  LanguageConfig_SummonTargetPoolNotSelectTips_CN = {
    Text = "选择定向命轮后方可唤醒"
  },
  LanguageConfig_SummonTrial_CN = {
    Text = "唤醒体试用"
  },
  LanguageConfig_SummonTripleLabel_CN = {Text = "x3"},
  LanguageConfig_SummonTypeText_0_CN = {
    Text = "常驻命轮唤醒"
  },
  LanguageConfig_SummonTypeText_10_CN = {
    Text = "众生百相唤醒"
  },
  LanguageConfig_SummonTypeText_12_CN = {
    Text = "逆命双生唤醒"
  },
  LanguageConfig_SummonTypeText_13_CN = {
    Text = "界域锚定唤醒"
  },
  LanguageConfig_SummonTypeText_14_CN = {
    Text = "角色自选唤醒"
  },
  LanguageConfig_SummonTypeText_15_CN = {
    Text = "命轨合契·三倍唤醒"
  },
  LanguageConfig_SummonTypeText_16_CN = {
    Text = "缚誓之谕"
  },
  LanguageConfig_SummonTypeText_17_CN = {
    Text = "百相自选唤醒"
  },
  LanguageConfig_SummonTypeText_1_CN = {
    Text = "命轮活动唤醒"
  },
  LanguageConfig_SummonTypeText_2_CN = {
    Text = "角色活动唤醒"
  },
  LanguageConfig_SummonTypeText_3_CN = {
    Text = "预留唤醒"
  },
  LanguageConfig_SummonTypeText_4_CN = {
    Text = "预留唤醒"
  },
  LanguageConfig_SummonTypeText_5_CN = {
    Text = "常驻角色唤醒"
  },
  LanguageConfig_SummonTypeText_6_CN = {
    Text = "新生推荐唤醒"
  },
  LanguageConfig_SummonTypeText_7_CN = {
    Text = "循序命理唤醒"
  },
  LanguageConfig_SummonTypeText_8_CN = {
    Text = "命轨合契唤醒"
  },
  LanguageConfig_SummonTypeText_9_CN = {
    Text = "新手角色唤醒"
  },
  LanguageConfig_SummonType_14SelectPanelDesc_CN = {
    Text = "1、角色自选唤醒：守密人可从本期角色自选唤醒活动可选的唤醒体列表中选择 4 个唤醒体作为本次UP目标。\n2、唤醒概率UP：\n·每次通过唤醒获取到SSR时，有50%的概率为本期选定的UP唤醒体之一。 \n·若本次唤醒获取的SSR非本期选定的UP唤醒体，则下次通过唤醒获取的SSR必定为本期选定的UP唤醒体。\n3、UP目标一旦选定后，本期无法再更改定向唤醒对象。"
  },
  LanguageConfig_SummonType_14SelectTips_CN = {
    Text = "选择 {s1} 名「忘却篇」限定唤醒体"
  },
  LanguageConfig_SummonType_14SelectTitle_CN = {
    Text = "选择 {s1} 名指定唤醒体"
  },
  LanguageConfig_SummonType_14SelectUpTips_CN = {
    Text = "已选定 {s1} 名概率提升的唤醒体"
  },
  LanguageConfig_SummonType_14SummonDesc1_CN = {
    Text = "<SummonOrange:自选 {s1} 个唤醒体>概率提升！"
  },
  LanguageConfig_SummonType_14SummonDesc2_CN = {
    Text = "选定后本期不可再更改"
  },
  LanguageConfig_SummonType_17FinishSelect_CN = {
    Text = "完成选择"
  },
  LanguageConfig_SummonType_17SelectPanelDesc_CN = {
    Text = "1、百相自选唤醒：守密人可从本期百相自选唤醒活动可选的唤醒体列表中选择 5 个唤醒体，被选中的唤醒体及其推荐命轮将作为本次唤醒活动的SSR列表\n2、每次通过唤醒获取到SSR时，有100%的概率为本期选定的唤醒体或推荐命轮之一。 \n3、UP目标一旦选定后，本期无法再更改定向唤醒对象。"
  },
  LanguageConfig_SummonType_17SelectTips_CN = {
    Text = "选择 {s1} 名「星辰篇」限定唤醒体"
  },
  LanguageConfig_SummonType_17SelectTitle_CN = {
    Text = "选择 1 名{s1}唤醒体"
  },
  LanguageConfig_SummonType_17SelectType_1_CN = {Text = "伤害型"},
  LanguageConfig_SummonType_17SelectType_2_CN = {Text = "防御型"},
  LanguageConfig_SummonType_17SelectType_3_CN = {Text = "辅助型"},
  LanguageConfig_SummonType_17SelectType_4_CN = {Text = "男性"},
  LanguageConfig_SummonType_17SelectType_5_CN = {Text = "女性"},
  LanguageConfig_SummonType_17SelectedDesc_CN = {
    Text = "已指定唤醒体和推荐命轮"
  },
  LanguageConfig_SummonType_17SelectedTips_CN = {
    Text = "{s1}已选中"
  },
  LanguageConfig_SummonType_17SelectionProgress_CN = {
    Text = "已选 {s1}/{s2}"
  },
  LanguageConfig_SummonType_17SummonDesc1_CN = {
    Text = "<SummonOrange:自选>唤醒SSR列表！"
  },
  LanguageConfig_SummonType_17SummonDesc2_CN = {
    Text = "选定后本期不可再更改"
  },
  LanguageConfig_Summon_Detail_Btn_CN = {Text = "查看"},
  LanguageConfig_Summon_DrawOnce_Btn_CN = {Text = "唤醒1次"},
  LanguageConfig_Summon_DrawTenTimes_Btn_CN = {Text = "唤醒5次"},
  LanguageConfig_Summon_Free_CN = {Text = "免费"},
  LanguageConfig_Summon_History_Btn_CN = {
    Text = "唤醒历史"
  },
  LanguageConfig_Summon_LongDesc_Text1_CN = {
    Text = "以下内容出现【概率UP！！！】"
  },
  LanguageConfig_Summon_LongDesc_Text2_CN = {
    Text = "以下SSR占全部SSR物品出率的50%"
  },
  LanguageConfig_Summon_LongDesc_Text3_CN = {
    Text = "以下SR占全部SR物品出率的50%"
  },
  LanguageConfig_Summon_RateDesc_Btn_CN = {
    Text = "唤醒详情"
  },
  LanguageConfig_Summon_RateDesc_Tab_ItemList_CN = {
    Text = "物品清单"
  },
  LanguageConfig_Summon_RateDesc_Tab_LongDesc_CN = {
    Text = "概率说明"
  },
  LanguageConfig_Summon_RateDesc_Tab_UPItem_CN = {Text = "UP物品"},
  LanguageConfig_Summon_RateList_Text1_CN = {
    Text = "以下为唤醒物品清单："
  },
  LanguageConfig_Summon_RateList_Text2_CN = {
    Text = "（当未触发UP或保底规则时，所有唤醒体或命轮均分基础出率）"
  },
  LanguageConfig_Summon_ReselectTimes_CN = {
    Text = "次数：{s1}/{s2}"
  },
  LanguageConfig_Summon_Reselect_Btn_CN = {
    Text = "重新唤醒"
  },
  LanguageConfig_Summon_SchoolSelected_CN = {
    Text = "当前指定：{s1}"
  },
  LanguageConfig_Summon_School_DetailTitle_CN = {
    Text = "界域特色——"
  },
  LanguageConfig_Summon_School_Difficulty_CN = {
    Text = "上手难度"
  },
  LanguageConfig_Summon_SelectSchoolTips_CN = {
    Text = "指定界域后才能唤醒"
  },
  LanguageConfig_Summon_SelectSchool_CN = {
    Text = "指定界域"
  },
  LanguageConfig_Summon_SelectSchool_Tips_CN = {
    Text = "点击此处选择指定界域"
  },
  LanguageConfig_Summon_SelectWeapon_CN = {
    Text = "定向命轮"
  },
  LanguageConfig_Summon_SelectWeapon_Tips_CN = {
    Text = "点击此处选择定向命轮"
  },
  LanguageConfig_Summon_Select_Btn_CN = {
    Text = "选择本次结果"
  },
  LanguageConfig_Summon_Shop_Btn_CN = {
    Text = "商店兑换"
  },
  LanguageConfig_Summon_Str_Free_CN = {
    Text = "首次免费"
  },
  LanguageConfig_Summon_Tab_Type0_CN = {
    Text = "常驻唤醒"
  },
  LanguageConfig_Summon_Tab_Type1_CN = {
    Text = "命轮\n活动唤醒"
  },
  LanguageConfig_Summon_Tab_Type2_CN = {
    Text = "唤醒体\n活动唤醒"
  },
  LanguageConfig_Summon_Time_Remain1_CN = {Text = "{s1} 天"},
  LanguageConfig_Summon_Time_Remain2_CN = {
    Text = "<RedQuality:{s1}>"
  },
  LanguageConfig_Summon_Times_Left_CN = {
    Text = "{s1} 次后消失"
  },
  LanguageConfig_SuperUltlSkillName_CN = {
    Text = "超限爆发"
  },
  LanguageConfig_SweepRuleTxt_CN = {
    Text = "<Title:重现>\n·重现可以立即获得该关卡的任务报酬。\n·每次重现需消耗等同于进行调查所需的「灵啡肽」或奖励次数。\n<Title:解锁条件>\n·不同关卡解锁重现的条件不同，在未解锁时守密人可以查看重现弹窗中的解锁方式提示。"
  },
  LanguageConfig_SweepTipsAllTasksNotClearTxt_CN = {
    Text = "通关后，「成就奖励」完成度达到100%解锁"
  },
  LanguageConfig_SweepTipsNotThreeStarTxt_CN = {
    Text = "调查评价达到三星后解锁"
  },
  LanguageConfig_SweepTipsUnopenTxt_CN = {
    Text = "完成挑战后解锁重现"
  },
  LanguageConfig_SystemPreset_CN = {
    Text = "剧情预设"
  },
  LanguageConfig_TDJMMainDia1_CN = {
    Text = "黯赋永罪，光赐福音"
  },
  LanguageConfig_TDJMMainDia2_CN = {
    Text = "皈光群羊，判汝黯堕"
  },
  LanguageConfig_TDJZMainDia1_CN = {
    Text = "永夜将至，光沐得赎"
  },
  LanguageConfig_TalentActivationConditionPrompt_CN = {
    Text = "需要满足激活条件"
  },
  LanguageConfig_TalentActivationConditions_CN = {
    Text = "激活条件"
  },
  LanguageConfig_TalentExtraFavor_CN = {
    Text = "{s1}（+{s2}）"
  },
  LanguageConfig_TalentTab_ALL_CN = {Text = "全部"},
  LanguageConfig_TalentUpgradeConditionPrompt_CN = {
    Text = "需要满足升级条件"
  },
  LanguageConfig_TalentUpgradeConditions_CN = {
    Text = "升级条件"
  },
  LanguageConfig_TalentUpgradeInsufficientMaterial_CN = {
    Text = "消耗材料不足"
  },
  LanguageConfig_TapToSummon_CN = {
    Text = "点击插入银钥"
  },
  LanguageConfig_TaskAvgUnlockStr_CN = {
    Text = "剧情解锁"
  },
  LanguageConfig_TaskAward_Btn_Completed_CN = {Text = "领取"},
  LanguageConfig_TaskModule_btn_reward_CN = {Text = "领取"},
  LanguageConfig_TaskNpc_001_CN = {
    Text = "有可领取的任务奖励"
  },
  LanguageConfig_TaskType_Appoint_Battle_CN = {Text = "战斗"},
  LanguageConfig_TaskType_Appoint_Dispatch_CN = {Text = "调查"},
  LanguageConfig_Task_AchievementLabel_CN = {
    Text = "成就标签"
  },
  LanguageConfig_Task_Achievement_Finished_CN = {
    Text = "已完成<color=#359bb1>{s1}</color>个成就"
  },
  LanguageConfig_Task_Appoint_AcountLvUpTips_CN = {
    Text = "可同时派遣任务提升至<TipsHighlightText_1: {s1} >个"
  },
  LanguageConfig_Task_Appoint_AllFinished_CN = {
    Text = "今日派遣任务已全部完成！"
  },
  LanguageConfig_Task_Appoint_Battle_Award_CN = {
    Text = "任务报酬"
  },
  LanguageConfig_Task_Appoint_Battle_EnemyInfo_CN = {
    Text = "战斗概况"
  },
  LanguageConfig_Task_Appoint_Battle_NeedTime_CN = {Text = "立即"},
  LanguageConfig_Task_Appoint_Battle_Select_CN = {
    Text = "前往战斗"
  },
  LanguageConfig_Task_Appoint_Cannot_GetNewApppoint_CN = {
    Text = "今日已派遣任务达到上限"
  },
  LanguageConfig_Task_Appoint_Level_CN = {
    Text = "派遣等级：{s1}（已废弃）"
  },
  LanguageConfig_Task_Appoint_Newer_Tips_CN = {
    Text = "完成所有任务后刷新"
  },
  LanguageConfig_Task_Appoint_NonExistent_CN = {
    Text = "任务已被刷新"
  },
  LanguageConfig_Task_Appoint_Refresh_CN = {
    Text = "刷新（已废弃）"
  },
  LanguageConfig_Task_Appoint_Refresh_Free_CN = {
    Text = "免费刷新（已废弃）"
  },
  LanguageConfig_Task_Appoint_Refresh_NoTaskToRefresh_CN = {
    Text = "没有可刷新任务（已废弃）"
  },
  LanguageConfig_Task_Appoint_Refresh_NotAvailable_CN = {
    Text = "今日已派遣任务达到上限，不可刷新"
  },
  LanguageConfig_Task_Appoint_Refresh_NotEnoughItem_CN = {
    Text = "银芯不足（已废弃）"
  },
  LanguageConfig_Task_Appoint_Refresh_TimeLeft_CN = {
    Text = "{s1}后刷新"
  },
  LanguageConfig_Task_Appoint_Rules_CN = {
    Text = "<Title:【派遣规则】>\n·守密人可以派遣唤醒体进行调查或研究任务，完成任务后可获得相应的奖励。\n·达到任务需求的派遣总等级才可成功派遣，每个任务至多可同时派遣4名唤醒体。\n·派遣总等级每超出任务需求20级，可获得1份额外奖励。\n·每个唤醒体同时只能承接一个派遣任务。若在任务途中取消派遣，可以快速释放占用的唤醒体，但将无法获得该任务的奖励。\n·守密人调查等级提升至20/30/40/50/60级时，可承接的派遣任务数额外+1。\n·注意：唤醒体本源形态不可派遣。"
  },
  LanguageConfig_Task_Appoint_TimesLeft_CN = {
    Text = "派遣限制：{s1}/{s2}"
  },
  LanguageConfig_Task_Appoint_Unclaimed_Toomuch_CN = {
    Text = "未领取奖励任务过多，请先领取"
  },
  LanguageConfig_Task_Career_Btn_Last_CN = {Text = "上一组"},
  LanguageConfig_Task_Career_Btn_Next_CN = {Text = "下一组"},
  LanguageConfig_Task_Career_LastChapter_Tips_CN = {
    Text = "当前已经是第一组"
  },
  LanguageConfig_Task_Career_NextChapter_Tips_CN = {
    Text = "完成所有任务后解锁下一组"
  },
  LanguageConfig_Task_Career_Parent_Pickup_Tips_CN = {
    Text = "完成右侧所有任务后可领取"
  },
  LanguageConfig_Task_Career_Progress_CN = {
    Text = "当前进度： {s1}/{s2}"
  },
  LanguageConfig_Task_Daily_Desc_CN = {
    Text = "每日任务提供「银芯」和大量「守密人经验」奖励。"
  },
  LanguageConfig_Task_Daily_Name_CN = {
    Text = "每日任务"
  },
  LanguageConfig_Task_Dispatch_AwakerState_CN = {Text = "派遣中"},
  LanguageConfig_Task_Dispatch_Awakers_CN = {
    Text = "派遣唤醒体"
  },
  LanguageConfig_Task_Dispatch_Callback_CN = {Text = "召回"},
  LanguageConfig_Task_Dispatch_Callback_CancelBtn_CN = {Text = "取消"},
  LanguageConfig_Task_Dispatch_Callback_ConfirmBtn_CN = {Text = "确认"},
  LanguageConfig_Task_Dispatch_Callback_Desc1_CN = {
    Text = "是否立即召回当前派遣的队伍？"
  },
  LanguageConfig_Task_Dispatch_Callback_Desc2_CN = {
    Text = "已派遣的唤醒体"
  },
  LanguageConfig_Task_Dispatch_Callback_Desc3_CN = {
    Text = "注意：召回后不会获得任何奖励"
  },
  LanguageConfig_Task_Dispatch_Callback_Title_CN = {
    Text = "派遣召回"
  },
  LanguageConfig_Task_Dispatch_DispatchingTips_CN = {
    Text = "该唤醒体已经在执行其他任务"
  },
  LanguageConfig_Task_Dispatch_Essential_Cond_CN = {
    Text = "必要条件"
  },
  LanguageConfig_Task_Dispatch_Extra_Award_CN = {
    Text = "额外报酬（已废弃）"
  },
  LanguageConfig_Task_Dispatch_Extra_Cond_CN = {
    Text = "加分条件（已废弃）"
  },
  LanguageConfig_Task_Dispatch_FinishedTips_CN = {
    Text = "此任务已完成，不可召回"
  },
  LanguageConfig_Task_Dispatch_Hour_CN = {
    Text = "{s1}小时{s2}分"
  },
  LanguageConfig_Task_Dispatch_LeftTime_CN = {
    Text = "剩余【待删除】"
  },
  LanguageConfig_Task_Dispatch_Level_Tips_CN = {
    Text = "总派遣等级{s1}级"
  },
  LanguageConfig_Task_Dispatch_Minute_CN = {Text = "{s1}分钟"},
  LanguageConfig_Task_Dispatch_NeedTime_CN = {
    Text = "需耗时{s1}小时"
  },
  LanguageConfig_Task_Dispatch_NeedTime_Min_CN = {
    Text = "需耗时{s1}分钟"
  },
  LanguageConfig_Task_Dispatch_Second_CN = {Text = "{s1}秒"},
  LanguageConfig_Task_Dispatch_SelectConfirm_CN = {
    Text = "确认派遣"
  },
  LanguageConfig_Task_Dispatch_Select_CN = {
    Text = "派遣上阵"
  },
  LanguageConfig_Task_Dispatch_Select_Condition_NotMeet_CN = {
    Text = "满足必要条件后方可派遣"
  },
  LanguageConfig_Task_Dispatch_Select_Null_CN = {
    Text = "需要至少派遣一个唤醒体"
  },
  LanguageConfig_Task_Dispatch_SpeedUp_CN = {
    Text = "加速（已废弃）"
  },
  LanguageConfig_Task_Dispatch_SpeedUp_Free_CN = {
    Text = "免费（已废弃）"
  },
  LanguageConfig_Task_Dispatch_SpeedUp_NotEnoughItem_CN = {
    Text = "加速券不足（已废弃）"
  },
  LanguageConfig_Task_Dispatch_TeamNum_CN = {
    Text = "已派遣队伍：{s1}/{s2}"
  },
  LanguageConfig_Task_Dispatch_TeamNum_NotEnough_CN = {
    Text = "可派遣队伍不足"
  },
  LanguageConfig_Task_GoldShop_Rules_CN = {
    Text = "<Title:【金券兑换规则】>\n·金券兑换商店每日9点重置【GMT+8】。\n·守密人可以消耗一定数量的「蔷薇金券」，来刷新金券兑换商店的库存。\n·每次重置最多可以手动刷新5次，消耗的「蔷薇金券」数量递增。\n·当守密人调查等级提升时，金券兑换商品会随之升级并解锁新内容。"
  },
  LanguageConfig_Task_Module_Btn_CN = {
    Text = "任务入口"
  },
  LanguageConfig_Task_State_Completed_CN = {Text = "已完成"},
  LanguageConfig_Task_State_Ongoing_CN = {Text = "进行中"},
  LanguageConfig_Task_State_Received_CN = {
    Text = "奖励已领取"
  },
  LanguageConfig_Task_SubTab_Achievement_CN = {
    Text = "生涯成就"
  },
  LanguageConfig_Task_Tab_Achievement_CN = {Text = "成就"},
  LanguageConfig_Task_Tab_Appoint_CN = {Text = "派遣"},
  LanguageConfig_Task_Tab_Career_CN = {
    Text = "行动报告"
  },
  LanguageConfig_Task_Tab_Daily_CN = {Text = "日程"},
  LanguageConfig_Task_Tips_ToReceive_CN = {Text = "可领取"},
  LanguageConfig_TeamAssistAwakerStepDown_CN = {
    Text = "助战唤醒体已下阵"
  },
  LanguageConfig_TeamAverageLevel_CN = {
    Text = "队伍平均等级"
  },
  LanguageConfig_TeamFormation_CN = {Text = "编队"},
  LanguageConfig_TeamNeedFightAwakerTips_CN = {
    Text = "本次调查{s1}必须上阵"
  },
  LanguageConfig_TeamRecommendLevel_CN = {
    Text = "推荐{s1}级"
  },
  LanguageConfig_TeamSchoolRequired_CN = {
    Text = "队伍要求"
  },
  LanguageConfig_TeamSkillStrength_CN = {
    Text = "队伍技能强度"
  },
  LanguageConfig_TeamTitleText_CN = {
    Text = "队伍配置"
  },
  LanguageConfig_TeamTrinketStrength_CN = {
    Text = "队伍密契强度"
  },
  LanguageConfig_TeamTypeTips_Atk_CN = {
    Text = "队伍中缺少攻击型唤醒体"
  },
  LanguageConfig_TeamTypeTips_Auxiliary_CN = {
    Text = "队伍中缺少辅助型唤醒体"
  },
  LanguageConfig_TeamTypeTips_Def_CN = {
    Text = "队伍中缺少防御型唤醒体"
  },
  LanguageConfig_TeamWeaponStrength_CN = {
    Text = "队伍命轮强度"
  },
  LanguageConfig_TeamWipe_CN = {
    Text = "团灭！！！"
  },
  LanguageConfig_Team_AwakerLevel_CN = {Text = "Lv.{s1}"},
  LanguageConfig_Team_CN = {Text = "队伍"},
  LanguageConfig_Team_Card_Str_Nill_Overview_CN = {
    Text = "请把角色放入编队"
  },
  LanguageConfig_Team_Occupation_Tips_CN = {
    Text = "界域天赋"
  },
  LanguageConfig_Team_Str_Nill_Actor_CN = {
    Text = "无唤醒体"
  },
  LanguageConfig_TentacleModeSwitch1_CN = {
    Text = "「潮涌」为当前触腕姿态，不可重复选择"
  },
  LanguageConfig_TentacleModeSwitch2_CN = {
    Text = "当前永久触腕数量不足，无法切换「怒涛」姿态"
  },
  LanguageConfig_TentacleModeSwitch3_CN = {
    Text = "「静海」姿态冷却中，无法切换，还需冷却 {s1} 回合"
  },
  LanguageConfig_TentacleModeSwitch4_CN = {
    Text = "「怒涛」姿态冷却中，无法切换，还需冷却 {s1} 回合"
  },
  LanguageConfig_TentacleModeSwitchCondString_CN = {
    Text = "无法选择"
  },
  LanguageConfig_TentacleModeSwitchCondTips_CN = {
    Text = "本回合已切换过触腕姿态"
  },
  LanguageConfig_TentacleModeSwitchNew_CN = {
    Text = "当前姿态"
  },
  LanguageConfig_TentacleModeSwitchTips_CN = {
    Text = "选择触腕姿态"
  },
  LanguageConfig_TentacleOverflow_CN = {
    Text = "溢出激发"
  },
  LanguageConfig_TentaclesTips_CN = {
    Text = "触腕伤害 +{s1}"
  },
  LanguageConfig_TextActOpenTime_CN = {
    Text = "「s1」将于{s2}后开启"
  },
  LanguageConfig_TextAlreadyReceivedAwaker_CN = {
    Text = "已唤醒：{s1}"
  },
  LanguageConfig_TextAlreadyReceivedWeapon_CN = {
    Text = "已领取：{s1}"
  },
  LanguageConfig_TextAlreadyReceived_CN = {Text = "已领取"},
  LanguageConfig_TextBanTitle_CN = {Text = "黑名单"},
  LanguageConfig_TextBan_CN = {Text = "拉黑"},
  LanguageConfig_TextBanned_CN = {Text = "已拉黑"},
  LanguageConfig_TextBossProgress_CN = {
    Text = "再战原初进度：{s1}<color=#A7B9C3>/{s2}</color>"
  },
  LanguageConfig_TextCancelBan_CN = {
    Text = "取消拉黑"
  },
  LanguageConfig_TextComma_CN = {Text = "、"},
  LanguageConfig_TextEmptyBan_CN = {
    Text = "暂无黑名单"
  },
  LanguageConfig_TextEventNotFinished_CN = {
    Text = "完成「{s1}」后解锁"
  },
  LanguageConfig_TextFightBoss_CN = {
    Text = "辰星安魂曲"
  },
  LanguageConfig_TextUnlockEvent_CN = {
    Text = "完成「{s1}」后解锁"
  },
  LanguageConfig_Text_Discount_Unlock_CN = {
    Text = "限时优惠解锁"
  },
  LanguageConfig_Text_Enter_Plot_CN = {
    Text = "进入剧情"
  },
  LanguageConfig_Text_Unlock_CN = {Text = "解锁"},
  LanguageConfig_TheNth_CN = {Text = "第{s1}名"},
  LanguageConfig_ThisWeek_CN = {Text = "本周"},
  LanguageConfig_Ticket_Countdown_Str_CN = {
    Text = "{s1}后恢复1张凭证"
  },
  LanguageConfig_Ticket_Revert_Btn_Return_CN = {Text = "取消"},
  LanguageConfig_Ticket_Revert_Btn_Sure_CN = {Text = "确定"},
  LanguageConfig_Ticket_Revert_Time_Tips_CN = {
    Text = "每小时回复一张"
  },
  LanguageConfig_TimeFormatYMDHm2_CN = {
    Text = "{s1} 月 {s2} 日 {s3}:{s4}"
  },
  LanguageConfig_TimeFormatYMDHm_CN = {
    Text = "{s1}年{s2}月{s3}日{s4}时{s5}分"
  },
  LanguageConfig_TimeSettleStr_CN = {
    Text = "{s1}后结算"
  },
  LanguageConfig_TimeoutText_CN = {Text = "已超时"},
  LanguageConfig_Tip_Ability_CN = {
    Text = "<CardTip:能力>\n每个唤醒体都拥有强大的能力，可在商店和营地进行解锁"
  },
  LanguageConfig_Tip_Rune_CN = {
    Text = "<CardTip:刻印>\n可镶嵌在除能力卡外的任意卡牌上，并对其附加刻印效果，每张卡牌至多镶嵌1个刻印"
  },
  LanguageConfig_Tip_TemporaryStrength_CN = {
    Text = "<CardTip:临时力量>\n增加造成的伤害量。自身回合结束时失去临时力量"
  },
  LanguageConfig_TipsAwakerEquip_CN = {
    Text = "{s1}已装备"
  },
  LanguageConfig_TipsOriginTitle_CN = {Text = "来源"},
  LanguageConfig_TipsRefineLevel_CN = {
    Text = "叠位{s1}阶"
  },
  LanguageConfig_TitleRate_CN = {Text = "概率"},
  LanguageConfig_TitleRewardItems_CN = {
    Text = "奖励道具"
  },
  LanguageConfig_TitleReward_CN = {Text = "奖项"},
  LanguageConfig_Today_CN = {Text = "本周"},
  LanguageConfig_TopBarItemTypeName_CN = {
    Text = "通用货币"
  },
  LanguageConfig_TotalNumWins_CN = {
    Text = "合计胜利场数"
  },
  LanguageConfig_TotallyNumb_CN = {
    Text = "彻底麻了！"
  },
  LanguageConfig_TrialActivityRewardTips_CN = {
    Text = "完成该唤醒体试玩后可领取"
  },
  LanguageConfig_TrinketApplyingToSuitPlan_CN = {Text = "已应用"},
  LanguageConfig_TrinketAutoRefineProgress_CN = {
    Text = "自动转录中，当前第{s1}次"
  },
  LanguageConfig_TrinketAutoRefineStopByGetTargetAttr_CN = {
    Text = "密契自动转录目标达成！\n<size=40>已完成 {s1} 次转录</size>"
  },
  LanguageConfig_TrinketAutoRefineStopByMaterialNotEnough_CN = {
    Text = "已转录 {s1} 次，本次自动转录结束。"
  },
  LanguageConfig_TrinketAutoRefineStopByMaxTimeLimit_CN = {
    Text = "已完成 100 次转录，自动转录结束。"
  },
  LanguageConfig_TrinketAutoRefine_CN = {
    Text = "<Title:自动转录>\n·自动转录可以根据当前材料情况，至多进行 100 次转录。\n·自动转录时，如果转录结果中有 1 条未锁定属性强度为 8 ，自动转录终止。\n·材料不足时，自动转录停止。\n\n<Title:跳过>\n·自动转录时将显示每一次转录结果，可以选择跳过转录过程。跳过后，将直接显示自动转录最终结果。"
  },
  LanguageConfig_TrinketAutoSelectTips_CN = {
    Text = "自动选择：优先选用品质较低、等级较低的密契作为素材"
  },
  LanguageConfig_TrinketBatchUnbindComingSoon_CN = {
    Text = "一键析离功能即将开放"
  },
  LanguageConfig_TrinketBatchUnbindTitle_CN = {
    Text = "一键析离"
  },
  LanguageConfig_TrinketBindBonusDesc_CN = {
    Text = "结合后，密契主属性额外提升{s1}！"
  },
  LanguageConfig_TrinketBindNoneSelectedTips_CN = {
    Text = "没有可以结合的密契，请至少选择一个。"
  },
  LanguageConfig_TrinketBindRuleDesc_CN = {
    Text = "<Title:密契结合>\n·守密人现在可以为唤醒体结合密契。\n·唤醒体每个位置可结合 1 个密契，总共 6 个。\n·结合后，每个位置上的密契主属性额外提升 50%。\n·已结合的密契不会在「物资-密契」与「冶炼室」中出现。\n·编队与唤醒体助战中，如果没有为唤醒体装配密契，已结合的密契将被自动装配。\n·强化已结合的密契部件不改变结合状态，主属性提升会根据强化后的状态更新。\n\n<Title:密契析离>\n·修改或取消密契结合，需要在密契结合页面中析离已结合的密契。\n·单个部件析离需要消耗 10 个同类型密契（不限位置）。\n·析离密契时，已使用的密契不会出现在素材选项中。"
  },
  LanguageConfig_TrinketBindSuccessTips_CN = {
    Text = "密契结合成功"
  },
  LanguageConfig_TrinketBind_CN = {Text = "结合"},
  LanguageConfig_TrinketChangeBindSuccessTips_CN = {
    Text = "密契结合修改成功"
  },
  LanguageConfig_TrinketChangeBind_CN = {Text = "结合"},
  LanguageConfig_TrinketChooseForRecast_CN = {
    Text = "选择用于重印的密契"
  },
  LanguageConfig_TrinketChooseLimited_CN = {
    Text = "所选密契数量已达上限"
  },
  LanguageConfig_TrinketChoosenPartTitle_CN = {Text = "部位"},
  LanguageConfig_TrinketChoosenSuitTitle_CN = {Text = "方案"},
  LanguageConfig_TrinketChoosenTitle_CN = {
    Text = "选择密契"
  },
  LanguageConfig_TrinketCompletionRate_CN = {
    Text = "密契完成度"
  },
  LanguageConfig_TrinketContrast_CN = {Text = "对比"},
  LanguageConfig_TrinketConversionLockOneOption_CN = {
    Text = "消耗「{s1}」补足残本"
  },
  LanguageConfig_TrinketConversionNewEnries_CN = {
    Text = "新副属性"
  },
  LanguageConfig_TrinketConversionOriEnries_CN = {
    Text = "原副属性"
  },
  LanguageConfig_TrinketConversionReplace_CN = {Text = "替换"},
  LanguageConfig_TrinketConversionRuleTitle_CN = {
    Text = "规则说明"
  },
  LanguageConfig_TrinketConversionRule_CN = {
    Text = "<Title:转录>\n·转录可以更改密契副属性的种类和数值，对主属性的种类和数值没有影响。\n·转录时，副属性的种类可以与主属性重复，副属性间的种类也可以重复。\n·转录时，副属性将会获得不同强度的数值。\n·守密人解锁密契转录后，通过任何方式新获得的密契都将自动免费转录一次。\n\n<Title:锁定>\n·转录时，如果想保留某些副属性，可以点击副属性旁的锁定按钮进行锁定，上锁副属性的种类和数值在转录时将会进行保留。\n·最多可同时对两个副属性进行锁定。\n·锁定1条属性时，需要额外消耗相应的「密契残本」× 20；锁定2条属性时，需要额外消耗「追念羽笔」× 10。\n·选择锁定1条属性时，可以勾选「消耗追念羽笔补足残本」；勾选后，若当前「密契残本」不足，将自动消耗相应数量的追念羽笔进行转录。"
  },
  LanguageConfig_TrinketConversion_CN = {Text = "转录"},
  LanguageConfig_TrinketCopyRules_CN = {
    Text = "1、禁忌纂录内通关关卡后可以获得「密契」！\n2、不同推荐等级的关卡可以获得不同数量的「密契」。\n·推荐等级 25 级的关卡可以获得「密契」× 1。\n·推荐等级 35 级的关卡可以获得「密契」× 2。\n·推荐等级 45 级的关卡可以获得「密契」× 3。\n3、完成关卡挑战后解锁重现，重现可以立即获得该关卡的任务报酬。每次重现需消耗等同于进行调查所需的「灵啡肽」。\n4、每通关一章调查事件就解锁一个密契关卡。\n5、若三星通关高难度关卡，则较低难度的关卡挑战进度会自动标记为三星通关。"
  },
  LanguageConfig_TrinketDecomposeEmptyTips_CN = {
    Text = "暂无可分解的密契"
  },
  LanguageConfig_TrinketDecomposeTitle_CN = {
    Text = "密契分解"
  },
  LanguageConfig_TrinketEmptyStateTips_CN = {
    Text = "尚未拥有当前位置的密契"
  },
  LanguageConfig_TrinketEntriesNone_CN = {
    Text = "暂无属性"
  },
  LanguageConfig_TrinketEquipped_CN = {Text = "已装备"},
  LanguageConfig_TrinketFilterMainAttrTitle_CN = {
    Text = "主属性：(主属性受位置影响)"
  },
  LanguageConfig_TrinketFilterPartTitle_CN = {Text = "位置"},
  LanguageConfig_TrinketFilterSubAttrTitle_CN = {Text = "副属性"},
  LanguageConfig_TrinketFilterSuitTitle_CN = {Text = "套装"},
  LanguageConfig_TrinketGetNewEntries_CN = {
    Text = "点击转录获得新副属性"
  },
  LanguageConfig_TrinketInvalidPrompt_CN = {
    Text = "<Block:{s1}><Damage:的6件套效果为队伍唯一效果，无法重复生效。当前该效果已于<Block:{s2}>生效，此处未生效。>"
  },
  LanguageConfig_TrinketIsLocked_CN = {
    Text = "密契已锁定"
  },
  LanguageConfig_TrinketLevelUpTips_1_CN = {
    Text = "增加{s1}条新的追加属性"
  },
  LanguageConfig_TrinketLevelUpTips_2_CN = {
    Text = "随机提升{s1}条追加属性"
  },
  LanguageConfig_TrinketLockedCannotSelectTips_CN = {
    Text = "密契已上锁，无法选中"
  },
  LanguageConfig_TrinketMaterialNotEnough_CN = {
    Text = "数量不足"
  },
  LanguageConfig_TrinketMaterialTypeName_CN = {
    Text = "密契材料"
  },
  LanguageConfig_TrinketMustChooseThree_CN = {
    Text = "所选密契不足3个，无法重印"
  },
  LanguageConfig_TrinketPlsSelect_CN = {
    Text = "请选择密契装备"
  },
  LanguageConfig_TrinketStow_CN = {Text = "收起"},
  LanguageConfig_TrinketStrengCostItemNotEnoughTips_CN = {
    Text = "「千面印章」不足"
  },
  LanguageConfig_TrinketStrengthNeed_CN = {Text = "需要"},
  LanguageConfig_TrinketStrengthTitle_CN = {
    Text = "密契详情"
  },
  LanguageConfig_TrinketStrengthenEmptyStateTips_1_CN = {
    Text = "尚未拥有未装备的密契或素材道具"
  },
  LanguageConfig_TrinketStrengthenEmptyStateTips_2_CN = {
    Text = "尚未拥有未装备的命轮"
  },
  LanguageConfig_TrinketStrengthenItemNum_1_CN = {
    Text = "密契 {s1}"
  },
  LanguageConfig_TrinketStrengthenItemNum_2_CN = {
    Text = "命轮 {s1}"
  },
  LanguageConfig_TrinketStrengthenLockTips_1_CN = {
    Text = "当前密契已锁定，解锁以作为素材消耗"
  },
  LanguageConfig_TrinketStrengthenLockTips_2_CN = {
    Text = "当前命轮已锁定，解锁以作为素材消耗"
  },
  LanguageConfig_TrinketStrengthenSuccess_1_CN = {
    Text = "强化成功"
  },
  LanguageConfig_TrinketStrengthenSuccess_2_CN = {
    Text = "强化成功·双倍"
  },
  LanguageConfig_TrinketStrengthenSuccess_5_CN = {
    Text = "强化成功·五倍"
  },
  LanguageConfig_TrinketStrengthentTips_CN = {
    Text = "请选择要强化的密契"
  },
  LanguageConfig_TrinketSuitEditTitle_CN = {
    Text = "编辑方案"
  },
  LanguageConfig_TrinketSuitEffect_CN = {
    Text = "{s1}件套: {s2}"
  },
  LanguageConfig_TrinketSuitPlanNum_CN = {
    Text = "方案数量"
  },
  LanguageConfig_TrinketSuitSavedTips_CN = {
    Text = "请输入方案名称"
  },
  LanguageConfig_TrinketSuitSavedTitle_CN = {
    Text = "保存密契方案"
  },
  LanguageConfig_TrinketTypeName_CN = {Text = "密契"},
  LanguageConfig_TrinketUnBindSuccessTips_CN = {
    Text = "密契析离成功"
  },
  LanguageConfig_TrinketUnbindMaterialTitle_CN = {
    Text = "析离素材选择"
  },
  LanguageConfig_TrinketUnbind_CN = {Text = "析离"},
  LanguageConfig_TrinketUpgradeConsumeReturn_CN = {
    Text = "强化溢出返还"
  },
  LanguageConfig_TrinketUpgradeConsume_CN = {
    Text = "消耗材料"
  },
  LanguageConfig_TrinketUpgradeLevelSuccess_CN = {
    Text = "强化成功"
  },
  LanguageConfig_TrinketUpgradeNoneMats_CN = {
    Text = "暂无套装与位置均相同的密契"
  },
  LanguageConfig_TrinketUpgradeSelMats_CN = {
    Text = "选择升级材料"
  },
  LanguageConfig_TrinketUpgrade_CN = {Text = "升级"},
  LanguageConfig_Trinket_Suggest_Btn_CN = {Text = "推荐"},
  LanguageConfig_TrinketsEquipedByAwakersTips_CN = {
    Text = "以下密契正在装备中，是否进行装备？"
  },
  LanguageConfig_TrinketsUpgradeMaxLevel_CN = {
    Text = "已达等级上限"
  },
  LanguageConfig_TrinketsUpgradeMax_CN = {
    Text = "升至上限"
  },
  LanguageConfig_TrinketsUpgradeOne_CN = {Text = "升1级"},
  LanguageConfig_TripleKill_CN = {
    Text = "三杀！！"
  },
  LanguageConfig_TripleSummonReward_CN = {
    Text = "唤醒1次 · 获得3份奖励"
  },
  LanguageConfig_Tuluhuodong1_CN = {
    Text = "选择「沉眠」或「苏醒」。"
  },
  LanguageConfig_TurnLockCardTips_CN = {
    Text = "还有指令卡可以打出，紧急情况就别保留实力了！"
  },
  LanguageConfig_TurnLockExSkillTips_CN = {
    Text = "狂气爆发已就绪，紧急情况就别保留实力了！"
  },
  LanguageConfig_TurnLockPosseTips_CN = {
    Text = "钥令准备好了，紧急情况就别保留实力了！"
  },
  LanguageConfig_TurntableProbabilityDesc_CN = {
    Text = "1、幻衣奖励将在第5次抽取时开始出现。第1 ~ 4抽时，幻衣奖励的概率将根据未获得奖励的初始概率按比例分配到各项未获得奖励。\n2、奖池内的奖励固定，已获得的奖励不会再次出现。未获得奖励的概率会发生变动，变动后的概率为「该奖励的初始概率/（100%-已获得奖励的初始概率总和）」。\n3、以下为所有奖励的具体概率展示，展示至四舍五入后的小数点第四位。"
  },
  LanguageConfig_TutorialReward_CN = {
    Text = "教学学习奖励"
  },
  LanguageConfig_TutorialSearchResult_CN = {
    Text = "总共<color=#5ef2ff>{s1}</color>个结果"
  },
  LanguageConfig_TutorialTaskLabel_CN = {Text = "教程"},
  LanguageConfig_TutorialTitle_CN = {Text = "教学"},
  LanguageConfig_TwoAndAHalfAnniversaryRAIDActiviityEndTime_CN = {
    Text = "抓捕总数达成 {s1} 天后结束"
  },
  LanguageConfig_UIBlockMaskTips_CN = {
    Text = "资源加载中，请稍候"
  },
  LanguageConfig_UIKeeperSkillChooseAll_CN = {Text = "全部"},
  LanguageConfig_UIKeeperSkillChoose_CN = {Text = "选择"},
  LanguageConfig_UIKeeperSkillUsed_CN = {Text = "使用中"},
  LanguageConfig_UI_Recharge_Panel_DayShopItemRefresh_CN = {
    Text = "{s1}天{s2}小时"
  },
  LanguageConfig_UI_Recharge_Panel_DayShopItemRefresh_Hour_CN = {
    Text = "{s1}小时{s2}分钟"
  },
  LanguageConfig_UI_Recharge_Panel_Deadline_CN = {
    Text = "{s1}天{s2}小时后下架"
  },
  LanguageConfig_UI_Recharge_Panel_Deadline_Hour_CN = {
    Text = "{s1}小时{s2}分后下架"
  },
  LanguageConfig_UI_Recharge_Panel_HaveItemCondition_CN = {
    Text = "拥有{s1}后解锁"
  },
  LanguageConfig_UI_Recharge_Panel_HourShopItemRefresh_CN = {
    Text = "0天{s1}小时"
  },
  LanguageConfig_UI_Recharge_Panel_Main_Text_Toggle_Battle_Pass_CN = {
    Text = "课题礼匣"
  },
  LanguageConfig_UI_Recharge_Panel_Main_Text_Toggle_Diamond_Shop_CN = {
    Text = "「银芯」购买"
  },
  LanguageConfig_UI_Recharge_Panel_Main_Text_Toggle_Normal_AdvanceDC_CN = {
    Text = "沉淀兑换"
  },
  LanguageConfig_UI_Recharge_Panel_Main_Text_Toggle_Normal_GiftBag_CN = {
    Text = "精选礼盒"
  },
  LanguageConfig_UI_Recharge_Panel_Main_Text_Toggle_Normal_Month_CN = {
    Text = "月相观测"
  },
  LanguageConfig_UI_Recharge_Panel_Main_Text_Toggle_Normal_Recharge_CN = {
    Text = "源液提取"
  },
  LanguageConfig_UI_Recharge_Panel_Main_Text_Toggle_Normal_Root_CN = {
    Text = "浮沫兑换"
  },
  LanguageConfig_UI_Recharge_Panel_PlayerLevelCondition_CN = {
    Text = "调查等级 {s1}级 解锁"
  },
  LanguageConfig_UI_Recharge_Panel_SpecialSaleDeadline_CN = {
    Text = "{s1}天{s2}小时后结束"
  },
  LanguageConfig_UI_Recharge_Panel_SpecialSaleDeadline_Hour_CN = {
    Text = "{s1}小时{s2}分后结束"
  },
  LanguageConfig_UI_WeekBoss_Refresh_CN = {
    Text = "{s1}天{s2}小时后刷新"
  },
  LanguageConfig_UWHXSideDia1_CN = {
    Text = "呵呵……这就是你的全部实力了么？"
  },
  LanguageConfig_UWHXSideDia2_CN = {
    Text = "游戏时间到，轮到我反击了！"
  },
  LanguageConfig_UWHXSideDia3_CN = {
    Text = "真可怜，你以为它能一直控制我么？"
  },
  LanguageConfig_UWHXSideDia4_CN = {
    Text = "自群星而来之物，我们……永不餍足！"
  },
  LanguageConfig_UltlSkillNamePrefix_CN = {
    Text = "超限爆发-"
  },
  LanguageConfig_UltlSkillName_CN = {
    Text = "狂气爆发"
  },
  LanguageConfig_UltraPotencyCommingsoon_CN = {
    Text = "敬请期待"
  },
  LanguageConfig_UltraPotencyDesc_CN = {
    Text = "唤醒体人格深化达到 +12 时会激活「最终法则」，激活后可获得一些独特的效果。"
  },
  LanguageConfig_UltraPotencyKeywords_CN = {
    Text = "<UltraPotencyKeywords:最终法则>"
  },
  LanguageConfig_UltraPotencyLockedName_CN = {
    Text = "最终法则"
  },
  LanguageConfig_UnGotStr_CN = {Text = "未获得"},
  LanguageConfig_Under_Investigation_Monster_CN = {
    Text = "正在调查中"
  },
  LanguageConfig_UniversalAlertTitle_CN = {Text = "提示"},
  LanguageConfig_UniversalCancelButton_CN = {Text = "取消"},
  LanguageConfig_UniversalConfirmButton_CN = {Text = "确定"},
  LanguageConfig_UniversalProgressDisplay_CN = {Text = "{s1}/{s2}"},
  LanguageConfig_UniversalSettlementPhiloStone_CN = {Text = "{s1}黑印"},
  LanguageConfig_UniversalUnlockButton_CN = {Text = "解锁"},
  LanguageConfig_UnlockConditionExemption_CN = {
    Text = "\n<Gray:（活动期间无视同调率要求）>"
  },
  LanguageConfig_Unlockable_CN = {Text = "可解锁"},
  LanguageConfig_Unranked_CN = {Text = "未上榜"},
  LanguageConfig_VerificationAgeFormat1_CN = {
    Text = "{s1}岁以下"
  },
  LanguageConfig_VerificationAgeFormat2_CN = {
    Text = "{s1}岁~{s2}岁"
  },
  LanguageConfig_VerificationAgeLimit_CN = {
    Text = "每月最高{s1}日元"
  },
  LanguageConfig_VictoryAward_CN = {Text = "获得"},
  LanguageConfig_VindicateTitle_CN = {
    Text = "繁衍狂热"
  },
  LanguageConfig_VoiceActorTips_CN = {Text = "VA：{s1}"},
  LanguageConfig_WDZZMainDia1_CN = {
    Text = "#@……#?……#*"
  },
  LanguageConfig_WaitResponseTips_CN = {
    Text = "正在排队进入校园，请耐心等候"
  },
  LanguageConfig_WaitngTimeout2_CN = {
    Text = "等待超时…"
  },
  LanguageConfig_WaitngTimeout_CN = {
    Text = "等待超时…"
  },
  LanguageConfig_WakeFromSleep_CN = {
    Text = "要来咯！"
  },
  LanguageConfig_WangdaResonance15_1_CN = {
    Text = "，随机觉醒 1 名唤醒体"
  },
  LanguageConfig_WangdaResonance1_1_CN = {
    Text = "，获得 Arg3 黑印"
  },
  LanguageConfig_WeaponBreakthroughPlayerLevelRequire_CN = {
    Text = "需要守密人达到 {s1} 级"
  },
  LanguageConfig_WeaponBreakthroughSkillDesc_CN = {
    Text = "特殊能力"
  },
  LanguageConfig_WeaponBreakthroughTip_CN = {
    Text = "命轮提升到{s1}级可升格下一阶"
  },
  LanguageConfig_WeaponCurrRefineLevel_CN = {Text = "{s1}阶"},
  LanguageConfig_WeaponDecomposeEmptyTips_CN = {
    Text = "暂无可分解的命轮"
  },
  LanguageConfig_WeaponDecompositionCraftLimitTips_CN = {
    Text = "次数来源于历史命轮分解记录。该次数为固定值，使用后不可恢复。"
  },
  LanguageConfig_WeaponEnhanceCost_CN = {
    Text = "消耗材料({s1}/{s2})"
  },
  LanguageConfig_WeaponEnhanceMtrlSortType_1_CN = {
    Text = "强化等级"
  },
  LanguageConfig_WeaponEnhanceMtrlSortType_2_CN = {Text = "稀有度"},
  LanguageConfig_WeaponEnhanceMtrlType_1_CN = {Text = "以太"},
  LanguageConfig_WeaponEnhanceMtrlType_2_CN = {
    Text = "R阶及以下的命轮"
  },
  LanguageConfig_WeaponEnhanced_CN = {Text = "已强化"},
  LanguageConfig_WeaponExclusiveTips_CN = {
    Text = "当装备者为{s1}时，{s2}的所有卡牌变成金色。"
  },
  LanguageConfig_WeaponHigherQuality_CN = {
    Text = "稀有度较高"
  },
  LanguageConfig_WeaponInvalidPrompt_CN = {
    Text = "<Damage:相同的命轮效果无法重复生效。当前该命轮效果已于<Block:{s1}>生效，此处未生效。>"
  },
  LanguageConfig_WeaponLevelMaxSelectTips_CN = {
    Text = "{s1}已达到叠位等级上限，请更换选择的物品"
  },
  LanguageConfig_WeaponListEmpty_CN = {
    Text = "无可装备命轮"
  },
  LanguageConfig_WeaponOverflowReturn_CN = {
    Text = "溢出经验返还"
  },
  LanguageConfig_WeaponPoolGroupBtnTip_2_CN = {
    Text = "点击切换指定命轮"
  },
  LanguageConfig_WeaponPoolGroupTitle_2_CN = {
    Text = "因果苗圃"
  },
  LanguageConfig_WeaponPreviewTitle_CN = {
    Text = "命轮预览"
  },
  LanguageConfig_WeaponRandomChestTipTitle_CN = {
    Text = "随机获得命轮"
  },
  LanguageConfig_WeaponRandomSelectTitle_CN = {
    Text = "随机获得命轮"
  },
  LanguageConfig_WeaponReachBreakthroughLimit_CN = {Text = "已满级"},
  LanguageConfig_WeaponReachNewRefineLevel_CN = {
    Text = "已叠位至{s1}阶"
  },
  LanguageConfig_WeaponRefineLevel_CN = {
    Text = "叠位{s1}阶"
  },
  LanguageConfig_WeaponRefined_02_CN = {
    Text = "自动叠位"
  },
  LanguageConfig_WeaponRefined_03_CN = {
    Text = "已达叠位等级上限的命轮自动分解为其他资源"
  },
  LanguageConfig_WeaponRefined_04_CN = {Text = "转换"},
  LanguageConfig_WeaponRefined_CN = {Text = "已叠位"},
  LanguageConfig_WeaponSelectPreviewDetailTips_CN = {
    Text = "点击命轮查看详情"
  },
  LanguageConfig_WeaponSelectTitle_CN = {
    Text = "选择命轮"
  },
  LanguageConfig_WeaponSelectUseDetailTips_CN = {
    Text = "长按命轮查看详情"
  },
  LanguageConfig_WeaponSortTypeName_1_CN = {Text = "等级"},
  LanguageConfig_WeaponSortTypeName_2_CN = {Text = "稀有度"},
  LanguageConfig_WeaponSortTypeName_3_CN = {
    Text = "获取顺序"
  },
  LanguageConfig_WeaponSortTypeName_4_CN = {Text = "界域"},
  LanguageConfig_WeaponSortTypeName_5_CN = {Text = "叠位"},
  LanguageConfig_WeaponTypeName_CN = {Text = "命轮"},
  LanguageConfig_WeaponUnequip_2_CN = {
    Text = "未装备命轮"
  },
  LanguageConfig_WeaponUnequip_CN = {Text = "未装备"},
  LanguageConfig_Weapon_Suggest_Btn_CN = {Text = "推荐"},
  LanguageConfig_WeekChallengeAwakerCannotChoose_CN = {
    Text = "精疲力竭"
  },
  LanguageConfig_WeekChallengeInstructions_CN = {
    Text = "<Title:【无光之境】>\n·「无光之境」是一系列高难度调查关卡。守密人战胜最终首领完成调查后，可领取丰厚的调查奖励。守密人于「无光之境」的挑战不会消耗「灵啡肽」。\n\n<Title:【挑战规则】>\n·守密人战胜密境最终首领完成调查后，可以获取相应星级的调查评价。随着调查评分星级的提升，可以获得不同的奖励。\n·在不同的「无光之境」关卡中，守密人会获得独特的初始造物支持，仅在当前「无光之境」关卡内生效。\n·在同一「无光之境」关卡中，守密人成功通关某一密境关卡后，将记录当前编队所使用的唤醒体。相同的唤醒体无法在其他密境关卡中上场。\n·守密人可对已经通关的密境关卡进行进度重置，重置后该密境下通关使用的角色以及星级记录将会被清除，守密人可重新进行编队调整并继续挑战。"
  },
  LanguageConfig_WeekChallengeNotReached_1_CN = {
    Text = "尚未达到下一阶段的奖励要求或所有奖励均已被领取"
  },
  LanguageConfig_WeekChallengeNotReached_CN = {Text = "未达成"},
  LanguageConfig_WeekChallengeRewardHaveBeenObtained_CN = {
    Text = "已获取全部奖励"
  },
  LanguageConfig_WeekChallengeRewardsPreview_CN = {
    Text = "挑战奖励预览"
  },
  LanguageConfig_WeekChallengeRulesOfPlay_CN = {
    Text = "无光之境"
  },
  LanguageConfig_WeekChallengeStarNumReach_CN = {
    Text = "当前挑战星数达到"
  },
  LanguageConfig_WeeklyBossInstructions_CN = {
    Text = "\n<Title:奖励次数>\n·每周一9点(GMT+8)奖励次数重置，通关任意「超验存在」的关卡后将消耗1次奖励次数获得任务报酬奖励。\n·未使用的奖励次数将不会继承到下一周。\n\n<Title:重现>\n·首次完成「超验存在」关卡挑战后将解锁重现，重现将消耗1次奖励次数并直接获得任务报酬奖励。\n·若三星通关高难度关卡，则较低难度的关卡挑战进度会自动标记为三星通关。"
  },
  LanguageConfig_WeeklyBossRemainTimes_CN = {
    Text = "本周「超验存在」剩余次数:<color={s1}>{s2}</color>/{s3}"
  },
  LanguageConfig_WeeklyBossTitle_CN = {
    Text = "规则说明"
  },
  LanguageConfig_WeeklyBoss_LvLimit_CN = {
    Text = "调查等级达到{s1}解锁"
  },
  LanguageConfig_WeeklyRecordDesc_CN = {
    Text = "相位对弈和幻梦深潜合计胜利{s1}场"
  },
  LanguageConfig_WeeklyRecord_CN = {
    Text = "每周试炼"
  },
  LanguageConfig_WeeklyTotalWinTaskDesc_CN = {
    Text = "在限时活动、幻梦深潜或相位对弈中获得 {s1} 次胜利<color=#A3A6AB>({s2}/{s1})</color>"
  },
  LanguageConfig_WhiteEnchantConfigTypeName_CN = {
    Text = "<WhiteRelic:普通刻印>"
  },
  LanguageConfig_WhiteRelicTypeName_CN = {
    Text = "<WhiteRelic:白银造物>"
  },
  LanguageConfig_WordItemDesc_CN = {
    Text = "词缀说明"
  },
  LanguageConfig_Word_DiDi_CN = {Text = "弟弟"},
  LanguageConfig_Word_GeGe_CN = {Text = "哥哥"},
  LanguageConfig_Word_He_CN = {Text = "他"},
  LanguageConfig_Word_JieJie_CN = {Text = "姐姐"},
  LanguageConfig_Word_LordLady_CN = {Text = "小姐"},
  LanguageConfig_Word_Lord_CN = {Text = "少爷"},
  LanguageConfig_Word_Madam_CN = {Text = "小姐"},
  LanguageConfig_Word_MeiMei_CN = {Text = "妹妹"},
  LanguageConfig_Word_She_CN = {Text = "她"},
  LanguageConfig_Word_Sir_CN = {Text = "先生"},
  LanguageConfig_WorldBossDoing_CN = {
    Text = "与其他守密人协同作战，获取珍稀奖励"
  },
  LanguageConfig_WorldBossDone_CN = {
    Text = "所有原初之视的分身均已被消灭"
  },
  LanguageConfig_WorldstageShopRelicStrengthTitle_CN = {Text = "祭祀"},
  LanguageConfig_WorldstageShopRelicStrength_CN = {
    Text = "花费黑印将白银造物强化为黄金，每次强化花费黑印都会提高。"
  },
  LanguageConfig_XLMainDia1_CN = {
    Text = "哼，就凭你们"
  },
  LanguageConfig_XLMainDia2_CN = {
    Text = "休想拦住我！"
  },
  LanguageConfig_XLMainDia3_CN = {
    Text = "把莉莉…………还给我！"
  },
  LanguageConfig_XLMainDia4_CN = {
    Text = "来吧，萝坦！"
  },
  LanguageConfig_XLMainDia5_CN = {
    Text = "一决高下！"
  },
  LanguageConfig_XLMainDia6_CN = {
    Text = "我还……没有输！"
  },
  LanguageConfig_XuanWoHuodong1_CN = {
    Text = "面对突然来找你玩的小煤球二世，你的选择是……"
  },
  LanguageConfig_chaotype2_pack_select_title_CN = {
    Text = "选择一组钥令依次释放"
  },
  LanguageConfig_chaotype2_teamskill_desc_CN = {
    Text = "{s1}额外重复 1 次。"
  },
  LanguageConfig_chaotype2_teamskill_name_CN = {
    Text = "双重·{s1}"
  },
  LanguageConfig_laikegamblingsuccess_CN = {
    Text = "豪赌的智慧-双发！"
  },
  LanguageConfig_risk_error_msg_freqControl_CN = {
    Text = "您当前的角色创建数量已达上限。"
  },
  LanguageConfig_risk_error_msg_maliciousAction_CN = {
    Text = "检测到违规行为，请前往【客服入口】联系客服进行申诉。"
  },
  LanguageConfig_risk_error_msg_maliciousEnv_CN = {
    Text = "设备或网络环境异常，请稍后再试。"
  },
  LanguageConfig_risk_error_msg_requestLimit_CN = {
    Text = "系统繁忙，请稍后再试。"
  },
  LanguageConfig_setUp_CN = {Text = "设置"},
  LanguageConfig_statistic_battle_filter_all_CN = {
    Text = "所有战斗"
  },
  LanguageConfig_statistic_battle_filter_boss_CN = {
    Text = "首领战斗"
  },
  LanguageConfig_statistic_battle_filter_common_CN = {
    Text = "普通战斗"
  },
  LanguageConfig_statistic_battle_filter_elite_CN = {
    Text = "精英战斗"
  },
  LanguageConfig_statistic_bout_filter_all_CN = {
    Text = "所有回合"
  },
  LanguageConfig_statistic_bout_filter_turn_CN = {
    Text = "第{s1}回合"
  },
  LanguageConfig_statistic_state_concept_FinalVerdict_CN = {
    Text = "命运裁断"
  },
  LanguageConfig_statistic_state_concept_bleed_CN = {Text = "出血"},
  LanguageConfig_statistic_state_concept_corrosion_CN = {Text = "侵蚀"},
  LanguageConfig_statistic_state_concept_counterattack_CN = {Text = "反击"},
  LanguageConfig_statistic_state_concept_poison_CN = {Text = "中毒"},
  LanguageConfig_statistic_state_concept_sacrifice_CN = {Text = "献祭"},
  LanguageConfig_statistic_type_filter_block_CN = {Text = "护盾"},
  LanguageConfig_statistic_type_filter_damage_CN = {Text = "伤害"},
  LanguageConfig_statistic_type_filter_heal_CN = {Text = "治疗"},
  LanguageConfig_test_api_a1_CN = {
    Text = "选择1组钥令依次释放"
  },
  LanguageConfig_test_api_a2_CN = {
    Text = "第2轮 必选2名给标记"
  },
  LanguageConfig_test_api_a3_CN = {
    Text = "第3轮 可选2名给标记"
  },
  LanguageConfig_test_api_a4_CN = {
    Text = "第4轮 滤出有{状态@空状态}的\n必选4名给标记"
  },
  LanguageConfig_yixiang10_1_CN = {Text = "花束"},
  LanguageConfig_yixiang10_2_CN = {Text = "花束"},
  LanguageConfig_yixiang10_3_CN = {Text = "花束"},
  LanguageConfig_yixiang10_CN = {Text = "花束"},
  LanguageConfig_yixiang11_1_CN = {Text = "猫"},
  LanguageConfig_yixiang11_2_CN = {Text = "猫"},
  LanguageConfig_yixiang11_3_CN = {Text = "猫"},
  LanguageConfig_yixiang11_CN = {Text = "猫"},
  LanguageConfig_yixiang12_1_CN = {Text = "大地"},
  LanguageConfig_yixiang12_2_CN = {Text = "大地"},
  LanguageConfig_yixiang12_3_CN = {Text = "大地"},
  LanguageConfig_yixiang12_CN = {Text = "大地"},
  LanguageConfig_yixiang13_1_CN = {Text = "泉水"},
  LanguageConfig_yixiang13_2_CN = {Text = "泉水"},
  LanguageConfig_yixiang13_3_CN = {Text = "泉水"},
  LanguageConfig_yixiang13_CN = {Text = "泉水"},
  LanguageConfig_yixiang14_1_CN = {Text = "月亮"},
  LanguageConfig_yixiang14_2_CN = {Text = "月亮"},
  LanguageConfig_yixiang14_3_CN = {Text = "月亮"},
  LanguageConfig_yixiang14_CN = {Text = "月亮"},
  LanguageConfig_yixiang1_1_CN = {Text = "太阳"},
  LanguageConfig_yixiang1_2_CN = {Text = "太阳"},
  LanguageConfig_yixiang1_3_CN = {Text = "太阳"},
  LanguageConfig_yixiang1_CN = {Text = "太阳"},
  LanguageConfig_yixiang2_1_CN = {Text = "星星"},
  LanguageConfig_yixiang2_2_CN = {Text = "星星"},
  LanguageConfig_yixiang2_3_CN = {Text = "星星"},
  LanguageConfig_yixiang2_CN = {Text = "星星"},
  LanguageConfig_yixiang3_1_CN = {Text = "春天"},
  LanguageConfig_yixiang3_2_CN = {Text = "春天"},
  LanguageConfig_yixiang3_3_CN = {Text = "春天"},
  LanguageConfig_yixiang3_CN = {Text = "春天"},
  LanguageConfig_yixiang4_1_CN = {Text = "诗句"},
  LanguageConfig_yixiang4_2_CN = {Text = "诗句"},
  LanguageConfig_yixiang4_3_CN = {Text = "诗句"},
  LanguageConfig_yixiang4_CN = {Text = "诗句"},
  LanguageConfig_yixiang5_1_CN = {Text = "蝴蝶"},
  LanguageConfig_yixiang5_2_CN = {Text = "蝴蝶"},
  LanguageConfig_yixiang5_3_CN = {Text = "蝴蝶"},
  LanguageConfig_yixiang5_CN = {Text = "蝴蝶"},
  LanguageConfig_yixiang6_1_CN = {Text = "云朵"},
  LanguageConfig_yixiang6_2_CN = {Text = "云朵"},
  LanguageConfig_yixiang6_3_CN = {Text = "云朵"},
  LanguageConfig_yixiang6_CN = {Text = "云朵"},
  LanguageConfig_yixiang7_1_CN = {Text = "风"},
  LanguageConfig_yixiang7_2_CN = {Text = "风"},
  LanguageConfig_yixiang7_3_CN = {Text = "风"},
  LanguageConfig_yixiang7_CN = {Text = "风"},
  LanguageConfig_yixiang8_1_CN = {Text = "森林"},
  LanguageConfig_yixiang8_2_CN = {Text = "森林"},
  LanguageConfig_yixiang8_3_CN = {Text = "森林"},
  LanguageConfig_yixiang8_CN = {Text = "森林"},
  LanguageConfig_yixiang9_1_CN = {Text = "雪"},
  LanguageConfig_yixiang9_2_CN = {Text = "雪"},
  LanguageConfig_yixiang9_3_CN = {Text = "雪"},
  LanguageConfig_yixiang9_CN = {Text = "雪"}
})
return Text_LanguageConfig
