-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingdragonchallenge/view/DivineKingDragonChallengeStageViewPresentor.lua

module("logic.extensions.godkingdragonchallenge.view.DivineKingDragonChallengeStageViewPresentor", package.seeall)

local DivineKingDragonChallengeStageViewPresentor = class("DivineKingDragonChallengeStageViewPresentor", ViewPresentor)

function DivineKingDragonChallengeStageViewPresentor:ctor()
	DivineKingDragonChallengeStageViewPresentor.super.ctor(self)
end

function DivineKingDragonChallengeStageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineKingDragonChallengeStageViewPresentor:dependWhatResources()
	return {
		"ui/views/divinekingdragonchallenge/divinekingdragonchallengestageview.prefab"
	}
end

function DivineKingDragonChallengeStageViewPresentor:buildViews()
	return {
		DivineKingDragonChallengeStageView.New()
	}
end

return DivineKingDragonChallengeStageViewPresentor
