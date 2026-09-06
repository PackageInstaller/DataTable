-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclehero/view/MiracleHeroMyTeamViewPresentor.lua

module("logic.extensions.miraclehero.view.MiracleHeroMyTeamViewPresentor", package.seeall)

local MiracleHeroMyTeamViewPresentor = class("MiracleHeroMyTeamViewPresentor", ViewPresentor)

function MiracleHeroMyTeamViewPresentor:ctor()
	MiracleHeroMyTeamViewPresentor.super.ctor(self)
end

function MiracleHeroMyTeamViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MiracleHeroMyTeamViewPresentor:dependWhatResources()
	return {
		"ui/views/miraclehero/miracleheromyteamview.prefab"
	}
end

function MiracleHeroMyTeamViewPresentor:buildViews()
	return {
		MiracleHeroMyTeamView.New()
	}
end

return MiracleHeroMyTeamViewPresentor
