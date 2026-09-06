-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/family/view/FamilyViewPresentor.lua

module("logic.extensions.family.view.FamilyViewPresentor", package.seeall)

local FamilyViewPresentor = class("FamilyViewPresentor", ViewPresentor)

function FamilyViewPresentor:ctor()
	FamilyViewPresentor.super.ctor(self)
end

function FamilyViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FamilyViewPresentor:dependWhatResources()
	return {
		"ui/views/family/familyview.prefab"
	}
end

function FamilyViewPresentor:buildViews()
	return {
		FamilyView.New()
	}
end

return FamilyViewPresentor
