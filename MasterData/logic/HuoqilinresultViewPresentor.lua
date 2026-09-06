-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/huoqilin/view/HuoqilinresultViewPresentor.lua

module("logic.extensions.huoqilin.view.HuoqilinresultViewPresentor", package.seeall)

local HuoqilinresultViewPresentor = class("HuoqilinresultViewPresentor", ViewPresentor)

function HuoqilinresultViewPresentor:ctor()
	HuoqilinresultViewPresentor.super.ctor(self)
end

function HuoqilinresultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HuoqilinresultViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/huoqilin/huoqilinresultview.prefab"
	}
end

function HuoqilinresultViewPresentor:buildViews()
	return {
		HuoqilinresultView.New()
	}
end

return HuoqilinresultViewPresentor
