-- chunkname: @modules/logic/versionactivity3_5/lorentz/view/LorentzGameViewContainer.lua

module("modules.logic.versionactivity3_5.lorentz.view.LorentzGameViewContainer", package.seeall)

local LorentzGameViewContainer = class("LorentzGameViewContainer", BaseViewContainer)

function LorentzGameViewContainer:buildViews()
	local views = {}

	table.insert(views, LorentzGameView.New())
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	return views
end

function LorentzGameViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			true
		}, HelpEnum.HelpId.Lorentz)

		self.navigateView:setOverrideClose(self._overrideCloseFunc, self)

		return {
			self.navigateView
		}
	end
end

function LorentzGameViewContainer:_overrideCloseFunc()
	LorentzStatHelper.instance:sendGameAbort()
	self:closeThis()
end

return LorentzGameViewContainer
