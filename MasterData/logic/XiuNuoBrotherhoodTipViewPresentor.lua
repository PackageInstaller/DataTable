-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiunuobrotherhood/view/XiuNuoBrotherhoodTipViewPresentor.lua

module("logic.extensions.xiunuobrotherhood.view.XiuNuoBrotherhoodTipViewPresentor", package.seeall)

local XiuNuoBrotherhoodTipViewPresentor = class("XiuNuoBrotherhoodTipViewPresentor", ViewPresentor)

function XiuNuoBrotherhoodTipViewPresentor:ctor()
	XiuNuoBrotherhoodTipViewPresentor.super.ctor(self)
end

function XiuNuoBrotherhoodTipViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function XiuNuoBrotherhoodTipViewPresentor:dependWhatResources()
	return {
		"ui/views/xiunuobrotherhood/xiunuobrotherhoodtipview.prefab"
	}
end

function XiuNuoBrotherhoodTipViewPresentor:buildViews()
	return {
		XiuNuoBrotherhoodTipView.New()
	}
end

return XiuNuoBrotherhoodTipViewPresentor
