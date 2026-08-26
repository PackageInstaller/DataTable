-- chunkname: @modules/logic/tower/defines/TowerDeepEnum.lua

module("modules.logic.tower.defines.TowerDeepEnum", package.seeall)

local TowerDeepEnum = _M

TowerDeepEnum.DeepLayerStage = 7
TowerDeepEnum.DefaultDeepRare = 1
TowerDeepEnum.MaxDeepRare = 5
TowerDeepEnum.MaxNormalBgStage = 5
TowerDeepEnum.ConstId = {
	FirstEnterDeepGuideId = 7,
	RewardTaskId = 4,
	EndDeepHigh = 9,
	NormalDeepEpisodeId = 5,
	UnlockLayer = 1,
	ResultBossDescSucc = 11,
	HeroGroupSaveCount = 3,
	ResultBossDescFail = 10,
	StartDeepHigh = 8,
	EndlessDeepEpisodeId = 6,
	HeroGroupTeamNum = 2
}
TowerDeepEnum.TeamOperateType = {
	Load = 1,
	Save = 2
}
TowerDeepEnum.FightResult = {
	Succ = 1,
	Fail = 0,
	NotFinish = -1
}

return TowerDeepEnum
