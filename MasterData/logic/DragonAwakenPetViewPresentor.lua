-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonawaken/view/DragonAwakenPetViewPresentor.lua

module("logic.extensions.dragonawaken.view.DragonAwakenPetViewPresentor", package.seeall)

local DragonAwakenPetViewPresentor = class("DragonAwakenPetViewPresentor", ViewPresentor)

function DragonAwakenPetViewPresentor:ctor()
	DragonAwakenPetViewPresentor.super.ctor(self)
end

function DragonAwakenPetViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DragonAwakenPetViewPresentor:dependWhatResources()
	return {
		"ui/views/dragonawaken/dragonawakenpetview.prefab"
	}
end

function DragonAwakenPetViewPresentor:buildViews()
	return {
		DragonAwakenPetView.New()
	}
end

return DragonAwakenPetViewPresentor
