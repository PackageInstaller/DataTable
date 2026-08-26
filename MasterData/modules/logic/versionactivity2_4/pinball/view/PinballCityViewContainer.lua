-- chunkname: @modules/logic/versionactivity2_4/pinball/view/PinballCityViewContainer.lua

module("modules.logic.versionactivity2_4.pinball.view.PinballCityViewContainer", package.seeall)

local PinballCityViewContainer = class("PinballCityViewContainer", BaseViewContainer)

function PinballCityViewContainer:buildViews()
	self._mapViewScene = PinballCitySceneView.New()

	return {
		self._mapViewScene,
		PinballCityView.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function PinballCityViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		local navView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			navView
		}
	end
end

function PinballCityViewContainer:setVisibleInternal(isVisible)
	if self._mapViewScene then
		self._mapViewScene:setSceneVisible(isVisible)
	end

	PinballCityViewContainer.super.setVisibleInternal(self, isVisible)
end

return PinballCityViewContainer
