-- chunkname: @modules/logic/survival/view/map/SurvivalMapResultPanelViewContainer.lua

module("modules.logic.survival.view.map.SurvivalMapResultPanelViewContainer", package.seeall)

local SurvivalMapResultPanelViewContainer = class("SurvivalMapResultPanelViewContainer", BaseViewContainer)

function SurvivalMapResultPanelViewContainer:buildViews()
	return {
		SurvivalMapResultPanelView.New()
	}
end

return SurvivalMapResultPanelViewContainer
