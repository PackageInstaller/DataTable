-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonbosschallengeViewPresentor.lua

module("logic.extensions.season.view.SeasonbosschallengeViewPresentor", package.seeall)

local SeasonbosschallengeViewPresentor = class("SeasonbosschallengeViewPresentor", ViewPresentor)

function SeasonbosschallengeViewPresentor:ctor()
	SeasonbosschallengeViewPresentor.super.ctor(self)
end

function SeasonbosschallengeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SeasonbosschallengeViewPresentor:dependWhatResources()
	return {
		"ui/views/season/seasonbosschallengeview.prefab"
	}
end

function SeasonbosschallengeViewPresentor:buildViews()
	return {
		SeasonBossChallengeView.New()
	}
end

return SeasonbosschallengeViewPresentor
