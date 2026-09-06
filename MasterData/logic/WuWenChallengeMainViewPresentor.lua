-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wuwenchallenge/view/WuWenChallengeMainViewPresentor.lua

module("logic.extensions.wuwenchallenge.view.WuWenChallengeMainViewPresentor", package.seeall)

local WuWenChallengeMainViewPresentor = class("WuWenChallengeMainViewPresentor", ViewPresentor)

function WuWenChallengeMainViewPresentor:ctor()
	WuWenChallengeMainViewPresentor.super.ctor(self)
end

function WuWenChallengeMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function WuWenChallengeMainViewPresentor:dependWhatResources()
	return {
		"ui/views/wuwenchallenge/wuwenchallengemainview.prefab"
	}
end

function WuWenChallengeMainViewPresentor:buildViews()
	return {
		WuWenChallengeMainView.New()
	}
end

return WuWenChallengeMainViewPresentor
