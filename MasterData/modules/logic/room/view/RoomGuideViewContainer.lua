-- chunkname: @modules/logic/room/view/RoomGuideViewContainer.lua

module("modules.logic.room.view.RoomGuideViewContainer", package.seeall)

local RoomGuideViewContainer = class("RoomGuideViewContainer", BaseViewContainer)

function RoomGuideViewContainer:buildViews()
	local views = {}

	table.insert(views, RoomGuideView.New())

	return views
end

return RoomGuideViewContainer
