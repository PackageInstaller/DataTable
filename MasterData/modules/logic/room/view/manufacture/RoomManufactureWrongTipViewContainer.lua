-- chunkname: @modules/logic/room/view/manufacture/RoomManufactureWrongTipViewContainer.lua

module("modules.logic.room.view.manufacture.RoomManufactureWrongTipViewContainer", package.seeall)

local RoomManufactureWrongTipViewContainer = class("RoomManufactureWrongTipViewContainer", BaseViewContainer)

function RoomManufactureWrongTipViewContainer:buildViews()
	local views = {}

	table.insert(views, RoomManufactureWrongTipView.New())

	return views
end

return RoomManufactureWrongTipViewContainer
