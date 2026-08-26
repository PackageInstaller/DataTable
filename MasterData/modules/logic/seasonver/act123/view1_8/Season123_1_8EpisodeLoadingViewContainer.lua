-- chunkname: @modules/logic/seasonver/act123/view1_8/Season123_1_8EpisodeLoadingViewContainer.lua

module("modules.logic.seasonver.act123.view1_8.Season123_1_8EpisodeLoadingViewContainer", package.seeall)

local Season123_1_8EpisodeLoadingViewContainer = class("Season123_1_8EpisodeLoadingViewContainer", BaseViewContainer)

function Season123_1_8EpisodeLoadingViewContainer:buildViews()
	return {
		Season123_1_8EpisodeLoadingView.New()
	}
end

return Season123_1_8EpisodeLoadingViewContainer
