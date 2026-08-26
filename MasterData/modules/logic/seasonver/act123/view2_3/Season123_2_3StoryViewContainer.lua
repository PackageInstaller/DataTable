-- chunkname: @modules/logic/seasonver/act123/view2_3/Season123_2_3StoryViewContainer.lua

module("modules.logic.seasonver.act123.view2_3.Season123_2_3StoryViewContainer", package.seeall)

local Season123_2_3StoryViewContainer = class("Season123_2_3StoryViewContainer", BaseViewContainer)

function Season123_2_3StoryViewContainer:buildViews()
	return {
		Season123_2_3StoryView.New(),
		TabViewGroup.New(1, "#go_LeftTop")
	}
end

function Season123_2_3StoryViewContainer:buildTabViews(tabContainerId)
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

function Season123_2_3StoryViewContainer:_overrideCloseFunc()
	self._views[1]._animView:Play(UIAnimationName.Close, 0, 0)
	TaskDispatcher.runDelay(self._doCloseView, self, 0.333)
end

function Season123_2_3StoryViewContainer:_doCloseView()
	self:closeThis()
end

function Season123_2_3StoryViewContainer:onContainerDestroy()
	TaskDispatcher.cancelTask(self._doCloseView, self)
end

return Season123_2_3StoryViewContainer
