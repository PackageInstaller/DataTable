-- chunkname: @modules/logic/room/view/debug/RoomDebugBuildingCameraViewContainer.lua

module("modules.logic.room.view.debug.RoomDebugBuildingCameraViewContainer", package.seeall)

local RoomDebugBuildingCameraViewContainer = class("RoomDebugBuildingCameraViewContainer", BaseViewContainer)

function RoomDebugBuildingCameraViewContainer:buildViews()
	local views = {}

	table.insert(views, RoomDebugBuildingCameraView.New())

	return views
end

return RoomDebugBuildingCameraViewContainer
