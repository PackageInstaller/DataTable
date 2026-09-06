-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yishichallenge/view/YishiChallengeMainViewPresentor.lua

module("logic.extensions.yishichallenge.view.YishiChallengeMainViewPresentor", package.seeall)

local YishiChallengeMainViewPresentor = class("YishiChallengeMainViewPresentor", ViewPresentor)

function YishiChallengeMainViewPresentor:ctor()
	YishiChallengeMainViewPresentor.super.ctor(self)
end

function YishiChallengeMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YishiChallengeMainViewPresentor:dependWhatResources()
	return {
		"ui/views/yishichallenge/yishichallengemainview.prefab"
	}
end

function YishiChallengeMainViewPresentor:buildViews()
	return {
		YishiChallengeMainView.New()
	}
end

return YishiChallengeMainViewPresentor
