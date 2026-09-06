-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiaoxiaoleskin/view/XiaoxiaoleSkinPopupViewPresentor.lua

module("logic.extensions.xiaoxiaoleskin.view.XiaoxiaoleSkinPopupViewPresentor", package.seeall)

local XiaoxiaoleSkinPopupViewPresentor = class("XiaoxiaoleSkinPopupViewPresentor", ViewPresentor)

function XiaoxiaoleSkinPopupViewPresentor:ctor()
	XiaoxiaoleSkinPopupViewPresentor.super.ctor(self)
end

function XiaoxiaoleSkinPopupViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function XiaoxiaoleSkinPopupViewPresentor:dependWhatResources()
	return {
		"ui/views/xiaoxiaoleskin/xiaoxiaoleskinpopupview.prefab"
	}
end

function XiaoxiaoleSkinPopupViewPresentor:buildViews()
	return {
		XiaoxiaoleSkinPopupView.New()
	}
end

return XiaoxiaoleSkinPopupViewPresentor
