-- chunkname: @modules/logic/room/view/RoomBuildingFilterViewContainer.lua

module("modules.logic.room.view.RoomBuildingFilterViewContainer", package.seeall)

local RoomBuildingFilterViewContainer = class("RoomBuildingFilterViewContainer", BaseViewContainer)

function RoomBuildingFilterViewContainer:buildViews()
	local views = {}

	table.insert(views, RoomBuildingFilterView.New())

	return views
end

function RoomBuildingFilterViewContainer:onContainerClickModalMask()
	self:closeThis()
end

return RoomBuildingFilterViewContainer
