-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stickcouplet/view/StickCoupletNormalGameViewPresentor.lua

module("logic.extensions.stickcouplet.view.StickCoupletNormalGameViewPresentor", package.seeall)

local StickCoupletNormalGameViewPresentor = class("StickCoupletNormalGameViewPresentor", ViewPresentor)

function StickCoupletNormalGameViewPresentor:ctor()
	StickCoupletNormalGameViewPresentor.super.ctor(self)
end

function StickCoupletNormalGameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function StickCoupletNormalGameViewPresentor:dependWhatResources()
	return {
		"ui/views/stickcouplet/stickcoupletnormalgameview.prefab"
	}
end

function StickCoupletNormalGameViewPresentor:buildViews()
	return {
		StickCoupletNormalGameView.New()
	}
end

return StickCoupletNormalGameViewPresentor
