-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/zhixulong/ZhiXuLongBuffShowViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.zhixulong.ZhiXuLongBuffShowViewPresentor", package.seeall)

local ZhiXuLongBuffShowViewPresentor = class("ZhiXuLongBuffShowViewPresentor", ViewPresentor)

function ZhiXuLongBuffShowViewPresentor:ctor()
	ZhiXuLongBuffShowViewPresentor.super.ctor(self)
end

function ZhiXuLongBuffShowViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ZhiXuLongBuffShowViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/zhixulong/zhixulongbuffshowview.prefab"
	}
end

function ZhiXuLongBuffShowViewPresentor:buildViews()
	return {
		ZhiXuLongBuffShowView.New()
	}
end

return ZhiXuLongBuffShowViewPresentor
