-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stickcouplet/view/StickCoupletChooseViewPresentor.lua

module("logic.extensions.stickcouplet.view.StickCoupletChooseViewPresentor", package.seeall)

local StickCoupletChooseViewPresentor = class("StickCoupletChooseViewPresentor", ViewPresentor)

function StickCoupletChooseViewPresentor:ctor()
	StickCoupletChooseViewPresentor.super.ctor(self)
end

function StickCoupletChooseViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function StickCoupletChooseViewPresentor:dependWhatResources()
	return {
		"ui/views/stickcouplet/stickcoupletchooseview.prefab"
	}
end

function StickCoupletChooseViewPresentor:buildViews()
	return {
		StickCoupletChooseView.New()
	}
end

return StickCoupletChooseViewPresentor
