-- chunkname: @modules/logic/room/view/building/RoomCommonStrengthViewContainer.lua

module("modules.logic.room.view.building.RoomCommonStrengthViewContainer", package.seeall)

local RoomCommonStrengthViewContainer = class("RoomCommonStrengthViewContainer", BaseViewContainer)

function RoomCommonStrengthViewContainer:buildViews()
	local views = {}

	table.insert(views, RoomCommonStrengthView.New())
	table.insert(views, RoomViewTopRight.New("#go_topright", self._viewSetting.otherRes[1], {
		{
			strengthId = 190007,
			strengthShowType = 0,
			classDefine = RoomViewTopRightStrengthItem
		},
		{
			strengthId = 190008,
			strengthShowType = 1,
			classDefine = RoomViewTopRightStrengthItem
		}
	}))

	return views
end

function RoomCommonStrengthViewContainer:onContainerClickModalMask()
	return
end

return RoomCommonStrengthViewContainer
