-- chunkname: @modules/logic/seasonver/act123/view/Season123StageFinishViewContainer.lua

module("modules.logic.seasonver.act123.view.Season123StageFinishViewContainer", package.seeall)

local Season123StageFinishViewContainer = class("Season123StageFinishViewContainer", BaseViewContainer)

function Season123StageFinishViewContainer:buildViews()
	return {
		Season123StageFinishView.New()
	}
end

return Season123StageFinishViewContainer
