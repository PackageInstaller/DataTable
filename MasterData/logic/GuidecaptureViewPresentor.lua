-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/view/GuidecaptureViewPresentor.lua

module("logic.extensions.guide.view.GuidecaptureViewPresentor", package.seeall)

local GuidecaptureViewPresentor = class("GuidecaptureViewPresentor", GuideViewPresentor)

function GuidecaptureViewPresentor:ctor()
	GuidecaptureViewPresentor.super.ctor(self)
end

function GuidecaptureViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GuidecaptureViewPresentor:dependWhatResources()
	return {
		"ui/views/guide/guidecaptureview.prefab"
	}
end

function GuidecaptureViewPresentor:buildViews()
	return {
		GuideCaptureView.New()
	}
end

return GuidecaptureViewPresentor
