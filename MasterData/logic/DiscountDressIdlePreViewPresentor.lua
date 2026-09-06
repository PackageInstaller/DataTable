-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dressactivityshop/view/DiscountDressIdlePreViewPresentor.lua

module("logic.extensions.dressactivityshop.view.DiscountDressIdlePreViewPresentor", package.seeall)

local DiscountDressIdlePreViewPresentor = class("DiscountDressIdlePreViewPresentor", ViewPresentor)

function DiscountDressIdlePreViewPresentor:ctor()
	DiscountDressIdlePreViewPresentor.super.ctor(self)
end

function DiscountDressIdlePreViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DiscountDressIdlePreViewPresentor:dependWhatResources()
	return {
		"ui/views/multicommoditysale/discountdressidlepreview.prefab"
	}
end

function DiscountDressIdlePreViewPresentor:buildViews()
	return {
		DiscountDressIdlePreView.New()
	}
end

return DiscountDressIdlePreViewPresentor
