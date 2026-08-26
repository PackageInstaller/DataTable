-- chunkname: @modules/logic/survival/view/map/SurvivalNPCSelectViewContainer.lua

module("modules.logic.survival.view.map.SurvivalNPCSelectViewContainer", package.seeall)

local SurvivalNPCSelectViewContainer = class("SurvivalNPCSelectViewContainer", BaseViewContainer)

function SurvivalNPCSelectViewContainer:buildViews()
	return {
		SurvivalNPCSelectView.New()
	}
end

return SurvivalNPCSelectViewContainer
