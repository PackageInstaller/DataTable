-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/payshop/view/PayShopMibaoViewPresentor.lua

module("logic.extensions.payshop.view.PayShopMibaoViewPresentor", package.seeall)

local PayShopMibaoViewPresentor = class("PayShopMibaoViewPresentor", ViewPresentor)

function PayShopMibaoViewPresentor:ctor()
	PayShopMibaoViewPresentor.super.ctor(self)
end

function PayShopMibaoViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PayShopMibaoViewPresentor:dependWhatResources()
	return {
		"ui/views/payshop/payshopmibaoview.prefab"
	}
end

function PayShopMibaoViewPresentor:buildViews()
	return {
		PayShopMibaoView.New()
	}
end

function PayShopMibaoViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return PayShopMibaoViewPresentor
