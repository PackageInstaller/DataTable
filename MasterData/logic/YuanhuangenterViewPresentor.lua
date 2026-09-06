-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yuanhuang/view/YuanhuangenterViewPresentor.lua

module("logic.extensions.yuanhuang.view.YuanhuangenterViewPresentor", package.seeall)

local YuanhuangenterViewPresentor = class("YuanhuangenterViewPresentor", ViewPresentor)

function YuanhuangenterViewPresentor:ctor()
	YuanhuangenterViewPresentor.super.ctor(self)
end

function YuanhuangenterViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YuanhuangenterViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/yuanhuang/yuanhuangenterview.prefab"
	}
end

function YuanhuangenterViewPresentor:buildViews()
	return {
		YuanhuangenterView.New()
	}
end

return YuanhuangenterViewPresentor
