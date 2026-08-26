-- chunkname: @modules/logic/room/define/RoomSceneTaskEnum.lua

module("modules.logic.room.define.RoomSceneTaskEnum", package.seeall)

local RoomSceneTaskEnum = _M

RoomSceneTaskEnum.ListenerType = {
	EditResTypeReach = "EditMainResBlockCount",
	EditHasResBlockCount = "EditHasResBlockCount",
	BuildingUseCount = "BuildingUseCount",
	RoomLevel = "RoomLevel",
	BuildingDegree = "BuildingDegree",
	EditResArea = "EditBlockCount"
}
RoomSceneTaskEnum.TaskSymbolRes = {
	"resource_0",
	"resource_1",
	"resource_2",
	"resource_3",
	"resource_4"
}
RoomSceneTaskEnum.AnimName = {
	Play = "switch",
	Hide = "close",
	Show = "open"
}
RoomSceneTaskEnum.AnimEventName = {
	PlayFinish = "SwitchFinish",
	ShowFinish = "ShowFinish",
	HideFinish = "CloseFinish"
}
RoomSceneTaskEnum.RoomLevelUpItem = 190010

return RoomSceneTaskEnum
