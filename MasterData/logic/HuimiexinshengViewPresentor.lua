-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/caiqingdraw/view/HuimiexinshengViewPresentor.lua

module("logic.extensions.caiqingdraw.view.HuimiexinshengViewPresentor", package.seeall)

local HuimiexinshengViewPresentor = class("HuimiexinshengViewPresentor", ViewPresentor)

function HuimiexinshengViewPresentor:ctor()
	HuimiexinshengViewPresentor.super.ctor(self)
end

function HuimiexinshengViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HuimiexinshengViewPresentor:dependWhatResources()
	return {
		"ui/views/activity/caiqingdraw/huimiexinshengview.prefab"
	}
end

function HuimiexinshengViewPresentor:buildViews()
	return {
		HuimiexinshengView.New()
	}
end

return HuimiexinshengViewPresentor
