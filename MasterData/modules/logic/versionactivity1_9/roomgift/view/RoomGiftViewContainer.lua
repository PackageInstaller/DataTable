-- chunkname: @modules/logic/versionactivity1_9/roomgift/view/RoomGiftViewContainer.lua

module("modules.logic.versionactivity1_9.roomgift.view.RoomGiftViewContainer", package.seeall)

local RoomGiftViewContainer = class("RoomGiftViewContainer", BaseViewContainer)

function RoomGiftViewContainer:buildViews()
	local views = {}

	table.insert(views, RoomGiftView.New())

	return views
end

return RoomGiftViewContainer
