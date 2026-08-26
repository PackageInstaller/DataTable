-- chunkname: @modules/logic/mainsceneswitch/view/MainSceneSkinMaterialTipView2Container.lua

module("modules.logic.mainsceneswitch.view.MainSceneSkinMaterialTipView2Container", package.seeall)

local MainSceneSkinMaterialTipView2Container = class("MainSceneSkinMaterialTipView2Container", BaseViewContainer)

function MainSceneSkinMaterialTipView2Container:buildViews()
	local views = {}

	self._bannerView = MainSceneSkinMaterialTipViewBanner2.New()

	table.insert(views, MainSceneSkinMaterialTipView2.New())
	table.insert(views, self._bannerView)

	return views
end

function MainSceneSkinMaterialTipView2Container:setGoodsTab(tabIndex)
	self._bannerView:setGoodsTab(tabIndex)
end

return MainSceneSkinMaterialTipView2Container
