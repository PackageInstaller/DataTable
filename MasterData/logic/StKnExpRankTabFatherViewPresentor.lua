-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stknexp/view/StKnExpRankTabFatherViewPresentor.lua

module("logic.extensions.stknexp.view.StKnExpRankTabFatherViewPresentor", package.seeall)

local StKnExpRankTabFatherViewPresentor = class("StKnExpRankTabFatherViewPresentor", ViewPresentor)

function StKnExpRankTabFatherViewPresentor:ctor()
	StKnExpRankTabFatherViewPresentor.super.ctor(self)
end

function StKnExpRankTabFatherViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function StKnExpRankTabFatherViewPresentor:dependWhatResources()
	return {
		"ui/views/stknexp/stknexpranktabfatherview.prefab"
	}
end

function StKnExpRankTabFatherViewPresentor:buildViews()
	return {
		StKnExpRankTabFatherView.New()
	}
end

return StKnExpRankTabFatherViewPresentor
