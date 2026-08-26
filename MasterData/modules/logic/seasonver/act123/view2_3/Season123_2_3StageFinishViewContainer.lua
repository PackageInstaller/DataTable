-- chunkname: @modules/logic/seasonver/act123/view2_3/Season123_2_3StageFinishViewContainer.lua

module("modules.logic.seasonver.act123.view2_3.Season123_2_3StageFinishViewContainer", package.seeall)

local Season123_2_3StageFinishViewContainer = class("Season123_2_3StageFinishViewContainer", BaseViewContainer)

function Season123_2_3StageFinishViewContainer:buildViews()
	return {
		Season123_2_3StageFinishView.New()
	}
end

return Season123_2_3StageFinishViewContainer
