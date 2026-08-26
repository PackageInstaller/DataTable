-- chunkname: @modules/logic/seasonver/act123/view3_5/Season123_3_5EpisodeListViewContainer.lua

module("modules.logic.seasonver.act123.view3_5.Season123_3_5EpisodeListViewContainer", package.seeall)

local Season123_3_5EpisodeListViewContainer = class("Season123_3_5EpisodeListViewContainer", BaseViewContainer)

function Season123_3_5EpisodeListViewContainer:buildViews()
	local views = {}

	self.episodeListView = Season123_3_5EpisodeListView.New()

	table.insert(views, Season123_3_5CheckCloseView.New())
	table.insert(views, self.episodeListView)
	table.insert(views, TabViewGroup.New(1, "top_left"))
	table.insert(views, TabViewGroup.New(2, "#go_carddetail"))

	return views
end

function Season123_3_5EpisodeListViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.Season3_5MainViewHelp)

		self._navigateButtonView:setOverrideClose(self._overrideCloseFunc, self)

		return {
			self._navigateButtonView
		}
	end

	if tabContainerId == 2 then
		return {
			Season123_3_5CardDetailView.New()
		}
	end
end

function Season123_3_5EpisodeListViewContainer:_overrideCloseFunc()
	self.episodeListView._viewAnimator:Play(UIAnimationName.Close, 0, 0)
	Season123Controller.instance:dispatchEvent(Season123Event.EnterEpiosdeList, false)
	TaskDispatcher.runDelay(self._doClose, self, 0.17)
end

function Season123_3_5EpisodeListViewContainer:_doClose()
	self:closeThis()
end

function Season123_3_5EpisodeListViewContainer:onContainerDestroy()
	TaskDispatcher.cancelTask(self._doClose, self)
end

return Season123_3_5EpisodeListViewContainer
