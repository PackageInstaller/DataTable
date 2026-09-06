-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/payshop/view/PayShopRechargeViewPresentor.lua

module("logic.extensions.payshop.view.PayShopRechargeViewPresentor", package.seeall)

local PayShopRechargeViewPresentor = class("PayShopRechargeViewPresentor", ViewPresentor)

function PayShopRechargeViewPresentor:ctor()
	PayShopRechargeViewPresentor.super.ctor(self)
end

function PayShopRechargeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PayShopRechargeViewPresentor:dependWhatResources()
	return {
		"ui/views/payshop/payshopmibaoview.prefab"
	}
end

function PayShopRechargeViewPresentor:buildViews()
	return {
		PayShopRechargeView.New()
	}
end

function PayShopRechargeViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return PayShopRechargeViewPresentor
