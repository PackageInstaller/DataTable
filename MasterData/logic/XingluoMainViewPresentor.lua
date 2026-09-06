-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lailisi/view/xingluo/XingluoMainViewPresentor.lua

module("logic.extensions.lailisi.view.xingluo.XingluoMainViewPresentor", package.seeall)

local XingluoMainViewPresentor = class("XingluoMainViewPresentor", ViewPresentor)

function XingluoMainViewPresentor:ctor()
	XingluoMainViewPresentor.super.ctor(self)
end

function XingluoMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function XingluoMainViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/xingluo/xingluomainview.prefab"
	}
end

function XingluoMainViewPresentor:buildViews()
	return {
		XingluoMainView.New()
	}
end

return XingluoMainViewPresentor
