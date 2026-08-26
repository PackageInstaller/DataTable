-- chunkname: @modules/logic/room/view/RoomSceneTaskDetailViewContainer.lua

module("modules.logic.room.view.RoomSceneTaskDetailViewContainer", package.seeall)

local RoomSceneTaskDetailViewContainer = class("RoomSceneTaskDetailViewContainer", BaseViewContainer)

function RoomSceneTaskDetailViewContainer:buildViews()
	local views = {}

	table.insert(views, RoomSceneTaskDetailView.New())
	table.insert(views, RoomViewTopRight.New())

	return views
end

function RoomSceneTaskDetailViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self._navigateButtonView
		}
	end
end

function RoomSceneTaskDetailViewContainer:onContainerClickModalMask()
	self:closeThis()
end

return RoomSceneTaskDetailViewContainer
