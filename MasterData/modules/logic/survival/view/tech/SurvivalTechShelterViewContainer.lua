-- chunkname: @modules/logic/survival/view/tech/SurvivalTechShelterViewContainer.lua

module("modules.logic.survival.view.tech.SurvivalTechShelterViewContainer", package.seeall)

local SurvivalTechShelterViewContainer = class("SurvivalTechShelterViewContainer", BaseViewContainer)

function SurvivalTechShelterViewContainer:buildViews()
	return {
		SurvivalTechShelterView.New(),
		TabViewGroup.New(1, "#go_btns"),
		ShelterCurrencyView.New({
			SurvivalEnum.CurrencyType.Gold
		}, "root/survivalcurrency")
	}
end

function SurvivalTechShelterViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateButtonView = NavigateButtonsView.New({
			true,
			false,
			false
		}, nil)

		return {
			self.navigateButtonView
		}
	end
end

return SurvivalTechShelterViewContainer
