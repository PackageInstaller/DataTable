-- chunkname: @modules/logic/abyss/define/AbyssEnum.lua

module("modules.logic.abyss.define.AbyssEnum", package.seeall)

local AbyssEnum = _M

AbyssEnum.MaxTaskStar = 1
AbyssEnum.ConstId = {
	ActId = 2,
	TargetBonus = 1
}
AbyssEnum.UIBlockKey = {
	EnterView = "AbyssEnterViewBlock",
	MainView = "AbyssMainViewBlock"
}
AbyssEnum.Color = {
	HaveChallenge = "#7275FF",
	NotChallenge = "#FFFFFF"
}
AbyssEnum.TxtParam = {
	ReStartChallenge = "p_cloudredemption_detailsview_txt2",
	StartChallenge = "p_cloudredemption_detailsview_txt1"
}
AbyssEnum.ViewOutTime = {
	EnterView = 0.33,
	MainView = 0.167
}
AbyssEnum.HeroState = {
	IsUsed = 2,
	NoUsed = 1,
	Empty = 0
}
AbyssEnum.HeroMaxCount = 4

return AbyssEnum
