-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xingjiang/view/XjlotteryViewPresentor.lua

module("logic.extensions.xingjiang.view.XjlotteryViewPresentor", package.seeall)

local XjlotteryViewPresentor = class("XjlotteryViewPresentor", ViewPresentor)

function XjlotteryViewPresentor:ctor()
	XjlotteryViewPresentor.super.ctor(self)
end

function XjlotteryViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function XjlotteryViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/xingjiang/xjlotteryview.prefab"
	}
end

function XjlotteryViewPresentor:buildViews()
	return {
		XjlotteryView.New()
	}
end

return XjlotteryViewPresentor
