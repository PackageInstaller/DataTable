-- chunkname: @modules/logic/seasonver/act123/view/Season123EpisodeDetailViewContainer.lua

module("modules.logic.seasonver.act123.view.Season123EpisodeDetailViewContainer", package.seeall)

local Season123EpisodeDetailViewContainer = class("Season123EpisodeDetailViewContainer", BaseViewContainer)

function Season123EpisodeDetailViewContainer:buildViews()
	local views = {}

	table.insert(views, Season123CheckCloseView.New())
	table.insert(views, Season123EpisodeDetailView.New())
	table.insert(views, TabViewGroup.New(1, "#go_info/#go_btns"))

	return views
end

function Season123EpisodeDetailViewContainer:buildTabViews(tabContainerId)
	self._navigateButtonView = NavigateButtonsView.New({
		true,
		true,
		false
	}, 100, self._closeCallback, self._homeCallback, nil, self)

	return {
		self._navigateButtonView
	}
end

function Season123EpisodeDetailViewContainer:_closeCallback()
	self:closeThis()
end

function Season123EpisodeDetailViewContainer:_homeCallback()
	self:closeThis()
end

return Season123EpisodeDetailViewContainer
