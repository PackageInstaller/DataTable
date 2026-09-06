-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miracleherocopy/view/MiracleHeroCopyMyTeamViewPresentor.lua

module("logic.extensions.miracleherocopy.view.MiracleHeroCopyMyTeamViewPresentor", package.seeall)

local MiracleHeroCopyMyTeamViewPresentor = class("MiracleHeroCopyMyTeamViewPresentor", ViewPresentor)

function MiracleHeroCopyMyTeamViewPresentor:ctor()
	MiracleHeroCopyMyTeamViewPresentor.super.ctor(self)
end

function MiracleHeroCopyMyTeamViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MiracleHeroCopyMyTeamViewPresentor:dependWhatResources()
	return {
		"ui/views/miracleherocopy/miracleherocopymyteamview.prefab"
	}
end

function MiracleHeroCopyMyTeamViewPresentor:buildViews()
	return {
		MiracleHeroCopyMyTeamView.New()
	}
end

return MiracleHeroCopyMyTeamViewPresentor
