-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lottery/view/LotteryViewPresentor.lua

module("logic.extensions.lottery.view.LotteryViewPresentor", package.seeall)

local LotteryViewPresentor = class("LotteryViewPresentor", ViewWithGuidePresentor)

function LotteryViewPresentor:ctor()
	LotteryViewPresentor.super.ctor(self)
end

function LotteryViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LotteryViewPresentor:dependWhatResources()
	return {
		"ui/views/lottery/lotteryview.prefab"
	}
end

function LotteryViewPresentor:buildViews()
	return {
		LotteryView.New()
	}
end

function LotteryViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return LotteryViewPresentor
