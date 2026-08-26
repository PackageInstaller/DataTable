-- chunkname: @modules/logic/room/view/manufacture/RoomManufactureGetViewContainer.lua

module("modules.logic.room.view.manufacture.RoomManufactureGetViewContainer", package.seeall)

local RoomManufactureGetViewContainer = class("RoomManufactureGetViewContainer", BaseViewContainer)

function RoomManufactureGetViewContainer:buildViews()
	local views = {}

	table.insert(views, RoomManufactureGetView.New())

	return views
end

return RoomManufactureGetViewContainer
