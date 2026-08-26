-- chunkname: @modules/logic/survival/view/shelter/SurvivalMainViewContainer.lua

module("modules.logic.survival.view.shelter.SurvivalMainViewContainer", package.seeall)

local SurvivalMainViewContainer = class("SurvivalMainViewContainer", BaseViewContainer)

function SurvivalMainViewContainer:buildViews()
	return {
		SurvivalMainView.New(),
		ShelterSceneUnitView.New(),
		SurvivalMainViewButton.New(),
		SurvivalMainViewCurrency.New(),
		SurvivalBubbleView.New(),
		SurvivalMapTalentView.New("go_normalroot/"),
		TabViewGroup.New(1, "#go_lefttop")
	}
end

function SurvivalMainViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		local navView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		navView:setOverrideClose(self.defaultOverrideCloseClick, self)

		return {
			navView
		}
	end
end

function SurvivalMainViewContainer:defaultOverrideCloseClick()
	SurvivalController.instance:exitMap()
	SurvivalStatHelper.instance:statBtnClick("OnClose", "SurvivalMainView")
end

function SurvivalMainViewContainer:setMainViewVisible(isVisible)
	self:_setVisible(isVisible)
end

return SurvivalMainViewContainer
