-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holylight/view/HolyLightBuffViewPresentor.lua

module("logic.extensions.holylight.view.HolyLightBuffViewPresentor", package.seeall)

local HolyLightBuffViewPresentor = class("HolyLightBuffViewPresentor", ViewPresentor)

function HolyLightBuffViewPresentor:ctor()
	HolyLightBuffViewPresentor.super.ctor(self)
end

function HolyLightBuffViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function HolyLightBuffViewPresentor:dependWhatResources()
	return {
		"ui/views/holylight/holylightbuffview.prefab"
	}
end

function HolyLightBuffViewPresentor:buildViews()
	return {
		HolyLightBuffView.New()
	}
end

return HolyLightBuffViewPresentor
