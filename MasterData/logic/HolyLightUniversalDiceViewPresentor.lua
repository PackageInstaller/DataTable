-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holylight/view/HolyLightUniversalDiceViewPresentor.lua

module("logic.extensions.holylight.view.HolyLightUniversalDiceViewPresentor", package.seeall)

local HolyLightUniversalDiceViewPresentor = class("HolyLightUniversalDiceViewPresentor", ViewPresentor)

function HolyLightUniversalDiceViewPresentor:ctor()
	HolyLightUniversalDiceViewPresentor.super.ctor(self)
end

function HolyLightUniversalDiceViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function HolyLightUniversalDiceViewPresentor:dependWhatResources()
	return {
		"ui/views/holylight/holylightuniversaldiceview.prefab"
	}
end

function HolyLightUniversalDiceViewPresentor:buildViews()
	return {
		HolyLightUniversalDiceView.New()
	}
end

return HolyLightUniversalDiceViewPresentor
