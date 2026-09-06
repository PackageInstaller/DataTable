-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/view/PetDectnUpgradeViewPresentor.lua

module("logic.extensions.equipment.view.PetDectnUpgradeViewPresentor", package.seeall)

local PetDectnUpgradeViewPresentor = class("PetDectnUpgradeViewPresentor", ViewWithGuidePresentor)

function PetDectnUpgradeViewPresentor:ctor()
	PetDectnUpgradeViewPresentor.super.ctor(self)
end

function PetDectnUpgradeViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PetDectnUpgradeViewPresentor:dependWhatResources()
	return {
		"ui/views/petequip/petdectnupgradeview.prefab"
	}
end

function PetDectnUpgradeViewPresentor:buildViews()
	return {
		PetDectnUpgradeView.New()
	}
end

return PetDectnUpgradeViewPresentor
