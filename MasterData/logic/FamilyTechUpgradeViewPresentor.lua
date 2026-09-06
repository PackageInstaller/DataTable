-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/familytech/view/FamilyTechUpgradeViewPresentor.lua

module("logic.extensions.familytech.view.FamilyTechUpgradeViewPresentor", package.seeall)

local FamilyTechUpgradeViewPresentor = class("FamilyTechUpgradeViewPresentor", ViewPresentor)

function FamilyTechUpgradeViewPresentor:ctor()
	FamilyTechUpgradeViewPresentor.super.ctor(self)
end

function FamilyTechUpgradeViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FamilyTechUpgradeViewPresentor:dependWhatResources()
	return {
		"ui/views/familytech/familytechupgradeview.prefab"
	}
end

function FamilyTechUpgradeViewPresentor:buildViews()
	return {
		FamilyTechUpgradeView.New()
	}
end

return FamilyTechUpgradeViewPresentor
