-- chunkname: @modules/logic/room/view/layout/RoomLayoutFindShareViewContainer.lua

module("modules.logic.room.view.layout.RoomLayoutFindShareViewContainer", package.seeall)

local RoomLayoutFindShareViewContainer = class("RoomLayoutFindShareViewContainer", BaseViewContainer)

function RoomLayoutFindShareViewContainer:buildViews()
	local views = {}

	table.insert(views, RoomLayoutFindShareView.New())

	return views
end

return RoomLayoutFindShareViewContainer
