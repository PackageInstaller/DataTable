-- chunkname: @modules/logic/seasonver/act123/view3_5/Season123_3_5StageFinishViewContainer.lua

module("modules.logic.seasonver.act123.view3_5.Season123_3_5StageFinishViewContainer", package.seeall)

local Season123_3_5StageFinishViewContainer = class("Season123_3_5StageFinishViewContainer", BaseViewContainer)

function Season123_3_5StageFinishViewContainer:buildViews()
	return {
		Season123_3_5StageFinishView.New()
	}
end

return Season123_3_5StageFinishViewContainer
