-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/saintknighttask/view/SKTPersonTaskTeamViewPresentor.lua

module("logic.extensions.saintknighttask.view.SKTPersonTaskTeamViewPresentor", package.seeall)

local SKTPersonTaskTeamViewPresentor = class("SKTPersonTaskTeamViewPresentor", ViewPresentor)

function SKTPersonTaskTeamViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function SKTPersonTaskTeamViewPresentor:dependWhatResources()
	return {
		"ui/views/saintknighttask/sktpersontaskteamview.prefab"
	}
end

function SKTPersonTaskTeamViewPresentor:buildViews()
	return {
		SKTPersonTaskTeamView.New()
	}
end

return SKTPersonTaskTeamViewPresentor
