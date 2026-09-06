-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/huoqilin/view/HuoqilinmainViewPresentor.lua

module("logic.extensions.huoqilin.view.HuoqilinmainViewPresentor", package.seeall)

local HuoqilinmainViewPresentor = class("HuoqilinmainViewPresentor", ViewPresentor)

function HuoqilinmainViewPresentor:ctor()
	HuoqilinmainViewPresentor.super.ctor(self)
end

function HuoqilinmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HuoqilinmainViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/huoqilin/huoqilinmainview.prefab"
	}
end

function HuoqilinmainViewPresentor:buildViews()
	return {
		HuoqilinmainView.New()
	}
end

return HuoqilinmainViewPresentor
