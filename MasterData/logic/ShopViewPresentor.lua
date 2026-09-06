-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shop/view/ShopViewPresentor.lua

module("logic.extensions.shop.view.ShopViewPresentor", package.seeall)

local ShopViewPresentor = class("ShopViewPresentor", ViewPresentor)

function ShopViewPresentor:ctor()
	ShopViewPresentor.super.ctor(self)
end

function ShopViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ShopViewPresentor:dependWhatResources()
	return {
		"ui/views/shop/shopview.prefab"
	}
end

function ShopViewPresentor:buildViews()
	return {
		ShopView.New()
	}
end

return ShopViewPresentor
