-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stickcouplet/view/StickCoupletHardGameViewPresentor.lua

module("logic.extensions.stickcouplet.view.StickCoupletHardGameViewPresentor", package.seeall)

local StickCoupletHardGameViewPresentor = class("StickCoupletHardGameViewPresentor", ViewPresentor)

function StickCoupletHardGameViewPresentor:ctor()
	StickCoupletHardGameViewPresentor.super.ctor(self)
end

function StickCoupletHardGameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function StickCoupletHardGameViewPresentor:dependWhatResources()
	return {
		"ui/views/stickcouplet/stickcouplethardgameview.prefab"
	}
end

function StickCoupletHardGameViewPresentor:buildViews()
	return {
		StickCoupletHardGameView.New()
	}
end

return StickCoupletHardGameViewPresentor
