-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/familyhoundingclg/view/tab/FamilyHoudingClgTabFrameViewPresentor.lua

module("logic.extensions.familyhoundingclg.view.tab.FamilyHoudingClgTabFrameViewPresentor", package.seeall)

local FamilyHoudingClgTabFrameViewPresentor = class("FamilyHoudingClgTabFrameViewPresentor", ViewPresentor)

function FamilyHoudingClgTabFrameViewPresentor:ctor()
	FamilyHoudingClgTabFrameViewPresentor.super.ctor(self)
end

function FamilyHoudingClgTabFrameViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FamilyHoudingClgTabFrameViewPresentor:dependWhatResources()
	return {
		"ui/views/familyhoundingclg/familyhoudingclgtabframeview.prefab"
	}
end

function FamilyHoudingClgTabFrameViewPresentor:buildViews()
	return {
		FamilyHoudingClgTabFrameView.New()
	}
end

return FamilyHoudingClgTabFrameViewPresentor
