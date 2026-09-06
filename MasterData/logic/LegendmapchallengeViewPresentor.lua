-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/legend/view/LegendmapchallengeViewPresentor.lua

module("logic.extensions.legend.view.LegendmapchallengeViewPresentor", package.seeall)

local LegendmapchallengeViewPresentor = class("LegendmapchallengeViewPresentor", ViewWithGuidePresentor)

function LegendmapchallengeViewPresentor:ctor()
	LegendmapchallengeViewPresentor.super.ctor(self)
end

function LegendmapchallengeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LegendmapchallengeViewPresentor:dependWhatResources()
	return {
		"ui/views/legend/legendmapchallengeview.prefab"
	}
end

function LegendmapchallengeViewPresentor:buildViews()
	return {
		LegendmapchallengeView.New()
	}
end

return LegendmapchallengeViewPresentor
