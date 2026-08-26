-- chunkname: @modules/logic/season/view1_2/Season1_2AdditionRuleTipViewContainer.lua

module("modules.logic.season.view1_2.Season1_2AdditionRuleTipViewContainer", package.seeall)

local Season1_2AdditionRuleTipViewContainer = class("Season1_2AdditionRuleTipViewContainer", BaseViewContainer)

function Season1_2AdditionRuleTipViewContainer:buildViews()
	return {
		Season1_2AdditionRuleTipView.New()
	}
end

return Season1_2AdditionRuleTipViewContainer
