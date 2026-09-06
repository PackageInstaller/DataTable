-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jiehuangchallenge/view/JieHuangChallengeSelectViewPresentor.lua

module("logic.extensions.jiehuangchallenge.view.JieHuangChallengeSelectViewPresentor", package.seeall)

local JieHuangChallengeSelectViewPresentor = class("JieHuangChallengeSelectViewPresentor", ViewPresentor)

function JieHuangChallengeSelectViewPresentor:ctor()
	JieHuangChallengeSelectViewPresentor.super.ctor(self)
end

function JieHuangChallengeSelectViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function JieHuangChallengeSelectViewPresentor:dependWhatResources()
	return {
		"ui/views/jiehuangchallenge/jiehuangchallengeselectview.prefab"
	}
end

function JieHuangChallengeSelectViewPresentor:buildViews()
	return {
		JieHuangChallengeSelectView.New()
	}
end

function JieHuangChallengeSelectViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return JieHuangChallengeSelectViewPresentor
