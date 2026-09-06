-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luyinjiade/view/LuYinJiaDeChallengeLevelViewPresentor.lua

module("logic.extensions.luyinjiade.view.LuYinJiaDeChallengeLevelViewPresentor", package.seeall)

local LuYinJiaDeChallengeLevelViewPresentor = class("LuYinJiaDeChallengeLevelViewPresentor", ViewPresentor)

function LuYinJiaDeChallengeLevelViewPresentor:ctor()
	LuYinJiaDeChallengeLevelViewPresentor.super.ctor(self)
end

function LuYinJiaDeChallengeLevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LuYinJiaDeChallengeLevelViewPresentor:dependWhatResources()
	return {
		"ui/views/luyinjiade/luyinjiadechallengelevelview.prefab"
	}
end

function LuYinJiaDeChallengeLevelViewPresentor:buildViews()
	return {
		LuYinJiaDeChallengeLevelView.New()
	}
end

return LuYinJiaDeChallengeLevelViewPresentor
