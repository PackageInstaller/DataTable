-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holylight/view/HolyLightBossViewPresentor.lua

module("logic.extensions.holylight.view.HolyLightBossViewPresentor", package.seeall)

local HolyLightBossViewPresentor = class("HolyLightBossViewPresentor", ViewPresentor)

function HolyLightBossViewPresentor:ctor()
	HolyLightBossViewPresentor.super.ctor(self)
end

function HolyLightBossViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function HolyLightBossViewPresentor:dependWhatResources()
	return {
		"ui/views/holylight/holylightbossview.prefab"
	}
end

function HolyLightBossViewPresentor:buildViews()
	return {
		HolyLightBossView.New()
	}
end

return HolyLightBossViewPresentor
