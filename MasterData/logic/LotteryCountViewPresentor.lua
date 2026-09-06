-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lottery/view/LotteryCountViewPresentor.lua

module("logic.extensions.lottery.view.LotteryCountViewPresentor", package.seeall)

local LotteryCountViewPresentor = class("LotteryCountViewPresentor", ViewPresentor)

function LotteryCountViewPresentor:ctor()
	LotteryCountViewPresentor.super.ctor(self)
end

function LotteryCountViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function LotteryCountViewPresentor:dependWhatResources()
	return {
		"ui/views/lottery/lotterycountview.prefab"
	}
end

function LotteryCountViewPresentor:buildViews()
	return {
		LotteryCountView.New()
	}
end

return LotteryCountViewPresentor
