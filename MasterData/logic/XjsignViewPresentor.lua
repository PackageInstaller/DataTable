-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xingjiang/view/XjsignViewPresentor.lua

module("logic.extensions.xingjiang.view.XjsignViewPresentor", package.seeall)

local XjsignViewPresentor = class("XjsignViewPresentor", ViewPresentor)

function XjsignViewPresentor:ctor()
	XjsignViewPresentor.super.ctor(self)
end

function XjsignViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function XjsignViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/xingjiang/xjsignview.prefab"
	}
end

function XjsignViewPresentor:buildViews()
	return {
		XjsignView.New()
	}
end

return XjsignViewPresentor
