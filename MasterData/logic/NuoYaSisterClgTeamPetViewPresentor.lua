-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nuoyasisterclg/view/NuoYaSisterClgTeamPetViewPresentor.lua

module("logic.extensions.nuoyasisterclg.view.NuoYaSisterClgTeamPetViewPresentor", package.seeall)

local NuoYaSisterClgTeamPetViewPresentor = class("NuoYaSisterClgTeamPetViewPresentor", ViewPresentor)

function NuoYaSisterClgTeamPetViewPresentor:ctor()
	NuoYaSisterClgTeamPetViewPresentor.super.ctor(self)
end

function NuoYaSisterClgTeamPetViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function NuoYaSisterClgTeamPetViewPresentor:dependWhatResources()
	return {
		"ui/views/nuoyasisterclg/nuoyasisterclgteampetview.prefab"
	}
end

function NuoYaSisterClgTeamPetViewPresentor:buildViews()
	return {
		NuoYaSisterClgTeamPetView.New()
	}
end

return NuoYaSisterClgTeamPetViewPresentor
