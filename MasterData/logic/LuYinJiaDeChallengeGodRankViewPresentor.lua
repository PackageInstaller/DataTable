-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luyinjiade/view/LuYinJiaDeChallengeGodRankViewPresentor.lua

module("logic.extensions.luyinjiade.view.LuYinJiaDeChallengeGodRankViewPresentor", package.seeall)

local LuYinJiaDeChallengeGodRankViewPresentor = class("LuYinJiaDeChallengeGodRankViewPresentor", ViewPresentor)

function LuYinJiaDeChallengeGodRankViewPresentor:ctor()
	LuYinJiaDeChallengeGodRankViewPresentor.super.ctor(self)
end

function LuYinJiaDeChallengeGodRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LuYinJiaDeChallengeGodRankViewPresentor:dependWhatResources()
	return {
		"ui/views/luyinjiade/luyinjiadechallengegodrankview.prefab"
	}
end

function LuYinJiaDeChallengeGodRankViewPresentor:buildViews()
	return {
		LuYinJiaDeChallengeGodRankView.New()
	}
end

return LuYinJiaDeChallengeGodRankViewPresentor
