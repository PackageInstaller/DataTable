-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dressactivityshop/view/DiscountDressShopViewPresentor.lua

module("logic.extensions.dressactivityshop.view.DiscountDressShopViewPresentor", package.seeall)

local DiscountDressShopViewPresentor = class("DiscountDressShopViewPresentor", ViewPresentor)

function DiscountDressShopViewPresentor:ctor()
	DiscountDressShopViewPresentor.super.ctor(self)
end

function DiscountDressShopViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DiscountDressShopViewPresentor:dependWhatResources()
	return {
		"ui/views/multicommoditysale/discountdressshopview.prefab"
	}
end

function DiscountDressShopViewPresentor:buildViews()
	return {
		DiscountDressShopView.New()
	}
end

return DiscountDressShopViewPresentor
