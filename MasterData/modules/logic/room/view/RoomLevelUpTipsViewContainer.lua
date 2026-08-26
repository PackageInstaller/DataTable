-- chunkname: @modules/logic/room/view/RoomLevelUpTipsViewContainer.lua

module("modules.logic.room.view.RoomLevelUpTipsViewContainer", package.seeall)

local RoomLevelUpTipsViewContainer = class("RoomLevelUpTipsViewContainer", BaseViewContainer)

function RoomLevelUpTipsViewContainer:buildViews()
	local views = {}

	table.insert(views, RoomLevelUpTipsView.New())

	return views
end

function RoomLevelUpTipsViewContainer:onContainerClickModalMask()
	self:closeThis()
end

return RoomLevelUpTipsViewContainer
