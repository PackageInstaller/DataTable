-- chunkname: @modules/logic/room/view/manufacture/RoomCritterOneKeyViewContainer.lua

module("modules.logic.room.view.manufacture.RoomCritterOneKeyViewContainer", package.seeall)

local RoomCritterOneKeyViewContainer = class("RoomCritterOneKeyViewContainer", BaseViewContainer)

function RoomCritterOneKeyViewContainer:buildViews()
	local views = {}

	table.insert(views, RoomCritterOneKeyView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function RoomCritterOneKeyViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self.navigateView
		}
	end
end

return RoomCritterOneKeyViewContainer
