-- chunkname: @modules/logic/bossrush/config/BossRushEnum.lua

module("modules.logic.bossrush.config.BossRushEnum", package.seeall)

local BossRushEnum = _M
local kResPathRoot = "ui/viewres/versionactivity_1_4/v1a4_bossrush/"
local kV3a2ResPathRoot = "ui/viewres/versionactivity_1_4/v1a4_bossrush/v3a2_bossrush/"
local kV3a9ResPathRoot = "ui/viewres/versionactivity_1_4/v1a4_bossrush/v3a9_bossrush/"

BossRushEnum.ResPath = {
	v1a4_bossrush_battle_assessicon = kResPathRoot .. "v1a4_bossrush_battle_assessicon.prefab",
	v1a4_bossrush_result_assess = kResPathRoot .. "v1a4_bossrush_result_assess.prefab",
	v1a4_bossrush_scheduleitem = kResPathRoot .. "v1a4_bossrush_scheduleitem.prefab",
	v1a4_bossrush_ig_scoretips = kResPathRoot .. "v1a4_bossrush_ig_scoretips.prefab",
	v1a4_bossrushleveldetail_spine = kResPathRoot .. "v1a4_bossrushleveldetail_spine.prefab",
	v1a4_bossrush_mainview_assessicon = kResPathRoot .. "v1a4_bossrush_mainview_assessicon.prefab",
	v1a4_bossrush_leveldetail_assessicon = kResPathRoot .. "v1a4_bossrush_leveldetail_assessicon.prefab",
	v1a4_bossrush_achievement_assessicon = kResPathRoot .. "v1a4_bossrush_achievement_assessicon.prefab",
	v1a4_bossrush_herogroup = kResPathRoot .. "v1a4_bossrush_herogroup.prefab",
	v1a4_bossrush_herogroupitem1 = kResPathRoot .. "v1a4_bossrush_herogroupitem1.prefab",
	v1a4_bossrush_herogroupitem2 = kResPathRoot .. "v1a4_bossrush_herogroupitem2.prefab",
	v1a4_bossrushmainitem = kResPathRoot .. "v1a4_bossrushmainitem.prefab",
	v1a6_bossrush_result_assess = kResPathRoot .. "v1a6_bossrush_resultassess.prefab",
	v1a6_bossrush_achievementview = kResPathRoot .. "v1a6_bossrush_achievementview.prefab",
	v1a6_bossrush_scheduleview = kResPathRoot .. "v1a6_bossrush_scheduleview.prefab",
	v2a1_bossrush_specialscheduleview = kResPathRoot .. "v2a1_bossrush_specialscheduleview.prefab",
	v1a4_bossrushmainview = kResPathRoot .. "v1a4_bossrushmainview.prefab",
	v1a4_bossrushleveldetail = kResPathRoot .. "v1a4_bossrushleveldetail.prefab",
	v3a2_bossrush_mainview = kV3a2ResPathRoot .. "v3a2_bossrush_mainview.prefab",
	v3a2_bossrush_leveldetail = kV3a2ResPathRoot .. "v3a2_bossrush_leveldetail.prefab",
	v3a2_bossrush_handbookitem = kV3a2ResPathRoot .. "v3a2_bossrush_handbookitem.prefab",
	v3a2_bossrush_handbookview = kV3a2ResPathRoot .. "v3a2_bossrush_handbookview.prefab",
	v3a2_bossrush_rankbtn = kV3a2ResPathRoot .. "v3a2_bossrush_rankbtn.prefab",
	v3a2_bossrush_rankview = kV3a2ResPathRoot .. "v3a2_bossrush_rankview.prefab",
	v3a2_bossrush_resultassess = kV3a2ResPathRoot .. "v3a2_bossrush_resultassess.prefab",
	v3a2_bossrush_resultpanel = kV3a2ResPathRoot .. "v3a2_bossrush_resultpanel.prefab",
	v3a2_bossrush_resultview = kV3a2ResPathRoot .. "v3a2_bossrush_resultview.prefab",
	v3a2_bossrush_strategyitem = kV3a2ResPathRoot .. "v3a2_bossrush_strategyitem.prefab",
	v3a2_bossrush_rankbonus = kV3a2ResPathRoot .. "v3a2_bossrush_rankbonus.prefab",
	v3a9_bossrush_mainswitchmodeview = kV3a9ResPathRoot .. "v3a9_bossrush_mainswitchmodeview.prefab",
	v3a9_bossrush_mainview = kV3a9ResPathRoot .. "v3a9_bossrush_mainview.prefab",
	v3a9_bossrush_leveldetail = kV3a9ResPathRoot .. "v3a9_bossrush_leveldetail.prefab",
	v3a9_bossrush_bondsitem = kV3a9ResPathRoot .. "v3a9_bossrush_bondsitem.prefab"
}
BossRushEnum.Color = {
	POINTVALUE_NORMAL = "#666362",
	POINTVALUE_GOT = "#AC5320",
	WHITE = "#FFFFFF",
	GRAY = "#666666"
}
BossRushEnum.TaskListenerType = {
	layer4Reward = "Act128BossLayer4TotalPoint",
	highestPoint = "Act128BossHighestPoint",
	SpHighestPoint = "Act128BossSpHighestPoint"
}
BossRushEnum.ScoreLevel = {
	S_AA = 9,
	C = 1,
	S = 7,
	S_AAA = 10,
	C_A = 2,
	S_AAAA = 10,
	S_AAAAA = 10,
	B_A = 4,
	A = 5,
	A_A = 6,
	S_A = 8,
	B = 3
}
BossRushEnum.ScoreLevelStr = {
	S = "S",
	C = "C",
	A_A = "A+",
	SSS = "SSS",
	SSSS = "SSSS",
	SSSSS = "SSSSS",
	SSSSSS = "SSSSSS",
	B_A = "B+",
	A = "A",
	SS = "SS",
	C_A = "C+",
	B = "B"
}
BossRushEnum.HpColor = {
	Orange = 2,
	Green = 4,
	Blue = 5,
	Red = 1,
	Yellow = 3,
	Purple = 6
}
BossRushEnum.AssessType = {
	Layer4 = 1,
	V3a2 = 2,
	Normal = 0
}
BossRushEnum.AnimLevelDetail = {
	HardEnter = "hard",
	NormalEnter = "normal",
	SwitchToHard = "tohard",
	Layer4 = "layer4",
	EndlessEnter = "endless",
	SwitchToEndless = "toendless",
	SwitchToLayer4 = "tolayer4",
	SwitchToNormal = "tonormal",
	CloseView = "close"
}
BossRushEnum.AnimLevelDetailBtn = {
	Select = "select",
	LockedIdle = "locked_idle",
	UnlockedIdle = "unlocked_idle"
}
BossRushEnum.AnimTriggerLevelDetailBtn = {
	PlayUnlock = "play_unlock"
}
BossRushEnum.AnimScheduleItemRewardItem = {
	ReceiveEnter = "v1a4_bossrush_scheduleitem_receiveenter",
	Idle = "v1a4_bossrush_scheduleitem_default_idle",
	Got = "v1a4_bossrush_scheduleitem_default_get"
}
BossRushEnum.AnimScheduleItemRewardItem_HasGet = {
	Idle = "v1a4_bossrush_go_hasget_idle",
	Got = "v1a4_bossrush_go_hasget_in"
}
BossRushEnum.AnimScoreTips = {
	LevelUp = "levelup",
	ScoreNumChange = "txt_scorenum_change"
}
BossRushEnum.AnimResultPanel = {
	InNotEmpty = "innotempty",
	InEmpty = "inempty"
}
BossRushEnum.AnimEvtAchievementItem = {
	onBtnGoEnter = "onBtnGoEnter",
	onFinishEnd = "onFinishEnd",
	onEndBlock = "onEndBlock"
}
BossRushEnum.AnimEvtResultPanel = {
	onOpenEnd = "onOpenEnd",
	EvaluateItemAnim = "EvaluateItemAnim",
	ScoreTween = "ScoreTween",
	onCompleteOpenStart = "onCompleteOpenStart",
	CompleteFinish = "CompleteFinish"
}
BossRushEnum.AnimEvtLevelDetail = {
	onPlayCloseTransitionFinish = "onPlayCloseTransitionFinish"
}
BossRushEnum.AnimEvtLevelDetailItem = {
	onPlayUnlockSound = "onPlayUnlockSound"
}
BossRushEnum.AnimMainItem = {
	Unlocking = "unlocking",
	OpeningUnlocked = "opening_unlocked",
	LockedIdle = "locked_idle",
	UnlockedIdle = "unlocked_idle",
	OpeningLocked = "opening_locked",
	Unlock = "unlock"
}
BossRushEnum.BonusViewTab = {
	SpecialScheduleTab = 3,
	ScheduleTab = 2,
	AchievementTab = 1
}
BossRushEnum.V2a9BonusViewTab = {
	V2a9Special = 2,
	V2a9TotalSchedule = 3,
	V2a9Normal = 1
}
BossRushEnum.V1a6_ResultAnimName = {
	NoEvaluate = "in",
	OpenEmpty = "openempty",
	Close = "close",
	HasEvaluate = "in2",
	Open = "open"
}
BossRushEnum.V1a6_BonusViewAnimName = {
	Out = "out",
	Idle = "idle",
	In = "in",
	Finish = "finish",
	Open = "open"
}
BossRushEnum.PlayUnlockAnimStage = "BossRushMainItem_%s_%s"
BossRushEnum.LayerRes = {
	EnterLevelBtn = {
		"v1a4_bossrush_btn_go2",
		nil,
		"v1a4_bossrush_btn_go3",
		"v2a1_bossrush_btn_go4"
	},
	EnterLevelBtnTxtColor = {
		"#070706",
		nil,
		"#F7F0E8",
		"#EBFDFF"
	}
}
BossRushEnum.StoreActivityId = 11604
BossRushEnum.LayerEnum = {
	Simple = 1,
	Endless = 3,
	Layer4 = 4,
	V2a9 = 5,
	Hard = 2
}
BossRushEnum.V2a9StageEnum = {
	Second = 2,
	First = 1
}
BossRushEnum.V2a9FightEquipSkillMaxCount = 4
BossRushEnum.V2a9FightCanEquipSkillCountConst = 4
BossRushEnum.S01Anim = {
	Load = "load",
	Unload = "unload"
}
BossRushEnum.LevelCondition = {
	[DungeonEnum.ChapterType.BossRushInfinite] = "v1a4_bossrushleveldetail_txt_target",
	[DungeonEnum.ChapterType.V3a2BossRush] = "v1a4_bossrushleveldetail_txt_target"
}

return BossRushEnum
