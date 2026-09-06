-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/family/view/FamilyAssignViewPresentor.lua

module("logic.extensions.family.view.FamilyAssignViewPresentor", package.seeall)

local FamilyAssignViewPresentor = class("FamilyAssignViewPresentor", ViewPresentor)

function FamilyAssignViewPresentor:ctor()
	FamilyAssignViewPresentor.super.ctor(self)
end

function FamilyAssignViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FamilyAssignViewPresentor:dependWhatResources()
	return {
		"ui/views/family/familyassignview.prefab"
	}
end

function FamilyAssignViewPresentor:buildViews()
	return {
		FamilyAssignView.New()
	}
end

return FamilyAssignViewPresentor
