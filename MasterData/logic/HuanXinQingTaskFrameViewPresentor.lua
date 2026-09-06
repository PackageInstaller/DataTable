-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/huanxinqing/view/HuanXinQingTaskFrameViewPresentor.lua

module("logic.extensions.huanxinqing.view.HuanXinQingTaskFrameViewPresentor", package.seeall)

local HuanXinQingTaskFrameViewPresentor = class("HuanXinQingTaskFrameViewPresentor", ViewPresentor)

function HuanXinQingTaskFrameViewPresentor:ctor()
	HuanXinQingTaskFrameViewPresentor.super.ctor(self)
end

function HuanXinQingTaskFrameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HuanXinQingTaskFrameViewPresentor:dependWhatResources()
	return {
		"ui/views/huanxinqing/huanxinqingtaskframeview.prefab"
	}
end

function HuanXinQingTaskFrameViewPresentor:buildViews()
	return {
		HuanXinQingTaskFrameView.New()
	}
end

function HuanXinQingTaskFrameViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return HuanXinQingTaskFrameViewPresentor
