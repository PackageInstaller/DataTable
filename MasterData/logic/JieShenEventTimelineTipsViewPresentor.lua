-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jieshenevent/view/JieShenEventTimelineTipsViewPresentor.lua

module("logic.extensions.jieshenevent.view.JieShenEventTimelineTipsViewPresentor", package.seeall)

local JieShenEventTimelineTipsViewPresentor = class("JieShenEventTimelineTipsViewPresentor", ViewPresentor)

function JieShenEventTimelineTipsViewPresentor:ctor()
	JieShenEventTimelineTipsViewPresentor.super.ctor(self)
end

function JieShenEventTimelineTipsViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function JieShenEventTimelineTipsViewPresentor:dependWhatResources()
	return {
		"ui/views/jieshenevent/jiesheneventtimelinetipsview.prefab"
	}
end

function JieShenEventTimelineTipsViewPresentor:buildViews()
	return {
		JieShenEventTimelineTipsView.New()
	}
end

return JieShenEventTimelineTipsViewPresentor
