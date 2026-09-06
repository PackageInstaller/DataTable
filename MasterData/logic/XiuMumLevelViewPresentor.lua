-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiumumchallenge/view/XiuMumLevelViewPresentor.lua

module("logic.extensions.xiumumchallenge.view.XiuMumLevelViewPresentor", package.seeall)

local XiuMumLevelViewPresentor = class("XiuMumLevelViewPresentor", ViewPresentor)

function XiuMumLevelViewPresentor:ctor()
	XiuMumLevelViewPresentor.super.ctor(self)
end

function XiuMumLevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function XiuMumLevelViewPresentor:dependWhatResources()
	return {
		"ui/views/xiumum/xiumumlevelview.prefab"
	}
end

function XiuMumLevelViewPresentor:buildViews()
	return {
		XiuMumLevelView.New()
	}
end

return XiuMumLevelViewPresentor
