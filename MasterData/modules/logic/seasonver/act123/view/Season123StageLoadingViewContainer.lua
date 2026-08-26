-- chunkname: @modules/logic/seasonver/act123/view/Season123StageLoadingViewContainer.lua

module("modules.logic.seasonver.act123.view.Season123StageLoadingViewContainer", package.seeall)

local Season123StageLoadingViewContainer = class("Season123StageLoadingViewContainer", BaseViewContainer)

function Season123StageLoadingViewContainer:buildViews()
	return {
		Season123StageLoadingView.New()
	}
end

return Season123StageLoadingViewContainer
