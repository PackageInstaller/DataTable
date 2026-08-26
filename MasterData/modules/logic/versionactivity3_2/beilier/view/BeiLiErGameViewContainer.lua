-- chunkname: @modules/logic/versionactivity3_2/beilier/view/BeiLiErGameViewContainer.lua

module("modules.logic.versionactivity3_2.beilier.view.BeiLiErGameViewContainer", package.seeall)

local BeiLiErGameViewContainer = class("BeiLiErGameViewContainer", BaseViewContainer)

function BeiLiErGameViewContainer:buildViews()
	local views = {}

	table.insert(views, BeiLiErGameView.New())
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	return views
end

function BeiLiErGameViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		self.navigateView:setOverrideClose(self._overrideCloseFunc, self)

		return {
			self.navigateView
		}
	end
end

function BeiLiErGameViewContainer:_overrideCloseFunc()
	BeiLiErStatHelper.instance:sendGameAbort()
	self:closeThis()
end

return BeiLiErGameViewContainer
