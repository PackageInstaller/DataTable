-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/view/FmtScoreViewPresentor.lua

module("logic.extensions.mission.view.FmtScoreViewPresentor", package.seeall)

local FmtScoreViewPresentor = class("FmtScoreViewPresentor", ViewPresentor)

function FmtScoreViewPresentor:ctor()
	FmtScoreViewPresentor.super.ctor(self)
end

function FmtScoreViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FmtScoreViewPresentor:dependWhatResources()
	return {
		"ui/views/challenge/fmtscoreview.prefab"
	}
end

function FmtScoreViewPresentor:buildViews()
	return {
		FmtScoreView.New()
	}
end

return FmtScoreViewPresentor
