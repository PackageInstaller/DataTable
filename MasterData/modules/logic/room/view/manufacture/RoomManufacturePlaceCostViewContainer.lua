-- chunkname: @modules/logic/room/view/manufacture/RoomManufacturePlaceCostViewContainer.lua

module("modules.logic.room.view.manufacture.RoomManufacturePlaceCostViewContainer", package.seeall)

local RoomManufacturePlaceCostViewContainer = class("RoomManufacturePlaceCostViewContainer", BaseViewContainer)

function RoomManufacturePlaceCostViewContainer:buildViews()
	local views = {}

	table.insert(views, RoomManufacturePlaceCostView.New())

	return views
end

return RoomManufacturePlaceCostViewContainer
