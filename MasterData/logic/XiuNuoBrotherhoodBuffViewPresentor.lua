-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiunuobrotherhood/view/XiuNuoBrotherhoodBuffViewPresentor.lua

module("logic.extensions.xiunuobrotherhood.view.XiuNuoBrotherhoodBuffViewPresentor", package.seeall)

local XiuNuoBrotherhoodBuffViewPresentor = class("XiuNuoBrotherhoodBuffViewPresentor", ViewPresentor)

function XiuNuoBrotherhoodBuffViewPresentor:ctor()
	XiuNuoBrotherhoodBuffViewPresentor.super.ctor(self)
end

function XiuNuoBrotherhoodBuffViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function XiuNuoBrotherhoodBuffViewPresentor:dependWhatResources()
	return {
		"ui/views/xiunuobrotherhood/xiunuobrotherhoodbuffview.prefab"
	}
end

function XiuNuoBrotherhoodBuffViewPresentor:buildViews()
	return {
		XiuNuoBrotherhoodBuffView.New()
	}
end

return XiuNuoBrotherhoodBuffViewPresentor
