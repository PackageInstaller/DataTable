-- chunkname: @modules/logic/seasonver/act123/view2_1/Season123_2_1AdditionRuleTipViewContainer.lua

module("modules.logic.seasonver.act123.view2_1.Season123_2_1AdditionRuleTipViewContainer", package.seeall)

local Season123_2_1AdditionRuleTipViewContainer = class("Season123_2_1AdditionRuleTipViewContainer", BaseViewContainer)

function Season123_2_1AdditionRuleTipViewContainer:buildViews()
	return {
		Season123_2_1AdditionRuleTipView.New()
	}
end

return Season123_2_1AdditionRuleTipViewContainer
