-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xingjiang/view/XjtaskViewPresentor.lua

module("logic.extensions.xingjiang.view.XjtaskViewPresentor", package.seeall)

local XjtaskViewPresentor = class("XjtaskViewPresentor", ViewPresentor)

function XjtaskViewPresentor:ctor()
	XjtaskViewPresentor.super.ctor(self)
end

function XjtaskViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function XjtaskViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/xingjiang/xjtaskview.prefab"
	}
end

function XjtaskViewPresentor:buildViews()
	return {
		XjtaskView.New()
	}
end

return XjtaskViewPresentor
