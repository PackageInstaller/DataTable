-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luyinjiade/view/LuYinJiaDeChallengeMainViewPresentor.lua

module("logic.extensions.luyinjiade.view.LuYinJiaDeChallengeMainViewPresentor", package.seeall)

local LuYinJiaDeChallengeMainViewPresentor = class("LuYinJiaDeChallengeMainViewPresentor", ViewPresentor)

function LuYinJiaDeChallengeMainViewPresentor:ctor()
	LuYinJiaDeChallengeMainViewPresentor.super.ctor(self)
end

function LuYinJiaDeChallengeMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LuYinJiaDeChallengeMainViewPresentor:dependWhatResources()
	return {
		"ui/views/luyinjiade/luyinjiadechallengemainview.prefab"
	}
end

function LuYinJiaDeChallengeMainViewPresentor:buildViews()
	return {
		LuYinJiaDeChallengeMainView.New()
	}
end

return LuYinJiaDeChallengeMainViewPresentor
