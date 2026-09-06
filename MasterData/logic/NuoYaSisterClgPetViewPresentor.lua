-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nuoyasisterclg/view/NuoYaSisterClgPetViewPresentor.lua

module("logic.extensions.nuoyasisterclg.view.NuoYaSisterClgPetViewPresentor", package.seeall)

local NuoYaSisterClgPetViewPresentor = class("NuoYaSisterClgPetViewPresentor", ViewPresentor)

function NuoYaSisterClgPetViewPresentor:ctor()
	NuoYaSisterClgPetViewPresentor.super.ctor(self)
end

function NuoYaSisterClgPetViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function NuoYaSisterClgPetViewPresentor:dependWhatResources()
	return {
		"ui/views/nuoyasisterclg/nuoyasisterclgpetview.prefab"
	}
end

function NuoYaSisterClgPetViewPresentor:buildViews()
	return {
		NuoYaSisterClgPetView.New()
	}
end

return NuoYaSisterClgPetViewPresentor
