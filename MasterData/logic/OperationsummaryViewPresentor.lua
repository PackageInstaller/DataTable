-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/OperationsummaryViewPresentor.lua

module("logic.extensions.operationsummary.view.OperationsummaryViewPresentor", package.seeall)

local OperationsummaryViewPresentor = class("OperationsummaryViewPresentor", ViewPresentor)

function OperationsummaryViewPresentor:ctor()
	OperationsummaryViewPresentor.super.ctor(self)
end

function OperationsummaryViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OperationsummaryViewPresentor:dependWhatResources()
	return {
		"ui/views/operationsummary/operationsummaryview.prefab"
	}
end

function OperationsummaryViewPresentor:buildViews()
	return {
		OperationSummaryView.New()
	}
end

return OperationsummaryViewPresentor
