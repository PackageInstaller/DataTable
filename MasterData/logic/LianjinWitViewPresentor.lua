-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/lianjinmm/LianjinWitViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.lianjinmm.LianjinWitViewPresentor", package.seeall)

local LianjinWitViewPresentor = class("LianjinWitViewPresentor", ViewPresentor)

function LianjinWitViewPresentor:ctor()
	LianjinWitViewPresentor.super.ctor(self)
end

function LianjinWitViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LianjinWitViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/lianjinmm/lianjinwitview.prefab"
	}
end

function LianjinWitViewPresentor:buildViews()
	return {
		LianjinWitView.New()
	}
end

return LianjinWitViewPresentor
