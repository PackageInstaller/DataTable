-- chunkname: @modules/logic/survival/view/SurvivalItemInfoViewContainer.lua

module("modules.logic.survival.view.SurvivalItemInfoViewContainer", package.seeall)

local SurvivalItemInfoViewContainer = class("SurvivalItemInfoViewContainer", BaseViewContainer)

function SurvivalItemInfoViewContainer:buildViews()
	return {
		SurvivalItemInfoView.New()
	}
end

return SurvivalItemInfoViewContainer
