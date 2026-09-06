-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcardpreheat2023/view/YearCardPreheat2023GameViewPresentor.lua

module("logic.extensions.yearcardpreheat2023.view.YearCardPreheat2023GameViewPresentor", package.seeall)

local YearCardPreheat2023GameViewPresentor = class("YearCardPreheat2023GameViewPresentor", ViewPresentor)

function YearCardPreheat2023GameViewPresentor:ctor()
	YearCardPreheat2023GameViewPresentor.super.ctor(self)
end

function YearCardPreheat2023GameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YearCardPreheat2023GameViewPresentor:dependWhatResources()
	return {
		"ui/views/yearcardpreheat2023/yearcardpreheat2023gameview.prefab"
	}
end

function YearCardPreheat2023GameViewPresentor:buildViews()
	return {
		YearCardPreheat2023GameView.New()
	}
end

return YearCardPreheat2023GameViewPresentor
