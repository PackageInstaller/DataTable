-- chunkname: @modules/logic/room/view/RoomBuildingInteractionViewContainer.lua

module("modules.logic.room.view.RoomBuildingInteractionViewContainer", package.seeall)

local RoomBuildingInteractionViewContainer = class("RoomBuildingInteractionViewContainer", BaseViewContainer)

function RoomBuildingInteractionViewContainer:buildViews()
	local views = {}

	table.insert(views, RoomBuildingInteractionView.New())

	return views
end

return RoomBuildingInteractionViewContainer
