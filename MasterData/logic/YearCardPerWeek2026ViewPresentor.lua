-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2026/main/YearCardPerWeek2026ViewPresentor.lua

module("logic.extensions.yearcard.view.yearcard2026.main.YearCardPerWeek2026ViewPresentor", package.seeall)

local YearCardPerWeek2026ViewPresentor = class("YearCardPerWeek2026ViewPresentor", ViewPresentor)

function YearCardPerWeek2026ViewPresentor:ctor()
	YearCardPerWeek2026ViewPresentor.super.ctor(self)
end

function YearCardPerWeek2026ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YearCardPerWeek2026ViewPresentor:dependWhatResources()
	return {
		"ui/views/yearcard2026/main/yearcardperweek2026view.prefab"
	}
end

function YearCardPerWeek2026ViewPresentor:buildViews()
	return {
		YearCardPerWeek2026View.New()
	}
end

return YearCardPerWeek2026ViewPresentor
