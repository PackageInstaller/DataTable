-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lottery/view/LotteryselfselectViewPresentor.lua

module("logic.extensions.lottery.view.LotteryselfselectViewPresentor", package.seeall)

local LotteryselfselectViewPresentor = class("LotteryselfselectViewPresentor", ViewPresentor)

function LotteryselfselectViewPresentor:ctor()
	LotteryselfselectViewPresentor.super.ctor(self)
end

function LotteryselfselectViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LotteryselfselectViewPresentor:dependWhatResources()
	return {
		"ui/views/lottery/lotteryselfselectview.prefab"
	}
end

function LotteryselfselectViewPresentor:buildViews()
	return {
		LotteryselfselectView.New()
	}
end

function LotteryselfselectViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return LotteryselfselectViewPresentor
