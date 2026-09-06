-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luckymoney/view/LuckyMoneyMainViewPresentor.lua

module("logic.extensions.luckymoney.view.LuckyMoneyMainViewPresentor", package.seeall)

local LuckyMoneyMainViewPresentor = class("LuckyMoneyMainViewPresentor", ViewPresentor)

function LuckyMoneyMainViewPresentor:ctor()
	LuckyMoneyMainViewPresentor.super.ctor(self)
end

function LuckyMoneyMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LuckyMoneyMainViewPresentor:dependWhatResources()
	return {
		"ui/views/luckymoney/luckymoneymainview.prefab"
	}
end

function LuckyMoneyMainViewPresentor:buildViews()
	return {
		LuckyMoneyMainView.New()
	}
end

return LuckyMoneyMainViewPresentor
