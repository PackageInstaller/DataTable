-- chunkname: @modules/logic/versionactivity2_3/act174/view/outside/Act174RotationViewContainer.lua

module("modules.logic.versionactivity2_3.act174.view.outside.Act174RotationViewContainer", package.seeall)

local Act174RotationViewContainer = class("Act174RotationViewContainer", BaseViewContainer)

function Act174RotationViewContainer:buildViews()
	self.view = Act174RotationView.New()

	local views = {}

	table.insert(views, self.view)
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function Act174RotationViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self.navigateView
		}
	end
end

function Act174RotationViewContainer:playCloseTransition()
	self.view.anim:Play(UIAnimationName.Close)
	TaskDispatcher.runDelay(self.onPlayCloseTransitionFinish, self, 0.3)
end

return Act174RotationViewContainer
