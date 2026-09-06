-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/domainadventure/view/rank/DomAdvRankTabFrameViewPresentor.lua

module("logic.extensions.domainadventure.view.rank.DomAdvRankTabFrameViewPresentor", package.seeall)

local DomAdvRankTabFrameViewPresentor = class("DomAdvRankTabFrameViewPresentor", ViewPresentor)

function DomAdvRankTabFrameViewPresentor:ctor()
	DomAdvRankTabFrameViewPresentor.super.ctor(self)
end

function DomAdvRankTabFrameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DomAdvRankTabFrameViewPresentor:dependWhatResources()
	return {
		"ui/views/domainadventure/domadvranktabframeview.prefab"
	}
end

function DomAdvRankTabFrameViewPresentor:buildViews()
	return {
		DomAdvRankTabFrameView.New()
	}
end

return DomAdvRankTabFrameViewPresentor
