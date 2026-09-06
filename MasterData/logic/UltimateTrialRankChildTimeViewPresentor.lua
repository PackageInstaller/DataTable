-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ultimatetrial/view/UltimateTrialRankChildTimeViewPresentor.lua

module("logic.extensions.ultimatetrial.view.UltimateTrialRankChildTimeViewPresentor", package.seeall)

local UltimateTrialRankChildTimeViewPresentor = class("UltimateTrialRankChildTimeViewPresentor", ViewPresentor)

function UltimateTrialRankChildTimeViewPresentor:ctor()
	UltimateTrialRankChildTimeViewPresentor.super.ctor(self)
end

function UltimateTrialRankChildTimeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function UltimateTrialRankChildTimeViewPresentor:dependWhatResources()
	return {
		"ui/views/ultimatetrial/ultimatetrialrankchildtimeview.prefab"
	}
end

function UltimateTrialRankChildTimeViewPresentor:buildViews()
	return {
		UltimateTrialRankChildTimeView.New()
	}
end

function UltimateTrialRankChildTimeViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return UltimateTrialRankChildTimeViewPresentor
