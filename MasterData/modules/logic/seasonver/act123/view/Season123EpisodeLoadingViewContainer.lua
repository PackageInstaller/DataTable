-- chunkname: @modules/logic/seasonver/act123/view/Season123EpisodeLoadingViewContainer.lua

module("modules.logic.seasonver.act123.view.Season123EpisodeLoadingViewContainer", package.seeall)

local Season123EpisodeLoadingViewContainer = class("Season123EpisodeLoadingViewContainer", BaseViewContainer)

function Season123EpisodeLoadingViewContainer:buildViews()
	return {
		Season123EpisodeLoadingView.New()
	}
end

return Season123EpisodeLoadingViewContainer
