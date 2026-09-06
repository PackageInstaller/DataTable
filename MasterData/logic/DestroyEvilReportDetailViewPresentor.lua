-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/destroyevil/view/DestroyEvilReportDetailViewPresentor.lua

module("logic.extensions.destroyevil.view.DestroyEvilReportDetailViewPresentor", package.seeall)

local DestroyEvilReportDetailViewPresentor = class("DestroyEvilReportDetailViewPresentor", ViewPresentor)

function DestroyEvilReportDetailViewPresentor:ctor()
	DestroyEvilReportDetailViewPresentor.super.ctor(self)
end

function DestroyEvilReportDetailViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DestroyEvilReportDetailViewPresentor:dependWhatResources()
	return {
		"ui/views/destroyevil/destroyevilreportdetailview.prefab"
	}
end

function DestroyEvilReportDetailViewPresentor:buildViews()
	return {
		DestroyEvilReportDetailView.New()
	}
end

return DestroyEvilReportDetailViewPresentor
