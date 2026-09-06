-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingdragonchallenge/view/DivineKingDragonChallengeStageTeamViewPresentor.lua

module("logic.extensions.godkingdragonchallenge.view.DivineKingDragonChallengeStageTeamViewPresentor", package.seeall)

local DivineKingDragonChallengeStageTeamViewPresentor = class("DivineKingDragonChallengeStageTeamViewPresentor", ViewPresentor)

function DivineKingDragonChallengeStageTeamViewPresentor:ctor()
	DivineKingDragonChallengeStageTeamViewPresentor.super.ctor(self)
end

function DivineKingDragonChallengeStageTeamViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineKingDragonChallengeStageTeamViewPresentor:dependWhatResources()
	return {
		"ui/views/divinekingdragonchallenge/divinekingdragonchallengestageteamview.prefab"
	}
end

function DivineKingDragonChallengeStageTeamViewPresentor:buildViews()
	return {
		DivineKingDragonChallengeStageTeamView.New()
	}
end

return DivineKingDragonChallengeStageTeamViewPresentor
