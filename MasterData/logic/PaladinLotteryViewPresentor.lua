-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lottery/view/paladinlottery/PaladinLotteryViewPresentor.lua

module("logic.extensions.lottery.view.paladinlottery.PaladinLotteryViewPresentor", package.seeall)

local PaladinLotteryViewPresentor = class("PaladinLotteryViewPresentor", ViewPresentor)

function PaladinLotteryViewPresentor:ctor()
	PaladinLotteryViewPresentor.super.ctor(self)
end

function PaladinLotteryViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PaladinLotteryViewPresentor:dependWhatResources()
	return {
		"ui/views/paladinlottery/paladinlotteryview.prefab"
	}
end

function PaladinLotteryViewPresentor:buildViews()
	return {
		PaladinLotteryView.New()
	}
end

return PaladinLotteryViewPresentor
