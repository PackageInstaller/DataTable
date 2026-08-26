-- chunkname: @modules/logic/survival/view/map/SurvivalMapBagViewContainer.lua

module("modules.logic.survival.view.map.SurvivalMapBagViewContainer", package.seeall)

local SurvivalMapBagViewContainer = class("SurvivalMapBagViewContainer", BaseViewContainer)

function SurvivalMapBagViewContainer:buildViews()
	return {
		SurvivalMapBagView.New(),
		ToggleListView.New(1, "root/toggleGroup")
	}
end

return SurvivalMapBagViewContainer
