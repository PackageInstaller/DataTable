-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xplanarchives/view/XplanarchivesrewardViewPresentor.lua

module("logic.extensions.xplanarchives.view.XplanarchivesrewardViewPresentor", package.seeall)

local XplanarchivesrewardViewPresentor = class("XplanarchivesrewardViewPresentor", ViewPresentor)

function XplanarchivesrewardViewPresentor:ctor()
	XplanarchivesrewardViewPresentor.super.ctor(self)
end

function XplanarchivesrewardViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function XplanarchivesrewardViewPresentor:dependWhatResources()
	return {
		"ui/views/xplanarchives/xplanarchivesrewardview.prefab"
	}
end

function XplanarchivesrewardViewPresentor:buildViews()
	return {
		XplanarchivesrewardView.New()
	}
end

return XplanarchivesrewardViewPresentor
