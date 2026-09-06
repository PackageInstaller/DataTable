-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiaoxiaoleskin/view/XiaoxiaoleSkinViewPresentor.lua

module("logic.extensions.xiaoxiaoleskin.view.XiaoxiaoleSkinViewPresentor", package.seeall)

local XiaoxiaoleSkinViewPresentor = class("XiaoxiaoleSkinViewPresentor", ViewPresentor)

function XiaoxiaoleSkinViewPresentor:ctor()
	XiaoxiaoleSkinViewPresentor.super.ctor(self)
end

function XiaoxiaoleSkinViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function XiaoxiaoleSkinViewPresentor:dependWhatResources()
	return {
		"ui/views/xiaoxiaoleskin/xiaoxiaoleskinview.prefab"
	}
end

function XiaoxiaoleSkinViewPresentor:buildViews()
	return {
		XiaoxiaoleSkinView.New()
	}
end

return XiaoxiaoleSkinViewPresentor
