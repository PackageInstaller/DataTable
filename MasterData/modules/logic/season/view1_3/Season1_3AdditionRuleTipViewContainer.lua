-- chunkname: @modules/logic/season/view1_3/Season1_3AdditionRuleTipViewContainer.lua

module("modules.logic.season.view1_3.Season1_3AdditionRuleTipViewContainer", package.seeall)

local Season1_3AdditionRuleTipViewContainer = class("Season1_3AdditionRuleTipViewContainer", BaseViewContainer)

function Season1_3AdditionRuleTipViewContainer:buildViews()
	return {
		Season1_3AdditionRuleTipView.New()
	}
end

return Season1_3AdditionRuleTipViewContainer
