-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lottery/view/LotteryOperateViewPresentor.lua

module("logic.extensions.lottery.view.LotteryOperateViewPresentor", package.seeall)

local LotteryOperateViewPresentor = class("LotteryOperateViewPresentor", ViewPresentor)

function LotteryOperateViewPresentor:ctor()
	LotteryOperateViewPresentor.super.ctor(self)
end

function LotteryOperateViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function LotteryOperateViewPresentor:dependWhatResources()
	return {
		"ui/views/lottery/lotteryoperateview.prefab"
	}
end

function LotteryOperateViewPresentor:buildViews()
	return {
		LotteryOperateView.New()
	}
end

function LotteryOperateViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return LotteryOperateViewPresentor
