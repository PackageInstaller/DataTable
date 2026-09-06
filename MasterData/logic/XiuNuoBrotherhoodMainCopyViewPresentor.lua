-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiunuobrotherhoodcopy/view/XiuNuoBrotherhoodMainCopyViewPresentor.lua

module("logic.extensions.xiunuobrotherhood.view.XiuNuoBrotherhoodMainCopyViewPresentor", package.seeall)

local XiuNuoBrotherhoodMainCopyViewPresentor = class("XiuNuoBrotherhoodMainCopyViewPresentor", ViewPresentor)

function XiuNuoBrotherhoodMainCopyViewPresentor:ctor()
	XiuNuoBrotherhoodMainCopyViewPresentor.super.ctor(self)
end

function XiuNuoBrotherhoodMainCopyViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function XiuNuoBrotherhoodMainCopyViewPresentor:dependWhatResources()
	return {
		"ui/views/xiunuobrotherhood/copy/xiunuobrotherhoodmaincopyview.prefab"
	}
end

function XiuNuoBrotherhoodMainCopyViewPresentor:buildViews()
	return {
		XiuNuoBrotherhoodMainCopyView.New()
	}
end

return XiuNuoBrotherhoodMainCopyViewPresentor
