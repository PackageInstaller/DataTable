-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcardpreheat/view/YearCardPreheatViewPresentor.lua

module("logic.extensions.yearcard.view.2022.YearCardPreheatViewPresentor", package.seeall)

local YearCardPreheatViewPresentor = class("YearCardPreheatViewPresentor", ViewPresentor)

function YearCardPreheatViewPresentor:ctor()
	YearCardPreheatViewPresentor.super.ctor(self)
end

function YearCardPreheatViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YearCardPreheatViewPresentor:dependWhatResources()
	return {
		"ui/views/yearcard2022/yearcardpreheatview.prefab"
	}
end

function YearCardPreheatViewPresentor:buildViews()
	return {
		YearCardPreheatView.New()
	}
end

return YearCardPreheatViewPresentor
