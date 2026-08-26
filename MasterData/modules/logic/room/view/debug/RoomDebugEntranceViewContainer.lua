-- chunkname: @modules/logic/room/view/debug/RoomDebugEntranceViewContainer.lua

module("modules.logic.room.view.debug.RoomDebugEntranceViewContainer", package.seeall)

local RoomDebugEntranceViewContainer = class("RoomDebugEntranceViewContainer", BaseViewContainer)

function RoomDebugEntranceViewContainer:buildViews()
	local views = {}

	table.insert(views, RoomDebugEntranceView.New())

	return views
end

function RoomDebugEntranceViewContainer:onContainerClickModalMask()
	if RoomController.instance:isEditorMode() then
		return
	end

	self:closeThis()
end

return RoomDebugEntranceViewContainer
