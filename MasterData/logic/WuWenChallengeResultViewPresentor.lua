-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wuwenchallenge/view/WuWenChallengeResultViewPresentor.lua

module("logic.extensions.wuwenchallenge.view.WuWenChallengeResultViewPresentor", package.seeall)

local WuWenChallengeResultViewPresentor = class("WuWenChallengeResultViewPresentor", ViewPresentor)

function WuWenChallengeResultViewPresentor:ctor()
	WuWenChallengeResultViewPresentor.super.ctor(self)
end

function WuWenChallengeResultViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function WuWenChallengeResultViewPresentor:dependWhatResources()
	return {
		"ui/views/wuwenchallenge/wuwenchallengeresultview.prefab"
	}
end

function WuWenChallengeResultViewPresentor:buildViews()
	return {
		WuWenChallengeResultView.New()
	}
end

return WuWenChallengeResultViewPresentor
