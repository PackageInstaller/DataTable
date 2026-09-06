-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jiehuangchallenge/view/JieHuangChallengeRuleViewPresentor.lua

module("logic.extensions.jiehuangchallenge.view.JieHuangChallengeRuleViewPresentor", package.seeall)

local JieHuangChallengeRuleViewPresentor = class("JieHuangChallengeRuleViewPresentor", ViewPresentor)

function JieHuangChallengeRuleViewPresentor:ctor()
	JieHuangChallengeRuleViewPresentor.super.ctor(self)
end

function JieHuangChallengeRuleViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function JieHuangChallengeRuleViewPresentor:dependWhatResources()
	return {
		"ui/views/jiehuangchallenge/jiehuangchallengeruleview.prefab"
	}
end

function JieHuangChallengeRuleViewPresentor:buildViews()
	return {
		JieHuangChallengeRuleView.New()
	}
end

function JieHuangChallengeRuleViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return JieHuangChallengeRuleViewPresentor
