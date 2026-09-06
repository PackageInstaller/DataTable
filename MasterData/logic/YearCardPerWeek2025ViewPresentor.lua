-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2025/main/YearCardPerWeek2025ViewPresentor.lua

module("logic.extensions.yearcard.view.yearcard2025.main.YearCardPerWeek2025ViewPresentor", package.seeall)

local YearCardPerWeek2025ViewPresentor = class("YearCardPerWeek2025ViewPresentor", ViewPresentor)

function YearCardPerWeek2025ViewPresentor:ctor()
	YearCardPerWeek2025ViewPresentor.super.ctor(self)
end

function YearCardPerWeek2025ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YearCardPerWeek2025ViewPresentor:dependWhatResources()
	return {
		"ui/views/yearcard2025/main/yearcardperweek2025view.prefab"
	}
end

function YearCardPerWeek2025ViewPresentor:buildViews()
	return {
		YearCardPerWeek2025View.New()
	}
end

return YearCardPerWeek2025ViewPresentor
