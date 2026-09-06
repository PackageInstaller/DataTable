-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/huanxinqing/view/HuanXinQingChildViewPresentor.lua

module("logic.extensions.huanxinqing.view.HuanXinQingChildViewPresentor", package.seeall)

local HuanXinQingChildViewPresentor = class("HuanXinQingChildViewPresentor", ViewPresentor)

function HuanXinQingChildViewPresentor:ctor()
	HuanXinQingChildViewPresentor.super.ctor(self)
end

function HuanXinQingChildViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HuanXinQingChildViewPresentor:dependWhatResources()
	return {
		"ui/views/huanxinqing/huanxinqingchildview.prefab"
	}
end

function HuanXinQingChildViewPresentor:buildViews()
	return {
		HuanXinQingChildView.New()
	}
end

function HuanXinQingChildViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return HuanXinQingChildViewPresentor
