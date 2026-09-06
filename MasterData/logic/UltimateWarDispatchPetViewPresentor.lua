-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ultimatewar/view/UltimateWarDispatchPetViewPresentor.lua

module("logic.extensions.ultimatewar.view.UltimateWarDispatchPetViewPresentor", package.seeall)

local UltimateWarDispatchPetViewPresentor = class("UltimateWarDispatchPetViewPresentor", ViewPresentor)

function UltimateWarDispatchPetViewPresentor:ctor()
	UltimateWarDispatchPetViewPresentor.super.ctor(self)
end

function UltimateWarDispatchPetViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function UltimateWarDispatchPetViewPresentor:dependWhatResources()
	return {
		"ui/views/ultimatewar/ultimatewardispatchpetview.prefab"
	}
end

function UltimateWarDispatchPetViewPresentor:buildViews()
	return {
		UltimateWarDispatchPetView.New()
	}
end

return UltimateWarDispatchPetViewPresentor
