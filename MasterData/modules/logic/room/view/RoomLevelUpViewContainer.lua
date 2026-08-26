-- chunkname: @modules/logic/room/view/RoomLevelUpViewContainer.lua

module("modules.logic.room.view.RoomLevelUpViewContainer", package.seeall)

local RoomLevelUpViewContainer = class("RoomLevelUpViewContainer", BaseViewContainer)

function RoomLevelUpViewContainer:buildViews()
	local views = {}

	table.insert(views, RoomLevelUpView.New())
	table.insert(views, RoomViewTopRight.New())

	return views
end

function RoomLevelUpViewContainer:onContainerClickModalMask()
	ViewMgr.instance:closeView(ViewName.RoomLevelUpView, nil, true)
end

return RoomLevelUpViewContainer
