-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shop/view/ShopChargeViewPresentor.lua

module("logic.extensions.shop.view.ShopChargeViewPresentor", package.seeall)

local ShopChargeViewPresentor = class("ShopChargeViewPresentor", ViewPresentor)

function ShopChargeViewPresentor:ctor()
	ShopChargeViewPresentor.super.ctor(self)
end

function ShopChargeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ShopChargeViewPresentor:dependWhatResources()
	return {
		"ui/views/shop/shopchargeview.prefab"
	}
end

function ShopChargeViewPresentor:buildViews()
	return {
		ShopChargeView.New()
	}
end

function ShopChargeViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ShopChargeViewPresentor
