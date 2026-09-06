-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jieshenevent/view/JieShenEventClueViewPresentor.lua

module("logic.extensions.jieshenevent.view.JieShenEventClueViewPresentor", package.seeall)

local JieShenEventClueViewPresentor = class("JieShenEventClueViewPresentor", ViewPresentor)

function JieShenEventClueViewPresentor:ctor()
	JieShenEventClueViewPresentor.super.ctor(self)
end

function JieShenEventClueViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function JieShenEventClueViewPresentor:dependWhatResources()
	return {
		"ui/views/jieshenevent/jiesheneventclueview.prefab"
	}
end

function JieShenEventClueViewPresentor:buildViews()
	return {
		JieShenEventClueView.New()
	}
end

return JieShenEventClueViewPresentor
