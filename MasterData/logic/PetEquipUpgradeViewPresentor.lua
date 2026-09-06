-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/view/PetEquipUpgradeViewPresentor.lua

module("logic.extensions.equipment.view.PetEquipUpgradeViewPresentor", package.seeall)

local PetEquipUpgradeViewPresentor = class("PetEquipUpgradeViewPresentor", ViewWithGuidePresentor)

function PetEquipUpgradeViewPresentor:ctor()
	PetEquipUpgradeViewPresentor.super.ctor(self)
end

function PetEquipUpgradeViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PetEquipUpgradeViewPresentor:dependWhatResources()
	return {
		"ui/views/petequip/petequipupgradeview.prefab"
	}
end

function PetEquipUpgradeViewPresentor:buildViews()
	return {
		PetEquipUpgradeView.New()
	}
end

return PetEquipUpgradeViewPresentor
