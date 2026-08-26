-- chunkname: @modules/logic/room/view/RoomBranchViewContainer.lua

module("modules.logic.room.view.RoomBranchViewContainer", package.seeall)

local RoomBranchViewContainer = class("RoomBranchViewContainer", BaseViewContainer)

function RoomBranchViewContainer:buildViews()
	local views = {}

	table.insert(views, RoomBranchView.New())

	return views
end

return RoomBranchViewContainer
