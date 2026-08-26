-- chunkname: @modules/logic/survival/view/map/SurvivalDropSelectViewContainer.lua

module("modules.logic.survival.view.map.SurvivalDropSelectViewContainer", package.seeall)

local SurvivalDropSelectViewContainer = class("SurvivalDropSelectViewContainer", BaseViewContainer)

function SurvivalDropSelectViewContainer:buildViews()
	return {
		SurvivalDropSelectView.New()
	}
end

return SurvivalDropSelectViewContainer
