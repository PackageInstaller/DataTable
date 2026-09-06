-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/shikongshenglong/SiYuanmainViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.shikongshenglong.SiYuanmainViewPresentor", package.seeall)

local SiYuanmainViewPresentor = class("SiYuanmainViewPresentor", ViewPresentor)

function SiYuanmainViewPresentor:ctor()
	SiYuanmainViewPresentor.super.ctor(self)
end

function SiYuanmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SiYuanmainViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/shikongshenglong/siyuanmainview.prefab"
	}
end

function SiYuanmainViewPresentor:buildViews()
	return {
		SiYuanmainView.New()
	}
end

return SiYuanmainViewPresentor
