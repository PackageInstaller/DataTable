-- chunkname: @modules/logic/seasonver/act123/view2_3/Season123_2_3EpisodeDetailViewContainer.lua

module("modules.logic.seasonver.act123.view2_3.Season123_2_3EpisodeDetailViewContainer", package.seeall)

local Season123_2_3EpisodeDetailViewContainer = class("Season123_2_3EpisodeDetailViewContainer", BaseViewContainer)

function Season123_2_3EpisodeDetailViewContainer:buildViews()
	local views = {}

	table.insert(views, Season123_2_3CheckCloseView.New())
	table.insert(views, Season123_2_3EpisodeDetailView.New())
	table.insert(views, TabViewGroup.New(1, "#go_info/#go_btns"))

	return views
end

function Season123_2_3EpisodeDetailViewContainer:buildTabViews(tabContainerId)
	self._navigateButtonView = NavigateButtonsView.New({
		true,
		true,
		false
	}, 100, self._closeCallback, self._homeCallback, nil, self)

	return {
		self._navigateButtonView
	}
end

function Season123_2_3EpisodeDetailViewContainer:_closeCallback()
	self:closeThis()
end

function Season123_2_3EpisodeDetailViewContainer:_homeCallback()
	self:closeThis()
end

return Season123_2_3EpisodeDetailViewContainer
