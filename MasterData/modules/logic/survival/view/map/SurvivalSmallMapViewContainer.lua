-- chunkname: @modules/logic/survival/view/map/SurvivalSmallMapViewContainer.lua

module("modules.logic.survival.view.map.SurvivalSmallMapViewContainer", package.seeall)

local SurvivalSmallMapViewContainer = class("SurvivalSmallMapViewContainer", BaseViewContainer)

function SurvivalSmallMapViewContainer:buildViews()
	return {
		SurvivalSmallMapView.New()
	}
end

return SurvivalSmallMapViewContainer
