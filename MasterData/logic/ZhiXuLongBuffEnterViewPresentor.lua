-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/zhixulong/ZhiXuLongBuffEnterViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.zhixulong.ZhiXuLongBuffEnterViewPresentor", package.seeall)

local ZhiXuLongBuffEnterViewPresentor = class("ZhiXuLongBuffEnterViewPresentor", ViewPresentor)

function ZhiXuLongBuffEnterViewPresentor:ctor()
	ZhiXuLongBuffEnterViewPresentor.super.ctor(self)
end

function ZhiXuLongBuffEnterViewPresentor:attachToWhichRoot()
	return ViewRootType.Notify
end

function ZhiXuLongBuffEnterViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/zhixulong/zhixulongbuffenterview.prefab"
	}
end

function ZhiXuLongBuffEnterViewPresentor:buildViews()
	return {
		ZhiXuLongBuffEnterView.New()
	}
end

return ZhiXuLongBuffEnterViewPresentor
