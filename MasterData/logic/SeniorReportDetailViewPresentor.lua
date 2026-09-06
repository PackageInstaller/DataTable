-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/seniorarena/view/SeniorReportDetailViewPresentor.lua

module("logic.extensions.seniorarena.view.SeniorReportDetailViewPresentor", package.seeall)

local SeniorReportDetailViewPresentor = class("SeniorReportDetailViewPresentor", ViewPresentor)

function SeniorReportDetailViewPresentor:ctor()
	SeniorReportDetailViewPresentor.super.ctor(self)
end

function SeniorReportDetailViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function SeniorReportDetailViewPresentor:dependWhatResources()
	return {
		"ui/views/seniorarena/seniorreportdetailview.prefab"
	}
end

function SeniorReportDetailViewPresentor:buildViews()
	return {
		SeniorReportDetailView.New()
	}
end

return SeniorReportDetailViewPresentor
