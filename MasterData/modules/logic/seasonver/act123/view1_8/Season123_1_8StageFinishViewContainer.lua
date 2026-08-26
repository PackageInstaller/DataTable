-- chunkname: @modules/logic/seasonver/act123/view1_8/Season123_1_8StageFinishViewContainer.lua

module("modules.logic.seasonver.act123.view1_8.Season123_1_8StageFinishViewContainer", package.seeall)

local Season123_1_8StageFinishViewContainer = class("Season123_1_8StageFinishViewContainer", BaseViewContainer)

function Season123_1_8StageFinishViewContainer:buildViews()
	return {
		Season123_1_8StageFinishView.New()
	}
end

return Season123_1_8StageFinishViewContainer
