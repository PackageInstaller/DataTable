-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lottery/view/LotteryPrizeViewPresentor.lua

module("logic.extensions.lottery.view.LotteryPrizeViewPresentor", package.seeall)

local LotteryPrizeViewPresentor = class("LotteryPrizeViewPresentor", ViewPresentor)

function LotteryPrizeViewPresentor:ctor()
	LotteryPrizeViewPresentor.super.ctor(self)
end

function LotteryPrizeViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function LotteryPrizeViewPresentor:dependWhatResources()
	return {
		"ui/views/lottery/lotteryprizeview.prefab"
	}
end

function LotteryPrizeViewPresentor:buildViews()
	return {
		LotteryPrizeView.New()
	}
end

return LotteryPrizeViewPresentor
