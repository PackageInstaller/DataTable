-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luckymoney/view/LuckyMoneyResultViewPresentor.lua

module("logic.extensions.luckymoney.view.LuckyMoneyResultViewPresentor", package.seeall)

local LuckyMoneyResultViewPresentor = class("LuckyMoneyResultViewPresentor", ViewPresentor)

function LuckyMoneyResultViewPresentor:ctor()
	LuckyMoneyResultViewPresentor.super.ctor(self)
end

function LuckyMoneyResultViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function LuckyMoneyResultViewPresentor:dependWhatResources()
	return {
		"ui/views/luckymoney/luckymoneyresultview.prefab"
	}
end

function LuckyMoneyResultViewPresentor:buildViews()
	return {
		LuckyMoneyResultView.New()
	}
end

return LuckyMoneyResultViewPresentor
