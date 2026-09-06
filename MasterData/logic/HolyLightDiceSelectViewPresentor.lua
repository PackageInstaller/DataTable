-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holylight/view/HolyLightDiceSelectViewPresentor.lua

module("logic.extensions.holylight.view.HolyLightDiceSelectViewPresentor", package.seeall)

local HolyLightDiceSelectViewPresentor = class("HolyLightDiceSelectViewPresentor", ViewPresentor)

function HolyLightDiceSelectViewPresentor:ctor()
	HolyLightDiceSelectViewPresentor.super.ctor(self)
end

function HolyLightDiceSelectViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function HolyLightDiceSelectViewPresentor:dependWhatResources()
	return {
		"ui/views/holylight/holylightdiceselectview.prefab"
	}
end

function HolyLightDiceSelectViewPresentor:buildViews()
	return {
		HolyLightDiceSelectView.New()
	}
end

return HolyLightDiceSelectViewPresentor
