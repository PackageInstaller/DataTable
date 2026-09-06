-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/payshop/view/PayShopMibaoBuyViewPresentor.lua

module("logic.extensions.payshop.view.PayShopMibaoBuyViewPresentor", package.seeall)

local PayShopMibaoBuyViewPresentor = class("PayShopMibaoBuyViewPresentor", ViewPresentor)

function PayShopMibaoBuyViewPresentor:ctor()
	PayShopMibaoBuyViewPresentor.super.ctor(self)
end

function PayShopMibaoBuyViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PayShopMibaoBuyViewPresentor:dependWhatResources()
	return {
		"ui/views/payshop/payshopmibaobuyview.prefab"
	}
end

function PayShopMibaoBuyViewPresentor:buildViews()
	return {
		PayShopMibaoBuyView.New()
	}
end

return PayShopMibaoBuyViewPresentor
