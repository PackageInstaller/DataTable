-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/family/view/FamilyApplyViewPresentor.lua

module("logic.extensions.family.view.FamilyApplyViewPresentor", package.seeall)

local FamilyApplyViewPresentor = class("FamilyApplyViewPresentor", ViewPresentor)

function FamilyApplyViewPresentor:ctor()
	FamilyApplyViewPresentor.super.ctor(self)
end

function FamilyApplyViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FamilyApplyViewPresentor:dependWhatResources()
	return {
		"ui/views/family/familyapplyview.prefab"
	}
end

function FamilyApplyViewPresentor:buildViews()
	return {
		FamilyApplyView.New()
	}
end

return FamilyApplyViewPresentor
