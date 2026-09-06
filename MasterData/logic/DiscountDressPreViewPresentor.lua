-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dressactivityshop/view/DiscountDressPreViewPresentor.lua

module("logic.extensions.dressactivityshop.view.DiscountDressPreViewPresentor", package.seeall)

local DiscountDressPreViewPresentor = class("DiscountDressPreViewPresentor", ViewPresentor)

function DiscountDressPreViewPresentor:ctor()
	DiscountDressPreViewPresentor.super.ctor(self)
end

function DiscountDressPreViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DiscountDressPreViewPresentor:dependWhatResources()
	return {
		"ui/views/multicommoditysale/discountdresspreview.prefab"
	}
end

function DiscountDressPreViewPresentor:buildViews()
	return {
		DiscountDressPreView.New()
	}
end

return DiscountDressPreViewPresentor
