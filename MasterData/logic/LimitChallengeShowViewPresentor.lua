-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/legend/view/limit/LimitChallengeShowViewPresentor.lua

module("logic.extensions.legend.view.limit.LimitChallengeShowViewPresentor", package.seeall)

local LimitChallengeShowViewPresentor = class("LimitChallengeShowViewPresentor", ViewPresentor)

function LimitChallengeShowViewPresentor:ctor()
	LimitChallengeShowViewPresentor.super.ctor(self)
end

function LimitChallengeShowViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LimitChallengeShowViewPresentor:dependWhatResources()
	return {
		"ui/views/legend/limit/limitchallengeshowview.prefab"
	}
end

function LimitChallengeShowViewPresentor:buildViews()
	return {
		LimitChallengeShowView.New()
	}
end

return LimitChallengeShowViewPresentor
