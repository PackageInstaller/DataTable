-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shop/view/ShopGiftViewPresentor.lua

module("logic.extensions.shop.view.ShopGiftViewPresentor", package.seeall)

local ShopGiftViewPresentor = class("ShopGiftViewPresentor", ViewPresentor)

function ShopGiftViewPresentor:ctor()
	ShopGiftViewPresentor.super.ctor(self)
end

function ShopGiftViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ShopGiftViewPresentor:dependWhatResources()
	return {
		"ui/views/shop/shopgiftview.prefab"
	}
end

function ShopGiftViewPresentor:buildViews()
	return {
		ShopGiftView.New()
	}
end

function ShopGiftViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ShopGiftViewPresentor
