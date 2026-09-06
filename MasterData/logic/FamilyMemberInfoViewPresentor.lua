-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/family/view/FamilyMemberInfoViewPresentor.lua

module("logic.extensions.family.view.FamilyMemberInfoViewPresentor", package.seeall)

local FamilyMemberInfoViewPresentor = class("FamilyMemberInfoViewPresentor", ViewPresentor)

function FamilyMemberInfoViewPresentor:ctor()
	FamilyMemberInfoViewPresentor.super.ctor(self)
end

function FamilyMemberInfoViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FamilyMemberInfoViewPresentor:dependWhatResources()
	return {
		"ui/views/family/familymeberinfoview.prefab"
	}
end

function FamilyMemberInfoViewPresentor:buildViews()
	return {
		FamilyMemberInfoView.New()
	}
end

return FamilyMemberInfoViewPresentor
