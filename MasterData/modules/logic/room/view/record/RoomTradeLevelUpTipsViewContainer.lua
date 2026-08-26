-- chunkname: @modules/logic/room/view/record/RoomTradeLevelUpTipsViewContainer.lua

module("modules.logic.room.view.record.RoomTradeLevelUpTipsViewContainer", package.seeall)

local RoomTradeLevelUpTipsViewContainer = class("RoomTradeLevelUpTipsViewContainer", BaseViewContainer)

function RoomTradeLevelUpTipsViewContainer:buildViews()
	local views = {}

	table.insert(views, RoomTradeLevelUpTipsView.New())

	return views
end

return RoomTradeLevelUpTipsViewContainer
