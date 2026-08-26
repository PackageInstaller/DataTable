-- chunkname: @modules/logic/udimo/view/UdimoMainViewContainer.lua

module("modules.logic.udimo.view.UdimoMainViewContainer", package.seeall)

local UdimoMainViewContainer = class("UdimoMainViewContainer", BaseViewContainer)

function UdimoMainViewContainer:buildViews()
	local views = {}

	self.mainView = UdimoMainView.New()

	table.insert(views, self.mainView)
	table.insert(views, TabViewGroup.New(1, "#go_main/#go_topleft"))

	return views
end

function UdimoMainViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		}, nil, self._closeCallback, nil, nil, self)

		return {
			self.navigateView
		}
	end
end

function UdimoMainViewContainer:_closeCallback()
	UdimoController.instance:exitUdimo()
end

function UdimoMainViewContainer:playCloseTransition()
	self.mainView:playAnim(UIAnimationName.Close, self.onPlayCloseTransitionFinish, self)
end

return UdimoMainViewContainer
