-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miyachallenge/view/MiyaChallengeRuleViewPresentor.lua

module("logic.extensions.miyachallenge.view.MiyaChallengeRuleViewPresentor", package.seeall)

local MiyaChallengeRuleViewPresentor = class("MiyaChallengeRuleViewPresentor", ViewPresentor)

function MiyaChallengeRuleViewPresentor:ctor()
	MiyaChallengeRuleViewPresentor.super.ctor(self)
end

function MiyaChallengeRuleViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function MiyaChallengeRuleViewPresentor:dependWhatResources()
	return {
		"ui/views/miyachallenge/miyachallengeruleview.prefab"
	}
end

function MiyaChallengeRuleViewPresentor:buildViews()
	return {
		MiyaChallengeRuleView.New()
	}
end

function MiyaChallengeRuleViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return MiyaChallengeRuleViewPresentor
