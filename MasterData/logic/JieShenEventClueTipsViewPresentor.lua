-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jieshenevent/view/JieShenEventClueTipsViewPresentor.lua

module("logic.extensions.jieshenevent.view.JieShenEventClueTipsViewPresentor", package.seeall)

local JieShenEventClueTipsViewPresentor = class("JieShenEventClueTipsViewPresentor", ViewPresentor)

function JieShenEventClueTipsViewPresentor:ctor()
	JieShenEventClueTipsViewPresentor.super.ctor(self)
end

function JieShenEventClueTipsViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function JieShenEventClueTipsViewPresentor:dependWhatResources()
	return {
		"ui/views/jieshenevent/jiesheneventcluetipsview.prefab"
	}
end

function JieShenEventClueTipsViewPresentor:buildViews()
	return {
		JieShenEventClueTipsView.New()
	}
end

return JieShenEventClueTipsViewPresentor
