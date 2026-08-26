-- chunkname: @modules/logic/seasonver/act123/view2_0/Season123_2_0EpisodeLoadingViewContainer.lua

module("modules.logic.seasonver.act123.view2_0.Season123_2_0EpisodeLoadingViewContainer", package.seeall)

local Season123_2_0EpisodeLoadingViewContainer = class("Season123_2_0EpisodeLoadingViewContainer", BaseViewContainer)

function Season123_2_0EpisodeLoadingViewContainer:buildViews()
	return {
		Season123_2_0EpisodeLoadingView.New()
	}
end

return Season123_2_0EpisodeLoadingViewContainer
