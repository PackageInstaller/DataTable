-- chunkname: @modules/logic/survival/view/shelter/SurvivalCeremonyClosingViewContainer.lua

module("modules.logic.survival.view.shelter.SurvivalCeremonyClosingViewContainer", package.seeall)

local SurvivalCeremonyClosingViewContainer = class("SurvivalCeremonyClosingViewContainer", BaseViewContainer)

function SurvivalCeremonyClosingViewContainer:buildViews()
	return {
		SurvivalCeremonyClosingView.New()
	}
end

return SurvivalCeremonyClosingViewContainer
