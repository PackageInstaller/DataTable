-- chunkname: @modules/logic/seasonver/act123/view3_5/Season123_3_5StageLoadingViewContainer.lua

module("modules.logic.seasonver.act123.view3_5.Season123_3_5StageLoadingViewContainer", package.seeall)

local Season123_3_5StageLoadingViewContainer = class("Season123_3_5StageLoadingViewContainer", BaseViewContainer)

function Season123_3_5StageLoadingViewContainer:buildViews()
	return {
		Season123_3_5StageLoadingView.New()
	}
end

return Season123_3_5StageLoadingViewContainer
