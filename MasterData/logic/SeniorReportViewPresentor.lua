-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/seniorarena/view/SeniorReportViewPresentor.lua

module("logic.extensions.seniorarena.view.SeniorReportViewPresentor", package.seeall)

local SeniorReportViewPresentor = class("SeniorReportViewPresentor", ViewPresentor)

function SeniorReportViewPresentor:ctor()
	SeniorReportViewPresentor.super.ctor(self)
end

function SeniorReportViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function SeniorReportViewPresentor:dependWhatResources()
	return {
		"ui/views/seniorarena/seniorreportview.prefab"
	}
end

function SeniorReportViewPresentor:buildViews()
	return {
		SeniorReportView.New()
	}
end

return SeniorReportViewPresentor
