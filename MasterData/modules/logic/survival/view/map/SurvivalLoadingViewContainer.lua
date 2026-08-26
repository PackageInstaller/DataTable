-- chunkname: @modules/logic/survival/view/map/SurvivalLoadingViewContainer.lua

module("modules.logic.survival.view.map.SurvivalLoadingViewContainer", package.seeall)

local SurvivalLoadingViewContainer = class("SurvivalLoadingViewContainer", BaseViewContainer)

function SurvivalLoadingViewContainer:buildViews()
	return {
		SurvivalLoadingView.New()
	}
end

return SurvivalLoadingViewContainer
