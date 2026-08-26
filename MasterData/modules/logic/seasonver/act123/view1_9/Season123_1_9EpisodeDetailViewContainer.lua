-- chunkname: @modules/logic/seasonver/act123/view1_9/Season123_1_9EpisodeDetailViewContainer.lua

module("modules.logic.seasonver.act123.view1_9.Season123_1_9EpisodeDetailViewContainer", package.seeall)

local Season123_1_9EpisodeDetailViewContainer = class("Season123_1_9EpisodeDetailViewContainer", BaseViewContainer)

function Season123_1_9EpisodeDetailViewContainer:buildViews()
	local views = {}

	table.insert(views, Season123_1_9CheckCloseView.New())
	table.insert(views, Season123_1_9EpisodeDetailView.New())
	table.insert(views, TabViewGroup.New(1, "#go_info/#go_btns"))

	return views
end

function Season123_1_9EpisodeDetailViewContainer:buildTabViews(tabContainerId)
	self._navigateButtonView = NavigateButtonsView.New({
		true,
		true,
		false
	}, 100, self._closeCallback, self._homeCallback, nil, self)

	return {
		self._navigateButtonView
	}
end

function Season123_1_9EpisodeDetailViewContainer:_closeCallback()
	self:closeThis()
end

function Season123_1_9EpisodeDetailViewContainer:_homeCallback()
	self:closeThis()
end

return Season123_1_9EpisodeDetailViewContainer
