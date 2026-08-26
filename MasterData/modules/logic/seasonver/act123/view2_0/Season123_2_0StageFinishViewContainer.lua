-- chunkname: @modules/logic/seasonver/act123/view2_0/Season123_2_0StageFinishViewContainer.lua

module("modules.logic.seasonver.act123.view2_0.Season123_2_0StageFinishViewContainer", package.seeall)

local Season123_2_0StageFinishViewContainer = class("Season123_2_0StageFinishViewContainer", BaseViewContainer)

function Season123_2_0StageFinishViewContainer:buildViews()
	return {
		Season123_2_0StageFinishView.New()
	}
end

return Season123_2_0StageFinishViewContainer
