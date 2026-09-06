-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lottery/view/LotteryGroupViewPresentor.lua

module("logic.extensions.lottery.view.LotteryGroupViewPresentor", package.seeall)

local LotteryGroupViewPresentor = class("LotteryGroupViewPresentor", ViewPresentor)

function LotteryGroupViewPresentor:ctor()
	LotteryGroupViewPresentor.super.ctor(self)
end

function LotteryGroupViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function LotteryGroupViewPresentor:dependWhatResources()
	return {
		"ui/views/lottery/lotterygroupview.prefab"
	}
end

function LotteryGroupViewPresentor:buildViews()
	return {
		LotteryGroupView.New()
	}
end

return LotteryGroupViewPresentor
