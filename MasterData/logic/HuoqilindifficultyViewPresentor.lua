-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/huoqilin/view/HuoqilindifficultyViewPresentor.lua

module("logic.extensions.huoqilin.view.HuoqilindifficultyViewPresentor", package.seeall)

local HuoqilindifficultyViewPresentor = class("HuoqilindifficultyViewPresentor", ViewPresentor)

function HuoqilindifficultyViewPresentor:ctor()
	HuoqilindifficultyViewPresentor.super.ctor(self)
end

function HuoqilindifficultyViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HuoqilindifficultyViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/huoqilin/huoqilindifficultyview.prefab"
	}
end

function HuoqilindifficultyViewPresentor:buildViews()
	return {
		HuoqilindifficultyView.New()
	}
end

return HuoqilindifficultyViewPresentor
