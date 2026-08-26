-- chunkname: @modules/logic/bgmswitch/define/BGMSwitchEnum.lua

module("modules.logic.bgmswitch.define.BGMSwitchEnum", package.seeall)

local BGMSwitchEnum = _M

BGMSwitchEnum.PlayMode = {
	LoopOne = 2,
	Random = 1,
	None = 0
}
BGMSwitchEnum.PlayingState = {
	FoldPlaying = 1,
	UnfoldPlaying = 2,
	None = 0
}
BGMSwitchEnum.Gear = {
	On2 = 2,
	OFF = 0,
	On1 = 1,
	On3 = 3
}
BGMSwitchEnum.BGMDetailShowType = {
	Introduce = 2,
	Comment = 3,
	Progress = 1,
	None = 0
}
BGMSwitchEnum.SelectType = {
	All = 0,
	Loved = 1
}
BGMSwitchEnum.EasterEggType = {
	Beat = 1,
	Ppt = 2
}
BGMSwitchEnum.RecordInfoType = {
	SwitchEgg = 2,
	BGMSwitchGear = 3,
	ListType = 1
}
BGMSwitchEnum.BGMGuideId = 19401

return BGMSwitchEnum
