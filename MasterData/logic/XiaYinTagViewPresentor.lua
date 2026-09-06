-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiayin/view/XiaYinTagViewPresentor.lua

module("logic.extensions.xiayin.view.XiaYinTagViewPresentor", package.seeall)

local XiaYinTagViewPresentor = class("XiaYinTagViewPresentor", ViewPresentor)

function XiaYinTagViewPresentor:ctor()
	XiaYinTagViewPresentor.super.ctor(self)
end

function XiaYinTagViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function XiaYinTagViewPresentor:dependWhatResources()
	return {
		"ui/views/xiayin/xiayintagview.prefab"
	}
end

function XiaYinTagViewPresentor:buildViews()
	return {
		XiaYinTagView.New()
	}
end

return XiaYinTagViewPresentor
