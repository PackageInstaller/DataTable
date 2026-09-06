-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mibaoshopsell/view/WangYeShopSellViewPresentor.lua

module("logic.extensions.mibaoshopsell.view.WangYeShopSellViewPresentor", package.seeall)

local WangYeShopSellViewPresentor = class("WangYeShopSellViewPresentor", ViewPresentor)

function WangYeShopSellViewPresentor:ctor()
	WangYeShopSellViewPresentor.super.ctor(self)
end

function WangYeShopSellViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function WangYeShopSellViewPresentor:dependWhatResources()
	return {
		"ui/views/mibaoshopsell/wangyeshopsellview.prefab"
	}
end

function WangYeShopSellViewPresentor:buildViews()
	return {
		WangYeShopSellView.New()
	}
end

return WangYeShopSellViewPresentor
