-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/view/PetEquipInfoViewPresentor.lua

module("logic.extensions.equipment.view.PetEquipInfoViewPresentor", package.seeall)

local PetEquipInfoViewPresentor = class("PetEquipInfoViewPresentor", ViewWithGuidePresentor)

function PetEquipInfoViewPresentor:ctor()
	PetEquipInfoViewPresentor.super.ctor(self)
end

function PetEquipInfoViewPresentor:attachToWhichRoot()
	return ViewRootType.TopMost
end

function PetEquipInfoViewPresentor:dependWhatResources()
	return {
		"ui/views/petequip/petequipinfoview.prefab"
	}
end

function PetEquipInfoViewPresentor:buildViews()
	return {
		PetEquipInfoView.New()
	}
end

return PetEquipInfoViewPresentor
