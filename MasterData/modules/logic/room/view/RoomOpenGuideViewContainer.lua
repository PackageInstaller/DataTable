-- chunkname: @modules/logic/room/view/RoomOpenGuideViewContainer.lua

module("modules.logic.room.view.RoomOpenGuideViewContainer", package.seeall)

local RoomOpenGuideViewContainer = class("RoomOpenGuideViewContainer", BaseViewContainer)

function RoomOpenGuideViewContainer:buildViews()
	local views = {}

	table.insert(views, RoomOpenGuideView.New())

	return views
end

return RoomOpenGuideViewContainer
