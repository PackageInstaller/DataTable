-- chunkname: @modules/logic/survival/view/map/SurvivalLogViewContainer.lua

module("modules.logic.survival.view.map.SurvivalLogViewContainer", package.seeall)

local SurvivalLogViewContainer = class("SurvivalLogViewContainer", BaseViewContainer)

function SurvivalLogViewContainer:buildViews()
	return {
		SurvivalLogView.New()
	}
end

return SurvivalLogViewContainer
