-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/huoqilin/view/HuoqilinpassruleViewPresentor.lua

module("logic.extensions.huoqilin.view.HuoqilinpassruleViewPresentor", package.seeall)

local HuoqilinpassruleViewPresentor = class("HuoqilinpassruleViewPresentor", ViewPresentor)

function HuoqilinpassruleViewPresentor:ctor()
	HuoqilinpassruleViewPresentor.super.ctor(self)
end

function HuoqilinpassruleViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HuoqilinpassruleViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/huoqilin/huoqilinpassruleview.prefab"
	}
end

function HuoqilinpassruleViewPresentor:buildViews()
	return {
		HuoqilinpassruleView.New()
	}
end

return HuoqilinpassruleViewPresentor
