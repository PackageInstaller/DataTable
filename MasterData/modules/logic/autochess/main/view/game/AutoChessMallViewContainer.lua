-- chunkname: @modules/logic/autochess/main/view/game/AutoChessMallViewContainer.lua

module("modules.logic.autochess.main.view.game.AutoChessMallViewContainer", package.seeall)

local AutoChessMallViewContainer = class("AutoChessMallViewContainer", BaseViewContainer)

function AutoChessMallViewContainer:buildViews()
	local views = {}

	self.mallView = AutoChessMallView.New()

	table.insert(views, self.mallView)
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function AutoChessMallViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			true
		}, 3207003)

		self.navigateView:setOverrideClose(self.mallView._overrideClose, self.mallView)

		return {
			self.navigateView
		}
	end
end

return AutoChessMallViewContainer
