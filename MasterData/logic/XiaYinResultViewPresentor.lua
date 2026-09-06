-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiayin/view/XiaYinResultViewPresentor.lua

module("logic.extensions.xiayin.view.XiaYinResultViewPresentor", package.seeall)

local XiaYinResultViewPresentor = class("XiaYinResultViewPresentor", ViewPresentor)

function XiaYinResultViewPresentor:ctor()
	XiaYinResultViewPresentor.super.ctor(self)
end

function XiaYinResultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function XiaYinResultViewPresentor:dependWhatResources()
	return {
		"ui/views/xiayin/xiayinresultview.prefab"
	}
end

function XiaYinResultViewPresentor:buildViews()
	return {
		XiaYinResultView.New()
	}
end

return XiaYinResultViewPresentor
