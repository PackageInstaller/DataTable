-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holylight/view/HolyLightPetShopViewPresentor.lua

module("logic.extensions.holylight.view.HolyLightPetShopViewPresentor", package.seeall)

local HolyLightPetShopViewPresentor = class("HolyLightPetShopViewPresentor", ViewPresentor)

function HolyLightPetShopViewPresentor:ctor()
	HolyLightPetShopViewPresentor.super.ctor(self)
end

function HolyLightPetShopViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HolyLightPetShopViewPresentor:dependWhatResources()
	return {
		"ui/views/holylight/holylightpetshopview.prefab"
	}
end

function HolyLightPetShopViewPresentor:buildViews()
	return {
		HolyLightPetShopView.New()
	}
end

return HolyLightPetShopViewPresentor
