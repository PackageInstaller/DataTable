-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ultimatewar/view/UltimateWarUpPetViewPresentor.lua

module("logic.extensions.ultimatewar.view.UltimateWarUpPetViewPresentor", package.seeall)

local UltimateWarUpPetViewPresentor = class("UltimateWarUpPetViewPresentor", ViewPresentor)

function UltimateWarUpPetViewPresentor:ctor()
	UltimateWarUpPetViewPresentor.super.ctor(self)
end

function UltimateWarUpPetViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function UltimateWarUpPetViewPresentor:dependWhatResources()
	return {
		"ui/views/ultimatewar/ultimatewaruppetview.prefab"
	}
end

function UltimateWarUpPetViewPresentor:buildViews()
	return {
		UltimateWarUpPetView.New()
	}
end

return UltimateWarUpPetViewPresentor
