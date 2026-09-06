-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiayin/view/XiaYinMainViewPresentor.lua

module("logic.extensions.xiayin.view.XiaYinMainViewPresentor", package.seeall)

local XiaYinMainViewPresentor = class("XiaYinMainViewPresentor", ViewPresentor)

function XiaYinMainViewPresentor:ctor()
	XiaYinMainViewPresentor.super.ctor(self)
end

function XiaYinMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function XiaYinMainViewPresentor:dependWhatResources()
	return {
		"ui/views/xiayin/xiayinmainview.prefab"
	}
end

function XiaYinMainViewPresentor:buildViews()
	return {
		XiaYinMainView.New()
	}
end

return XiaYinMainViewPresentor
