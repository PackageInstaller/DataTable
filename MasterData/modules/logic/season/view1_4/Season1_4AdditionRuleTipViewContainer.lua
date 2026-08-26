-- chunkname: @modules/logic/season/view1_4/Season1_4AdditionRuleTipViewContainer.lua

module("modules.logic.season.view1_4.Season1_4AdditionRuleTipViewContainer", package.seeall)

local Season1_4AdditionRuleTipViewContainer = class("Season1_4AdditionRuleTipViewContainer", BaseViewContainer)

function Season1_4AdditionRuleTipViewContainer:buildViews()
	return {
		Season1_4AdditionRuleTipView.New()
	}
end

return Season1_4AdditionRuleTipViewContainer
