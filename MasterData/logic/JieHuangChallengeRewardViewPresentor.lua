-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jiehuangchallenge/view/JieHuangChallengeRewardViewPresentor.lua

module("logic.extensions.jiehuangchallenge.view.JieHuangChallengeRewardViewPresentor", package.seeall)

local JieHuangChallengeRewardViewPresentor = class("JieHuangChallengeRewardViewPresentor", ViewPresentor)

function JieHuangChallengeRewardViewPresentor:ctor()
	JieHuangChallengeRewardViewPresentor.super.ctor(self)
end

function JieHuangChallengeRewardViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function JieHuangChallengeRewardViewPresentor:dependWhatResources()
	return {
		"ui/views/miyachallenge/miyachallengerewardview.prefab"
	}
end

function JieHuangChallengeRewardViewPresentor:buildViews()
	return {
		JieHuangChallengeRewardView.New()
	}
end

function JieHuangChallengeRewardViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return JieHuangChallengeRewardViewPresentor
