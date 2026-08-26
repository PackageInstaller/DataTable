-- chunkname: @modules/logic/season/view1_5/Season1_5AdditionRuleTipViewContainer.lua

module("modules.logic.season.view1_5.Season1_5AdditionRuleTipViewContainer", package.seeall)

local Season1_5AdditionRuleTipViewContainer = class("Season1_5AdditionRuleTipViewContainer", BaseViewContainer)

function Season1_5AdditionRuleTipViewContainer:buildViews()
	return {
		Season1_5AdditionRuleTipView.New()
	}
end

return Season1_5AdditionRuleTipViewContainer
