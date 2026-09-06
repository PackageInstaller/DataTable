-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dressactivityshop/view/DiscountDressShopMoorTwoViewPresentor.lua

module("logic.extensions.dressactivityshop.view.DiscountDressShopMoorTwoViewPresentor", package.seeall)

local DiscountDressShopMoorTwoViewPresentor = class("DiscountDressShopMoorTwoViewPresentor", ViewPresentor)

function DiscountDressShopMoorTwoViewPresentor:ctor()
	DiscountDressShopMoorTwoViewPresentor.super.ctor(self)
end

function DiscountDressShopMoorTwoViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DiscountDressShopMoorTwoViewPresentor:dependWhatResources()
	return {
		"ui/views/multicommoditysale/discountdressshopmoortwoview.prefab"
	}
end

function DiscountDressShopMoorTwoViewPresentor:buildViews()
	return {
		DiscountDressShopMoorTwoView.New()
	}
end

function DiscountDressShopMoorTwoViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return DiscountDressShopMoorTwoViewPresentor
