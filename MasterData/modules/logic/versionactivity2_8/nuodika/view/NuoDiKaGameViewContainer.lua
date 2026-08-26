-- chunkname: @modules/logic/versionactivity2_8/nuodika/view/NuoDiKaGameViewContainer.lua

module("modules.logic.versionactivity2_8.nuodika.view.NuoDiKaGameViewContainer", package.seeall)

local NuoDiKaGameViewContainer = class("NuoDiKaGameViewContainer", BaseViewContainer)

function NuoDiKaGameViewContainer:buildViews()
	return {
		NuoDiKaGameView.New(),
		NuoDiKaGameMapView.New(),
		TabViewGroup.New(1, "#go_lefttop")
	}
end

function NuoDiKaGameViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		local navView = NavigateButtonsView.New({
			true,
			true,
			true
		})

		navView:setOverrideClose(self._onCloseGameView, self)
		navView:setOverrideHome(self._onHomeCloseGameView, self)
		navView:setOverrideHelp(self._onEnterInfoClick, self)

		return {
			navView
		}
	end
end

function NuoDiKaGameViewContainer:_onCloseGameView()
	NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.OnActiveClose)
	NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.OnBackToLevel)
	self:closeThis()
end

function NuoDiKaGameViewContainer:_onHomeCloseGameView()
	NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.OnActiveClose)
	NavigateButtonsView.homeClick()
end

function NuoDiKaGameViewContainer:_onEnterInfoClick()
	NuoDiKaController.instance:enterInfosView()
end

return NuoDiKaGameViewContainer
