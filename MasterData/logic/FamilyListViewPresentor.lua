-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/family/view/FamilyListViewPresentor.lua

module("logic.extensions.family.view.FamilyListViewPresentor", package.seeall)

local FamilyListViewPresentor = class("FamilyListViewPresentor", ViewWithGuidePresentor)

function FamilyListViewPresentor:ctor()
	FamilyListViewPresentor.super.ctor(self)
end

function FamilyListViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FamilyListViewPresentor:dependWhatResources()
	return {
		"ui/views/family/familylistview.prefab"
	}
end

function FamilyListViewPresentor:buildViews()
	return {
		FamilyListView.New()
	}
end

return FamilyListViewPresentor
