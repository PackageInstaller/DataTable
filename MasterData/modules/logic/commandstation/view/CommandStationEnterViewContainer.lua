-- chunkname: @modules/logic/commandstation/view/CommandStationEnterViewContainer.lua

module("modules.logic.commandstation.view.CommandStationEnterViewContainer", package.seeall)

local CommandStationEnterViewContainer = class("CommandStationEnterViewContainer", BaseViewContainer)

function CommandStationEnterViewContainer:buildViews()
	return {
		CommandStationEnterView.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function CommandStationEnterViewContainer:playOpenTransition()
	local param

	CommandStationEnterViewContainer.super.playOpenTransition(self, (self.viewParam and self.viewParam.fromDungeonSectionItem or nil) and {
		anim = "open2"
	})
end

function CommandStationEnterViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.CommandStationEnter)

		return {
			self.navigateView
		}
	end
end

return CommandStationEnterViewContainer
