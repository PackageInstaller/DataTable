-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guardcity/view/GuardCityChallengeRewardViewPresentor.lua

module("logic.extensions.guardcity.view.GuardCityChallengeRewardViewPresentor", package.seeall)

local GuardCityChallengeRewardViewPresentor = class("GuardCityChallengeRewardViewPresentor", ViewPresentor)

function GuardCityChallengeRewardViewPresentor:ctor()
	GuardCityChallengeRewardViewPresentor.super.ctor(self)
end

function GuardCityChallengeRewardViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function GuardCityChallengeRewardViewPresentor:dependWhatResources()
	return {
		"ui/views/guardcity/guardcitychallengerewardview.prefab"
	}
end

function GuardCityChallengeRewardViewPresentor:buildViews()
	return {
		GuardCityChallengeRewardView.New()
	}
end

function GuardCityChallengeRewardViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return GuardCityChallengeRewardViewPresentor
