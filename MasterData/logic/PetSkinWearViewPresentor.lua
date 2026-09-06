-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petskin/view/PetSkinWearViewPresentor.lua

module("logic.extensions.petskin.view.PetSkinWearViewPresentor", package.seeall)

local PetSkinWearViewPresentor = class("PetSkinWearViewPresentor", ViewPresentor)

function PetSkinWearViewPresentor:ctor()
	PetSkinWearViewPresentor.super.ctor(self)
end

function PetSkinWearViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PetSkinWearViewPresentor:dependWhatResources()
	return {
		"ui/views/bag/petskinwearview.prefab"
	}
end

function PetSkinWearViewPresentor:buildViews()
	return {
		PetSkinWearView.New()
	}
end

return PetSkinWearViewPresentor
