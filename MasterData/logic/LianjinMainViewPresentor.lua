-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/lianjinmm/LianjinMainViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.lianjinmm.LianjinMainViewPresentor", package.seeall)

local LianjinMainViewPresentor = class("LianjinMainViewPresentor", ViewPresentor)

function LianjinMainViewPresentor:ctor()
	LianjinMainViewPresentor.super.ctor(self)
end

function LianjinMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LianjinMainViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/lianjinmm/lianjinmainview.prefab"
	}
end

function LianjinMainViewPresentor:buildViews()
	return {
		LianjinMainView.New()
	}
end

return LianjinMainViewPresentor
