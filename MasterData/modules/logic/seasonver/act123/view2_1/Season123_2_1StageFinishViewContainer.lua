-- chunkname: @modules/logic/seasonver/act123/view2_1/Season123_2_1StageFinishViewContainer.lua

module("modules.logic.seasonver.act123.view2_1.Season123_2_1StageFinishViewContainer", package.seeall)

local Season123_2_1StageFinishViewContainer = class("Season123_2_1StageFinishViewContainer", BaseViewContainer)

function Season123_2_1StageFinishViewContainer:buildViews()
	return {
		Season123_2_1StageFinishView.New()
	}
end

return Season123_2_1StageFinishViewContainer
