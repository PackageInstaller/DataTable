-- chunkname: @modules/logic/season/view1_6/Season1_6AdditionRuleTipViewContainer.lua

module("modules.logic.season.view1_6.Season1_6AdditionRuleTipViewContainer", package.seeall)

local Season1_6AdditionRuleTipViewContainer = class("Season1_6AdditionRuleTipViewContainer", BaseViewContainer)

function Season1_6AdditionRuleTipViewContainer:buildViews()
	return {
		Season1_6AdditionRuleTipView.New()
	}
end

return Season1_6AdditionRuleTipViewContainer
