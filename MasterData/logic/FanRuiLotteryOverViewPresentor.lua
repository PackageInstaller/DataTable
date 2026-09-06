-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fanruilottery/view/FanRuiLotteryOverViewPresentor.lua

module("logic.extensions.fanruilottery.view.FanRuiLotteryOverViewPresentor", package.seeall)

local FanRuiLotteryOverViewPresentor = class("FanRuiLotteryOverViewPresentor", ViewPresentor)

function FanRuiLotteryOverViewPresentor:ctor()
	FanRuiLotteryOverViewPresentor.super.ctor(self)
end

function FanRuiLotteryOverViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FanRuiLotteryOverViewPresentor:dependWhatResources()
	return {
		"ui/views/fanruilottery/fanruilotteryoverview.prefab"
	}
end

function FanRuiLotteryOverViewPresentor:buildViews()
	return {
		FanRuiLotteryOverView.New()
	}
end

return FanRuiLotteryOverViewPresentor
