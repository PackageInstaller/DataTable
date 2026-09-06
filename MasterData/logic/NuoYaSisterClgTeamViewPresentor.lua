-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nuoyasisterclg/view/NuoYaSisterClgTeamViewPresentor.lua

module("logic.extensions.nuoyasisterclg.view.NuoYaSisterClgTeamViewPresentor", package.seeall)

local NuoYaSisterClgTeamViewPresentor = class("NuoYaSisterClgTeamViewPresentor", ViewPresentor)

function NuoYaSisterClgTeamViewPresentor:ctor()
	NuoYaSisterClgTeamViewPresentor.super.ctor(self)
end

function NuoYaSisterClgTeamViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NuoYaSisterClgTeamViewPresentor:dependWhatResources()
	return {
		"ui/views/nuoyasisterclg/nuoyasisterclgteamview.prefab"
	}
end

function NuoYaSisterClgTeamViewPresentor:buildViews()
	return {
		NuoYaSisterClgTeamView.New()
	}
end

return NuoYaSisterClgTeamViewPresentor
