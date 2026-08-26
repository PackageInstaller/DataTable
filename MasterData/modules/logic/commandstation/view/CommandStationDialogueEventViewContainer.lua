-- chunkname: @modules/logic/commandstation/view/CommandStationDialogueEventViewContainer.lua

module("modules.logic.commandstation.view.CommandStationDialogueEventViewContainer", package.seeall)

local CommandStationDialogueEventViewContainer = class("CommandStationDialogueEventViewContainer", BaseViewContainer)

function CommandStationDialogueEventViewContainer:buildViews()
	local views = {}

	table.insert(views, CommandStationDialogueEventView.New())
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	return views
end

function CommandStationDialogueEventViewContainer:buildTabViews(tabContainerId)
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

return CommandStationDialogueEventViewContainer
