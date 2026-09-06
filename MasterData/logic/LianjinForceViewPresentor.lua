-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/lianjinmm/LianjinForceViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.lianjinmm.LianjinForceViewPresentor", package.seeall)

local LianjinForceViewPresentor = class("LianjinForceViewPresentor", ViewPresentor)

function LianjinForceViewPresentor:ctor()
	LianjinForceViewPresentor.super.ctor(self)
end

function LianjinForceViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LianjinForceViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/lianjinmm/lianjinforceview.prefab"
	}
end

function LianjinForceViewPresentor:buildViews()
	return {
		LianjinForceView.New()
	}
end

return LianjinForceViewPresentor
