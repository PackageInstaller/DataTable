-- chunkname: @modules/logic/room/view/manufacture/RoomManufactureBuildingDetailViewContainer.lua

module("modules.logic.room.view.manufacture.RoomManufactureBuildingDetailViewContainer", package.seeall)

local RoomManufactureBuildingDetailViewContainer = class("RoomManufactureBuildingDetailViewContainer", BaseViewContainer)

function RoomManufactureBuildingDetailViewContainer:buildViews()
	local views = {}

	table.insert(views, RoomManufactureBuildingDetailView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function RoomManufactureBuildingDetailViewContainer:buildTabViews(tabContainerId)
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

return RoomManufactureBuildingDetailViewContainer
