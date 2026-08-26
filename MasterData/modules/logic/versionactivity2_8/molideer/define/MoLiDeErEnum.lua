-- chunkname: @modules/logic/versionactivity2_8/molideer/define/MoLiDeErEnum.lua

module("modules.logic.versionactivity2_8.molideer.define.MoLiDeErEnum", package.seeall)

local MoLiDeErEnum = _M

MoLiDeErEnum.EventTitleColor = {
	NoComplete = "#DDD9D0",
	Dispatching = "#969696",
	Complete = "#EFE5B6"
}
MoLiDeErEnum.EventBgColor = {
	Dispatching = "#808080",
	Normal = "#FFFFFF"
}
MoLiDeErEnum.DispatchState = {
	Finish = 4,
	Dispatch = 2,
	Dispatching = 3,
	Main = 1
}
MoLiDeErEnum.EventName = {
	3,
	4,
	5
}
MoLiDeErEnum.ItemType = {
	Passive = 0,
	Initiative = 1
}
MoLiDeErEnum.BuffType = {
	Passive = 2,
	Initiative = 3,
	Forever = 1
}
MoLiDeErEnum.EventState = {
	Unlock = 0,
	Complete = 1
}
MoLiDeErEnum.OptionCostType = {
	Round = 5,
	Execution = 1
}
MoLiDeErEnum.OptionConditionType = {
	Team = 1,
	Item = 2
}
MoLiDeErEnum.TeamBuffType = {
	Item = 2
}
MoLiDeErEnum.LevelItemTitleColor = {
	NoComplete = "#FFFFFF",
	Complete = "#FFF8DA"
}
MoLiDeErEnum.LevelItemStateNameColor = {
	NoComplete = "#C9EDF6",
	Complete = "#F9F1CC"
}
MoLiDeErEnum.CostDestColor = {
	NoComplete = "#C9EDF6",
	Complete = "#F9F1CC"
}
MoLiDeErEnum.ExecutionBuffType = {
	Percent = 2,
	Fixed = 6,
	FixedOther = 4
}
MoLiDeErEnum.RoundBuffType = {
	Percent = 1,
	Fixed = 5,
	FixedOther = 3
}
MoLiDeErEnum.AnimationTime = {
	InterludeDuration = 1,
	InterludeCloseDuration = 1.33
}
MoLiDeErEnum.DelayTime = {
	BlackScreenTime2 = 3,
	NewEventShow = 1.5,
	Close = 0.2,
	BlackEnd = 1.167,
	BlackScreenTime = 4,
	TipHide = 2,
	BlackScreenTime3 = 4,
	TargetFxProgressAdd = 1.5,
	DescTextShowDelay = 0.05,
	DescBtnShowDelay = 0.2,
	TargetFxMove = 0.5,
	FinishEventShow = 1.15,
	ItemHideOrAppear = 0.8
}
MoLiDeErEnum.OptionRestrictionType = {
	Team = 1,
	Item = 2
}
MoLiDeErEnum.OptionEffectType = {
	Team = 3,
	Round = 5,
	Item = 2,
	Execution = 1
}
MoLiDeErEnum.ItemBuffType = {
	ExtraRoundAdd = 12,
	MainRoundAdd = 11
}
MoLiDeErEnum.TargetType = {
	RoundFinishAny = 4,
	RoundFinishAll = 2
}
MoLiDeErEnum.AnimName = {
	GameViewEventItemFinish = "finish",
	GameViewEventRoleIn = "in",
	GameViewEventRoleOut = "out",
	EventViewSwitchOpen = "switch",
	InterludeViewClose = "close",
	GameViewEventItemClose = "close",
	GameViewEventTitleIdle = "idle",
	LevelViewOpen = "open",
	LevelPathItemFinished = "finished",
	InterludeViewOpen = "open",
	RoleItemOut = "out",
	GameViewEventItemOpen = "open",
	GameViewEventTitleCount = "count",
	LevelItemFinish = "finish",
	RoleItemIn = "in",
	LevelItemUnlock = "unlock",
	EventViewFinishOpen = "open",
	LevelPathItemFinish = "finish"
}
MoLiDeErEnum.LevelAnimTime = {
	LevelItemUnlock = 1,
	LevelViewOpen = 0.667,
	LevelItemFinish = 1,
	LevelForceEndBlock = 5
}
MoLiDeErEnum.LevelState = {
	Unlock = 0,
	Complete = 1
}
MoLiDeErEnum.EventCenterOffset = {
	X = 0,
	Y = -165
}
MoLiDeErEnum.EventLinePivot = {
	Appear = 0,
	Fade = 1
}
MoLiDeErEnum.ProgressChangeType = {
	Percentage = 1,
	Failed = 3,
	Success = 2
}
MoLiDeErEnum.TargetId = {
	Extra = 2,
	Main = 1
}
MoLiDeErEnum.ProgressRange = {
	Failed = -1,
	Success = 100
}
MoLiDeErEnum.TargetConditionState = {
	Shortage = 1,
	Enough = 3,
	Failed = 3,
	Normal = 2
}
MoLiDeErEnum.TargetTitleColor = {
	[MoLiDeErEnum.TargetConditionState.Enough] = "#74CE95",
	[MoLiDeErEnum.TargetConditionState.Normal] = "#EEBF77",
	[MoLiDeErEnum.TargetConditionState.Shortage] = "#F68D92"
}
MoLiDeErEnum.TargetDescColor = {
	[MoLiDeErEnum.ProgressChangeType.Percentage] = "#FFFFFF",
	[MoLiDeErEnum.ProgressChangeType.Success] = "#EEBF77",
	[MoLiDeErEnum.ProgressChangeType.Failed] = "#A6ADB0"
}
MoLiDeErEnum.ResultTargetColor = {
	Fail = "#9B9A98",
	Success = "#CBB980"
}
MoLiDeErEnum.TeamDispatchState = {
	WithDraw = -1,
	Dispatch = 1,
	Dispatching = 0
}
MoLiDeErEnum.TargetConditionType = {
	RoundLimitedFinishAll = 2,
	RoundLimitedFinishAny = 4
}
MoLiDeErEnum.EventLineUnitLength = 27

return MoLiDeErEnum
