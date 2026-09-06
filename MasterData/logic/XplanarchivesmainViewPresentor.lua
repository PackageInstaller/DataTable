-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xplanarchives/view/XplanarchivesmainViewPresentor.lua

module("logic.extensions.xplanarchives.view.XplanarchivesmainViewPresentor", package.seeall)

local XplanarchivesmainViewPresentor = class("XplanarchivesmainViewPresentor", ViewPresentor)

function XplanarchivesmainViewPresentor:ctor()
	XplanarchivesmainViewPresentor.super.ctor(self)
end

function XplanarchivesmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function XplanarchivesmainViewPresentor:dependWhatResources()
	return {
		"ui/views/xplanarchives/xplanarchivesmainview.prefab"
	}
end

function XplanarchivesmainViewPresentor:buildViews()
	return {
		XplanarchivesmainView.New()
	}
end

return XplanarchivesmainViewPresentor
