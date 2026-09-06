-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stickcouplet/view/StickCoupletMainViewPresentor.lua

module("logic.extensions.stickcouplet.view.StickCoupletMainViewPresentor", package.seeall)

local StickCoupletMainViewPresentor = class("StickCoupletMainViewPresentor", ViewPresentor)

function StickCoupletMainViewPresentor:ctor()
	StickCoupletMainViewPresentor.super.ctor(self)
end

function StickCoupletMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function StickCoupletMainViewPresentor:dependWhatResources()
	return {
		"ui/views/stickcouplet/stickcoupletmainview.prefab"
	}
end

function StickCoupletMainViewPresentor:buildViews()
	return {
		StickCoupletMainView.New()
	}
end

return StickCoupletMainViewPresentor
