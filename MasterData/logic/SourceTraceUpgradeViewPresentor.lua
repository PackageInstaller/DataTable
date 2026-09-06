-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sourcetrace/view/SourceTraceUpgradeViewPresentor.lua

module("logic.extensions.sourcetrace.view.SourceTraceUpgradeViewPresentor", package.seeall)

local SourceTraceUpgradeViewPresentor = class("SourceTraceUpgradeViewPresentor", ViewPresentor)

function SourceTraceUpgradeViewPresentor:ctor()
	SourceTraceUpgradeViewPresentor.super.ctor(self)
end

function SourceTraceUpgradeViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function SourceTraceUpgradeViewPresentor:dependWhatResources()
	return {
		"ui/views/sourcetrace/sourcetraceupgradeview.prefab"
	}
end

function SourceTraceUpgradeViewPresentor:buildViews()
	return {
		SourceTraceUpgradeView.New()
	}
end

return SourceTraceUpgradeViewPresentor
