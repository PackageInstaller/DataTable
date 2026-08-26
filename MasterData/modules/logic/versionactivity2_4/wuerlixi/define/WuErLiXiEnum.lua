-- chunkname: @modules/logic/versionactivity2_4/wuerlixi/define/WuErLiXiEnum.lua

module("modules.logic.versionactivity2_4.wuerlixi.define.WuErLiXiEnum", package.seeall)

local WuErLiXiEnum = _M

WuErLiXiEnum.EpisodeStatus = {
	BeforeStory = 0,
	MapGame = 1,
	Finished = 3,
	AfterStory = 2
}
WuErLiXiEnum.Dir = {
	Down = 2,
	Up = 0,
	Right = 1,
	Left = 3
}
WuErLiXiEnum.UnitType = {
	Reflection = 5,
	KeyStart = 2,
	Obstacle = 4,
	SignalStart = 1,
	Switch = 7,
	SignalMulti = 6,
	SignalEnd = 3,
	Key = 8
}
WuErLiXiEnum.UnitTypeToName = {}

for name, index in pairs(WuErLiXiEnum.UnitType) do
	WuErLiXiEnum.UnitTypeToName[index] = name
end

WuErLiXiEnum.NodeType = {
	Placeable = 1,
	UnPlaceable = 2
}
WuErLiXiEnum.RayType = {
	SwitchSignal = 2,
	NormalSignal = 1
}
WuErLiXiEnum.GameMapNodeWidth = 84

return WuErLiXiEnum
