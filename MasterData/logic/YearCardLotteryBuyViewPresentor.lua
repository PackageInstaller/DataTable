-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcardlottery/view/YearCardLotteryBuyViewPresentor.lua

module("logic.extensions.yearcardlottery.view.YearCardLotteryBuyViewPresentor", package.seeall)

local YearCardLotteryBuyViewPresentor = class("YearCardLotteryBuyViewPresentor", ViewPresentor)

function YearCardLotteryBuyViewPresentor:ctor()
	YearCardLotteryBuyViewPresentor.super.ctor(self)
end

function YearCardLotteryBuyViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YearCardLotteryBuyViewPresentor:dependWhatResources()
	return {
		"ui/views/yearcardlottery/yclotterybuyview.prefab"
	}
end

function YearCardLotteryBuyViewPresentor:buildViews()
	return {
		YearCardLotteryBuyView.New()
	}
end

return YearCardLotteryBuyViewPresentor
