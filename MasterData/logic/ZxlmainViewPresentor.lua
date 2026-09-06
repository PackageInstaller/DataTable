-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/shikongshenglong/ZxlmainViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.shikongshenglong.ZxlmainViewPresentor", package.seeall)

local ZxlmainViewPresentor = class("ZxlmainViewPresentor", ViewPresentor)

function ZxlmainViewPresentor:ctor()
	ZxlmainViewPresentor.super.ctor(self)
end

function ZxlmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ZxlmainViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/shikongshenglong/zxlmainview.prefab"
	}
end

function ZxlmainViewPresentor:buildViews()
	return {
		ZxlmainView.New()
	}
end

return ZxlmainViewPresentor
