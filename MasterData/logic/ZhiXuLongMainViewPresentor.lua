-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/zhixulong/ZhiXuLongMainViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.zhixulong.ZhiXuLongMainViewPresentor", package.seeall)

local ZhiXuLongMainViewPresentor = class("ZhiXuLongMainViewPresentor", ViewPresentor)

function ZhiXuLongMainViewPresentor:ctor()
	ZhiXuLongMainViewPresentor.super.ctor(self)
end

function ZhiXuLongMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ZhiXuLongMainViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/zhixulong/zhixulongmainview.prefab"
	}
end

function ZhiXuLongMainViewPresentor:buildViews()
	return {
		ZhiXuLongMainView.New()
	}
end

return ZhiXuLongMainViewPresentor
