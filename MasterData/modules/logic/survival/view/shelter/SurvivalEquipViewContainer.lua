-- chunkname: @modules/logic/survival/view/shelter/SurvivalEquipViewContainer.lua

module("modules.logic.survival.view.shelter.SurvivalEquipViewContainer", package.seeall)

local SurvivalEquipViewContainer = class("SurvivalEquipViewContainer", BaseViewContainer)

function SurvivalEquipViewContainer:buildViews()
	return {
		SurvivalEquipView.New(),
		TabViewGroup.New(1, "#go_lefttop")
	}
end

function SurvivalEquipViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		local navView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			navView
		}
	end
end

return SurvivalEquipViewContainer
