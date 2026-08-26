-- chunkname: @modules/logic/seasonver/act123/view1_9/Season123_1_9AdditionRuleTipViewContainer.lua

module("modules.logic.seasonver.act123.view1_9.Season123_1_9AdditionRuleTipViewContainer", package.seeall)

local Season123_1_9AdditionRuleTipViewContainer = class("Season123_1_9AdditionRuleTipViewContainer", BaseViewContainer)

function Season123_1_9AdditionRuleTipViewContainer:buildViews()
	return {
		Season123_1_9AdditionRuleTipView.New()
	}
end

return Season123_1_9AdditionRuleTipViewContainer
