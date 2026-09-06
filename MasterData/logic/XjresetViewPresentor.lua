-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xingjiang/view/XjresetViewPresentor.lua

module("logic.extensions.xingjiang.view.XjresetViewPresentor", package.seeall)

local XjresetViewPresentor = class("XjresetViewPresentor", ViewPresentor)

function XjresetViewPresentor:ctor()
	XjresetViewPresentor.super.ctor(self)
end

function XjresetViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function XjresetViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/xingjiang/xjresetview.prefab"
	}
end

function XjresetViewPresentor:buildViews()
	return {
		XjresetView.New()
	}
end

return XjresetViewPresentor
