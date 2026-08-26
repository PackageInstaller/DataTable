-- chunkname: @modules/logic/season/view3_0/Season3_0AdditionRuleTipViewContainer.lua

module("modules.logic.season.view3_0.Season3_0AdditionRuleTipViewContainer", package.seeall)

local Season3_0AdditionRuleTipViewContainer = class("Season3_0AdditionRuleTipViewContainer", BaseViewContainer)

function Season3_0AdditionRuleTipViewContainer:buildViews()
	return {
		Season3_0AdditionRuleTipView.New()
	}
end

return Season3_0AdditionRuleTipViewContainer
