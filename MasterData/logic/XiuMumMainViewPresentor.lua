-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiumumchallenge/view/XiuMumMainViewPresentor.lua

module("logic.extensions.xiumumchallenge.view.XiuMumMainViewPresentor", package.seeall)

local XiuMumMainViewPresentor = class("XiuMumMainViewPresentor", ViewPresentor)

function XiuMumMainViewPresentor:ctor()
	XiuMumMainViewPresentor.super.ctor(self)
end

function XiuMumMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function XiuMumMainViewPresentor:dependWhatResources()
	return {
		"ui/views/xiumum/xiumummainview.prefab"
	}
end

function XiuMumMainViewPresentor:buildViews()
	return {
		XiuMumMainView.New()
	}
end

return XiuMumMainViewPresentor
