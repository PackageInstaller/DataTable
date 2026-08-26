-- chunkname: @modules/logic/seasonver/act123/view1_8/Season123_1_8AdditionRuleTipViewContainer.lua

module("modules.logic.seasonver.act123.view1_8.Season123_1_8AdditionRuleTipViewContainer", package.seeall)

local Season123_1_8AdditionRuleTipViewContainer = class("Season123_1_8AdditionRuleTipViewContainer", BaseViewContainer)

function Season123_1_8AdditionRuleTipViewContainer:buildViews()
	return {
		Season123_1_8AdditionRuleTipView.New()
	}
end

return Season123_1_8AdditionRuleTipViewContainer
