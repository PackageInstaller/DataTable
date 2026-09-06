-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yuanhuang/view/YuanhuangmainViewPresentor.lua

module("logic.extensions.yuanhuang.view.YuanhuangmainViewPresentor", package.seeall)

local YuanhuangmainViewPresentor = class("YuanhuangmainViewPresentor", ViewPresentor)

function YuanhuangmainViewPresentor:ctor()
	YuanhuangmainViewPresentor.super.ctor(self)
end

function YuanhuangmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YuanhuangmainViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/yuanhuang/yuanhuangmainview.prefab"
	}
end

function YuanhuangmainViewPresentor:buildViews()
	return {
		YuanhuangmainView.New()
	}
end

return YuanhuangmainViewPresentor
