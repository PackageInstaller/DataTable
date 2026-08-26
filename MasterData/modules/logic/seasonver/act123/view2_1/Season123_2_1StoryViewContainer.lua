-- chunkname: @modules/logic/seasonver/act123/view2_1/Season123_2_1StoryViewContainer.lua

module("modules.logic.seasonver.act123.view2_1.Season123_2_1StoryViewContainer", package.seeall)

local Season123_2_1StoryViewContainer = class("Season123_2_1StoryViewContainer", BaseViewContainer)

function Season123_2_1StoryViewContainer:buildViews()
	return {
		Season123_2_1StoryView.New(),
		TabViewGroup.New(1, "#go_LeftTop")
	}
end

function Season123_2_1StoryViewContainer:buildTabViews(tabContainerId)
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

function Season123_2_1StoryViewContainer:_overrideCloseFunc()
	self._views[1]._animView:Play(UIAnimationName.Close, 0, 0)
	TaskDispatcher.runDelay(self._doCloseView, self, 0.333)
end

function Season123_2_1StoryViewContainer:_doCloseView()
	self:closeThis()
end

function Season123_2_1StoryViewContainer:onContainerDestroy()
	TaskDispatcher.cancelTask(self._doCloseView, self)
end

return Season123_2_1StoryViewContainer
