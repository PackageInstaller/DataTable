-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miyachallenge/view/MiyaChallengeLevelViewPresentor.lua

module("logic.extensions.miyachallenge.view.MiyaChallengeLevelViewPresentor", package.seeall)

local MiyaChallengeLevelViewPresentor = class("MiyaChallengeLevelViewPresentor", ViewPresentor)

function MiyaChallengeLevelViewPresentor:ctor()
	MiyaChallengeLevelViewPresentor.super.ctor(self)
end

function MiyaChallengeLevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MiyaChallengeLevelViewPresentor:dependWhatResources()
	return {
		"ui/views/miyachallenge/miyachallengelevelview.prefab"
	}
end

function MiyaChallengeLevelViewPresentor:buildViews()
	return {
		MiyaChallengeLevelView.New()
	}
end

function MiyaChallengeLevelViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return MiyaChallengeLevelViewPresentor
