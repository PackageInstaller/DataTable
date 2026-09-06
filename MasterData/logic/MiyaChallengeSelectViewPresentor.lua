-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miyachallenge/view/MiyaChallengeSelectViewPresentor.lua

module("logic.extensions.miyachallenge.view.MiyaChallengeSelectViewPresentor", package.seeall)

local MiyaChallengeSelectViewPresentor = class("MiyaChallengeSelectViewPresentor", ViewPresentor)

function MiyaChallengeSelectViewPresentor:ctor()
	MiyaChallengeSelectViewPresentor.super.ctor(self)
end

function MiyaChallengeSelectViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function MiyaChallengeSelectViewPresentor:dependWhatResources()
	return {
		"ui/views/miyachallenge/miyachallengeselectview.prefab"
	}
end

function MiyaChallengeSelectViewPresentor:buildViews()
	return {
		MiyaChallengeSelectView.New()
	}
end

function MiyaChallengeSelectViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return MiyaChallengeSelectViewPresentor
