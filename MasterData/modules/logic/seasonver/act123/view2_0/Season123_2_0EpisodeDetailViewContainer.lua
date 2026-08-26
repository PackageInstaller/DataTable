-- chunkname: @modules/logic/seasonver/act123/view2_0/Season123_2_0EpisodeDetailViewContainer.lua

module("modules.logic.seasonver.act123.view2_0.Season123_2_0EpisodeDetailViewContainer", package.seeall)

local Season123_2_0EpisodeDetailViewContainer = class("Season123_2_0EpisodeDetailViewContainer", BaseViewContainer)

function Season123_2_0EpisodeDetailViewContainer:buildViews()
	local views = {}

	table.insert(views, Season123_2_0CheckCloseView.New())
	table.insert(views, Season123_2_0EpisodeDetailView.New())
	table.insert(views, TabViewGroup.New(1, "#go_info/#go_btns"))

	return views
end

function Season123_2_0EpisodeDetailViewContainer:buildTabViews(tabContainerId)
	self._navigateButtonView = NavigateButtonsView.New({
		true,
		true,
		false
	}, 100, self._closeCallback, self._homeCallback, nil, self)

	return {
		self._navigateButtonView
	}
end

function Season123_2_0EpisodeDetailViewContainer:_closeCallback()
	self:closeThis()
end

function Season123_2_0EpisodeDetailViewContainer:_homeCallback()
	self:closeThis()
end

return Season123_2_0EpisodeDetailViewContainer
