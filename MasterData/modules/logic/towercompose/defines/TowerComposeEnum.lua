-- chunkname: @modules/logic/towercompose/defines/TowerComposeEnum.lua

module("modules.logic.towercompose.defines.TowerComposeEnum", package.seeall)

local TowerComposeEnum = _M

TowerComposeEnum.DefaultThemeAndLayer = "1#1"
TowerComposeEnum.scrollCategoryHeight = 950
TowerComposeEnum.FirstPlaneGuide = 33058
TowerComposeEnum.SecondPlaneGuide = 33056
TowerComposeEnum.TowerMainType = {
	OldTower = 1,
	NewTower = 2
}
TowerComposeEnum.LocalPrefsKey = {
	TowerComposeUpdateTheme = "TowerComposeUpdateTheme",
	LocalThemeAndLayerId = "TowerLocalThemeAndLayerId",
	PopUpThemeEnvView = "TowerPopUpThemeEnvView",
	LocalThemePlaneBuffData = "TowerLocalThemePlaneBuffData"
}
TowerComposeEnum.ModType = {
	Env = 3,
	Body = 1,
	Word = 2,
	None = 0
}
TowerComposeEnum.PlaneType = {
	Once = 1,
	Twice = 2,
	None = 0
}
TowerComposeEnum.TaskType = {
	Research = 3,
	LimitTime = 2,
	Normal = 1
}
TowerComposeEnum.TeamBuffType = {
	Research = 2,
	Support = 1,
	Cloth = 3
}
TowerComposeEnum.JumpId = {
	TowerComposeMain = 1,
	TowerComposeModEquip = 5,
	TowerModeSelect = 2,
	TowerComposeTheme = 4,
	TowerComposePlane = 3
}
TowerComposeEnum.ConstId = {
	ModEquipRuleDesc = 9,
	ResearchExLevel2 = 4,
	SupportRoleDesc = 3,
	ExtraRoleDesc = 2,
	IgnoreCalPointBaseModList = 12,
	MaxResearchProgress = 1,
	ResearchExLevel1 = 5
}
TowerComposeEnum.ActiveType = {
	Passive = 2,
	Active = 1
}
TowerComposeEnum.FightResult = {
	Win = 1,
	Fail = 2,
	None = 0
}
TowerComposeEnum.TeamOperateType = {
	Load = 1,
	Save = 2
}
TowerComposeEnum.SaveTeamState = {
	Record = 1,
	Current = 2
}

return TowerComposeEnum
