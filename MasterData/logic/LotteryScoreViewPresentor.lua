-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lottery/view/LotteryScoreViewPresentor.lua

module("logic.extensions.lottery.view.LotteryScoreViewPresentor", package.seeall)

local LotteryScoreViewPresentor = class("LotteryScoreViewPresentor", ViewPresentor)

function LotteryScoreViewPresentor:ctor()
	LotteryScoreViewPresentor.super.ctor(self)
end

function LotteryScoreViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LotteryScoreViewPresentor:dependWhatResources()
	return {
		"ui/views/lottery/lotteryscoreview.prefab"
	}
end

function LotteryScoreViewPresentor:buildViews()
	return {
		LotteryScoreView.New()
	}
end

return LotteryScoreViewPresentor
