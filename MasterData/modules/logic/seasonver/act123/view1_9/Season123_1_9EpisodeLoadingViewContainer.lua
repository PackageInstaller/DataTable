-- chunkname: @modules/logic/seasonver/act123/view1_9/Season123_1_9EpisodeLoadingViewContainer.lua

module("modules.logic.seasonver.act123.view1_9.Season123_1_9EpisodeLoadingViewContainer", package.seeall)

local Season123_1_9EpisodeLoadingViewContainer = class("Season123_1_9EpisodeLoadingViewContainer", BaseViewContainer)

function Season123_1_9EpisodeLoadingViewContainer:buildViews()
	return {
		Season123_1_9EpisodeLoadingView.New()
	}
end

return Season123_1_9EpisodeLoadingViewContainer
