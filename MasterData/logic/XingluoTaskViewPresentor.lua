-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lailisi/view/xingluo/XingluoTaskViewPresentor.lua

module("logic.extensions.lailisi.view.xingluo.XingluoTaskViewPresentor", package.seeall)

local XingluoTaskViewPresentor = class("XingluoTaskViewPresentor", ViewPresentor)

function XingluoTaskViewPresentor:ctor()
	XingluoTaskViewPresentor.super.ctor(self)
end

function XingluoTaskViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function XingluoTaskViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/xingluo/xingluotaskview.prefab"
	}
end

function XingluoTaskViewPresentor:buildViews()
	return {
		XingluoTaskView.New()
	}
end

return XingluoTaskViewPresentor
