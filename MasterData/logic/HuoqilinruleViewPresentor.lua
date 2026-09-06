-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/huoqilin/view/HuoqilinruleViewPresentor.lua

module("logic.extensions.huoqilin.view.HuoqilinruleViewPresentor", package.seeall)

local HuoqilinruleViewPresentor = class("HuoqilinruleViewPresentor", ViewPresentor)

function HuoqilinruleViewPresentor:ctor()
	HuoqilinruleViewPresentor.super.ctor(self)
end

function HuoqilinruleViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HuoqilinruleViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/huoqilin/huoqilinruleview.prefab"
	}
end

function HuoqilinruleViewPresentor:buildViews()
	return {
		HuoqilinruleView.New()
	}
end

return HuoqilinruleViewPresentor
