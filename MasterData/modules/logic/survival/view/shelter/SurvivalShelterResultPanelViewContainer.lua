-- chunkname: @modules/logic/survival/view/shelter/SurvivalShelterResultPanelViewContainer.lua

module("modules.logic.survival.view.shelter.SurvivalShelterResultPanelViewContainer", package.seeall)

local SurvivalShelterResultPanelViewContainer = class("SurvivalShelterResultPanelViewContainer", BaseViewContainer)

function SurvivalShelterResultPanelViewContainer:buildViews()
	return {
		SurvivalShelterResultPanelView.New()
	}
end

return SurvivalShelterResultPanelViewContainer
