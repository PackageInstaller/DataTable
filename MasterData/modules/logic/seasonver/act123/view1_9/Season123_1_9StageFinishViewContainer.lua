-- chunkname: @modules/logic/seasonver/act123/view1_9/Season123_1_9StageFinishViewContainer.lua

module("modules.logic.seasonver.act123.view1_9.Season123_1_9StageFinishViewContainer", package.seeall)

local Season123_1_9StageFinishViewContainer = class("Season123_1_9StageFinishViewContainer", BaseViewContainer)

function Season123_1_9StageFinishViewContainer:buildViews()
	return {
		Season123_1_9StageFinishView.New()
	}
end

return Season123_1_9StageFinishViewContainer
