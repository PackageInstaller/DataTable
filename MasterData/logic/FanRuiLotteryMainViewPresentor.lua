-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fanruilottery/view/FanRuiLotteryMainViewPresentor.lua

module("logic.extensions.fanruilottery.view.FanRuiLotteryMainViewPresentor", package.seeall)

local FanRuiLotteryMainViewPresentor = class("FanRuiLotteryMainViewPresentor", ViewPresentor)

function FanRuiLotteryMainViewPresentor:ctor()
	FanRuiLotteryMainViewPresentor.super.ctor(self)
end

function FanRuiLotteryMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FanRuiLotteryMainViewPresentor:dependWhatResources()
	return {
		"ui/views/fanruilottery/fanruilotterymainview.prefab"
	}
end

function FanRuiLotteryMainViewPresentor:buildViews()
	return {
		FanRuiLotteryMainView.New()
	}
end

return FanRuiLotteryMainViewPresentor
