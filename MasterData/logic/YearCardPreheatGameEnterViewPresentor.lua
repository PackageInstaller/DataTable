-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcardpreheat/view/YearCardPreheatGameEnterViewPresentor.lua

module("logic.extensions.yearcardpreheat.view.YearCardPreheatGameEnterViewPresentor", package.seeall)

local YearCardPreheatGameEnterViewPresentor = class("YearCardPreheatGameEnterViewPresentor", ViewPresentor)

function YearCardPreheatGameEnterViewPresentor:ctor()
	YearCardPreheatGameEnterViewPresentor.super.ctor(self)
end

function YearCardPreheatGameEnterViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YearCardPreheatGameEnterViewPresentor:dependWhatResources()
	return {
		"ui/views/yearcard2022/ycphgameenterview.prefab"
	}
end

function YearCardPreheatGameEnterViewPresentor:buildViews()
	return {
		YearCardPreheatGameEnterView.New()
	}
end

return YearCardPreheatGameEnterViewPresentor
