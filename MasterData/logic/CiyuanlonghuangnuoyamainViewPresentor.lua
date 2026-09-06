-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ciyuanlonghuangnuoya/view/CiyuanlonghuangnuoyamainViewPresentor.lua

module("logic.extensions.ciyuanlonghuangnuoya.view.CiyuanlonghuangnuoyamainViewPresentor", package.seeall)

local CiyuanlonghuangnuoyamainViewPresentor = class("CiyuanlonghuangnuoyamainViewPresentor", ViewPresentor)

function CiyuanlonghuangnuoyamainViewPresentor:ctor()
	CiyuanlonghuangnuoyamainViewPresentor.super.ctor(self)
end

function CiyuanlonghuangnuoyamainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CiyuanlonghuangnuoyamainViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/ciyuanlonghuangnuoya/ciyuanlonghuangnuoyamainview.prefab"
	}
end

function CiyuanlonghuangnuoyamainViewPresentor:buildViews()
	return {
		CiyuanlonghuangnuoyamainView.New()
	}
end

return CiyuanlonghuangnuoyamainViewPresentor
