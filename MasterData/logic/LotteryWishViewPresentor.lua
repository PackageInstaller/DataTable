-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lottery/view/LotteryWishViewPresentor.lua

module("logic.extensions.lottery.view.LotteryWishViewPresentor", package.seeall)

local LotteryWishViewPresentor = class("LotteryWishViewPresentor", ViewPresentor)

function LotteryWishViewPresentor:ctor()
	LotteryWishViewPresentor.super.ctor(self)
end

function LotteryWishViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LotteryWishViewPresentor:dependWhatResources()
	return {
		"ui/views/lottery/lotterywishview.prefab"
	}
end

function LotteryWishViewPresentor:buildViews()
	return {
		LotteryWishView.New()
	}
end

return LotteryWishViewPresentor
