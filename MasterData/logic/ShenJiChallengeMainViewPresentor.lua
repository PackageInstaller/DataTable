-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shenjichallenge/view/ShenJiChallengeMainViewPresentor.lua

module("logic.extensions.shenjichallenge.view.ShenJiChallengeMainViewPresentor", package.seeall)

local ShenJiChallengeMainViewPresentor = class("ShenJiChallengeMainViewPresentor", ViewPresentor)

function ShenJiChallengeMainViewPresentor:ctor()
	ShenJiChallengeMainViewPresentor.super.ctor(self)
end

function ShenJiChallengeMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ShenJiChallengeMainViewPresentor:dependWhatResources()
	return {
		"ui/views/shenjichallenge/shenjichallengemainview.prefab"
	}
end

function ShenJiChallengeMainViewPresentor:buildViews()
	return {
		ShenJiChallengeMainView.New()
	}
end

return ShenJiChallengeMainViewPresentor
