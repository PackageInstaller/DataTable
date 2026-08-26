-- chunkname: @modules/logic/commandstation/view/CommandStationRelationShipDetailContainer.lua

module("modules.logic.commandstation.view.CommandStationRelationShipDetailContainer", package.seeall)

local CommandStationRelationShipDetailContainer = class("CommandStationRelationShipDetailContainer", BaseViewContainer)

function CommandStationRelationShipDetailContainer:buildViews()
	local views = {}

	table.insert(views, CommandStationRelationShipDetail.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function CommandStationRelationShipDetailContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			self.navigateView
		}
	end
end

return CommandStationRelationShipDetailContainer
