-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/familytech/view/FamilyTechMainViewPresentor.lua

module("logic.extensions.familytech.view.FamilyTechMainViewPresentor", package.seeall)

local FamilyTechMainViewPresentor = class("FamilyTechMainViewPresentor", ViewPresentor)

function FamilyTechMainViewPresentor:ctor()
	FamilyTechMainViewPresentor.super.ctor(self)
end

function FamilyTechMainViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FamilyTechMainViewPresentor:dependWhatResources()
	return {
		"ui/views/familytech/familytechmainview.prefab"
	}
end

function FamilyTechMainViewPresentor:buildViews()
	return {
		FamilyTechMainView.New()
	}
end

return FamilyTechMainViewPresentor
