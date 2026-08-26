-- chunkname: @modules/logic/versionactivity3_2/huidiaolan/view/HuiDiaoLanGameViewContainer.lua

module("modules.logic.versionactivity3_2.huidiaolan.view.HuiDiaoLanGameViewContainer", package.seeall)

local HuiDiaoLanGameViewContainer = class("HuiDiaoLanGameViewContainer", BaseViewContainer)

function HuiDiaoLanGameViewContainer:buildViews()
	local views = {}

	self.huiDiaoLanGameView = HuiDiaoLanGameView.New()
	self.HuiDiaoLanEffectView = HuiDiaoLanEffectView.New()
	self.HuiDiaoLanSceneView = HuiDiaoLanSceneView.New()

	table.insert(views, self.huiDiaoLanGameView)
	table.insert(views, self.HuiDiaoLanSceneView)
	table.insert(views, self.HuiDiaoLanEffectView)
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function HuiDiaoLanGameViewContainer:buildTabViews(tabContainerId)
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

function HuiDiaoLanGameViewContainer:getHuiDiaoLanGameView()
	return self.huiDiaoLanGameView
end

function HuiDiaoLanGameViewContainer:getHuiDiaoLanSceneView()
	return self.HuiDiaoLanSceneView
end

function HuiDiaoLanGameViewContainer:getHuiDiaoLanEffectView()
	return self.HuiDiaoLanEffectView
end

function HuiDiaoLanGameViewContainer:setOverrideCloseClick(overrideCloseFunc, overrideCloseObj)
	self.navigateView:setOverrideClose(overrideCloseFunc, overrideCloseObj)
end

return HuiDiaoLanGameViewContainer
