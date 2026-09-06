-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonFormTeamViewPresentor.lua

module("logic.extensions.season.view.SeasonFormTeamViewPresentor", package.seeall)

local SeasonFormTeamViewPresentor = class("SeasonFormTeamViewPresentor", ViewPresentor)

function SeasonFormTeamViewPresentor:ctor()
	SeasonFormTeamViewPresentor.super.ctor(self)
end

function SeasonFormTeamViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SeasonFormTeamViewPresentor:dependWhatResources()
	return {
		"ui/views/season/seasonformteamview.prefab"
	}
end

function SeasonFormTeamViewPresentor:buildViews()
	return {
		SeasonFormTeamView.New()
	}
end

return SeasonFormTeamViewPresentor
