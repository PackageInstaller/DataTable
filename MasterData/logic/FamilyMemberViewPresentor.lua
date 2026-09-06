-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/family/view/FamilyMemberViewPresentor.lua

module("logic.extensions.family.view.FamilyMemberViewPresentor", package.seeall)

local FamilyMemberViewPresentor = class("FamilyMemberViewPresentor", ViewPresentor)

function FamilyMemberViewPresentor:ctor()
	FamilyMemberViewPresentor.super.ctor(self)
end

function FamilyMemberViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FamilyMemberViewPresentor:dependWhatResources()
	return {
		"ui/views/family/familymemberview.prefab"
	}
end

function FamilyMemberViewPresentor:buildViews()
	return {
		FamilyMemberView.New()
	}
end

return FamilyMemberViewPresentor
