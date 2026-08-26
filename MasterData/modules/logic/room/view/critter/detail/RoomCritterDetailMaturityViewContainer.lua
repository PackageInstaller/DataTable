-- chunkname: @modules/logic/room/view/critter/detail/RoomCritterDetailMaturityViewContainer.lua

module("modules.logic.room.view.critter.detail.RoomCritterDetailMaturityViewContainer", package.seeall)

local RoomCritterDetailMaturityViewContainer = class("RoomCritterDetailMaturityViewContainer", BaseViewContainer)

function RoomCritterDetailMaturityViewContainer:buildViews()
	local views = {}

	table.insert(views, RoomCritterDetailMaturityView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function RoomCritterDetailMaturityViewContainer:buildTabViews(tabContainerId)
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

return RoomCritterDetailMaturityViewContainer
