-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sourcetrace/view/SourceTraceMainViewPresentor.lua

module("logic.extensions.sourcetrace.view.SourceTraceMainViewPresentor", package.seeall)

local SourceTraceMainViewPresentor = class("SourceTraceMainViewPresentor", ViewPresentor)

function SourceTraceMainViewPresentor:ctor()
	SourceTraceMainViewPresentor.super.ctor(self)
end

function SourceTraceMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SourceTraceMainViewPresentor:dependWhatResources()
	return {
		"ui/views/sourcetrace/sourcetracemainview.prefab"
	}
end

function SourceTraceMainViewPresentor:buildViews()
	return {
		SourceTraceMainView.New()
	}
end

function SourceTraceMainViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return SourceTraceMainViewPresentor
