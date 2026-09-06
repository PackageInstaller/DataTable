-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/family/view/FamilyLogViewPresentor.lua

module("logic.extensions.family.view.FamilyLogViewPresentor", package.seeall)

local FamilyLogViewPresentor = class("FamilyLogViewPresentor", ViewPresentor)

function FamilyLogViewPresentor:ctor()
	FamilyLogViewPresentor.super.ctor(self)
end

function FamilyLogViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FamilyLogViewPresentor:dependWhatResources()
	return {
		"ui/views/family/familylogview.prefab"
	}
end

function FamilyLogViewPresentor:buildViews()
	return {
		FamilyLogView.New()
	}
end

return FamilyLogViewPresentor
