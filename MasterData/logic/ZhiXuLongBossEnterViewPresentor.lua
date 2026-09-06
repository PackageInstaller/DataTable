-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/zhixulong/ZhiXuLongBossEnterViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.zhixulong.ZhiXuLongBossEnterViewPresentor", package.seeall)

local ZhiXuLongBossEnterViewPresentor = class("ZhiXuLongBossEnterViewPresentor", ViewPresentor)

function ZhiXuLongBossEnterViewPresentor:ctor()
	ZhiXuLongBossEnterViewPresentor.super.ctor(self)
end

function ZhiXuLongBossEnterViewPresentor:attachToWhichRoot()
	return ViewRootType.Notify
end

function ZhiXuLongBossEnterViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/zhixulong/zhixulongbossenterview.prefab"
	}
end

function ZhiXuLongBossEnterViewPresentor:buildViews()
	return {
		ZhiXuLongBossEnterView.New()
	}
end

return ZhiXuLongBossEnterViewPresentor
