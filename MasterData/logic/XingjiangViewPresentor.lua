-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xingjiang/view/XingjiangViewPresentor.lua

module("logic.extensions.xingjiang.view.XingjiangViewPresentor", package.seeall)

local XingjiangViewPresentor = class("XingjiangViewPresentor", ViewPresentor)

function XingjiangViewPresentor:ctor()
	XingjiangViewPresentor.super.ctor(self)
end

function XingjiangViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function XingjiangViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/xingjiang/xingjiangview.prefab"
	}
end

function XingjiangViewPresentor:buildViews()
	return {
		XingjiangView.New()
	}
end

return XingjiangViewPresentor
