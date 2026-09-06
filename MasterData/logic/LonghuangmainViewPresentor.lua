-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/longhuang/LonghuangmainViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.longhuang.LonghuangmainViewPresentor", package.seeall)

local LonghuangmainViewPresentor = class("LonghuangmainViewPresentor", ViewPresentor)

function LonghuangmainViewPresentor:ctor()
	LonghuangmainViewPresentor.super.ctor(self)
end

function LonghuangmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LonghuangmainViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/longhuangmainview.prefab"
	}
end

function LonghuangmainViewPresentor:buildViews()
	return {
		LonghuangmainView.New()
	}
end

return LonghuangmainViewPresentor
