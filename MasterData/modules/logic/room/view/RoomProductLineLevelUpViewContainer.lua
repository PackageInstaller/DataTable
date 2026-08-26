-- chunkname: @modules/logic/room/view/RoomProductLineLevelUpViewContainer.lua

module("modules.logic.room.view.RoomProductLineLevelUpViewContainer", package.seeall)

local RoomProductLineLevelUpViewContainer = class("RoomProductLineLevelUpViewContainer", BaseViewContainer)

function RoomProductLineLevelUpViewContainer:buildViews()
	local views = {}

	table.insert(views, RoomProductLineLevelUpView.New())

	return views
end

function RoomProductLineLevelUpViewContainer:onContainerClickModalMask()
	ViewMgr.instance:closeView(ViewName.RoomProductLineLevelUpView, nil, true)
end

return RoomProductLineLevelUpViewContainer
