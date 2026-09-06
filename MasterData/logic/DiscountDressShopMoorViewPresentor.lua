-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dressactivityshop/view/DiscountDressShopMoorViewPresentor.lua

module("logic.extensions.dressactivityshop.view.DiscountDressShopMoorViewPresentor", package.seeall)

local DiscountDressShopMoorViewPresentor = class("DiscountDressShopMoorViewPresentor", ViewPresentor)

function DiscountDressShopMoorViewPresentor:ctor()
	DiscountDressShopMoorViewPresentor.super.ctor(self)
end

function DiscountDressShopMoorViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DiscountDressShopMoorViewPresentor:dependWhatResources()
	return {
		"ui/views/multicommoditysale/discountdressshopmoorview.prefab"
	}
end

function DiscountDressShopMoorViewPresentor:buildViews()
	return {
		DiscountDressShopMoorView.New()
	}
end

function DiscountDressShopMoorViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return DiscountDressShopMoorViewPresentor
