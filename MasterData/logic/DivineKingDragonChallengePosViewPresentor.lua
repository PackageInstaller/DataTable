-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingdragonchallenge/view/DivineKingDragonChallengePosViewPresentor.lua

module("logic.extensions.divinekingdragonchallenge.view.DivineKingDragonChallengePosViewPresentor", package.seeall)

local DivineKingDragonChallengePosViewPresentor = class("DivineKingDragonChallengePosViewPresentor", ViewPresentor)

function DivineKingDragonChallengePosViewPresentor:ctor()
	DivineKingDragonChallengePosViewPresentor.super.ctor(self)
end

function DivineKingDragonChallengePosViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineKingDragonChallengePosViewPresentor:dependWhatResources()
	return {
		"ui/views/divinekingdragonchallenge/divinekingdragonchallengeposview.prefab"
	}
end

function DivineKingDragonChallengePosViewPresentor:buildViews()
	return {
		DivineKingDragonChallengePosView.New()
	}
end

return DivineKingDragonChallengePosViewPresentor
