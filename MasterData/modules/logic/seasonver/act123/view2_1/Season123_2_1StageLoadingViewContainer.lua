-- chunkname: @modules/logic/seasonver/act123/view2_1/Season123_2_1StageLoadingViewContainer.lua

module("modules.logic.seasonver.act123.view2_1.Season123_2_1StageLoadingViewContainer", package.seeall)

local Season123_2_1StageLoadingViewContainer = class("Season123_2_1StageLoadingViewContainer", BaseViewContainer)

function Season123_2_1StageLoadingViewContainer:buildViews()
	return {
		Season123_2_1StageLoadingView.New()
	}
end

return Season123_2_1StageLoadingViewContainer
