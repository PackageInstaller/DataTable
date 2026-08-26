-- chunkname: @modules/logic/sp01/assassin2/outside/view/AssassinStealthGameViewContainer.lua

module("modules.logic.sp01.assassin2.outside.view.AssassinStealthGameViewContainer", package.seeall)

local AssassinStealthGameViewContainer = class("AssassinStealthGameViewContainer", BaseViewContainer)

function AssassinStealthGameViewContainer:buildViews()
	local views = {}

	table.insert(views, AssassinStealthGameView.New())
	table.insert(views, TabViewGroup.New(1, "root/#go_topleft"))

	return views
end

function AssassinStealthGameViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			true
		}, HelpEnum.HelpId.AssassinStealthGame)

		self.navigateView:setOverrideClose(self.overrideCloseFunc, self)

		return {
			self.navigateView
		}
	end
end

function AssassinStealthGameViewContainer:overrideCloseFunc()
	AssassinController.instance:openAssassinStealthGamePauseView()
end

return AssassinStealthGameViewContainer
