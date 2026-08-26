-- chunkname: @modules/logic/seasonver/act123/view3_5/Season123_3_5EpisodeDetailViewContainer.lua

module("modules.logic.seasonver.act123.view3_5.Season123_3_5EpisodeDetailViewContainer", package.seeall)

local Season123_3_5EpisodeDetailViewContainer = class("Season123_3_5EpisodeDetailViewContainer", BaseViewContainer)

function Season123_3_5EpisodeDetailViewContainer:buildViews()
	local views = {}

	table.insert(views, Season123_3_5CheckCloseView.New())
	table.insert(views, Season123_3_5EpisodeDetailView.New())
	table.insert(views, TabViewGroup.New(1, "#go_info/#go_btns"))

	return views
end

function Season123_3_5EpisodeDetailViewContainer:buildTabViews(tabContainerId)
	self._navigateButtonView = NavigateButtonsView.New({
		true,
		true,
		true
	}, HelpEnum.HelpId.Season3_5EpisodeViewHelp, self._closeCallback, self._homeCallback, nil, self)

	return {
		self._navigateButtonView
	}
end

function Season123_3_5EpisodeDetailViewContainer:_closeCallback()
	self:closeThis()
end

function Season123_3_5EpisodeDetailViewContainer:_homeCallback()
	self:closeThis()
end

return Season123_3_5EpisodeDetailViewContainer
