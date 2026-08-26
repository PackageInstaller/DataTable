-- chunkname: @modules/logic/room/view/manufacture/RoomManufactureAccelerateViewContainer.lua

module("modules.logic.room.view.manufacture.RoomManufactureAccelerateViewContainer", package.seeall)

local RoomManufactureAccelerateViewContainer = class("RoomManufactureAccelerateViewContainer", BaseViewContainer)

function RoomManufactureAccelerateViewContainer:buildViews()
	local views = {}

	table.insert(views, RoomManufactureAccelerateView.New())

	return views
end

return RoomManufactureAccelerateViewContainer
