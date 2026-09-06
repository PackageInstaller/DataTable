-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xinxiyamirror/view/XinxiyaShopViewPresentor.lua

module("logic.extensions.xinxiyamirror.view.XinxiyaShopViewPresentor", package.seeall)

local XinxiyaShopViewPresentor = class("XinxiyaShopViewPresentor", ViewWithGuidePresentor)

function XinxiyaShopViewPresentor:ctor()
	XinxiyaShopViewPresentor.super.ctor(self)
end

function XinxiyaShopViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function XinxiyaShopViewPresentor:dependWhatResources()
	return {
		"ui/views/xinxiyamirror/xinxiyashopview.prefab"
	}
end

function XinxiyaShopViewPresentor:buildViews()
	return {
		XinxiyaShopView.New()
	}
end

return XinxiyaShopViewPresentor
