-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lailisi/view/xingluo/XingluoChanllengeViewPresentor.lua

module("logic.extensions.lailisi.view.xingluo.XingluoChanllengeViewPresentor", package.seeall)

local XingluoChanllengeViewPresentor = class("XingluoChanllengeViewPresentor", ViewPresentor)

function XingluoChanllengeViewPresentor:ctor()
	XingluoChanllengeViewPresentor.super.ctor(self)
end

function XingluoChanllengeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function XingluoChanllengeViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/xingluo/xingluochanllengeview.prefab"
	}
end

function XingluoChanllengeViewPresentor:buildViews()
	return {
		XingluoChanllengeView.New()
	}
end

return XingluoChanllengeViewPresentor
