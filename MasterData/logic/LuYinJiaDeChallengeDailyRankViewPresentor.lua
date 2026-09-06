-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luyinjiade/view/LuYinJiaDeChallengeDailyRankViewPresentor.lua

module("logic.extensions.luyinjiade.view.LuYinJiaDeChallengeDailyRankViewPresentor", package.seeall)

local LuYinJiaDeChallengeDailyRankViewPresentor = class("LuYinJiaDeChallengeDailyRankViewPresentor", ViewPresentor)

function LuYinJiaDeChallengeDailyRankViewPresentor:ctor()
	LuYinJiaDeChallengeDailyRankViewPresentor.super.ctor(self)
end

function LuYinJiaDeChallengeDailyRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LuYinJiaDeChallengeDailyRankViewPresentor:dependWhatResources()
	return {
		"ui/views/luyinjiade/luyinjiadechallengedailyrankview.prefab"
	}
end

function LuYinJiaDeChallengeDailyRankViewPresentor:buildViews()
	return {
		LuYinJiaDeChallengeDailyRankView.New()
	}
end

return LuYinJiaDeChallengeDailyRankViewPresentor
