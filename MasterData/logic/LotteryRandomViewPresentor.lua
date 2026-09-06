-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lottery/view/LotteryRandomViewPresentor.lua

module("logic.extensions.lottery.view.LotteryRandomViewPresentor", package.seeall)

local LotteryRandomViewPresentor = class("LotteryRandomViewPresentor", ViewPresentor)

function LotteryRandomViewPresentor:ctor()
	LotteryRandomViewPresentor.super.ctor(self)
end

function LotteryRandomViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function LotteryRandomViewPresentor:dependWhatResources()
	return {
		"ui/views/lottery/lotteryrandomview.prefab"
	}
end

function LotteryRandomViewPresentor:buildViews()
	return {
		LotteryRandomView.New()
	}
end

return LotteryRandomViewPresentor
