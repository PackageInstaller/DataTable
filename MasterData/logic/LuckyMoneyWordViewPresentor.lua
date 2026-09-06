-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luckymoney/view/LuckyMoneyWordViewPresentor.lua

module("logic.extensions.luckymoney.view.LuckyMoneyWordViewPresentor", package.seeall)

local LuckyMoneyWordViewPresentor = class("LuckyMoneyWordViewPresentor", ViewPresentor)

function LuckyMoneyWordViewPresentor:ctor()
	LuckyMoneyWordViewPresentor.super.ctor(self)
end

function LuckyMoneyWordViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LuckyMoneyWordViewPresentor:dependWhatResources()
	return {
		"ui/views/luckymoney/luckymoneywordview.prefab"
	}
end

function LuckyMoneyWordViewPresentor:buildViews()
	return {
		LuckyMoneyWordView.New()
	}
end

return LuckyMoneyWordViewPresentor
