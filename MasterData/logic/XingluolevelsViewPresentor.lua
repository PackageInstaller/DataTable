-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lailisi/view/xingluo/XingluolevelsViewPresentor.lua

module("logic.extensions.lailisi.view.xingluo.XingluolevelsViewPresentor", package.seeall)

local XingluolevelsViewPresentor = class("XingluolevelsViewPresentor", ViewPresentor)

function XingluolevelsViewPresentor:ctor()
	XingluolevelsViewPresentor.super.ctor(self)
end

function XingluolevelsViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function XingluolevelsViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/xingluo/xingluolevelsview.prefab"
	}
end

function XingluolevelsViewPresentor:buildViews()
	return {
		XingluolevelsView.New()
	}
end

return XingluolevelsViewPresentor
