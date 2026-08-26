-- chunkname: @modules/logic/survival/view/shelter/SurvivalDecreeViewContainer.lua

module("modules.logic.survival.view.shelter.SurvivalDecreeViewContainer", package.seeall)

local SurvivalDecreeViewContainer = class("SurvivalDecreeViewContainer", BaseViewContainer)

function SurvivalDecreeViewContainer:buildViews()
	local views = {}

	table.insert(views, SurvivalDecreeView.New())
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))
	table.insert(views, ShelterCurrencyView.New({
		SurvivalEnum.CurrencyType.Build
	}, "#go_topright"))

	return views
end

function SurvivalDecreeViewContainer:buildTabViews(tabContainerId)
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

return SurvivalDecreeViewContainer
