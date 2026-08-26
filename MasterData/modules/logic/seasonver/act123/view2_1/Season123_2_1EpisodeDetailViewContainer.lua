-- chunkname: @modules/logic/seasonver/act123/view2_1/Season123_2_1EpisodeDetailViewContainer.lua

module("modules.logic.seasonver.act123.view2_1.Season123_2_1EpisodeDetailViewContainer", package.seeall)

local Season123_2_1EpisodeDetailViewContainer = class("Season123_2_1EpisodeDetailViewContainer", BaseViewContainer)

function Season123_2_1EpisodeDetailViewContainer:buildViews()
	local views = {}

	table.insert(views, Season123_2_1CheckCloseView.New())
	table.insert(views, Season123_2_1EpisodeDetailView.New())
	table.insert(views, TabViewGroup.New(1, "#go_info/#go_btns"))

	return views
end

function Season123_2_1EpisodeDetailViewContainer:buildTabViews(tabContainerId)
	self._navigateButtonView = NavigateButtonsView.New({
		true,
		true,
		false
	}, 100, self._closeCallback, self._homeCallback, nil, self)

	return {
		self._navigateButtonView
	}
end

function Season123_2_1EpisodeDetailViewContainer:_closeCallback()
	self:closeThis()
end

function Season123_2_1EpisodeDetailViewContainer:_homeCallback()
	self:closeThis()
end

return Season123_2_1EpisodeDetailViewContainer
