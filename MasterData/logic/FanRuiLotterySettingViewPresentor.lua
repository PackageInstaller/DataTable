-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fanruilottery/view/FanRuiLotterySettingViewPresentor.lua

module("logic.extensions.fanruilottery.view.FanRuiLotterySettingViewPresentor", package.seeall)

local FanRuiLotterySettingViewPresentor = class("FanRuiLotterySettingViewPresentor", ViewPresentor)

function FanRuiLotterySettingViewPresentor:ctor()
	FanRuiLotterySettingViewPresentor.super.ctor(self)
end

function FanRuiLotterySettingViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FanRuiLotterySettingViewPresentor:dependWhatResources()
	return {
		"ui/views/fanruilottery/fanruilotterysettingview.prefab"
	}
end

function FanRuiLotterySettingViewPresentor:buildViews()
	return {
		FanRuiLotterySettingView.New()
	}
end

return FanRuiLotterySettingViewPresentor
