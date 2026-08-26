-- chunkname: @modules/logic/room/view/building/RoomStrengthViewContainer.lua

module("modules.logic.room.view.building.RoomStrengthViewContainer", package.seeall)

local RoomStrengthViewContainer = class("RoomStrengthViewContainer", BaseViewContainer)

function RoomStrengthViewContainer:buildViews()
	local views = {}

	table.insert(views, RoomStrengthView.New())

	return views
end

function RoomStrengthViewContainer:onContainerClickModalMask()
	self:closeThis()
end

return RoomStrengthViewContainer
