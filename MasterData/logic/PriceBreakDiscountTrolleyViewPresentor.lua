-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pricebreakdiscount/view/PriceBreakDiscountTrolleyViewPresentor.lua

module("logic.extensions.pricebreakdiscount.view.PriceBreakDiscountTrolleyViewPresentor", package.seeall)

local PriceBreakDiscountTrolleyViewPresentor = class("PriceBreakDiscountTrolleyViewPresentor", ViewPresentor)

function PriceBreakDiscountTrolleyViewPresentor:ctor()
	PriceBreakDiscountTrolleyViewPresentor.super.ctor(self)
end

function PriceBreakDiscountTrolleyViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PriceBreakDiscountTrolleyViewPresentor:dependWhatResources()
	return {
		"ui/views/pricebreakdiscount/pricebreakdiscounttrolleyview.prefab"
	}
end

function PriceBreakDiscountTrolleyViewPresentor:buildViews()
	return {
		PriceBreakDiscountTrolleyView.New()
	}
end

function PriceBreakDiscountTrolleyViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return PriceBreakDiscountTrolleyViewPresentor
