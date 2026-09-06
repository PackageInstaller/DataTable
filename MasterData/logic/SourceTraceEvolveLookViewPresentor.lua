-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sourcetrace/view/SourceTraceEvolveLookViewPresentor.lua

module("logic.extensions.sourcetrace.view.SourceTraceEvolveLookViewPresentor", package.seeall)

local SourceTraceEvolveLookViewPresentor = class("SourceTraceEvolveLookViewPresentor", ViewPresentor)

function SourceTraceEvolveLookViewPresentor:ctor()
	SourceTraceEvolveLookViewPresentor.super.ctor(self)
end

function SourceTraceEvolveLookViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function SourceTraceEvolveLookViewPresentor:dependWhatResources()
	return {
		"ui/views/sourcetrace/sourcetraceevolvelookview.prefab"
	}
end

function SourceTraceEvolveLookViewPresentor:buildViews()
	return {
		SourceTraceEvolveLookView.New()
	}
end

return SourceTraceEvolveLookViewPresentor
