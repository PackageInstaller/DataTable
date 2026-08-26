-- chunkname: @modules/logic/room/view/debug/RoomDebugBuildingAreaViewContainer.lua

module("modules.logic.room.view.debug.RoomDebugBuildingAreaViewContainer", package.seeall)

local RoomDebugBuildingAreaViewContainer = class("RoomDebugBuildingAreaViewContainer", BaseViewContainer)

function RoomDebugBuildingAreaViewContainer:buildViews()
	local views = {}

	table.insert(views, RoomDebugBuildingAreaView.New())

	return views
end

return RoomDebugBuildingAreaViewContainer
