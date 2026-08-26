-- chunkname: @modules/logic/seasonver/act123/view1_8/Season123_1_8StageLoadingViewContainer.lua

module("modules.logic.seasonver.act123.view1_8.Season123_1_8StageLoadingViewContainer", package.seeall)

local Season123_1_8StageLoadingViewContainer = class("Season123_1_8StageLoadingViewContainer", BaseViewContainer)

function Season123_1_8StageLoadingViewContainer:buildViews()
	return {
		Season123_1_8StageLoadingView.New()
	}
end

return Season123_1_8StageLoadingViewContainer
