-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ciyuanlonghuangnuoya/view/CiyuanlonghuangnuoyaresultlViewPresentor.lua

module("logic.extensions.ciyuanlonghuangnuoya.view.CiyuanlonghuangnuoyaresultlViewPresentor", package.seeall)

local CiyuanlonghuangnuoyaresultlViewPresentor = class("CiyuanlonghuangnuoyaresultlViewPresentor", ViewPresentor)

function CiyuanlonghuangnuoyaresultlViewPresentor:ctor()
	CiyuanlonghuangnuoyaresultlViewPresentor.super.ctor(self)
end

function CiyuanlonghuangnuoyaresultlViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CiyuanlonghuangnuoyaresultlViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/ciyuanlonghuangnuoya/ciyuanlonghuangnuoyaresultlview.prefab"
	}
end

function CiyuanlonghuangnuoyaresultlViewPresentor:buildViews()
	return {
		CiyuanlonghuangnuoyaresultlView.New()
	}
end

return CiyuanlonghuangnuoyaresultlViewPresentor
