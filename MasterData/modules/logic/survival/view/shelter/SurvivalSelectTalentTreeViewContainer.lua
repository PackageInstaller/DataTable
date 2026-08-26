-- chunkname: @modules/logic/survival/view/shelter/SurvivalSelectTalentTreeViewContainer.lua

module("modules.logic.survival.view.shelter.SurvivalSelectTalentTreeViewContainer", package.seeall)

local SurvivalSelectTalentTreeViewContainer = class("SurvivalSelectTalentTreeViewContainer", BaseViewContainer)

function SurvivalSelectTalentTreeViewContainer:buildViews()
	return {
		SurvivalSelectTalentTreeView.New(),
		TabViewGroup.New(1, "#go_lefttop")
	}
end

function SurvivalSelectTalentTreeViewContainer:buildTabViews(tabContainerId)
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

return SurvivalSelectTalentTreeViewContainer
