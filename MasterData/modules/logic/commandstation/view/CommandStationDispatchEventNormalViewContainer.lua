-- chunkname: @modules/logic/commandstation/view/CommandStationDispatchEventNormalViewContainer.lua

module("modules.logic.commandstation.view.CommandStationDispatchEventNormalViewContainer", package.seeall)

local CommandStationDispatchEventNormalViewContainer = class("CommandStationDispatchEventNormalViewContainer", BaseViewContainer)

function CommandStationDispatchEventNormalViewContainer:buildViews()
	local views = {}

	table.insert(views, CommandStationDispatchEventNormalView.New())
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	return views
end

function CommandStationDispatchEventNormalViewContainer:buildTabViews(tabContainerId)
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

return CommandStationDispatchEventNormalViewContainer
