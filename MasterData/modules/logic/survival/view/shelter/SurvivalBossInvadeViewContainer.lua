-- chunkname: @modules/logic/survival/view/shelter/SurvivalBossInvadeViewContainer.lua

module("modules.logic.survival.view.shelter.SurvivalBossInvadeViewContainer", package.seeall)

local SurvivalBossInvadeViewContainer = class("SurvivalBossInvadeViewContainer", BaseViewContainer)

function SurvivalBossInvadeViewContainer:buildViews()
	return {
		SurvivalBossInvadeView.New()
	}
end

return SurvivalBossInvadeViewContainer
