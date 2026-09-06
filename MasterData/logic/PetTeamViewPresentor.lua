-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/handbook/view/PetTeamViewPresentor.lua

module("logic.extensions.handbook.view.PetTeamViewPresentor", package.seeall)

local PetTeamViewPresentor = class("PetTeamViewPresentor", ViewWithGuidePresentor)

function PetTeamViewPresentor:ctor()
	PetTeamViewPresentor.super.ctor(self)
end

function PetTeamViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetTeamViewPresentor:dependWhatResources()
	return {
		"ui/views/handbook/petteamview.prefab"
	}
end

function PetTeamViewPresentor:buildViews()
	return {
		PetTeamView.New()
	}
end

return PetTeamViewPresentor
