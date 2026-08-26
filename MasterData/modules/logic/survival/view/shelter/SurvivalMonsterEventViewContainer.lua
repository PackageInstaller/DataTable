-- chunkname: @modules/logic/survival/view/shelter/SurvivalMonsterEventViewContainer.lua

module("modules.logic.survival.view.shelter.SurvivalMonsterEventViewContainer", package.seeall)

local SurvivalMonsterEventViewContainer = class("SurvivalMonsterEventViewContainer", BaseViewContainer)

function SurvivalMonsterEventViewContainer:buildViews()
	return {
		SurvivalMonsterEventView.New()
	}
end

return SurvivalMonsterEventViewContainer
