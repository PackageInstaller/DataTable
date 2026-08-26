-- chunkname: @modules/logic/seasonver/act123/view1_8/Season123_1_8EpisodeDetailViewContainer.lua

module("modules.logic.seasonver.act123.view1_8.Season123_1_8EpisodeDetailViewContainer", package.seeall)

local Season123_1_8EpisodeDetailViewContainer = class("Season123_1_8EpisodeDetailViewContainer", BaseViewContainer)

function Season123_1_8EpisodeDetailViewContainer:buildViews()
	local views = {}

	table.insert(views, Season123_1_8CheckCloseView.New())
	table.insert(views, Season123_1_8EpisodeDetailView.New())
	table.insert(views, TabViewGroup.New(1, "#go_info/#go_btns"))

	return views
end

function Season123_1_8EpisodeDetailViewContainer:buildTabViews(tabContainerId)
	self._navigateButtonView = NavigateButtonsView.New({
		true,
		true,
		false
	}, 100, self._closeCallback, self._homeCallback, nil, self)

	return {
		self._navigateButtonView
	}
end

function Season123_1_8EpisodeDetailViewContainer:_closeCallback()
	self:closeThis()
end

function Season123_1_8EpisodeDetailViewContainer:_homeCallback()
	self:closeThis()
end

return Season123_1_8EpisodeDetailViewContainer
