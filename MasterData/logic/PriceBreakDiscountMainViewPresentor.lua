-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pricebreakdiscount/view/PriceBreakDiscountMainViewPresentor.lua

module("logic.extensions.pricebreakdiscount.view.PriceBreakDiscountMainViewPresentor", package.seeall)

local PriceBreakDiscountMainViewPresentor = class("PriceBreakDiscountMainViewPresentor", ViewPresentor)

function PriceBreakDiscountMainViewPresentor:ctor()
	PriceBreakDiscountMainViewPresentor.super.ctor(self)
end

function PriceBreakDiscountMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PriceBreakDiscountMainViewPresentor:dependWhatResources()
	return {
		"ui/views/pricebreakdiscount/pricebreakdiscountmainview.prefab"
	}
end

function PriceBreakDiscountMainViewPresentor:buildViews()
	return {
		PriceBreakDiscountMainView.New()
	}
end

function PriceBreakDiscountMainViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return PriceBreakDiscountMainViewPresentor
