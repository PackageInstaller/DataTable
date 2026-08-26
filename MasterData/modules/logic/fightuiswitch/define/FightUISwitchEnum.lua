-- chunkname: @modules/logic/fightuiswitch/define/FightUISwitchEnum.lua

module("modules.logic.fightuiswitch.define.FightUISwitchEnum", package.seeall)

local FightUISwitchEnum = _M

FightUISwitchEnum.StyleClassify = {
	FightCard = 2,
	FightFloat = 1
}
FightUISwitchEnum.StyleClassifyInfo = {
	[FightUISwitchEnum.StyleClassify.FightCard] = {
		Sort = 1,
		ClassifyTitle = "fightuiswitch_classify_2",
		SimpleProperty = PlayerEnum.SimpleProperty.FightUICardStyle,
		SubType = ItemEnum.SubType.FightCard
	},
	[FightUISwitchEnum.StyleClassify.FightFloat] = {
		Sort = 2,
		ClassifyTitle = "fightuiswitch_classify_1",
		SimpleProperty = PlayerEnum.SimpleProperty.FightUIFloatStyle,
		SubType = ItemEnum.SubType.FightFloatType
	}
}
FightUISwitchEnum.SceneRes = "ui/viewres/mainsceneswitch/%s.prefab"
FightUISwitchEnum.AnimKey = {
	Switch = "switch",
	Close = "close",
	Open = "open"
}
FightUISwitchEnum.SwitchAnimDelayTime = 0.16
FightUISwitchEnum.SwitchAnimTime = 3

return FightUISwitchEnum
