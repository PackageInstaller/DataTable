-- chunkname: @modules/logic/room/view/critter/detail/RoomCritterDetailYoungViewContainer.lua

module("modules.logic.room.view.critter.detail.RoomCritterDetailYoungViewContainer", package.seeall)

local RoomCritterDetailYoungViewContainer = class("RoomCritterDetailYoungViewContainer", BaseViewContainer)

function RoomCritterDetailYoungViewContainer:buildViews()
	local views = {}

	table.insert(views, RoomCritterDetailYoungView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function RoomCritterDetailYoungViewContainer:buildTabViews(tabContainerId)
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

return RoomCritterDetailYoungViewContainer
