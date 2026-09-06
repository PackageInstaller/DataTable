-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jieshenevent/view/JieShenEventClueCombineViewPresentor.lua

module("logic.extensions.jieshenevent.view.JieShenEventClueCombineViewPresentor", package.seeall)

local JieShenEventClueCombineViewPresentor = class("JieShenEventClueCombineViewPresentor", ViewPresentor)

function JieShenEventClueCombineViewPresentor:ctor()
	JieShenEventClueCombineViewPresentor.super.ctor(self)
end

function JieShenEventClueCombineViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function JieShenEventClueCombineViewPresentor:dependWhatResources()
	return {
		"ui/views/jieshenevent/jiesheneventcluecombineview.prefab"
	}
end

function JieShenEventClueCombineViewPresentor:buildViews()
	return {
		JieShenEventClueCombineView.New()
	}
end

return JieShenEventClueCombineViewPresentor
