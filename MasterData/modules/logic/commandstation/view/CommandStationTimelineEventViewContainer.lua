-- chunkname: @modules/logic/commandstation/view/CommandStationTimelineEventViewContainer.lua

module("modules.logic.commandstation.view.CommandStationTimelineEventViewContainer", package.seeall)

local CommandStationTimelineEventViewContainer = class("CommandStationTimelineEventViewContainer", BaseViewContainer)

function CommandStationTimelineEventViewContainer:buildViews()
	local views = {}

	table.insert(views, CommandStationTimelineEventView.New())
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	return views
end

function CommandStationTimelineEventViewContainer:buildTabViews(tabContainerId)
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

return CommandStationTimelineEventViewContainer
