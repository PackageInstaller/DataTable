-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcardpreheat2023/view/YearCardPreheat2023GameRuleViewPresentor.lua

module("logic.extensions.yearcardpreheat2023.view.YearCardPreheat2023GameRuleViewPresentor", package.seeall)

local YearCardPreheat2023GameRuleViewPresentor = class("YearCardPreheat2023GameRuleViewPresentor", ViewPresentor)

function YearCardPreheat2023GameRuleViewPresentor:ctor()
	YearCardPreheat2023GameRuleViewPresentor.super.ctor(self)
end

function YearCardPreheat2023GameRuleViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function YearCardPreheat2023GameRuleViewPresentor:dependWhatResources()
	return {
		"ui/views/yearcardpreheat2023/yearcardpreheat2023gameruleview.prefab"
	}
end

function YearCardPreheat2023GameRuleViewPresentor:buildViews()
	return {
		YearCardPreheat2023GameRuleView.New()
	}
end

return YearCardPreheat2023GameRuleViewPresentor
