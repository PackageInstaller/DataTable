-- chunkname: @modules/logic/survival/view/map/SurvivalGetRewardViewContainer.lua

module("modules.logic.survival.view.map.SurvivalGetRewardViewContainer", package.seeall)

local SurvivalGetRewardViewContainer = class("SurvivalGetRewardViewContainer", BaseViewContainer)

function SurvivalGetRewardViewContainer:buildViews()
	return {
		SurvivalGetRewardView.New()
	}
end

return SurvivalGetRewardViewContainer
