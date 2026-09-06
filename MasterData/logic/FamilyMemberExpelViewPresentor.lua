-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/family/view/FamilyMemberExpelViewPresentor.lua

module("logic.extensions.family.view.FamilyMemberExpelViewPresentor", package.seeall)

local FamilyMemberExpelViewPresentor = class("FamilyMemberExpelViewPresentor", ViewPresentor)

function FamilyMemberExpelViewPresentor:ctor()
	FamilyMemberExpelViewPresentor.super.ctor(self)
end

function FamilyMemberExpelViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FamilyMemberExpelViewPresentor:dependWhatResources()
	return {
		"ui/views/family/familymemberexpelview.prefab"
	}
end

function FamilyMemberExpelViewPresentor:buildViews()
	return {
		FamilyMemberExpelView.New()
	}
end

return FamilyMemberExpelViewPresentor
