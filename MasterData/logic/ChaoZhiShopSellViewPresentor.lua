-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mibaoshopsell/view/ChaoZhiShopSellViewPresentor.lua

module("logic.extensions.mibaoshopsell.view.ChaoZhiShopSellViewPresentor", package.seeall)

local ChaoZhiShopSellViewPresentor = class("ChaoZhiShopSellViewPresentor", ViewPresentor)

function ChaoZhiShopSellViewPresentor:ctor()
	ChaoZhiShopSellViewPresentor.super.ctor(self)
end

function ChaoZhiShopSellViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ChaoZhiShopSellViewPresentor:dependWhatResources()
	return {
		"ui/views/mibaoshopsell/chaozhishopsellview.prefab"
	}
end

function ChaoZhiShopSellViewPresentor:buildViews()
	return {
		ChaoZhiShopSellView.New()
	}
end

return ChaoZhiShopSellViewPresentor
