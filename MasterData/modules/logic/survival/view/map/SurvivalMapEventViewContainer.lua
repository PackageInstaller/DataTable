-- chunkname: @modules/logic/survival/view/map/SurvivalMapEventViewContainer.lua

module("modules.logic.survival.view.map.SurvivalMapEventViewContainer", package.seeall)

local SurvivalMapEventViewContainer = class("SurvivalMapEventViewContainer", BaseViewContainer)

function SurvivalMapEventViewContainer:buildViews()
	return {
		SurvivalMapEventView.New(),
		SurvivalShrinkView.New()
	}
end

return SurvivalMapEventViewContainer
