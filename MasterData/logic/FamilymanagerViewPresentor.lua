-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/family/view/FamilymanagerViewPresentor.lua

module("logic.extensions.family.view.FamilymanagerViewPresentor", package.seeall)

local FamilymanagerViewPresentor = class("FamilymanagerViewPresentor", ViewPresentor)

function FamilymanagerViewPresentor:ctor()
	FamilymanagerViewPresentor.super.ctor(self)
end

function FamilymanagerViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FamilymanagerViewPresentor:dependWhatResources()
	return {
		"ui/views/family/familymanagerview.prefab"
	}
end

function FamilymanagerViewPresentor:buildViews()
	return {
		FamilymanagerView.New()
	}
end

return FamilymanagerViewPresentor
