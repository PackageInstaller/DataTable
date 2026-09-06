-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/superghostlottery/view/SuperGhostLotterySelectViewPresentor.lua

module("logic.extensions.superghostlottery.view.SuperGhostLotterySelectViewPresentor", package.seeall)

local SuperGhostLotterySelectViewPresentor = class("SuperGhostLotterySelectViewPresentor", ViewPresentor)

function SuperGhostLotterySelectViewPresentor:ctor()
	SuperGhostLotterySelectViewPresentor.super.ctor(self)
end

function SuperGhostLotterySelectViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SuperGhostLotterySelectViewPresentor:dependWhatResources()
	return {
		"ui/views/superghostlottery/superghostlotteryselectview.prefab"
	}
end

function SuperGhostLotterySelectViewPresentor:buildViews()
	return {
		SuperGhostLotterySelectView.New()
	}
end

return SuperGhostLotterySelectViewPresentor
