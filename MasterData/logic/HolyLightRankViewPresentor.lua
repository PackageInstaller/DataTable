-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holylight/view/HolyLightRankViewPresentor.lua

module("logic.extensions.holylight.view.HolyLightRankViewPresentor", package.seeall)

local HolyLightRankViewPresentor = class("HolyLightRankViewPresentor", ViewPresentor)

function HolyLightRankViewPresentor:ctor()
	HolyLightRankViewPresentor.super.ctor(self)
end

function HolyLightRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HolyLightRankViewPresentor:dependWhatResources()
	return {
		"ui/views/holylight/holylightrankview.prefab"
	}
end

function HolyLightRankViewPresentor:buildViews()
	return {
		HolyLightRankView.New()
	}
end

return HolyLightRankViewPresentor
