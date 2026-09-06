-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiumumchallenge/view/XiuMumGameViewPresentor.lua

module("logic.extensions.xiumumchallenge.view.XiuMumGameViewPresentor", package.seeall)

local XiuMumGameViewPresentor = class("XiuMumGameViewPresentor", ViewPresentor)

function XiuMumGameViewPresentor:ctor()
	XiuMumGameViewPresentor.super.ctor(self)
end

function XiuMumGameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function XiuMumGameViewPresentor:dependWhatResources()
	return {
		"ui/views/xiumum/xiumumgameview.prefab"
	}
end

function XiuMumGameViewPresentor:buildViews()
	return {
		XiuMumGameView.New()
	}
end

return XiuMumGameViewPresentor
