-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiunuobrotherhood/view/XiuNuoBrotherhoodMainViewPresentor.lua

module("logic.extensions.xiunuobrotherhood.view.XiuNuoBrotherhoodMainViewPresentor", package.seeall)

local XiuNuoBrotherhoodMainViewPresentor = class("XiuNuoBrotherhoodMainViewPresentor", ViewPresentor)

function XiuNuoBrotherhoodMainViewPresentor:ctor()
	XiuNuoBrotherhoodMainViewPresentor.super.ctor(self)
end

function XiuNuoBrotherhoodMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function XiuNuoBrotherhoodMainViewPresentor:dependWhatResources()
	return {
		"ui/views/xiunuobrotherhood/xiunuobrotherhoodmainview.prefab"
	}
end

function XiuNuoBrotherhoodMainViewPresentor:buildViews()
	return {
		XiuNuoBrotherhoodMainView.New()
	}
end

return XiuNuoBrotherhoodMainViewPresentor
