-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiunuobrotherhoodcopy/view/XiuNuoBrotherhoodBuffCopyViewPresentor.lua

module("logic.extensions.xiunuobrotherhood.view.XiuNuoBrotherhoodBuffCopyViewPresentor", package.seeall)

local XiuNuoBrotherhoodBuffCopyViewPresentor = class("XiuNuoBrotherhoodBuffCopyViewPresentor", ViewPresentor)

function XiuNuoBrotherhoodBuffCopyViewPresentor:ctor()
	XiuNuoBrotherhoodBuffCopyViewPresentor.super.ctor(self)
end

function XiuNuoBrotherhoodBuffCopyViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function XiuNuoBrotherhoodBuffCopyViewPresentor:dependWhatResources()
	return {
		"ui/views/xiunuobrotherhood/copy/xiunuobrotherhoodbuffcopyview.prefab"
	}
end

function XiuNuoBrotherhoodBuffCopyViewPresentor:buildViews()
	return {
		XiuNuoBrotherhoodBuffCopyView.New()
	}
end

return XiuNuoBrotherhoodBuffCopyViewPresentor
