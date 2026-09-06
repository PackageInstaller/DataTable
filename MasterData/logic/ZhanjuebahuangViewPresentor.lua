-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/tianmanking/ZhanjuebahuangViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.tianmanking.ZhanjuebahuangViewPresentor", package.seeall)

local ZhanjuebahuangViewPresentor = class("ZhanjuebahuangViewPresentor", ViewPresentor)

function ZhanjuebahuangViewPresentor:ctor()
	ZhanjuebahuangViewPresentor.super.ctor(self)
end

function ZhanjuebahuangViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ZhanjuebahuangViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/tianmanking/zhanjuebahuangview.prefab"
	}
end

function ZhanjuebahuangViewPresentor:buildViews()
	return {
		ZhanjuebahuangView.New()
	}
end

return ZhanjuebahuangViewPresentor
