-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/huanxinqing/view/HuanXinQingMainViewPresentor.lua

module("logic.extensions.huanxinqing.view.HuanXinQingMainViewPresentor", package.seeall)

local HuanXinQingMainViewPresentor = class("HuanXinQingMainViewPresentor", ViewPresentor)

function HuanXinQingMainViewPresentor:ctor()
	HuanXinQingMainViewPresentor.super.ctor(self)
end

function HuanXinQingMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HuanXinQingMainViewPresentor:dependWhatResources()
	return {
		"ui/views/huanxinqing/huanxinqingmainview.prefab"
	}
end

function HuanXinQingMainViewPresentor:buildViews()
	return {
		HuanXinQingMainView.New()
	}
end

return HuanXinQingMainViewPresentor
