-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ciyuanlonghuangnuoya/view/CiyuanlonghuangnuoyanorresultlViewPresentor.lua

module("logic.extensions.ciyuanlonghuangnuoya.view.CiyuanlonghuangnuoyanorresultlViewPresentor", package.seeall)

local CiyuanlonghuangnuoyanorresultlViewPresentor = class("CiyuanlonghuangnuoyanorresultlViewPresentor", ViewPresentor)

function CiyuanlonghuangnuoyanorresultlViewPresentor:ctor()
	CiyuanlonghuangnuoyanorresultlViewPresentor.super.ctor(self)
end

function CiyuanlonghuangnuoyanorresultlViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CiyuanlonghuangnuoyanorresultlViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/ciyuanlonghuangnuoya/ciyuanlonghuangnuoyanorresultlview.prefab"
	}
end

function CiyuanlonghuangnuoyanorresultlViewPresentor:buildViews()
	return {
		CiyuanlonghuangnuoyanorresultlView.New()
	}
end

return CiyuanlonghuangnuoyanorresultlViewPresentor
