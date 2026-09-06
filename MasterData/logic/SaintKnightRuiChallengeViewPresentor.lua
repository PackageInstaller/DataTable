-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/saintknightrui/view/SaintKnightRuiChallengeViewPresentor.lua

module("logic.extensions.saintknightrui.view.SaintKnightRuiChallengeViewPresentor", package.seeall)

local SaintKnightRuiChallengeViewPresentor = class("SaintKnightRuiChallengeViewPresentor", ViewPresentor)

function SaintKnightRuiChallengeViewPresentor:ctor()
	SaintKnightRuiChallengeViewPresentor.super.ctor(self)
end

function SaintKnightRuiChallengeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SaintKnightRuiChallengeViewPresentor:dependWhatResources()
	return {
		"ui/views/saintknightrui/saintknightruichallengeview.prefab"
	}
end

function SaintKnightRuiChallengeViewPresentor:buildViews()
	return {
		SaintKnightRuiChallengeView.New()
	}
end

return SaintKnightRuiChallengeViewPresentor
