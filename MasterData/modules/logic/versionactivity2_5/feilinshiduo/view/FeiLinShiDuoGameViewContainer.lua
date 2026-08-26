-- chunkname: @modules/logic/versionactivity2_5/feilinshiduo/view/FeiLinShiDuoGameViewContainer.lua

module("modules.logic.versionactivity2_5.feilinshiduo.view.FeiLinShiDuoGameViewContainer", package.seeall)

local FeiLinShiDuoGameViewContainer = class("FeiLinShiDuoGameViewContainer", BaseViewContainer)

function FeiLinShiDuoGameViewContainer:buildViews()
	local views = {}

	self.feiLinShiDuoSceneView = FeiLinShiDuoSceneView.New()
	self.feiLinShiDuoGameView = FeiLinShiDuoGameView.New()

	table.insert(views, self.feiLinShiDuoSceneView)
	table.insert(views, self.feiLinShiDuoGameView)
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function FeiLinShiDuoGameViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self.navigateView
		}
	end
end

function FeiLinShiDuoGameViewContainer:getSceneView()
	return self.feiLinShiDuoSceneView
end

function FeiLinShiDuoGameViewContainer:getGameView()
	return self.feiLinShiDuoGameView
end

function FeiLinShiDuoGameViewContainer:setOverrideCloseClick(overrideCloseFunc, overrideCloseObj)
	self.navigateView:setOverrideClose(overrideCloseFunc, overrideCloseObj)
end

return FeiLinShiDuoGameViewContainer
