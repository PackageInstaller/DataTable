-- chunkname: @modules/logic/seasonver/act123/view2_3/Season123_2_3StageLoadingViewContainer.lua

module("modules.logic.seasonver.act123.view2_3.Season123_2_3StageLoadingViewContainer", package.seeall)

local Season123_2_3StageLoadingViewContainer = class("Season123_2_3StageLoadingViewContainer", BaseViewContainer)

function Season123_2_3StageLoadingViewContainer:buildViews()
	return {
		Season123_2_3StageLoadingView.New()
	}
end

return Season123_2_3StageLoadingViewContainer
