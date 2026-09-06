-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/discountaccruingpay/view/DiscountaccruingpayViewPresentor.lua

module("logic.extensions.discountaccruingpay.view.DiscountaccruingpayViewPresentor", package.seeall)

local DiscountaccruingpayViewPresentor = class("DiscountaccruingpayViewPresentor", ViewPresentor)

function DiscountaccruingpayViewPresentor:ctor()
	DiscountaccruingpayViewPresentor.super.ctor(self)
end

function DiscountaccruingpayViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DiscountaccruingpayViewPresentor:dependWhatResources()
	return {
		"ui/views/discountaccruingpay/discountaccruingpayview.prefab"
	}
end

function DiscountaccruingpayViewPresentor:buildViews()
	return {
		DiscountaccruingpayView.New()
	}
end

return DiscountaccruingpayViewPresentor
