-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xingjiang/view/XjshopViewPresentor.lua

module("logic.extensions.xingjiang.view.XjshopViewPresentor", package.seeall)

local XjshopViewPresentor = class("XjshopViewPresentor", ViewPresentor)

function XjshopViewPresentor:ctor()
	XjshopViewPresentor.super.ctor(self)
end

function XjshopViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function XjshopViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/xingjiang/xjshopview.prefab"
	}
end

function XjshopViewPresentor:buildViews()
	return {
		XjshopView.New()
	}
end

return XjshopViewPresentor
