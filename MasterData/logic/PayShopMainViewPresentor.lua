-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/payshop/view/PayShopMainViewPresentor.lua

module("logic.extensions.payshop.view.PayShopMainViewPresentor", package.seeall)

local PayShopMainViewPresentor = class("PayShopMainViewPresentor", ViewPresentor)

function PayShopMainViewPresentor:ctor()
	PayShopMainViewPresentor.super.ctor(self)
end

function PayShopMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PayShopMainViewPresentor:dependWhatResources()
	return {
		"ui/views/payshop/payshopmainview.prefab"
	}
end

function PayShopMainViewPresentor:buildViews()
	return {
		PayShopMainView.New()
	}
end

return PayShopMainViewPresentor
