-- chunkname: @modules/logic/seasonver/act123/view1_8/Season123_1_8StoryViewContainer.lua

module("modules.logic.seasonver.act123.view1_8.Season123_1_8StoryViewContainer", package.seeall)

local Season123_1_8StoryViewContainer = class("Season123_1_8StoryViewContainer", BaseViewContainer)

function Season123_1_8StoryViewContainer:buildViews()
	return {
		Season123_1_8StoryView.New(),
		TabViewGroup.New(1, "#go_LeftTop")
	}
end

function Season123_1_8StoryViewContainer:buildTabViews(tabContainerId)
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

function Season123_1_8StoryViewContainer:_overrideCloseFunc()
	self._views[1]._animView:Play(UIAnimationName.Close, 0, 0)
	TaskDispatcher.runDelay(self._doCloseView, self, 0.333)
end

function Season123_1_8StoryViewContainer:_doCloseView()
	self:closeThis()
end

function Season123_1_8StoryViewContainer:onContainerDestroy()
	TaskDispatcher.cancelTask(self._doCloseView, self)
end

return Season123_1_8StoryViewContainer
