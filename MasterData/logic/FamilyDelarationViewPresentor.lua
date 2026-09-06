-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/family/view/FamilyDelarationViewPresentor.lua

module("logic.extensions.family.view.FamilyDelarationViewPresentor", package.seeall)

local FamilyDelarationViewPresentor = class("FamilyDelarationViewPresentor", ViewPresentor)

function FamilyDelarationViewPresentor:ctor()
	FamilyDelarationViewPresentor.super.ctor(self)
end

function FamilyDelarationViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FamilyDelarationViewPresentor:dependWhatResources()
	return {
		"ui/views/family/familydeclarationview.prefab"
	}
end

function FamilyDelarationViewPresentor:buildViews()
	return {
		FamilyDelarationView.New()
	}
end

return FamilyDelarationViewPresentor
