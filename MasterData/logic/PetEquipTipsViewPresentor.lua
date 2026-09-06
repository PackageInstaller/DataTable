-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/view/PetEquipTipsViewPresentor.lua

module("logic.extensions.equipment.view.PetEquipTipsViewPresentor", package.seeall)

local PetEquipTipsViewPresentor = class("PetEquipTipsViewPresentor", ViewWithGuidePresentor)

function PetEquipTipsViewPresentor:ctor()
	PetEquipTipsViewPresentor.super.ctor(self)
end

function PetEquipTipsViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PetEquipTipsViewPresentor:dependWhatResources()
	return {
		"ui/views/petequip/petequiptipsview.prefab"
	}
end

function PetEquipTipsViewPresentor:buildViews()
	return {
		PetEquipTipsView.New()
	}
end

return PetEquipTipsViewPresentor
