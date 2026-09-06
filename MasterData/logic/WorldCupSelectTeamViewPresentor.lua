-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/worldcup/view/WorldCupSelectTeamViewPresentor.lua

module("logic.extensions.worldcup.view.WorldCupSelectTeamViewPresentor", package.seeall)

local WorldCupSelectTeamViewPresentor = class("WorldCupSelectTeamViewPresentor", ViewPresentor)

function WorldCupSelectTeamViewPresentor:ctor()
	WorldCupSelectTeamViewPresentor.super.ctor(self)
end

function WorldCupSelectTeamViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function WorldCupSelectTeamViewPresentor:dependWhatResources()
	return {
		"ui/views/worldcup/worldcupselectteamview.prefab"
	}
end

function WorldCupSelectTeamViewPresentor:buildViews()
	return {
		WorldCupSelectTeamView.New()
	}
end

return WorldCupSelectTeamViewPresentor
