-- chunkname: @modules/logic/room/view/layout/RoomLayoutCreateTipsViewContainer.lua

module("modules.logic.room.view.layout.RoomLayoutCreateTipsViewContainer", package.seeall)

local RoomLayoutCreateTipsViewContainer = class("RoomLayoutCreateTipsViewContainer", BaseViewContainer)

function RoomLayoutCreateTipsViewContainer:buildViews()
	local views = {}

	table.insert(views, RoomLayoutCreateTipsView.New())

	return views
end

return RoomLayoutCreateTipsViewContainer
