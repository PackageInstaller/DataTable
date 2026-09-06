-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fanruilottery/view/FanRuiLotteryGameViewPresentor.lua

module("logic.extensions.fanruilottery.view.FanRuiLotteryGameViewPresentor", package.seeall)

local FanRuiLotteryGameViewPresentor = class("FanRuiLotteryGameViewPresentor", ViewPresentor)

function FanRuiLotteryGameViewPresentor:ctor()
	FanRuiLotteryGameViewPresentor.super.ctor(self)
end

function FanRuiLotteryGameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FanRuiLotteryGameViewPresentor:dependWhatResources()
	return {
		"ui/views/fanruilottery/fanruilotterygameview.prefab"
	}
end

function FanRuiLotteryGameViewPresentor:buildViews()
	return {
		FanRuiLotteryGameView.New()
	}
end

return FanRuiLotteryGameViewPresentor
