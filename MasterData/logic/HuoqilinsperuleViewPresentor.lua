-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/huoqilin/view/HuoqilinsperuleViewPresentor.lua

module("logic.extensions.huoqilin.view.HuoqilinsperuleViewPresentor", package.seeall)

local HuoqilinsperuleViewPresentor = class("HuoqilinsperuleViewPresentor", ViewPresentor)

function HuoqilinsperuleViewPresentor:ctor()
	HuoqilinsperuleViewPresentor.super.ctor(self)
end

function HuoqilinsperuleViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HuoqilinsperuleViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/huoqilin/huoqilinsperuleview.prefab"
	}
end

function HuoqilinsperuleViewPresentor:buildViews()
	return {
		HuoqilinsperuleView.New()
	}
end

return HuoqilinsperuleViewPresentor
