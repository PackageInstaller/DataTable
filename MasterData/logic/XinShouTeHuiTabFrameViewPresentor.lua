-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xinshoutehui/view/XinShouTeHuiTabFrameViewPresentor.lua

module("logic.extensions.xinshoutehui.view.XinShouTeHuiTabFrameViewPresentor", package.seeall)

local XinShouTeHuiTabFrameViewPresentor = class("XinShouTeHuiTabFrameViewPresentor", ViewPresentor)

function XinShouTeHuiTabFrameViewPresentor:ctor()
	XinShouTeHuiTabFrameViewPresentor.super.ctor(self)
end

function XinShouTeHuiTabFrameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function XinShouTeHuiTabFrameViewPresentor:dependWhatResources()
	return {
		"ui/views/xinshoutehui/xinshoutehuitabframeview.prefab"
	}
end

function XinShouTeHuiTabFrameViewPresentor:buildViews()
	return {
		XinShouTeHuiTabFrameView.New()
	}
end

return XinShouTeHuiTabFrameViewPresentor
