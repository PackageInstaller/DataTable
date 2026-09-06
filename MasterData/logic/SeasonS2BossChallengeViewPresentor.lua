-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/seasonS2/SeasonS2BossChallengeViewPresentor.lua

module("logic.extensions.season.view.seasonS2.SeasonS2BossChallengeViewPresentor", package.seeall)

local SeasonS2BossChallengeViewPresentor = class("SeasonS2BossChallengeViewPresentor", ViewPresentor)

function SeasonS2BossChallengeViewPresentor:ctor()
	SeasonS2BossChallengeViewPresentor.super.ctor(self)
end

function SeasonS2BossChallengeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SeasonS2BossChallengeViewPresentor:dependWhatResources()
	return {
		"ui/views/season/season2/seasons2bosschallengeview.prefab"
	}
end

function SeasonS2BossChallengeViewPresentor:buildViews()
	return {
		SeasonS2BossChallengeView.New()
	}
end

return SeasonS2BossChallengeViewPresentor
