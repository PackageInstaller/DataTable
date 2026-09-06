-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ultimatetrial/view/PetChallengeFirstPassRankViewPresentor.lua

module("logic.extensions.ultimatetrial.view.PetChallengeFirstPassRankViewPresentor", package.seeall)

local PetChallengeFirstPassRankViewPresentor = class("PetChallengeFirstPassRankViewPresentor", ViewPresentor)

function PetChallengeFirstPassRankViewPresentor:ctor()
	PetChallengeFirstPassRankViewPresentor.super.ctor(self)
end

function PetChallengeFirstPassRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetChallengeFirstPassRankViewPresentor:dependWhatResources()
	return {
		"ui/views/ultimatetrial/petchallengefirstpassrankview.prefab"
	}
end

function PetChallengeFirstPassRankViewPresentor:buildViews()
	return {
		PetChallengeFirstPassRankView.New()
	}
end

function PetChallengeFirstPassRankViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return PetChallengeFirstPassRankViewPresentor
