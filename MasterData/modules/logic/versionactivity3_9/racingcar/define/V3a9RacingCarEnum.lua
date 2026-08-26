-- chunkname: @modules/logic/versionactivity3_9/racingcar/define/V3a9RacingCarEnum.lua

module("modules.logic.versionactivity3_9.racingcar.define.V3a9RacingCarEnum", package.seeall)

local V3a9RacingCarEnum = _M

V3a9RacingCarEnum.RacingLevelStarMaxCount = 3
V3a9RacingCarEnum.RacingGameState = {
	Racing = 1,
	Paused = 2,
	GuidePaused = 3,
	Countdown = 0
}
V3a9RacingCarEnum.GuideParam = {
	Coin = 3,
	Distance = 1,
	Item = 2,
	Obstacle = 4
}
V3a9RacingCarEnum.TalentGuideId = 39029
V3a9RacingCarEnum.EpisodeGuideMap = {
	[1392001] = {
		39024,
		39025
	},
	[1392002] = {
		39027,
		39028
	}
}
V3a9RacingCarEnum.PostFinishDelay = 10
V3a9RacingCarEnum.StarTargetType = {
	Finish = 1,
	Time = 3,
	Rank = 2
}
V3a9RacingCarEnum.SceneLevelId = {
	Main = 1
}
V3a9RacingCarEnum.CameraId = {
	[V3a9RacingCarEnum.SceneLevelId.Main] = 24
}
V3a9RacingCarEnum.FirstPlaceSafeTime = 3
V3a9RacingCarEnum.MileStoneId = 390001
V3a9RacingCarEnum.EpisodeType = {
	RacingCar = 2,
	Bird = 1
}
V3a9RacingCarEnum.TalentTab = {
	Role = 2,
	Talent = 1
}
V3a9RacingCarEnum.Act243Const = {
	CurrencyId = 1,
	RewardDetail = 2,
	UnlockEnterBtnStoryId = 4
}
V3a9RacingCarEnum.RoleAttr = {
	MaxSpeed = 3,
	BaseSpeed = 1,
	BaseAcceleration = 2
}
V3a9RacingCarEnum.RoleAttrInfo = {
	[V3a9RacingCarEnum.RoleAttr.BaseSpeed] = {
		param = "baseSpeed",
		title = "v3a9Racing_role_attr_name1"
	},
	[V3a9RacingCarEnum.RoleAttr.BaseAcceleration] = {
		param = "baseAcceleration",
		title = "v3a9Racing_role_attr_name2"
	},
	[V3a9RacingCarEnum.RoleAttr.MaxSpeed] = {
		param = "maxSpeed",
		title = "v3a9Racing_role_attr_name3"
	}
}
V3a9RacingCarEnum.AudioId = {
	PlayBeiaiWaveAppear = 370408,
	PlayChongranFlyby = 390039,
	PlayBulaochuanGetCandle = 340086,
	PlayBulaochuanLeak = 340092,
	PlayChongranRippleAmb = 390041,
	PlayBulaochuanBubbleBurst = 340082,
	PlayChongranSeagull = 390052,
	PlayBeiaiWaterAbsorb = 370402,
	StopChongranRippleAmb = 390042,
	PlayCikexiaLinkReceiveAward = 20305611,
	PlayChongranFlyLoop = 390035,
	PlayChongranSplashWater = 390037,
	PlayBulaochuanFloorShiny = 340153,
	PlayBulaochuanColor = 340081,
	PlayChongranCastSkillmax = 390040,
	PlayDiqiuUnlock = 340102,
	PlayFuleyuanTansuoSuccess2 = 20280626,
	StopChongranFlyLoop = 390036,
	PlayWin = 340066,
	StopChongranSplashWater = 390038,
	PlayYuanzhengMrsJiasu = 330067,
	PlaySwitchLane = 3852019
}
V3a9RacingCarEnum.bgm = {
	partygame_lobby = 3340002,
	partygame_bgm_stop = 3340033,
	partygame_main = 3340001
}
V3a9RacingCarEnum.MaxPowerSpeed = 6

return V3a9RacingCarEnum
