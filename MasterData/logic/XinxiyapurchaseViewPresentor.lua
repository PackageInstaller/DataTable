-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/activityshop/view/XinxiyapurchaseViewPresentor.lua

module("logic.extensions.activityshop.view.XinxiyapurchaseViewPresentor", package.seeall)

local XinxiyapurchaseViewPresentor = class("XinxiyapurchaseViewPresentor", ViewPresentor)

function XinxiyapurchaseViewPresentor:ctor()
	XinxiyapurchaseViewPresentor.super.ctor(self)
end

function XinxiyapurchaseViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function XinxiyapurchaseViewPresentor:dependWhatResources()
	return {
		"ui/views/xinxiyapurchase/xinxiyapurchaseview.prefab"
	}
end

function XinxiyapurchaseViewPresentor:buildViews()
	return {
		XinxiyapurchaseView.New()
	}
end

return XinxiyapurchaseViewPresentor
