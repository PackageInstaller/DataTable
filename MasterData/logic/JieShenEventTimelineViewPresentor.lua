-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jieshenevent/view/JieShenEventTimelineViewPresentor.lua

module("logic.extensions.jieshenevent.view.JieShenEventTimelineViewPresentor", package.seeall)

local JieShenEventTimelineViewPresentor = class("JieShenEventTimelineViewPresentor", ViewPresentor)

function JieShenEventTimelineViewPresentor:ctor()
	JieShenEventTimelineViewPresentor.super.ctor(self)
end

function JieShenEventTimelineViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function JieShenEventTimelineViewPresentor:dependWhatResources()
	return {
		"ui/views/jieshenevent/jiesheneventtimelineview.prefab"
	}
end

function JieShenEventTimelineViewPresentor:buildViews()
	return {
		JieShenEventTimelineView.New()
	}
end

return JieShenEventTimelineViewPresentor
