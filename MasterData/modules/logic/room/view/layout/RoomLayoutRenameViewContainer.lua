-- chunkname: @modules/logic/room/view/layout/RoomLayoutRenameViewContainer.lua

module("modules.logic.room.view.layout.RoomLayoutRenameViewContainer", package.seeall)

local RoomLayoutRenameViewContainer = class("RoomLayoutRenameViewContainer", BaseViewContainer)

function RoomLayoutRenameViewContainer:buildViews()
	local views = {}

	table.insert(views, RoomLayoutRenameView.New())

	return views
end

return RoomLayoutRenameViewContainer
