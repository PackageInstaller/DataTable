-- chunkname: @modules/logic/survival/view/map/SurvivalToastViewContainer.lua

module("modules.logic.survival.view.map.SurvivalToastViewContainer", package.seeall)

local SurvivalToastViewContainer = class("SurvivalToastViewContainer", BaseViewContainer)

function SurvivalToastViewContainer:buildViews()
	return {
		SurvivalToastView.New()
	}
end

return SurvivalToastViewContainer
