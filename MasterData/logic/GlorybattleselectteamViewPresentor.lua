-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/glorybattle/view/GlorybattleselectteamViewPresentor.lua

module("logic.extensions.glorybattle.view.GlorybattleselectteamViewPresentor", package.seeall)

local GlorybattleselectteamViewPresentor = class("GlorybattleselectteamViewPresentor", ViewPresentor)

function GlorybattleselectteamViewPresentor:ctor()
	GlorybattleselectteamViewPresentor.super.ctor(self)
end

function GlorybattleselectteamViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GlorybattleselectteamViewPresentor:dependWhatResources()
	return {
		"ui/views/glorybattle/glorybattleselectteamview.prefab"
	}
end

function GlorybattleselectteamViewPresentor:buildViews()
	return {
		GlorybattleselectteamView.New()
	}
end

return GlorybattleselectteamViewPresentor
