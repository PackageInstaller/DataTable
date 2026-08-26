-- chunkname: @modules/logic/sp02/operationactivity/define/AtomicOperationActivityEnum.lua

module("modules.logic.sp02.operationactivity.define.AtomicOperationActivityEnum", package.seeall)

local AtomicOperationActivityEnum = _M

AtomicOperationActivityEnum.RewardState = {
	CanGet = 1,
	Locked = 0,
	HasGet = 2
}
AtomicOperationActivityEnum.LoopType = {
	Week = 2,
	Activity = 3,
	Day = 1
}
AtomicOperationActivityEnum.FirstDay = 1
AtomicOperationActivityEnum.EntranceIdList = {
	ActivityEnum.Activity.SP02_AtomicOperationActivityTask,
	ActivityEnum.Activity.SP02_AtomicOperationActivityGame,
	ActivityEnum.Activity.SP02_AtomicOperationActivitySignIn
}
AtomicOperationActivityEnum.ConstId = {
	RewardScore = 3,
	PosCD = 8,
	GameStartCountDown = 5,
	SkinId = 12,
	CountDownErrorStateTime = 9,
	HeroId = 11,
	CurrencyId = 1,
	hitCD = 7,
	MaxTargetCount = 6,
	DailyRewardGameCount = 2,
	BigScoreShowLimit = 10,
	GameTime = 4
}
AtomicOperationActivityEnum.HideNumItemDic = {
	[171504] = true
}
AtomicOperationActivityEnum.TargetId = {
	Boss = 1
}
AtomicOperationActivityEnum.GameFirstEnterKey = "SPO2_AtomicOperationActivityEnum_Game_FirstEnter_Test1"
AtomicOperationActivityEnum.MileStoneRewardCount = 2
AtomicOperationActivityEnum.GameMaxTargetCount = 7
AtomicOperationActivityEnum.TargetState = {
	Disappear = 3,
	Hit = 2,
	HitDisappear = 4,
	Normal = 1
}
AtomicOperationActivityEnum.DelayTime = {
	TaskUpdateTime = 0.1,
	GameCountDown = 3,
	TargetAppear = 0.2,
	GameTimeRefresh = 0.5,
	TargetDisappear = 0.233,
	AddScore = 1,
	TaskFinishTime = 0.667,
	GameLogic = 0.01,
	TargetHit = 0.7,
	TargetHitAppear = 0.467
}
AtomicOperationActivityEnum.StateColor = {
	[AtomicOperationActivityEnum.TargetState.Normal] = "#FFFFFF",
	[AtomicOperationActivityEnum.TargetState.Hit] = "#FF5858"
}
AtomicOperationActivityEnum.StateAlpha = {
	Disappear = 0,
	Appear = 1
}
AtomicOperationActivityEnum.PreparationId = {
	DoubleScore = 1,
	MoreScoreEnemy = 3,
	NoReduceScore = 2,
	NearHit = 5,
	AfterHit = 4
}
AtomicOperationActivityEnum.ProgressType = {
	Score = 2,
	GameCount = 1
}
AtomicOperationActivityEnum.TipViewReadState = {
	NotRead = 0,
	HaveRead = 1
}
AtomicOperationActivityEnum.ShowHeroSkinId = 306605
AtomicOperationActivityEnum.ShowHeroId = 3066
AtomicOperationActivityEnum.WeightMultiple = 1000
AtomicOperationActivityEnum.LockScreenKey = {
	SwitchRole = "AtomicOperationActivityEnterView_Switch_Role"
}
AtomicOperationActivityEnum.LockScreenTime = {
	SwitchRole = 0.167
}
AtomicOperationActivityEnum.TaskLoopType = {
	Forever = 3
}
AtomicOperationActivityEnum.ComboLimit = 2
AtomicOperationActivityEnum.DefaultHitRadius = 150

return AtomicOperationActivityEnum
