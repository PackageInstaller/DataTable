-- chunkname: @modules/logic/seasonver/act123/view1_9/Season123_1_9StageLoadingViewContainer.lua

module("modules.logic.seasonver.act123.view1_9.Season123_1_9StageLoadingViewContainer", package.seeall)

local Season123_1_9StageLoadingViewContainer = class("Season123_1_9StageLoadingViewContainer", BaseViewContainer)

function Season123_1_9StageLoadingViewContainer:buildViews()
	return {
		Season123_1_9StageLoadingView.New()
	}
end

return Season123_1_9StageLoadingViewContainer
