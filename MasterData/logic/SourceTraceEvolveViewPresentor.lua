-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sourcetrace/view/SourceTraceEvolveViewPresentor.lua

module("logic.extensions.sourcetrace.view.SourceTraceEvolveViewPresentor", package.seeall)

local SourceTraceEvolveViewPresentor = class("SourceTraceEvolveViewPresentor", ViewPresentor)

function SourceTraceEvolveViewPresentor:ctor()
	SourceTraceEvolveViewPresentor.super.ctor(self)
end

function SourceTraceEvolveViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SourceTraceEvolveViewPresentor:dependWhatResources()
	return {
		"ui/views/sourcetrace/sourcetraceevolveview.prefab"
	}
end

function SourceTraceEvolveViewPresentor:buildViews()
	return {
		SourceTraceEvolveView.New()
	}
end

return SourceTraceEvolveViewPresentor
