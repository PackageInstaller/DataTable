-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shop/view/ShopMessViewPresentor.lua

module("logic.extensions.shop.view.ShopMessViewPresentor", package.seeall)

local ShopMessViewPresentor = class("ShopMessViewPresentor", ViewPresentor)

function ShopMessViewPresentor:ctor()
	ShopMessViewPresentor.super.ctor(self)
end

function ShopMessViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ShopMessViewPresentor:dependWhatResources()
	return {
		"ui/views/shop/shopgiftview.prefab"
	}
end

function ShopMessViewPresentor:buildViews()
	return {
		ShopMessView.New()
	}
end

function ShopMessViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ShopMessViewPresentor
