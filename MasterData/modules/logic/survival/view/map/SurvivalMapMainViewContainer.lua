-- chunkname: @modules/logic/survival/view/map/SurvivalMapMainViewContainer.lua

module("modules.logic.survival.view.map.SurvivalMapMainViewContainer", package.seeall)

local SurvivalMapMainViewContainer = class("SurvivalMapMainViewContainer", BaseViewContainer)

function SurvivalMapMainViewContainer:buildViews()
	return {
		SurvivalMapMainView.New(),
		SurvivalMapUnitView.New(),
		SurvivalShrinkView.New(),
		SurvivalMapUseItemView.New(),
		SurvivalMapTreeOpenFogView.New(),
		SurvivalHeroHealthView.New(),
		SurvivalMapBubbleView.New(),
		SurvivalMapGMPosView.New(),
		SurvivalMapTalentView.New(),
		TabViewGroup.New(1, "#go_lefttop")
	}
end

function SurvivalMapMainViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		local navView = NavigateButtonsView.New({
			true,
			false,
			true
		}, HelpEnum.HelpId.Survival)

		navView:setOverrideClose(self.defaultOverrideCloseClick, self)

		return {
			navView
		}
	end
end

function SurvivalMapMainViewContainer:setCloseFunc(closeFunc, closeObj)
	self._closeFunc = closeFunc
	self._closeObj = closeObj
end

function SurvivalMapMainViewContainer:defaultOverrideCloseClick()
	SurvivalStatHelper.instance:statBtnClick("onClose", "SurvivalMapMainView")

	if self._closeFunc then
		self._closeFunc(self._closeObj)

		return
	end

	if SurvivalMapHelper.instance:isInFlow() then
		SurvivalMapHelper.instance:fastDoFlow()

		return
	end

	SurvivalController.instance:exitMap()
end

return SurvivalMapMainViewContainer
