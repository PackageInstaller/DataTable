-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcardpreheat/view/YearCardPreheatGameViewPresentor.lua

module("logic.extensions.yearcardpreheat.view.YearCardPreheatGameViewPresentor", package.seeall)

local YearCardPreheatGameViewPresentor = class("YearCardPreheatGameViewPresentor", ViewPresentor)

function YearCardPreheatGameViewPresentor:ctor()
	YearCardPreheatGameViewPresentor.super.ctor(self)
end

function YearCardPreheatGameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YearCardPreheatGameViewPresentor:dependWhatResources()
	return {
		"ui/views/yearcard2022/ycphgameview.prefab"
	}
end

function YearCardPreheatGameViewPresentor:buildViews()
	return {
		YearCardPreheatGameView.New()
	}
end

return YearCardPreheatGameViewPresentor
