-- chunkname: @modules/logic/tower/defines/TowerEnum.lua

module("modules.logic.tower.defines.TowerEnum", package.seeall)

local TowerEnum = _M

TowerEnum.TowerType = {
	Boss = 2,
	Limited = 3,
	Normal = 1
}
TowerEnum.TowerStatus = {
	Ready = 1,
	Open = 2,
	Close = 3,
	None = 0
}
TowerEnum.PermanentUI = {
	SingleItemH = 120,
	DeepScrollH = 800,
	LockTipH = 200,
	ScrollH = 950,
	ItemSpaceH = 90,
	StageTitleH = 80
}
TowerEnum.PermanentTowerId = 0
TowerEnum.ActTaskType = 1
TowerEnum.MaxShowStarNum = 4
TowerEnum.BossGuideId = 23205
TowerEnum.TimeLimitGuideId = 23207
TowerEnum.PermanentEliteEpisodeState = {
	Finish = 2,
	FinishSelect = 1,
	NormalSelect = 3,
	Normal = 4
}
TowerEnum.PassEpisodeState = {
	Pass = 1,
	NotPass = 0
}
TowerEnum.ShowState = {
	Hide = 0,
	Show = 1
}
TowerEnum.JumpId = {
	TowerBoss = 2,
	TowerBossTeach = 4,
	TowerLimited = 3,
	TowerPermanent = 1
}
TowerEnum.ConstId = {
	BalanceBossLevel = 118,
	CustomTalentPlanCount = 119,
	TimeLimitOpenLayerNum = 112,
	BossHandbookOpen = 116,
	HeroTrialRule = 120,
	MopUpRecoverTime = 102,
	MopUpOpenLayerNum = 113,
	BossTowerOpen = 111,
	BossHeroTrialList = 123,
	TimeLimitEasyMulti = 104,
	MaxMopUpTimes = 101,
	StoreOpen = 122,
	MopUpTicketIcon = 114,
	TimeLimitNormalMulti = 105,
	TaskRewardOpen = 117,
	TeachBossLevel = 121,
	TimeLimitHardMulti = 106
}
TowerEnum.LocalPrefsKey = {
	MopUpDailyRefresh = "MopUpDailyRefresh",
	TowerBossSPEpisodeFinishEffect = "TowerBossSPEpisodeFinishEffect",
	NewBossSpOpen = "NewBossSpOpen",
	NewTimeLimitOpen = "NewTimeLimitOpen",
	ReddotNewBossOpen = "ReddotNewBossOpen",
	TowerBossSelectHandBookEffect = "TowerBossSelectHandBookEffect",
	NewBossOpen = "NewBossOpen",
	TowerMainHeroTrialEffect = "TowerMainHeroTrialEffect",
	LastEntranceDifficulty = "LastEntranceDifficulty",
	ReddotNewLimitedActTask = "ReddotNewLimitedActTask",
	OpenMopUpViewWithFullTicket = "OpenMopUpViewWithFullTicket",
	TowerBossTeachFinishEffect = "TowerBossTeachFinishEffect",
	ReddotNewTimeLimitOpen = "ReddotNewTimeLimitOpen",
	ReddotNewHeroTrial = "ReddotNewHeroTrial"
}
TowerEnum.LockKey = 0
TowerEnum.UnlockKey = 1
TowerEnum.Difficulty = {
	Normal = 2,
	Hard = 3,
	Easy = 1
}
TowerEnum.AttrKey = {
	CriDmg = "criDmg",
	Attack = "attack",
	Cri = "cri"
}
TowerEnum.UpAttrId = {
	[TowerEnum.AttrKey.Cri] = 1,
	[TowerEnum.AttrKey.CriDmg] = 1
}
TowerEnum.AttrKey2AttrId = {
	[TowerEnum.AttrKey.Attack] = CharacterEnum.AttrId.Attack,
	[TowerEnum.AttrKey.Cri] = CharacterEnum.AttrId.Cri,
	[TowerEnum.AttrKey.CriDmg] = CharacterEnum.AttrId.CriDmg
}
TowerEnum.HeroTrialEntranceType = {
	Compose = 2,
	Normal = 1
}
TowerEnum.HeroTrialType = {
	Permanenet = 1,
	Compose = 4,
	Deep = 3,
	Boss = 2
}

return TowerEnum
