-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ciyuanlonghuangnuoya/view/CiyuanlonghuangnuoyalevelViewPresentor.lua

module("logic.extensions.ciyuanlonghuangnuoya.view.CiyuanlonghuangnuoyalevelViewPresentor", package.seeall)

local CiyuanlonghuangnuoyalevelViewPresentor = class("CiyuanlonghuangnuoyalevelViewPresentor", ViewPresentor)

function CiyuanlonghuangnuoyalevelViewPresentor:ctor()
	CiyuanlonghuangnuoyalevelViewPresentor.super.ctor(self)
end

function CiyuanlonghuangnuoyalevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CiyuanlonghuangnuoyalevelViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/ciyuanlonghuangnuoya/ciyuanlonghuangnuoyalevelview.prefab"
	}
end

function CiyuanlonghuangnuoyalevelViewPresentor:buildViews()
	return {
		CiyuanlonghuangnuoyalevelView.New()
	}
end

return CiyuanlonghuangnuoyalevelViewPresentor
