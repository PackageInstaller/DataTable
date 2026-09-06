-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/familyhoundingclg/view/FamilyHoudingClgStageViewPresentor.lua

module("logic.extensions.familyhoundingclg.view.FamilyHoudingClgStageViewPresentor", package.seeall)

local FamilyHoudingClgStageViewPresentor = class("FamilyHoudingClgStageViewPresentor", ViewPresentor)

function FamilyHoudingClgStageViewPresentor:ctor()
	FamilyHoudingClgStageViewPresentor.super.ctor(self)
end

function FamilyHoudingClgStageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FamilyHoudingClgStageViewPresentor:dependWhatResources()
	return {
		"ui/views/familyhoundingclg/familyhoudingclgstageview.prefab"
	}
end

function FamilyHoudingClgStageViewPresentor:buildViews()
	return {
		FamilyHoudingClgStageView.New()
	}
end

return FamilyHoudingClgStageViewPresentor
