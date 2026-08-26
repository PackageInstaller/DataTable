-- chunkname: @modules/logic/room/view/critter/RoomCritterTrainEventViewContainer.lua

module("modules.logic.room.view.critter.RoomCritterTrainEventViewContainer", package.seeall)

local RoomCritterTrainEventViewContainer = class("RoomCritterTrainEventViewContainer", BaseViewContainer)

function RoomCritterTrainEventViewContainer:buildViews()
	local views = {}

	table.insert(views, RoomCritterTrainEventView.New())
	table.insert(views, TabViewGroup.New(1, "#go_BackBtns"))

	return views
end

function RoomCritterTrainEventViewContainer:buildTabViews(tabContainerId)
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

function RoomCritterTrainEventViewContainer:_onCurrencyOpen()
	logError("_onCurrencyOpen")
end

return RoomCritterTrainEventViewContainer
