-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ultimatetrial/view/UltimateTrialRankFatherViewPresentor.lua

module("logic.extensions.ultimatetrial.view.UltimateTrialRankFatherViewPresentor", package.seeall)

local UltimateTrialRankFatherViewPresentor = class("UltimateTrialRankFatherViewPresentor", ViewPresentor)

function UltimateTrialRankFatherViewPresentor:ctor()
	UltimateTrialRankFatherViewPresentor.super.ctor(self)
end

function UltimateTrialRankFatherViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function UltimateTrialRankFatherViewPresentor:dependWhatResources()
	return {
		"ui/views/ultimatetrial/ultimatetrialrankfatherview.prefab"
	}
end

function UltimateTrialRankFatherViewPresentor:buildViews()
	return {
		UltimateTrialRankFatherView.New()
	}
end

return UltimateTrialRankFatherViewPresentor
