-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiayin/view/XiaYinLevelViewPresentor.lua

module("logic.extensions.xiayin.view.XiaYinLevelViewPresentor", package.seeall)

local XiaYinLevelViewPresentor = class("XiaYinLevelViewPresentor", ViewPresentor)

function XiaYinLevelViewPresentor:ctor()
	XiaYinLevelViewPresentor.super.ctor(self)
end

function XiaYinLevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function XiaYinLevelViewPresentor:dependWhatResources()
	return {
		"ui/views/xiayin/xiayinlevelview.prefab"
	}
end

function XiaYinLevelViewPresentor:buildViews()
	return {
		XiaYinLevelView.New()
	}
end

return XiaYinLevelViewPresentor
