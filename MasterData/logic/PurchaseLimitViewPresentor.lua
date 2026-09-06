-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/purchaselimit/view/PurchaseLimitViewPresentor.lua

module("logic.extensions.purchaselimit.view.PurchaseLimitViewPresentor", package.seeall)

local PurchaseLimitViewPresentor = class("PurchaseLimitViewPresentor", ViewPresentor)

function PurchaseLimitViewPresentor:ctor()
	PurchaseLimitViewPresentor.super.ctor(self)
end

function PurchaseLimitViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PurchaseLimitViewPresentor:dependWhatResources()
	return {
		"ui/views/purchaselimit/purchaselimitview.prefab"
	}
end

function PurchaseLimitViewPresentor:buildViews()
	return {
		PurchaseLimitView.New()
	}
end

return PurchaseLimitViewPresentor
