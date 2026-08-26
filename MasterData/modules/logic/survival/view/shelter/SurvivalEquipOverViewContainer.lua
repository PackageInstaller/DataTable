-- chunkname: @modules/logic/survival/view/shelter/SurvivalEquipOverViewContainer.lua

module("modules.logic.survival.view.shelter.SurvivalEquipOverViewContainer", package.seeall)

local SurvivalEquipOverViewContainer = class("SurvivalEquipOverViewContainer", BaseViewContainer)

function SurvivalEquipOverViewContainer:buildViews()
	return {
		SurvivalEquipOverView.New()
	}
end

return SurvivalEquipOverViewContainer
