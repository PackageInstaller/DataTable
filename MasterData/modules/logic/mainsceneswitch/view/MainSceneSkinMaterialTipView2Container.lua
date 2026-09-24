-- chunkname: @modules/logic/mainsceneswitch/view/MainSceneSkinMaterialTipView2Container.lua

module("modules.logic.mainsceneswitch.view.MainSceneSkinMaterialTipView2Container", package.seeall)

local MainSceneSkinMaterialTipView2Container = class("MainSceneSkinMaterialTipView2Container", BaseViewContainer)

function MainSceneSkinMaterialTipView2Container:buildViews()
	local views = {}

	self._bannerView = MainSceneSkinMaterialTipViewBanner2.New()
	self._tipView = MainSceneSkinMaterialTipView2.New()

	table.insert(views, self._tipView)
	table.insert(views, self._bannerView)
	table.insert(views, TabViewGroupFit.New(1, "extra"))

	return views
end

function MainSceneSkinMaterialTipView2Container:setGoodsTab(goodsId)
	self._bannerView:setGoodsTab(goodsId)
	self._tipView:setGoodsTab(goodsId)
end

function MainSceneSkinMaterialTipView2Container:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._packageLeftView = DecoratePackageLeftView.New()

		return {
			self._packageLeftView
		}
	end
end

return MainSceneSkinMaterialTipView2Container
