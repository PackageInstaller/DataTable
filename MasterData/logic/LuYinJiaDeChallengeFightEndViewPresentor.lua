-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luyinjiade/view/LuYinJiaDeChallengeFightEndViewPresentor.lua

module("logic.extensions.luyinjiade.view.LuYinJiaDeChallengeFightEndViewPresentor", package.seeall)

local LuYinJiaDeChallengeFightEndViewPresentor = class("LuYinJiaDeChallengeFightEndViewPresentor", ViewPresentor)

function LuYinJiaDeChallengeFightEndViewPresentor:ctor()
	LuYinJiaDeChallengeFightEndViewPresentor.super.ctor(self)
end

function LuYinJiaDeChallengeFightEndViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LuYinJiaDeChallengeFightEndViewPresentor:dependWhatResources()
	return {
		"ui/views/luyinjiade/luyinjiadechallengefightendview.prefab"
	}
end

function LuYinJiaDeChallengeFightEndViewPresentor:buildViews()
	return {
		LuYinJiaDeChallengeFightEndView.New()
	}
end

return LuYinJiaDeChallengeFightEndViewPresentor
