-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luyinjiade/view/LuYinJiaDeChallengeRankTabFrameViewPresentor.lua

module("logic.extensions.luyinjiade.view.LuYinJiaDeChallengeRankTabFrameViewPresentor", package.seeall)

local LuYinJiaDeChallengeRankTabFrameViewPresentor = class("LuYinJiaDeChallengeRankTabFrameViewPresentor", ViewPresentor)

function LuYinJiaDeChallengeRankTabFrameViewPresentor:ctor()
	LuYinJiaDeChallengeRankTabFrameViewPresentor.super.ctor(self)
end

function LuYinJiaDeChallengeRankTabFrameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LuYinJiaDeChallengeRankTabFrameViewPresentor:dependWhatResources()
	return {
		"ui/views/luyinjiade/luyinjiadechallengeranktabframeview.prefab"
	}
end

function LuYinJiaDeChallengeRankTabFrameViewPresentor:buildViews()
	return {
		LuYinJiaDeChallengeRankTabFrameView.New()
	}
end

return LuYinJiaDeChallengeRankTabFrameViewPresentor
