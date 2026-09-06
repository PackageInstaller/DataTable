-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miyachallenge/view/MiyaChallengeMainViewPresentor.lua

module("logic.extensions.miyachallenge.view.MiyaChallengeMainViewPresentor", package.seeall)

local MiyaChallengeMainViewPresentor = class("MiyaChallengeMainViewPresentor", ViewPresentor)

function MiyaChallengeMainViewPresentor:ctor()
	MiyaChallengeMainViewPresentor.super.ctor(self)
end

function MiyaChallengeMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MiyaChallengeMainViewPresentor:dependWhatResources()
	return {
		"ui/views/miyachallenge/miyachallengemainview.prefab"
	}
end

function MiyaChallengeMainViewPresentor:buildViews()
	return {
		MiyaChallengeMainView.New()
	}
end

function MiyaChallengeMainViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return MiyaChallengeMainViewPresentor
