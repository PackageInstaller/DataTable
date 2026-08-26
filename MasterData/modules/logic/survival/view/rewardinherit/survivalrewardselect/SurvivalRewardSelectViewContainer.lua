-- chunkname: @modules/logic/survival/view/rewardinherit/survivalrewardselect/SurvivalRewardSelectViewContainer.lua

module("modules.logic.survival.view.rewardinherit.survivalrewardselect.SurvivalRewardSelectViewContainer", package.seeall)

local SurvivalRewardSelectViewContainer = class("SurvivalRewardSelectViewContainer", BaseViewContainer)

function SurvivalRewardSelectViewContainer:buildViews()
	return {
		SurvivalRewardSelectView.New()
	}
end

return SurvivalRewardSelectViewContainer
