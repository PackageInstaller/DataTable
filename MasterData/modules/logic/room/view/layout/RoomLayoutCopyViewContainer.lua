-- chunkname: @modules/logic/room/view/layout/RoomLayoutCopyViewContainer.lua

module("modules.logic.room.view.layout.RoomLayoutCopyViewContainer", package.seeall)

local RoomLayoutCopyViewContainer = class("RoomLayoutCopyViewContainer", BaseViewContainer)

function RoomLayoutCopyViewContainer:buildViews()
	local views = {}

	table.insert(views, RoomLayoutCopyView.New())

	return views
end

return RoomLayoutCopyViewContainer
