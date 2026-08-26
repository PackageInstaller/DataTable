-- chunkname: @modules/logic/seasonver/act123/view2_3/Season123_2_3EpisodeLoadingViewContainer.lua

module("modules.logic.seasonver.act123.view2_3.Season123_2_3EpisodeLoadingViewContainer", package.seeall)

local Season123_2_3EpisodeLoadingViewContainer = class("Season123_2_3EpisodeLoadingViewContainer", BaseViewContainer)

function Season123_2_3EpisodeLoadingViewContainer:buildViews()
	return {
		Season123_2_3EpisodeLoadingView.New()
	}
end

return Season123_2_3EpisodeLoadingViewContainer
