-- chunkname: @modules/logic/room/view/debug/RoomDebugSelectPackageViewContainer.lua

module("modules.logic.room.view.debug.RoomDebugSelectPackageViewContainer", package.seeall)

local RoomDebugSelectPackageViewContainer = class("RoomDebugSelectPackageViewContainer", BaseViewContainer)

function RoomDebugSelectPackageViewContainer:buildViews()
	local views = {}

	table.insert(views, RoomDebugSelectPackageView.New())

	return views
end

function RoomDebugSelectPackageViewContainer:onContainerClickModalMask()
	self:closeThis()
end

return RoomDebugSelectPackageViewContainer
