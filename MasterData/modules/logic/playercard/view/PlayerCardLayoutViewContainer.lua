-- chunkname: @modules/logic/playercard/view/PlayerCardLayoutViewContainer.lua

module("modules.logic.playercard.view.PlayerCardLayoutViewContainer", package.seeall)

local PlayerCardLayoutViewContainer = class("PlayerCardLayoutViewContainer", BaseViewContainer)

function PlayerCardLayoutViewContainer:buildViews()
	local views = {}

	self.layoutView = PlayerCardLayoutView.New()

	table.insert(views, self.layoutView)
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	return views
end

function PlayerCardLayoutViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		self.navigateView:setOverrideClose(self._closeFunc, self)

		return {
			self.navigateView
		}
	end
end

function PlayerCardLayoutViewContainer:_closeFunc()
	if self.layoutView then
		self.layoutView:playCloseAnim()
	end
end

return PlayerCardLayoutViewContainer
