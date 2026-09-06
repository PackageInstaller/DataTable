-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/family/view/FamilyActivityViewPresentor.lua

module("logic.extensions.family.view.FamilyActivityViewPresentor", package.seeall)

local FamilyActivityViewPresentor = class("FamilyActivityViewPresentor", ViewPresentor)

function FamilyActivityViewPresentor:ctor()
	FamilyActivityViewPresentor.super.ctor(self)
end

function FamilyActivityViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FamilyActivityViewPresentor:dependWhatResources()
	return {
		"ui/views/family/familyactivityview.prefab"
	}
end

function FamilyActivityViewPresentor:buildViews()
	return {
		FamilyActivityView.New()
	}
end

return FamilyActivityViewPresentor
