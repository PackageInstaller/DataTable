-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goldentowerlottery/view/GoldenTowerLotteryViewPresentor.lua

module("logic.extensions.goldentowerlottery.view.GoldenTowerLotteryViewPresentor", package.seeall)

local GoldenTowerLotteryViewPresentor = class("GoldenTowerLotteryViewPresentor", ViewPresentor)

function GoldenTowerLotteryViewPresentor:ctor()
	GoldenTowerLotteryViewPresentor.super.ctor(self)
end

function GoldenTowerLotteryViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoldenTowerLotteryViewPresentor:dependWhatResources()
	return {
		"ui/views/goldentowerlottery/goldentowerlotteryview.prefab"
	}
end

function GoldenTowerLotteryViewPresentor:buildViews()
	return {
		GoldenTowerLotteryView.New()
	}
end

return GoldenTowerLotteryViewPresentor
