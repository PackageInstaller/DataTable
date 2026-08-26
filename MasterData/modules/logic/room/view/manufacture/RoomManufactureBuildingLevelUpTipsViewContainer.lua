-- chunkname: @modules/logic/room/view/manufacture/RoomManufactureBuildingLevelUpTipsViewContainer.lua

module("modules.logic.room.view.manufacture.RoomManufactureBuildingLevelUpTipsViewContainer", package.seeall)

local RoomManufactureBuildingLevelUpTipsViewContainer = class("RoomManufactureBuildingLevelUpTipsViewContainer", BaseViewContainer)

function RoomManufactureBuildingLevelUpTipsViewContainer:buildViews()
	local views = {}

	table.insert(views, RoomManufactureBuildingLevelUpTipsView.New())

	return views
end

return RoomManufactureBuildingLevelUpTipsViewContainer
