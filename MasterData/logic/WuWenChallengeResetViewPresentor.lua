-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wuwenchallenge/view/WuWenChallengeResetViewPresentor.lua

module("logic.extensions.wuwenchallenge.view.WuWenChallengeResetViewPresentor", package.seeall)

local WuWenChallengeResetViewPresentor = class("WuWenChallengeResetViewPresentor", ViewPresentor)

function WuWenChallengeResetViewPresentor:ctor()
	WuWenChallengeResetViewPresentor.super.ctor(self)
end

function WuWenChallengeResetViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function WuWenChallengeResetViewPresentor:dependWhatResources()
	return {
		"ui/views/wuwenchallenge/wuwenchallengeresetview.prefab"
	}
end

function WuWenChallengeResetViewPresentor:buildViews()
	return {
		WuWenChallengeResetView.New()
	}
end

return WuWenChallengeResetViewPresentor
