-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/shikongshenglong/SkslmainViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.shikongshenglong.SkslmainViewPresentor", package.seeall)

local SkslmainViewPresentor = class("SkslmainViewPresentor", ViewPresentor)

function SkslmainViewPresentor:ctor()
	SkslmainViewPresentor.super.ctor(self)
end

function SkslmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SkslmainViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/shikongshenglong/skslmainview.prefab"
	}
end

function SkslmainViewPresentor:buildViews()
	return {
		SkslmainView.New()
	}
end

return SkslmainViewPresentor
