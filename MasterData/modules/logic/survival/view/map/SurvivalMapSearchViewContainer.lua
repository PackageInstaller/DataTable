-- chunkname: @modules/logic/survival/view/map/SurvivalMapSearchViewContainer.lua

module("modules.logic.survival.view.map.SurvivalMapSearchViewContainer", package.seeall)

local SurvivalMapSearchViewContainer = class("SurvivalMapSearchViewContainer", BaseViewContainer)

function SurvivalMapSearchViewContainer:buildViews()
	return {
		SurvivalMapSearchView.New()
	}
end

return SurvivalMapSearchViewContainer
