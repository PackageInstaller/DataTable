-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/seasonS2/SeasonS2BossDetatilChallengeViewPresentor.lua

module("logic.extensions.season.view.seasonS2.SeasonS2BossDetatilChallengeViewPresentor", package.seeall)

local SeasonS2BossDetatilChallengeViewPresentor = class("SeasonS2BossDetatilChallengeViewPresentor", ViewPresentor)

function SeasonS2BossDetatilChallengeViewPresentor:ctor()
	SeasonS2BossDetatilChallengeViewPresentor.super.ctor(self)
end

function SeasonS2BossDetatilChallengeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SeasonS2BossDetatilChallengeViewPresentor:dependWhatResources()
	return {
		"ui/views/season/season2/seasons2bossdetatilchallengeview.prefab"
	}
end

function SeasonS2BossDetatilChallengeViewPresentor:buildViews()
	return {
		SeasonS2BossDetatilChallengeView.New()
	}
end

return SeasonS2BossDetatilChallengeViewPresentor
