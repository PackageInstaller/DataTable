-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miyachallenge/view/MiyaChallengeRewardViewPresentor.lua

module("logic.extensions.miyachallenge.view.MiyaChallengeRewardViewPresentor", package.seeall)

local MiyaChallengeRewardViewPresentor = class("MiyaChallengeRewardViewPresentor", ViewPresentor)

function MiyaChallengeRewardViewPresentor:ctor()
	MiyaChallengeRewardViewPresentor.super.ctor(self)
end

function MiyaChallengeRewardViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function MiyaChallengeRewardViewPresentor:dependWhatResources()
	return {
		"ui/views/miyachallenge/miyachallengerewardview.prefab"
	}
end

function MiyaChallengeRewardViewPresentor:buildViews()
	return {
		MiyaChallengeRewardView.New()
	}
end

function MiyaChallengeRewardViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return MiyaChallengeRewardViewPresentor
