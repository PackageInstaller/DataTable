-- chunkname: @modules/logic/survival/view/SurvivalViewContainer.lua

module("modules.logic.survival.view.SurvivalViewContainer", package.seeall)

local SurvivalViewContainer = class("SurvivalViewContainer", BaseViewContainer)

function SurvivalViewContainer:buildViews()
	return {
		SurvivalView.New(),
		TabViewGroup.New(1, "#go_lefttop")
	}
end

function SurvivalViewContainer:buildTabViews(tabContainerId)
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

return SurvivalViewContainer
