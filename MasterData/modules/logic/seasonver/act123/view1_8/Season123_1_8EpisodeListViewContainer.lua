-- chunkname: @modules/logic/seasonver/act123/view1_8/Season123_1_8EpisodeListViewContainer.lua

module("modules.logic.seasonver.act123.view1_8.Season123_1_8EpisodeListViewContainer", package.seeall)

local Season123_1_8EpisodeListViewContainer = class("Season123_1_8EpisodeListViewContainer", BaseViewContainer)

function Season123_1_8EpisodeListViewContainer:buildViews()
	local views = {}

	self.episodeListView = Season123_1_8EpisodeListView.New()

	table.insert(views, Season123_1_8CheckCloseView.New())
	table.insert(views, self.episodeListView)
	table.insert(views, TabViewGroup.New(1, "top_left"))

	return views
end

function Season123_1_8EpisodeListViewContainer:buildTabViews(tabContainerId)
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

function Season123_1_8EpisodeListViewContainer:_overrideCloseFunc()
	self.episodeListView._viewAnimator:Play(UIAnimationName.Close, 0, 0)
	Season123Controller.instance:dispatchEvent(Season123Event.EnterEpiosdeList, false)
	TaskDispatcher.runDelay(self._doClose, self, 0.17)
end

function Season123_1_8EpisodeListViewContainer:_doClose()
	self:closeThis()
end

function Season123_1_8EpisodeListViewContainer:onContainerDestroy()
	TaskDispatcher.cancelTask(self._doClose, self)
end

return Season123_1_8EpisodeListViewContainer
