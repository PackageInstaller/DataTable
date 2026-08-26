-- chunkname: @modules/logic/survival/view/shelter/SurvivalEventPanelViewContainer.lua

module("modules.logic.survival.view.shelter.SurvivalEventPanelViewContainer", package.seeall)

local SurvivalEventPanelViewContainer = class("SurvivalEventPanelViewContainer", BaseViewContainer)

function SurvivalEventPanelViewContainer:buildViews()
	return {
		SurvivalEventPanelView.New()
	}
end

return SurvivalEventPanelViewContainer
