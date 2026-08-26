-- chunkname: @modules/logic/survival/view/map/SurvivalMapResultViewContainer.lua

module("modules.logic.survival.view.map.SurvivalMapResultViewContainer", package.seeall)

local SurvivalMapResultViewContainer = class("SurvivalMapResultViewContainer", BaseViewContainer)

function SurvivalMapResultViewContainer:buildViews()
	return {
		SurvivalMapResultView.New()
	}
end

return SurvivalMapResultViewContainer
