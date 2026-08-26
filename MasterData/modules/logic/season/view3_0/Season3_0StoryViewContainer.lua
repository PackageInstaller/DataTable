-- chunkname: @modules/logic/season/view3_0/Season3_0StoryViewContainer.lua

module("modules.logic.season.view3_0.Season3_0StoryViewContainer", package.seeall)

local Season3_0StoryViewContainer = class("Season3_0StoryViewContainer", BaseViewContainer)

function Season3_0StoryViewContainer:buildViews()
	return {
		Season3_0StoryView.New(),
		TabViewGroup.New(1, "#go_LeftTop")
	}
end

function Season3_0StoryViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		self._navigateButtonView:setOverrideClose(self._overrideCloseFunc, self)

		return {
			self._navigateButtonView
		}
	end
end

function Season3_0StoryViewContainer:_overrideCloseFunc()
	self._views[1]._animView:Play(UIAnimationName.Close, 0, 0)
	TaskDispatcher.runDelay(self._doCloseView, self, 0.333)
end

function Season3_0StoryViewContainer:_doCloseView()
	self:closeThis()
end

function Season3_0StoryViewContainer:onContainerDestroy()
	TaskDispatcher.cancelTask(self._doCloseView, self)
end

return Season3_0StoryViewContainer
