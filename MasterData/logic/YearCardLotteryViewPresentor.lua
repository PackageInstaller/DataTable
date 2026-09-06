-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcardlottery/view/YearCardLotteryViewPresentor.lua

module("logic.extensions.yearcardlottery.view.YearCardLotteryViewPresentor", package.seeall)

local YearCardLotteryViewPresentor = class("YearCardLotteryViewPresentor", ViewPresentor)

function YearCardLotteryViewPresentor:ctor()
	YearCardLotteryViewPresentor.super.ctor(self)
end

function YearCardLotteryViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YearCardLotteryViewPresentor:dependWhatResources()
	return {
		"ui/views/yearcardlottery/yclotteryview.prefab"
	}
end

function YearCardLotteryViewPresentor:buildViews()
	return {
		YearCardLotteryView.New()
	}
end

function YearCardLotteryViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return YearCardLotteryViewPresentor
