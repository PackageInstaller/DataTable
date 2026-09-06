-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sourcetrace/view/SourceTracePopupViewPresentor.lua

module("logic.extensions.sourcetrace.view.SourceTracePopupViewPresentor", package.seeall)

local SourceTracePopupViewPresentor = class("SourceTracePopupViewPresentor", ViewPresentor)

function SourceTracePopupViewPresentor:ctor()
	SourceTracePopupViewPresentor.super.ctor(self)
end

function SourceTracePopupViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function SourceTracePopupViewPresentor:dependWhatResources()
	return {
		"ui/views/sourcetrace/sourcetracepopupview.prefab"
	}
end

function SourceTracePopupViewPresentor:buildViews()
	return {
		SourceTracePopupView.New()
	}
end

return SourceTracePopupViewPresentor
