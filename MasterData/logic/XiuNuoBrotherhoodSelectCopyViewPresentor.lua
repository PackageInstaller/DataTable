-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiunuobrotherhoodcopy/view/XiuNuoBrotherhoodSelectCopyViewPresentor.lua

module("logic.extensions.xiunuobrotherhood.view.XiuNuoBrotherhoodSelectCopyViewPresentor", package.seeall)

local XiuNuoBrotherhoodSelectCopyViewPresentor = class("XiuNuoBrotherhoodSelectCopyViewPresentor", ViewPresentor)

function XiuNuoBrotherhoodSelectCopyViewPresentor:ctor()
	XiuNuoBrotherhoodSelectCopyViewPresentor.super.ctor(self)
end

function XiuNuoBrotherhoodSelectCopyViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function XiuNuoBrotherhoodSelectCopyViewPresentor:dependWhatResources()
	return {
		"ui/views/xiunuobrotherhood/copy/xiunuobrotherhoodselectcopyview.prefab"
	}
end

function XiuNuoBrotherhoodSelectCopyViewPresentor:buildViews()
	return {
		XiuNuoBrotherhoodSelectCopyView.New()
	}
end

return XiuNuoBrotherhoodSelectCopyViewPresentor
