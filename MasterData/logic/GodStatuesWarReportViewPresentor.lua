-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godstatueswar/view/GodStatuesWarReportViewPresentor.lua

module("logic.extensions.godstatueswar.view.GodStatuesWarReportViewPresentor", package.seeall)

local GodStatuesWarReportViewPresentor = class("GodStatuesWarReportViewPresentor", ViewPresentor)

function GodStatuesWarReportViewPresentor:ctor()
	GodStatuesWarReportViewPresentor.super.ctor(self)
end

function GodStatuesWarReportViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GodStatuesWarReportViewPresentor:dependWhatResources()
	return {
		"ui/views/godstatueswar/godstatueswarreportview.prefab"
	}
end

function GodStatuesWarReportViewPresentor:buildViews()
	return {
		GodStatuesWarReportView.New()
	}
end

return GodStatuesWarReportViewPresentor
