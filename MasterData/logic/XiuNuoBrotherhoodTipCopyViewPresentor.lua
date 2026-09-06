-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiunuobrotherhoodcopy/view/XiuNuoBrotherhoodTipCopyViewPresentor.lua

module("logic.extensions.xiunuobrotherhood.view.XiuNuoBrotherhoodTipCopyViewPresentor", package.seeall)

local XiuNuoBrotherhoodTipCopyViewPresentor = class("XiuNuoBrotherhoodTipCopyViewPresentor", ViewPresentor)

function XiuNuoBrotherhoodTipCopyViewPresentor:ctor()
	XiuNuoBrotherhoodTipCopyViewPresentor.super.ctor(self)
end

function XiuNuoBrotherhoodTipCopyViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function XiuNuoBrotherhoodTipCopyViewPresentor:dependWhatResources()
	return {
		"ui/views/xiunuobrotherhood/copy/xiunuobrotherhoodtipcopyview.prefab"
	}
end

function XiuNuoBrotherhoodTipCopyViewPresentor:buildViews()
	return {
		XiuNuoBrotherhoodTipCopyView.New()
	}
end

return XiuNuoBrotherhoodTipCopyViewPresentor
