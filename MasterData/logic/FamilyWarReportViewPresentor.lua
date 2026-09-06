-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newfamily/view/war/FamilyWarReportViewPresentor.lua

module("logic.extensions.newfamily.view.war.FamilyWarReportViewPresentor", package.seeall)

local FamilyWarReportViewPresentor = class("FamilyWarReportViewPresentor", ViewPresentor)

function FamilyWarReportViewPresentor:ctor()
	FamilyWarReportViewPresentor.super.ctor(self)
end

function FamilyWarReportViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FamilyWarReportViewPresentor:dependWhatResources()
	return {
		"ui/views/newfamily/war/familywarreportview.prefab"
	}
end

function FamilyWarReportViewPresentor:buildViews()
	return {
		FamilyWarReportView.New()
	}
end

return FamilyWarReportViewPresentor
