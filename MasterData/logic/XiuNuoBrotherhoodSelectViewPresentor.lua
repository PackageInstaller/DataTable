-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiunuobrotherhood/view/XiuNuoBrotherhoodSelectViewPresentor.lua

module("logic.extensions.xiunuobrotherhood.view.XiuNuoBrotherhoodSelectViewPresentor", package.seeall)

local XiuNuoBrotherhoodSelectViewPresentor = class("XiuNuoBrotherhoodSelectViewPresentor", ViewPresentor)

function XiuNuoBrotherhoodSelectViewPresentor:ctor()
	XiuNuoBrotherhoodSelectViewPresentor.super.ctor(self)
end

function XiuNuoBrotherhoodSelectViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function XiuNuoBrotherhoodSelectViewPresentor:dependWhatResources()
	return {
		"ui/views/xiunuobrotherhood/xiunuobrotherhoodselectview.prefab"
	}
end

function XiuNuoBrotherhoodSelectViewPresentor:buildViews()
	return {
		XiuNuoBrotherhoodSelectView.New()
	}
end

return XiuNuoBrotherhoodSelectViewPresentor
