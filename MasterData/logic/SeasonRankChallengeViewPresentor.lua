-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonRankChallengeViewPresentor.lua

module("logic.extensions.season.view.SeasonRankChallengeViewPresentor", package.seeall)

local SeasonRankChallengeViewPresentor = class("SeasonRankChallengeViewPresentor", ViewPresentor)

function SeasonRankChallengeViewPresentor:ctor()
	SeasonRankChallengeViewPresentor.super.ctor(self)
end

function SeasonRankChallengeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SeasonRankChallengeViewPresentor:dependWhatResources()
	return {
		"ui/views/season/seasonrankchallengeview.prefab"
	}
end

function SeasonRankChallengeViewPresentor:buildViews()
	return {
		SeasonRankChallengeView.New()
	}
end

function SeasonRankChallengeViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return SeasonRankChallengeViewPresentor
