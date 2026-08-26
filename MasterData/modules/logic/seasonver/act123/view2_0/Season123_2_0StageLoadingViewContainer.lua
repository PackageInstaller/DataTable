-- chunkname: @modules/logic/seasonver/act123/view2_0/Season123_2_0StageLoadingViewContainer.lua

module("modules.logic.seasonver.act123.view2_0.Season123_2_0StageLoadingViewContainer", package.seeall)

local Season123_2_0StageLoadingViewContainer = class("Season123_2_0StageLoadingViewContainer", BaseViewContainer)

function Season123_2_0StageLoadingViewContainer:buildViews()
	return {
		Season123_2_0StageLoadingView.New()
	}
end

return Season123_2_0StageLoadingViewContainer
