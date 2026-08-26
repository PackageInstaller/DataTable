-- chunkname: @modules/logic/roomfishing/view/RoomFishingStoreViewContainer.lua

module("modules.logic.roomfishing.view.RoomFishingStoreViewContainer", package.seeall)

local RoomFishingStoreViewContainer = class("RoomFishingStoreViewContainer", BaseViewContainer)

function RoomFishingStoreViewContainer:buildViews()
	local views = {}

	table.insert(views, RoomFishingStoreView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function RoomFishingStoreViewContainer:buildTabViews(tabContainerId)
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

return RoomFishingStoreViewContainer
