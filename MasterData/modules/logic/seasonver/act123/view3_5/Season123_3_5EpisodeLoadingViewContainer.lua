-- chunkname: @modules/logic/seasonver/act123/view3_5/Season123_3_5EpisodeLoadingViewContainer.lua

module("modules.logic.seasonver.act123.view3_5.Season123_3_5EpisodeLoadingViewContainer", package.seeall)

local Season123_3_5EpisodeLoadingViewContainer = class("Season123_3_5EpisodeLoadingViewContainer", BaseViewContainer)

function Season123_3_5EpisodeLoadingViewContainer:buildViews()
	return {
		Season123_3_5EpisodeLoadingView.New()
	}
end

return Season123_3_5EpisodeLoadingViewContainer
