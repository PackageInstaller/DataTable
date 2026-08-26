-- chunkname: @modules/logic/seasonver/act123/view2_1/Season123_2_1EpisodeLoadingViewContainer.lua

module("modules.logic.seasonver.act123.view2_1.Season123_2_1EpisodeLoadingViewContainer", package.seeall)

local Season123_2_1EpisodeLoadingViewContainer = class("Season123_2_1EpisodeLoadingViewContainer", BaseViewContainer)

function Season123_2_1EpisodeLoadingViewContainer:buildViews()
	return {
		Season123_2_1EpisodeLoadingView.New()
	}
end

return Season123_2_1EpisodeLoadingViewContainer
