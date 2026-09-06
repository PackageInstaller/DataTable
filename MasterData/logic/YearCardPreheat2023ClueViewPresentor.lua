-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcardpreheat2023/view/YearCardPreheat2023ClueViewPresentor.lua

module("logic.extensions.yearcardpreheat2023.view.YearCardPreheat2023ClueViewPresentor", package.seeall)

local YearCardPreheat2023ClueViewPresentor = class("YearCardPreheat2023ClueViewPresentor", ViewPresentor)

function YearCardPreheat2023ClueViewPresentor:ctor()
	YearCardPreheat2023ClueViewPresentor.super.ctor(self)
end

function YearCardPreheat2023ClueViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function YearCardPreheat2023ClueViewPresentor:dependWhatResources()
	return {
		"ui/views/yearcardpreheat2023/yearcardpreheat2023clueview.prefab"
	}
end

function YearCardPreheat2023ClueViewPresentor:buildViews()
	return {
		YearCardPreheat2023ClueView.New()
	}
end

return YearCardPreheat2023ClueViewPresentor
