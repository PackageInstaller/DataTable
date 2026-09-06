-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sourcetrace/view/SourceTraceMultiNodeViewPresentor.lua

module("logic.extensions.sourcetrace.view.SourceTraceMultiNodeViewPresentor", package.seeall)

local SourceTraceMultiNodeViewPresentor = class("SourceTraceMultiNodeViewPresentor", ViewPresentor)

function SourceTraceMultiNodeViewPresentor:ctor()
	SourceTraceMultiNodeViewPresentor.super.ctor(self)
end

function SourceTraceMultiNodeViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function SourceTraceMultiNodeViewPresentor:dependWhatResources()
	return {
		"ui/views/sourcetrace/sourcetracemultinodeview.prefab"
	}
end

function SourceTraceMultiNodeViewPresentor:buildViews()
	return {
		SourceTraceMultiNodeView.New()
	}
end

return SourceTraceMultiNodeViewPresentor
